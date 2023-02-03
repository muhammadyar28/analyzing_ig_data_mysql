CREATE DATABASE ig_database;
USE ig_database;

-- USERS Schema 
-- username has to be unique and cannot be NULL
-- created at current time and default value is NOW

CREATE TABLE users (
	id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
    );

-- PHOTOS Schema
-- Need to be related to particular user
-- user_id will point to id from the USERS table
-- image_url cannot be null, their always needs to be a picture
-- user_id also cannot be NULL, their must be an existing user that posted that image

CREATE TABLE photos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users (id)
);
 
-- USERS Schema
-- Comments rely on users and the photos they post, this table will be related to USER and PHOTO
-- We will therefore have two foreign keys. user_id to users.id and photo_id to photo.id
-- comment_text should be NOT NULL, dont want anyone leaving empty comments.
-- user_id and photo_id cannot be NULL, they need to be related to a photo and user

CREATE TABLE comments (
	id INT AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    user_id INTEGER NOT NULL,
    photo_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY (photo_id) REFERENCES photos(id)
    );
    
-- LIKES Schema
-- This scheme is similiar to the comments schema
-- A person can only like a picture one time 
-- We dont need an id column, because we likes will not be referred by anyother table.
-- We will declare two primary keys to ensure that you are not allowed to insert likes that are the same, with same user_id and photo_id

CREATE TABLE likes (
	user_id INT NOT NULL,
    photo_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    PRIMARY KEY(user_id, photo_id)
    );
    
-- FOLLOWERS Schema
-- This is a one way relationship. 
-- A follower can follow someone else, without them having to follow them back. 
-- Will need an id for the follower and an id for the person being followed
-- We also dont want duplicate follows, need to apply Primary key. 

CREATE TABLE followers (
	follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(follower_id) REFERENCES users(id),
    FOREIGN KEY(followee_id) REFERENCES users(id),
    PRIMARY KEY(followee_id, follower_id)
    );

-- TAGS Scheme
-- There are three potential structures we can use

-- Solution 1: We add a tags column to our photos table
-- This column will be a string, we use the hashtag to split '#cat#pets#fun'
-- Disadvantges: We are limited by the number of tags we can put it

-- Solution 2: We use two tables, we have our photots table and we create a tags table with tag_name and photo_id
-- This allows us to put unlimited number of tags, but this is actually slower then Solution 1

-- Solution 3:              
-- We use three tables, photos, tags (id, tag_name), photo_tags(photo_id, tag_id)
-- Advantges: Unlimited number of tags, can add additional information
-- Disadvantges: More work when inserting/updating. Have to worry about orphans. 

CREATE TABLE tags (
	id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
    );
    
CREATE TABLE photo_tags (
	photo_id INT NOT NULL,
    tag_id INT NOT NULL,
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    FOREIGN KEY(tag_id) REFERENCES tags(id),
    PRIMARY KEY(photo_id, tag_id)
    );








    