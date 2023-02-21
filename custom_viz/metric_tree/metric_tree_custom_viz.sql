{{
  config(
    materialized='table'
    )
}}

WITH net_ltv AS (
--New Net LTV generated in the period--
    SELECT
        "NET LTV" AS measure
        , CAST(NULL AS STRING) AS parent_measure
        , "gbp_0" AS value_number_format
        , "sum" AS value_calc
        , record_date AS date
        , SUM(ltv) - SUM(cac) AS single_value
        , CAST(NULL AS NUMERIC) AS numerator
        , CAST(NULL AS NUMERIC) AS denominator
    FROM {{ ref('nltv_table') }}
    GROUP BY 1,2,3,4,5
)

, ltv AS (
--New LTV generated in the period--
    SELECT
        "LTV" AS measure
        , "NET LTV" AS parent_measure
        , "gbp" AS value_number_format
        , "sum" AS value_calc
        , record_date AS date
        , SUM(ltv) AS single_value
        , CAST(NULL AS NUMERIC) AS numerator
        , CAST(NULL AS NUMERIC) AS denominator
    FROM {{ ref('ltv_table') }}
    GROUP BY 1,2,3,4,5
)

, cac AS (
--New CAC spent in the period--
    SELECT
        "CAC" AS measure
        , "NET LTV" AS parent_measure
        , "gbp" AS value_number_format
        , "sum" AS value_calc
        , record_date AS date
        , SUM(cac) AS single_value
        , CAST(NULL AS NUMERIC) AS numerator
        , CASt(NULL AS NUMERIC) AS denominator
    FROM {{ ref('cac_table') }} 
    GROUP BY 1,2,3,4,5
)


SELECT
    *
FROM net_ltv
UNION ALL
SELECT
    *
FROM ltv
UNION ALL
SELECT
    *
FROM cac


-----------------------------------------------------
{{
  config(
    materialized='table'
    )
}}

WITH source_data AS (
  SELECT 
    measure
    , parent_measure
  FROM {{ ref('nltv_kpi_tree') }}
  GROUP BY 1,2
)

, t AS (
  SELECT
    level1.measure,
    ARRAY(
      SELECT a 
      FROM UNNEST(([ 
        down_level2.measure
        , down_level3.measure
        , down_level4.measure
        , down_level5.measure
        , down_level6.measure
        , down_level7.measure
        , down_level8.measure
        , down_level9.measure
        , down_level10.measure
        , down_level11.measure ])) AS a 
      WHERE a is not null
    ) AS children,

  FROM source_data AS level1
    LEFT JOIN source_data AS down_level2 ON level1.measure = down_level2.parent_measure
    LEFT JOIN source_data AS down_level3 ON down_level2.measure = down_level3.parent_measure
    LEFT JOIN source_data AS down_level4 ON down_level3.measure = down_level4.parent_measure
    LEFT JOIN source_data AS down_level5 ON down_level4.measure = down_level5.parent_measure
    LEFT JOIN source_data AS down_level6 ON down_level5.measure = down_level6.parent_measure
    LEFT JOIN source_data AS down_level7 ON down_level6.measure = down_level7.parent_measure
    LEFT JOIN source_data AS down_level8 ON down_level7.measure = down_level8.parent_measure
    LEFT JOIN source_data AS down_level9 ON down_level8.measure = down_level9.parent_measure
    LEFT JOIN source_data AS down_level10 ON down_level9.measure = down_level10.parent_measure
    LEFT JOIN source_data AS down_level11 ON down_level10.measure = down_level11.parent_measure
    LEFT JOIN source_data AS down_level12 ON down_level11.measure = down_level12.parent_measure
)

SELECT
  t.measure 
  , ARRAY_CONCAT_AGG(t.children) AS children
FROM t
GROUP BY 1
