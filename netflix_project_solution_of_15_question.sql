-- 15 Business Problems & Solutions

--1. Count the number of Movies vs TV Shows.
SELECT type, COUNT(*) AS total_count
FROM netflix
GROUP BY type 
ORDER BY total_count;

--2. Find the most common rating for movies and TV shows.
WITH TypeRatings AS(
                SELECT 
                type,
                rating,
				COUNT(*) AS rating_count
                FROM netflix
				GROUP BY type,rating 
),
RankedRatings AS(
              SELECT
               type,
               rating,
			   rating_count,
			   RANK() OVER(PARTITION BY type ORDER BY rating_count DESC) AS rank
			 FROM TypeRatings 
)

SELECT
   type,
   rating AS most_frequent_rating 
FROM RankedRatings
WHERE rank = 1;
   

--3. List all movies released in a specific year (e.g., 2020).
SELECT type,release_year
FROM netflix
WHERE type ='Movie' 
AND release_year =2020;

--4. Find the top 5 countries with the most content on Netflix.
SELECT country, COUNT(*) content_Netflix 
FROM netflix
WHERE country IS NOT NULL
GROUP BY country
ORDER BY content_Netflix DESC
LIMIT 5;
--5. Identify the longest movie.
SELECT title, duration
FROM netflix
WHERE type = 'Movie'
AND duration IS NOT NULL 
ORDER BY CAST(SPLIT_PART(duration, ' ', 1) AS INT) DESC
LIMIT 5;
--6. Find content added in the last 5 years.
SELECT *
FROM netflix
WHERE TO_DATE(date_added, 'Month ,DD, YYYY')>= CURRENT_DATE - INTERVAL '5 years';

--7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
SELECT type,director
FROM netflix
WHERE director = 'Rajiv Chilaka'
ORDER BY type;
--8. List all TV shows with more than 5 seasons
SELECT type, title, duration
FROM netflix
WHERE type = 'TV Show'
AND CAST(SPLIT_PART(duration,' ',1) AS INT) > 5;
--9. Count the number of content items in each genre.
SELECT listed_in, COUNT(*) AS number_of_content
FROM netflix
GROUP BY listed_in
ORDER BY number_of_content DESC; 
/*10.Find each year and the average numbers of content 
release in India on netflix.
Return top 5 year with highest avg content release!*/
SELECT release_year,country,COUNT(*) AS content_release
FROM netflix
WHERE country ='India'
GROUP BY release_year,country
ORDER BY content_release DESC
LIMIT 5;


--11. List all movies that are documentaries.
SELECT type,listed_in
FROM netflix
WHERE type ='Movie' AND listed_in LIKE '%Documentaries'; 
--12. Find all content without a director
SELECT title, director
FROM netflix
WHERE director IS NULL; 
--13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
SELECT *
FROM netflix
WHERE type = 'Movie'
AND netflix."casts" LIKE '%Salman Khan%'
AND release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10;

--14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
SELECT casts, COUNT(*) AS total_movies
FROM netflix
WHERE type = 'Movie'
AND country LIKE '%India%'
GROUP BY casts
ORDER BY total_movies DESC
LIMIT 10;
/*15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.*/
SELECT 
    CASE 
        WHEN description ILIKE '%kill%' 
          OR description ILIKE '%violence%' 
        THEN 'Bad'
        ELSE 'Good'
    END AS content_category,
    COUNT(*) AS total_count
FROM netflix
GROUP BY content_category;
