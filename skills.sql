-- Note: Please consult the directions for this assignment
-- for the most explanatory version of each question.

-- 1. Select all columns for all brands in the brands table.

SELECT *
FROM brands;

-- 2. Select all columns for all car models made by Pontiac in the models table.

SELECT *
FROM models
WHERE brand_name = 'Pontiac';

-- 3. Select the brand name and model
--    name for all models made in 1964 from the models table.

SELECT brand_name, name
FROM models
WHERE year = 1964;


-- 4. Select the model name, brand name, and headquarters for the Ford Mustang
--    from the models and brands tables.

SELECT models.name, models.brand_name, brands.headquarters
FROM models 
INNER JOIN brands
    ON models.brand_name=brands.name
WHERE models.brand_name = 'Ford' AND models.name = 'Mustang';

-- 5. Select all rows for the three oldest brands
--    from the brands table (Hint: you can use LIMIT and ORDER BY).

SELECT *
FROM brands
ORDER BY founded ASC
LIMIT 3;

-- 6. Count the Ford models in the database (output should be a number).

SELECT COUNT(*)
FROM brands
INNER JOIN models
    ON models.brand_name=brands.name
WHERE brands.name = 'Ford';

-- 7. Select the name of any and all car brands that are not discontinued.

SELECT brands.name
FROM brands
  LEFT JOIN models
    ON models.brand_name=brands.name;
WHERE brands.discontinued IS NULL;

-- 8. Select rows 15-25 of the DB in alphabetical order by model name.

SELECT *
FROM brands
  LEFT JOIN models
    ON models.brand_name=brands.name
ORDER BY brands.name ASC;

-- 9. Select the brand, name, and year the model's brand was
--    founded for all of the models from 1960. Include row(s)
--    for model(s) even if its brand is not in the brands table.
--    (The year the brand was founded should be NULL if
--    the brand is not in the brands table.)

SELECT models.brand_name, models.name, brands.founded
FROM models
   LEFT JOIN brands
     ON models.brand_name=brands.name
WHERE models.year = 1960;


-- Part 2: Change the following queries according to the specifications.
-- Include the answers to the follow up questions in a comment below your
-- query.

-- 1. Modify this query so it shows all brands that are not discontinued
-- regardless of whether they have any models in the models table.
-- before:

    SELECT b.name,
           b.founded,
           m.name
    FROM brands AS b
      LEFT JOIN models AS m
        ON b.name = m.brand_name
    WHERE b.discontinued IS NULL;

-- 2. Modify this left join so it only selects models that have brands in the brands table.
-- before:

    SELECT m.name,
           m.brand_name,
           b.founded
    FROM models AS m
      INNER JOIN brands AS b
        ON b.name = m.brand_name;

-- followup question: In your own words, describe the difference between
-- left joins and inner joins.

-- Inner joins combine two tables' data (based on the filters) where the tables' data is complete, meaning that it does not include null data.
-- Left joins combine two tables' data (based on the filters) but include incomplete data from the first, the "left", table, meaning that it will include null data in the results if necessary.

-- 3. Modify the query so that it only selects brands that don't have any models in the models table.
-- (Hint: it should only show Tesla's row.)
-- before:

    SELECT brands.name,
           brands.founded
    FROM brands
      LEFT JOIN models
        ON brands.name = models.brand_name
    WHERE models.brand_name IS NULL;

-- 4. Modify the query to add another column to the results to show
-- the number of years from the year of the model until the brand becomes discontinued
-- Display this column with the name years_until_brand_discontinued.
-- before:

    SELECT b.name,
      m.name,
      m.year,
      b.discontinued,
      b.discontinued - m.year
    FROM models AS m
    LEFT JOIN brands AS b
      ON m.brand_name = b.name
    WHERE b.discontinued IS NOT NULL;




-- Part 3: Further Study

-- 1. Select the name of any brand with more than 5 models in the database.

-- INCOMPLETE

SELECT brands.name
FROM brands
  INNER JOIN models
    ON brands.name=models.brand_name
WHERE COUNT(models.brand_name) > 5;

-- 2. Add the following rows to the models table.

INSERT INTO models VALUES ('2015', 'Chevrolet', 'Malibu');
INSERT INTO models VALUES ('2015', 'Subaru', 'Outback');

-- year    name       brand_name
-- ----    ----       ----------
-- 2015    Chevrolet  Malibu
-- 2015    Subaru     Outback

-- 3. Write a SQL statement to crate a table called `Awards`
--    with columns `name`, `year`, and `winner`. Choose
--    an appropriate datatype and nullability for each column
--   (no need to do subqueries here).

CREATE TABLE awards(
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    year INTEGER NOT NULL,
    winner_id VARCHAR(20) NOT NULL,
    );

-- 4. Write a SQL statement that adds the following rows to the Awards table:

winner_id = SELECT id FROM models WHERE brand_name = 'Chevrolet' AND name = 'Malibu' AND year = 2015;
INSERT INTO awards VALUES ('2015', 'IIHS Safety Award', winner_id);

winner_id = SELECT id FROM models WHERE brand_name = 'Chevrolet' AND name = 'Malibu' AND year = 2015;
INSERT INTO awards VALUES ('2015', 'IIHS Safety Award', winner_id);

-- I couldn't tell if I needed to define what the winner ID was or just include the placeholder variable for it.


--   name                 year      winner_model_id
--   ----                 ----      ---------------
--   IIHS Safety Award    2015      the id for the 2015 Chevrolet Malibu
--   IIHS Safety Award    2015      the id for the 2015 Subaru Outback

-- 5. Using a subquery, select only the *name* of any model whose
-- year is the same year that *any* brand was founded.

SELECT name
FROM models
WHERE year IN
  (
   SELECT founded
   FROM brands
  );

-- This one tells you which particular year is matching with brands
-- SELECT name, year
-- FROM models
-- WHERE year IN
--   (
--    SELECT founded
--    FROM brands
--   );




