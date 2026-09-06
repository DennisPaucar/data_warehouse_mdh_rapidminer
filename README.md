# Human Development Credit (CDH) Data Warehouse - MIES (2020–2025)

> Comprehensive ETL pipeline in Altair AI Studio (RapidMiner), multidimensional star schema modeling in PowerDesigner, analytical database implementation in SQL Server, and interactive business intelligence dashboards in Power BI based on open public data from Ecuador's Ministry of Economic and Social Inclusion (MIES).

---

## 📌 Executive Summary

The **Human Development Credit (CDH)** program, promoted by the Ministry of Economic and Social Inclusion (MIES), fosters productive micro-enterprises by providing advance payments of social bonuses and non-contributory pensions to vulnerable families living in poverty and extreme poverty.

Historically, CDH program data was distributed across separate yearly files without a centralized analytical architecture, hindering longitudinal comparative analysis. This project implements an end-to-end **Business Intelligence and Data Warehousing** solution across six official datasets (covering the 2020–2025 period). It enables multi-variable analysis across sociodemographic shifts, geographic coverage, economic activities, and priority subsidy allocations.

---

## 🛠️ Technology Stack

| Layer / Stage | Tool / Technology | Role in Architecture |
| :--- | :--- | :--- |
| **Data Modeling** | SAP PowerDesigner | Design of the logical and physical dimensional Star Schema. |
| **ETL & Data Prep** | Altair AI Studio (RapidMiner) | Extraction, cleaning, normalization, joins, and database ingestion. |
| **Data Warehouse** | Microsoft SQL Server | Relational storage for dimensional tables and the `FACT_CREDITO` table. |
| **BI & Analytics** | Microsoft Power BI | Dimensional modeling, DAX measures, and interactive decision-support dashboards. |

---

## 🗄️ Data Warehouse Architecture (Star Schema)

The analytical data model follows Kimball's dimensional modeling principles using a **Star Schema** optimized for high-performance aggregation and slicing:

```text
               +-------------------+
               |    DIM_TIEMPO     |
               +-------------------+
               | PK_DIM_TIEMPO     |
               | FECHA_ANIO        |
               +---------+---------+
                         |
+-------------------+    |    +--------------------+
|   DIM_UBICACION   |    |    |    DIM_ACTIVIDAD   |
+-------------------+    |    +--------------------+
| PK_DIM_UBICACION  |    |    | PK_DIM_ACTIVIDAD   |
| ZONA              |    |    | NOMBRE_ACTIVIDAD   |
| DISTRITO_MIES     |    |    | TIPO_ACTIVIDAD     |
| PROVINCIA         |    |    +---------+----------+
| CANTON            |    |              |
| PARROQUIA         +----+----+         |
| TIPO_ZONA         |    |    |         |
| REGION            |    v    |         |
+---------+---------+ +-------+-------+ +
          |           |  FACT_CREDITO |
          |           +---------------+
          +---------->| PK_FACT_...   |<--------+
                      | FK_TIEMPO     |         |
          +---------->| FK_ACTIVIDAD  |<----+   |
          |           | FK_UBICACION  |     |   |
+---------+---------+ | FK_SUBSIDIO   |     |   |
|  DIM_BENEFICIARIO | | FK_BENEFIC... |     |   |
+-------------------+ | CUOTAS_CANC...|     |   |
| PK_DIM_BENEFICI...| | NUMERO_CUOTAS |     |   |
| GENERO            | | NUMERO_CDH    |     |   |
| EDAD              | | CANTIDAD_REG..|     |   |
| ETNIA             | +---------------+     |   |
+-------------------+                       |   |
                                            |   |
                      +---------------------+   |
                      |      DIM_SUBSIDIO       |
                      +-------------------------+
                      | PK_DIM_SUBSIDIO         |
                      | CLASE_CREDITO           |
                      | TIPO_SUBSIDIO           |
                      | FECHA_PRIMERA_CUOTA     |
                      +-------------------------+
