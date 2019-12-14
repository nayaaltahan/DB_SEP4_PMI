use Dim_SEP4_PMI;

-----HOLDS THE LAST UPDATED DATE;
--we insert the timestamp when we do the initial load
--this row should be updated after every incremental load

CREATE TABLE Last_Updated(
    last_updated DATETIME
)


-- after initial load run this
INSERT INTO Last_Updated (last_updated) VALUES (GETDATE());

-- after every incremental load
UPDATE Last_Updated set last_updated = GETDATE();




