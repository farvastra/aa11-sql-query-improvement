----------
-- Step 0 - Create a Query 
----------
-- Query: Select all cats that have a toy with an id of 5

    -- Your code here 
      SELECT c.name 
FROM cats c
JOIN cat_toys ct ON c.id = ct.cat_id
JOIN toys t ON t.id = ct.toy_id
WHERE t.id = 5;

-- Paste your results below (as a comment):
-- "Rachele", "Rodger", "Jamal"



----------
-- Step 1 - Analyze the Query
----------
-- Query:

    -- Your code here 
 EXPLAIN QUERY PLAN
SELECT c.name 
FROM cats c
JOIN cat_toys ct ON c.id = ct.cat_id
JOIN toys t ON t.id = ct.toy_id
WHERE t.id = 5;
-- Paste your results below (as a comment):
-- 0|0|0|SEARCH TABLE toys USING INTEGER PRIMARY KEY (id=?)
-- 0|1|1|SCAN TABLE cat_toys AS ct
-- 0|2|2|SEARCH TABLE cats USING INTEGER PRIMARY KEY (id=?)

-- What do your results mean?
   -- Was this a SEARCH or SCAN?
-- - For the `toys` and `cats` table, it used a `SEARCH`.
-- - For the `cat_toys` table, it performed a `SCAN`.

-- What does that mean?
-- - A `SEARCH` means the query was able to use the index to efficiently locate the matching rows.
-- - A `SCAN` means the query had to examine all rows in the `cat_toys` table to find the matches.


----------
-- Step 2 - Time the Query to get a baseline
----------
-- Query (to be used in the sqlite CLI):

    -- Your code here 
.timer ON
SELECT c.name 
FROM cats c
JOIN cat_toys ct ON c.id = ct.cat_id
JOIN toys t ON t.id = ct.toy_id
WHERE t.id = 5;
-- Paste your results below (as a comment):
-- Run Time: 0.005 seconds


----------
-- Step 3 - Add an index and analyze how the query is executing
----------

-- Create index:

    -- Your code here 
CREATE INDEX IF NOT EXISTS idx_cat_toys_toy_id ON cat_toys(toy_id);


-- Analyze Query:
    -- Your code here 
    
EXPLAIN QUERY PLAN
SELECT c.name 
FROM cats c
JOIN cat_toys ct ON c.id = ct.cat_id
JOIN toys t ON t.id = ct.toy_id
WHERE t.id = 5;
-- Paste your results below (as a comment):
  -- 0|0|0|SEARCH TABLE toys USING INTEGER PRIMARY KEY (id=?)
-- 0|1|1|SEARCH TABLE cat_toys USING INDEX idx_cat_toys_toy_id (toy_id=?)
-- 0|2|2|SEARCH TABLE cats USING INTEGER PRIMARY KEY (id=?)


-- Analyze Results:

    -- Is the new index being applied in this query?

   -- Yes, the query is now using the index `


----------
-- Step 4 - Re-time the query using the new index
----------
-- Query (to be used in the sqlite CLI):

    -- Your code here 
.timer ON
SELECT c.name 
FROM cats c
JOIN cat_toys ct ON c.id = ct.cat_id
JOIN toys t ON t.id = ct.toy_id
WHERE t.id = 5;
-- Paste your results below (as a comment):
-- Run Time: 0.003 seconds

-- Analyze Results:
    -- Are you still getting the correct query results?
    -- Yes, the correct cats are still being returned.

    -- Did the execution time improve (decrease)?
    -- Yes, the execution time decreased slightly from 0.005 to 0.003 seconds.


    -- Do you see any other opportunities for making this query more efficient?
    -- At this point, the query is quite efficient. No further improvements are necessary.

---------------------------------
-- Notes From Further Exploration
---------------------------------
