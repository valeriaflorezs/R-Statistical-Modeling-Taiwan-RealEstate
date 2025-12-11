# 📈 R Statistical Modeling: Selección de Modelos para Precios Inmobiliarios

Este proyecto es un análisis de **Regresión Lineal Múltiple (RLM)** utilizando el dataset de precios de bienes raíces de Taiwán.

El análisis completo está documentado en formato reproducible con **RMarkdown** (TallerFinal_ME_VFS.Rmd) y se encuentra disponible en formato HTML.

---

## ✨ Metodología de Selección de Modelos

El valor técnico de este proyecto se centra en la aplicación rigurosa de los siguientes métodos de selección de variables:

| Método de Selección | Criterio de Decisión | Algoritmo Implementado |
| :--- | :--- | :--- |
| **Búsqueda Automática** | **Criterio de Información de Akaike (AIC)** | Utilización de la función `stepAIC()` (selección *Forward* y *Backward*) para identificar modelos con el mejor equilibrio entre bondad de ajuste y complejidad. |
| **Todas las Regresiones** | $R^2$ Ajustado y Criterio de Mallows ($C_p$) | Utilización de la librería `olsrr` para examinar todas las combinaciones posibles de variables. |
| **Comparación ANOVA** | P-valor | Utilización de la prueba ANOVA para determinar si el modelo reducido es significativamente inferior al modelo completo, validando así la remoción de variables (ej., 'latitude'). |

## ⚙️ Habilidades Demostradas

* **Lenguaje:** **R** (Dominio en scripting y análisis).
* **Herramientas:** `RMarkdown` (Reportes reproducibles), `tidyverse` (Manipulación de datos), `fst` (Manejo de datasets eficientes).
* **Modelado:** Regresión Lineal Múltiple (RLM).
* **Ingeniería de Características:** Creación y manejo de **Variables Dummy** a partir de variables categóricas.
* **Diagnóstico:** Evaluación de la multicolinealidad, normalidad y homocedasticidad de los residuos.

## 📁 Archivos Clave

* **`TallerFinal_ME_VFS.Rmd`**: El código fuente reproducible que contiene todos los modelos, análisis y visualizaciones.
* **`Paso_a_Paso_Taiwan.R`**: Script de R con el proceso detallado de remoción manual de variables (validación con ANOVA).
* **`taiwan_real_estate.fst`**: El dataset de Taiwán (formato FST).
* **`TallerFinal_ME_VFS.html`**: El informe final renderizado (salida del RMarkdown).
