LOAD DATA
TRUNCATE
-- too dangerous to use synonym, may kill something else
INTO TABLE det_pp09
FIELDS TERMINATED BY WHITESPACE OPTIONALLY ENCLOSED BY '"'
(
FNAME,
OBJ,
X,
Y,
W,
H,
PROB,
batch_id constant 'PP09'
)
