# 1. Preparación y Carga de Librerías y Datos ----------------------------------

# Instalar y cargar librerías necesarias (descomentar si es la primera vez)
# install.packages(c("tidyverse", "fst", "MASS"))
library(tidyverse)
library(fst)
library(MASS) # Para la función stepAIC

# Carga del dataset
# Asegúrate de que 'taiwan_real_estate.fst' esté en el directorio de trabajo
df_taiwan = read_fst("C:/Users/valef/Desktop/TallerFinal_ME/taiwan_real_estate.fst")

# Preparación de datos: Convertir la antigüedad de la casa a factor no ordenado
df_taiwan$house_age_years = factor(df_taiwan$house_age_years, ordered = FALSE)

# ==============================================================================
# 2. Selección de Modelo Automática (Criterio AIC)
# ==============================================================================

## 2.1. Definición de Modelos Nulo y Completo
modelo_null_taiwan = lm(price_twd_msq ~ 1, data = df_taiwan)
modelo_full_taiwan = lm(price_twd_msq ~ ., data = df_taiwan)

## 2.2. Selección Forward (Adición de variables)
cat("\n--- 2.2. SELECCIÓN FORWARD (AIC) ---\n")
sel_forward <- stepAIC(modelo_null_taiwan,
                       scope = list(lower = modelo_null_taiwan, upper = modelo_full_taiwan),
                       direction = 'forward',
                       trace = FALSE) # trace=FALSE suprime la salida paso a paso

summary(sel_forward)


## 2.3. Selección Bidireccional (Ambas direcciones)
cat("\n--- 2.3. SELECCIÓN BIDIRECCIONAL (AIC) ---\n")
sel_both <- stepAIC(modelo_null_taiwan,
                    scope = list(lower = modelo_null_taiwan, upper = modelo_full_taiwan),
                    direction = 'both',
                    trace = FALSE)

summary(sel_both)

# Ambos métodos AIC seleccionan el mismo modelo óptimo:
# price_twd_msq ~ dist_to_mrt_m + n_convenience + house_age_years

# ==============================================================================
# 3. Selección de Modelo Manual (Criterio p-valor y ANOVA)
# ==============================================================================

cat("\n--- 3. SELECCIÓN MANUAL (p-valor y ANOVA) ---\n")

# Paso 3.1: Modelo Completo (Punto de Partida)
modelo_completo = lm(price_twd_msq ~ ., data = df_taiwan)
cat("\n--- 3.1. Summary del Modelo Completo ---\n")
summary(modelo_completo) 
# Observación: 'latitude' (p=0.4913) es la variable menos significativa.

# --- Inicio del proceso de remoción ---

# Paso 3.2: Remover 'latitude'
submodelo_1 = lm(price_twd_msq ~ dist_to_mrt_m + n_convenience + house_age_years, 
                 data = df_taiwan)
cat("\n--- 3.2. Summary del Submodelo 1 (sin latitude) ---\n")
summary(submodelo_1)

# Comparación ANOVA (Modelo Completo vs Submodelo 1)
cat("\n--- 3.2. ANOVA: Completo vs Submodelo 1 ---\n")
anova(modelo_completo, submodelo_1)
# P-valor = 0.4913 > 0.05. El modelo reducido es suficiente.

# Paso 3.3: Remover 'longitude'
# Observación en Submodelo 1: 'longitude' (p=0.2023) es la siguiente menos significativa.
submodelo_2 = lm(price_twd_msq ~ dist_to_mrt_m + n_convenience + house_age_years, 
                 data = df_taiwan)
cat("\n--- 3.3. Summary del Submodelo 2 (sin longitude) ---\n")
summary(submodelo_2)

# Comparación ANOVA (Submodelo 1 vs Submodelo 2)
cat("\n--- 3.3. ANOVA: Submodelo 1 vs Submodelo 2 ---\n")
anova(submodelo_1, submodelo_2)
# P-valor = 0.2023 > 0.05. El modelo más reducido es suficiente.

# --- Fin del proceso de remoción ---

# Paso 3.4: Modelo Final Manual
cat("\n--- 3.4. Modelo Final Seleccionado (Submodelo 2) ---\n")
summary(submodelo_2)
# Todas las variables restantes son significativas (p < 0.001).

