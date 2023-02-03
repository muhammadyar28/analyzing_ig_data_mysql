USE ig_database;

-- We will play the role of a person analyzing data for the company
-- We are given certain tasks, and need to find the solution

-- TASK #1 
-- We want to reward our users who have been around the longest
-- Find the 5 oldest users

SELECT 
	username AS 5_oldest_users 
FROM users
ORDER BY created_at LIMIT 5;

-- TASK #2 
-- We need to figure out when to schedule an ad champgain
-- For this we need to figure out what day of the week do most users registor on?

SELECT
	(DATE_FORMAT(created_at, '%W'))  AS DAY,
	COUNT(*) AS 'Number of Sign Ups'
FROM users
GROUP BY DAY;

-- TASK #3
-- We want to taregt our inactive users with an email campaign
-- To do this find the users who have never posted a photo
-- We want all the users from the users table, and any corresponding info from photos table, therefore inner join

SELECT
	username,
    image_url
FROM users
LEFT JOIN photos ON users.id = photos.user_id
WHERE image_url IS NULL;

-- TASK #4
-- Which user got the most likes on a single photo?

SELECT 
	users.username,
    photos.image_url,
    COUNT(*) AS total
FROM photos
INNER JOIN likes ON likes.photo_id = photos.id
INNER JOIN users ON photos.user_id = users.id
GROUP BY photos.id 
ORDER BY total DESC LIMIT 1;

-- TASK #5
-- Our investors want to know how many times does the average user post?
-- Calculate average number of posts per user

SELECT 
	(SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS 'AVERAGE NUMBER OF POSTS PER USER';

-- TASK #6
-- A brand wants to know which hashtags to use in a post.
-- What are the 5 most commonly used hashtags

SELECT
	tags.tag_name,
    COUNT(*) AS Total
FROM tags
INNER JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY Total DESC LIMIT 5;

-- TASK #7
-- We have a small problem with bots on our site
-- Find users who have liked every single photo on the site
-- We cannot use the where after GROUP BY

SELECT
	users.username,
    COUNT(*) AS total_likes
FROM users
INNER JOIN likes ON users.id = likes.user_id
GROUP BY users.id
HAVING total_likes = (SELECT COUNT(*) FROM photos)
;







