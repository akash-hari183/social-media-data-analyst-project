CREATE DATABASE socialmedia;

USE socialmedia;

-- Users Table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Posts Table
CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    content VARCHAR(255) NOT NULL,
    post_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Comments Table
CREATE TABLE comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    user_id INT,
    content VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Likes Table
CREATE TABLE likes (
    like_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    post_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE
);

-- Tags Table
CREATE TABLE tags (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(50) NOT NULL UNIQUE
);

-- Post Tags (Many-to-Many Relationship)
CREATE TABLE post_tags (
    post_id INT,
    tag_id INT,
    PRIMARY KEY (post_id, tag_id),
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tags(tag_id) ON DELETE CASCADE
);

-- Shares Table
CREATE TABLE shares (
    share_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    user_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Notifications Table
CREATE TABLE notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    message VARCHAR(255),
    notification_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Users
INSERT INTO users (user_name, email, created_at) VALUES
('Akash', 'akash@gmail.com', '2021-01-01'),
('Barath', 'barath12@gmail.com', '2022-02-02'),
('Dhanush', 'rxlover@gmail.com', '2023-03-03'),
('Elango', 'king13@gmail.com', '2024-04-04'),
('Mani', 'mani@gmail.com', '2025-05-05');

-- Posts
INSERT INTO posts (user_id, content, post_at) VALUES
(1, 'Love', '2021-01-02'),
(2, 'Friendship', '2022-02-01'),
(3, 'Fight', '2023-03-01'),
(4, 'Anime', '2024-04-01'),
(5, 'Comedy', '2025-05-01');

-- Comments
INSERT INTO comments (post_id, user_id, content) VALUES
(1, 1, 'Waste'),
(2, 2, 'Poor'),
(3, 3, 'Super'),
(4, 4, 'Good'),
(5, 5, 'Bad');

-- Likes
INSERT INTO likes (user_id, post_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Tags
INSERT INTO tags (tag_name) VALUES
('College'),
('School'),
('ClassBunk'),
('Breakup'),
('Single');

-- Associating Tags with Posts
INSERT INTO post_tags (post_id, tag_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Shares
INSERT INTO shares (post_id, user_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Notifications
INSERT INTO notifications (user_id, message) VALUES
(1, 'New comment on your post!'),
(2, 'Someone liked your post!'),
(3, 'Your post got shared!'),
(4, 'New follower request!'),
(5, 'You have a new message!');

SELECT * FROM users WHERE user_name = 'Elango';

SELECT * FROM notifications WHERE notification_time IS NULL;

SELECT p.post_id, p.content, COUNT(c.comment_id) AS total_comments
FROM posts p
LEFT JOIN comments c ON p.post_id = c.post_id
GROUP BY p.post_id, p.content
ORDER BY total_comments DESC;

SELECT u.user_name, COUNT(p.post_id) AS total_posts
FROM users u
LEFT JOIN posts p ON u.user_id = p.user_id
GROUP BY u.user_name
ORDER BY total_posts DESC;

SELECT t.tag_name, COUNT(l.like_id) AS like_count
FROM tags t
JOIN post_tags pt ON t.tag_id = pt.tag_id
JOIN likes l ON pt.post_id = l.post_id
GROUP BY t.tag_name
ORDER BY like_count DESC
LIMIT 1;

SELECT p.post_id, u.user_name, p.content, COUNT(c.comment_id) AS total_comments
FROM posts p
JOIN users u ON p.user_id = u.user_id
LEFT JOIN comments c ON p.post_id = c.post_id
GROUP BY p.post_id, u.user_name, p.content
ORDER BY total_comments DESC
LIMIT 10;

SELECT COUNT(*) FROM users
 
SELECT COUNT(*) FROM posts

SELECT COUNT(*) FROM comments

SELECT COUNT(*) FROM likes

SELECT COUNT(*) FROM tags

SELECT COUNT(*) FROM shares

SELECT COUNT(*) FROM notifications

SELECT max(user_id) FROM users

SELECT avg(user_id) FROM users

SELECT COUNT(post_id) FROM shares

SELECT MAX(user_id) AS max_user_id, AVG(user_id) AS avg_user_id FROM users;

SELECT MAX(comment_count) AS max_comments
FROM (
    SELECT post_id, COUNT(comment_id) AS comment_count
    FROM comments
    GROUP BY post_id
) AS comment_counts;


SELECT * FROM comments limit 2

SELECT * FROM posts limit 4

SELECT * FROM users limit 3

SELECT * FROM likes limit 5

SELECT COUNT(message) FROM notifications

SELECT * FROM users order by user_name

SELECT * FROM posts order by post_id

SELECT * from comments order by created_at

SELECT * FROM notifications order by notification_time

SELECT * FROM comments

SELECT * FROM likes

SELECT * FROM notifications

SELECT * FROM post_tags

SELECT * FROM posts

SELECT * FROM shares

SELECT * FROM tags

SELECT * FROM users





















