/*
    Pre-requisites:
    - pastikan project-mu sudah punya dataset bernama `demo`, atau ganti nama dataset sesuai nama dataset-mu
*/

-- udf sql
CREATE OR REPLACE FUNCTION `demo.word_finder`(input_string STRING) AS (
CASE
    WHEN LOWER(input_string) LIKE "%bug%" THEN "BUGS"
    WHEN LOWER(input_string) LIKE "%fix%" THEN "BUGS"
    WHEN LOWER(input_string) LIKE "%feature%" THEN "FEATURE"
    WHEN LOWER(input_string) LIKE "%improve%" THEN "IMPROVEMENT"
    WHEN LOWER(input_string) LIKE "%refactor%" THEN "REFACTOR"
    ELSE "OTHERS"
  END
);

-- udf javascript
CREATE OR REPLACE FUNCTION `demo.word_finder_js`(input_string STRING) RETURNS STRING LANGUAGE js AS """
category = "OTHERS";
  if (input_string.toLowerCase().indexOf("bug") >=0) {
    category = "BUGS";
  } else if (input_string.toLowerCase().indexOf("fix") >=0) {
    category = "BUGS";
  } else if (input_string.toLowerCase().indexOf("feature") >=0) {
    category = "FEATURE";
  } else if (input_string.toLowerCase().indexOf("improve") >=0) {
    category = "IMPROVEMENT";
  } 
  return category
""";

-- sample query using javascript udf
SELECT
    `demo.word_finder_js`(message),
    COUNT(1)
FROM `bigquery-public-data.github_repos.commits`
GROUP BY 1
ORDER BY 2

-- sample query using sql udf
SELECT `demo.word_finder`(message), COUNT(1)
FROM `bigquery-public-data.github_repos.commits`
GROUP BY 1
ORDER BY 2