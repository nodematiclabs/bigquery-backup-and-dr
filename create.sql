WITH numbers AS (
  SELECT x
  FROM UNNEST(GENERATE_ARRAY(1, 1000)) AS x
)

, sample_data AS (
  SELECT
    x AS id,
    CONCAT('User', CAST(x AS STRING)) AS name,
    CAST(FLOOR(18 + (RAND() * 52)) AS INT64) AS age,
    CONCAT('user', CAST(x AS STRING), '@example.com') AS email
  FROM
    numbers
)

SELECT
  id,
  name,
  age,
  email
FROM
  sample_data;
