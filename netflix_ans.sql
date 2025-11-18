create table netflix(
show_id varchar(6),
type varchar(10),
title varchar(150),
director varchar(210),
cast varchar(1000),
country varchar(150),
data_added varchar(50),
release_year int,
rating varchar(10),
duration varchar(15),
listed_in varchar(100),
description varchar(250)
);

select count(*)
from netflix;

-- 1. Count the number of Movies vs TV Shows

SELECT 
    type, COUNT(*) AS total_content
FROM
    netflix
GROUP BY type;

-- 2. Find the most common rating for movies and TV shows
SELECT 
    type, rating, COUNT(*) AS most_common_rating,
rank() over(partition by type order by count(*) desc) as ranking
FROM
    netflix
GROUP BY type , rating
ORDER BY most_common_rating DESC;

-- 3. List all movies released in a specific year (e.g., 2020)
SELECT 
    type, title
FROM
    netflix
WHERE
    type = 'Movie' AND release_year = '2020';
-- 4. Find the top 5 countries with the most content on Netflix
SELECT 
    country AS new_country, COUNT(show_id) AS total
FROM
    netflix
GROUP BY new_country
ORDER BY total DESC
LIMIT 5;
-- 5. Identify the longest movie
SELECT 
    *
FROM
    netflix
WHERE
    type = 'movie'
        AND duration = (SELECT 
            MAX(duration)
        FROM
            netflix);
-- 6. Find content added in the last 5 years
select * from netflix where date(date_added,month ,dd,yyyy) >=current_date()-interval '5 years';
-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
SELECT 
    *
FROM
    netflix
WHERE
    director LIKE '%Rajiv Chilaka%';
-- 8. List all TV shows with more than 5 seasons
SELECT 
    *, SUBSTRING(duration, ' ', 1) AS seasons
FROM
    netflix
WHERE
    type = 'TV Show' AND duration > 5;
-- 9. Count the number of content items in each genre
SELECT 
    show_id, COUNT(listed_in)
FROM
    netflix
GROUP BY show_id;
-- 10. List all movies that are documentaries
SELECT * from netflix where listed_in like "%documentaries";