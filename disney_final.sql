USE disney;

SELECT * FROM revenues1;
SELECT * FROM directors1;
SELECT * FROM totalgross1;
SELECT * FROM voiceactors1;
SELECT * FROM characters1;

SELECT `Year`, `Studio Entertainment[NI 1]`, `Disney Consumer Products[NI 2]`,
CAST(`Disney Interactive[NI 3][Rev 1]` AS decimal),
`Walt Disney Parks and Resorts`, `Disney Media Networks`, `Total`
FROM revenues1;


#gross per movie
SELECT movie_title, total_gross, inflation_adjusted_gross
FROM totalgross1
ORDER BY inflation_adjusted_gross DESC;

#gross per movie
SELECT movie_title, CAST(release_date AS datetime), total_gross, inflation_adjusted_gross
FROM totalgross1
ORDER BY inflation_adjusted_gross DESC;

SELECT d.movietitle, tg.genre, va.`character`, va.`voice-actor`
FROM directors AS d
INNER JOIN total_gross1 tg ON d.movietitle = tg.movietitle
JOIN voice_actors va ON tg.movietitle = va.movietitle;

#join 4 tables with movie titles
SELECT d.movietitle, tg.genre, d.director
FROM directors AS d
INNER JOIN total_gross tg ON d.movietitle = tg.movietitle
#INNER JOIN voice_actors va ON tg.movietitle = va.movietitle
INNER JOIN characters c ON tg.movietitle = c.movietitle;

SELECT d.name, tg.genre, d.director, tg.`inflation_adjusted_gross`
FROM directors AS d
INNER JOIN total_gross tg ON d.name = tg.movie_title
JOIN voice_actors va ON tg.movie_title = va.movie
GROUP BY d.director;

SELECT genre, inflation_adjusted_gross, avg(inflation_adjusted_gross)
FROM total_gross
GROUP BY genre;

UPDATE total_gross
SET total_gross=REPLACE(total_gross,',','');

UPDATE total_gross
SET total_gross=REPLACE(total_gross,',','');

ALTER TABLE total_gross
ALTER COLUMN total_gross TYPE integer USING (id::integer);

ALTER TABLE total_gross ALTER COLUMN total_gross TYPE integer USING (col_name::integer);



#cast and replace to run insights on revenues
SELECT REPLACE(inflation_adjusted_gross,'$','') AS in_adj_gross
FROM total_gross
GROUP BY genre;

ALTER TABLE characters
ADD FOREIGN KEY (movietitle) REFERENCES directors(movietitle);

SET SQL_SAFE_UPDATES = 0;



# cast and replace to run insights on revenue
SELECT REPLACE (replace(inflation_adjusted_gross, '$', ''), ',', '') AS in_adj_gross
FROM total_gross
GROUP BY genre;

ALTER TABLE total_gross1
RENAME COLUMN movie_title TO movietitle;

alter table totalgross1 add column new_date DATE;
update totalgross1
set new_date = str_to_date(`release_date`, '%m/%d/%Y');

#characters, total gross
SELECT DISTINCT c.hero, c.movie_title, tg.inflation_adjusted_gross
FROM characters1 as c
INNER JOIN totalgross1 tg ON c.movie_title = tg.movie_title
ORDER BY tg.inflation_adjusted_gross DESC;

#directors, total gross
SELECT DISTINCT d.director, d.movie_title, c.hero, tg.inflation_adjusted_gross
FROM directors1 as d
INNER JOIN totalgross1 tg ON d.movie_title = tg.movie_title
INNER JOIN characters1 c ON c.movie_title = d.movie_title
# INNER JOIN voiceactors1 v ON v.movie_title = d.movie_title
ORDER BY tg.inflation_adjusted_gross DESC;

#grouped by genre
SELECT DISTINCT tg.genre, AVG(tg.inflation_adjusted_gross)
FROM totalgross1 as tg
GROUP BY tg.genre;

SELECT MPAA_rating, COUNT(MPAA_rating)
FROM totalgross1
GROUP BY MPAA_rating;

SELECT movie_title, inflation_adjusted_gross, release_date FROM totalgross1
ORDER BY inflation_adjusted_gross;



#creating foreign keys
ALTER TABLE totalgross1
ADD FOREIGN KEY (movie_title) REFERENCES characters1(movie_title);

ALTER TABLE totalgross1
ADD CONSTRAINT FK_movie
FOREIGN KEY (movie_title) REFERENCES characters1(movie_title);

