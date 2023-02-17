USE ig_database;
SET SESSION sql_mode= 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- I will play the role of a data analyst working for Instagram.
-- We are given certain cases and need to provide a solution and recommendation for each one.

-- CASE #1

-- Our advertisers are worried that Instagram may have a bot problem. 
-- I need you to investigate this issue and prepare a report with your analysis.  

-- First, I need to determine what constitutes bot like activity and determine the proportion of users that are bots on Instagram. 
-- From my judgment I will constitute an account that likes more then 10% of the posts on Instagram and has zero uploads as a bot account. 
-- It is reasonable to believe that no human would be so active as to like 10% of the posts on Instagram, but at the same time not upload anything. 
-- The thought process behind this judgment of what constitutes a bot account must be conveyed to the manager. 


CREATE VIEW bots AS
SELECT
	users.id AS 'Account ID Number',
	users.username AS 'List of Bot Accounts'
FROM users
INNER JOIN likes ON users.id = likes.user_id
LEFT JOIN photos ON users.id = photos.user_id
WHERE image_url IS NULL
GROUP BY users.id
HAVING COUNT(*) > ((SELECT COUNT(*) FROM photos) * 0.10);

SELECT 
	COUNT(*) AS 'Number of Users'
FROM users;

-- CASE #2 

-- One of our biggest advertisers reached out to us and is wondering when is the best time to display promotional ads that will bring new users to their Instagram page. 
-- They also want to know what are the best hashtags to use in their posts. 

-- First, I need to find the day of the week and month of the year when new users join Instagram the most.
-- Then, I need to find the hashtag that is most popular on Instagram posts.   

SELECT
	(DATE_FORMAT(created_at, '%W'))  AS DAY,
	COUNT(*) AS 'Number of Sign-Ups'
FROM users
GROUP BY DAY;

SELECT
	(DATE_FORMAT(uploaded_at, '%M'))  AS MONTH,
	COUNT(*) AS 'Number of Likes'
FROM photos
GROUP BY MONTH;

SELECT
	tags.tag_name AS 'Hashtag',
    COUNT(*) AS 'Total Number of Times Used'
FROM tags
INNER JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY COUNT(*) DESC LIMIT 30;



