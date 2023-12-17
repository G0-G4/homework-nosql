CREATE KEYSPACE hh
  WITH REPLICATION = { 
   'class' : 'SimpleStrategy', 
   'replication_factor' : 1 
  };

create table hh.user_posts (
    user_id    INT,
    username   VARCHAR,
    email      VARCHAR,
    post_id    INT,
    topic_id   INT,
    content    TEXT,
    created_at TIMESTAMP,
    PRIMARY KEY (user_id, created_at)
) with clustering order by (created_at desc);

create table hh.topic_posts (
    user_id    INT,
    username   VARCHAR,
    email      VARCHAR,
    post_id    INT,
    topic_id   INT,
    content    TEXT,
    created_at TIMESTAMP,
    date       DATE,
    PRIMARY KEY ((topic_id, date), created_at)
) with clustering order by (created_at desc);

INSERT INTO hh.user_posts (user_id, username, email, post_id, topic_id, content, created_at) VALUES (1, 'user1', 'user1@example.com', 1, 1, 'Content 1', '2023-12-13 10:00:00');
INSERT INTO hh.user_posts (user_id, username, email, post_id, topic_id, content, created_at) VALUES  (1, 'user1', 'user1@example.com', 2, 1, 'Content 2', '2023-12-13 11:00:00');
INSERT INTO hh.user_posts (user_id, username, email, post_id, topic_id, content, created_at) VALUES  (2, 'user2', 'user2@example.com', 3, 2, 'Content 3', '2023-12-13 12:00:00');
INSERT INTO hh.user_posts (user_id, username, email, post_id, topic_id, content, created_at) VALUES  (2, 'user2', 'user2@example.com', 4, 2, 'Content 4', '2023-12-13 13:00:00');
INSERT INTO hh.user_posts (user_id, username, email, post_id, topic_id, content, created_at) VALUES  (3, 'user3', 'user3@example.com', 5, 3, 'Content 5', '2023-12-13 14:00:00');
INSERT INTO hh.user_posts (user_id, username, email, post_id, topic_id, content, created_at) VALUES  (3, 'user3', 'user3@example.com', 6, 3, 'Content 6', '2023-12-13 15:00:00');
INSERT INTO hh.user_posts (user_id, username, email, post_id, topic_id, content, created_at) VALUES  (4, 'user4', 'user4@example.com', 7, 4, 'Content 7', '2023-12-13 16:00:00');
INSERT INTO hh.user_posts (user_id, username, email, post_id, topic_id, content, created_at) VALUES  (4, 'user4', 'user4@example.com', 8, 4, 'Content 8', '2023-12-13 17:00:00');
INSERT INTO hh.user_posts (user_id, username, email, post_id, topic_id, content, created_at) VALUES  (5, 'user5', 'user5@example.com', 9, 5, 'Content 9', '2023-12-13 18:00:00');
INSERT INTO hh.user_posts (user_id, username, email, post_id, topic_id, content, created_at) VALUES  (5, 'user5', 'user5@example.com', 10, 5, 'Content 10', '2023-12-13 19:00:00');
INSERT INTO hh.user_posts (user_id, username, email, post_id, topic_id, content, created_at) VALUES  (6, 'user6', 'user6@example.com', 11, 6, 'Content 11', '2023-12-13 20:00:00');
INSERT INTO hh.user_posts (user_id, username, email, post_id, topic_id, content, created_at) VALUES  (6, 'user6', 'user6@example.com', 12, 6, 'Content 12', '2023-12-13 21:00:00');
INSERT INTO hh.user_posts (user_id, username, email, post_id, topic_id, content, created_at) VALUES  (7, 'user7', 'user7@example.com', 13, 7, 'Content 13', '2023-12-13 22:00:00');
INSERT INTO hh.user_posts (user_id, username, email, post_id, topic_id, content, created_at) VALUES  (7, 'user7', 'user7@example.com', 14, 7, 'Content 14', '2023-12-13 23:00:00');
INSERT INTO hh.user_posts (user_id, username, email, post_id, topic_id, content, created_at) VALUES  (8, 'user8', 'user8@example.com', 15, 8, 'Content 15', '2023-12-14 00:00:00');
INSERT INTO hh.user_posts (user_id, username, email, post_id, topic_id, content, created_at) VALUES  (8, 'user8', 'user8@example.com', 16, 8, 'Content 16', '2023-12-14 01:00:00');
INSERT INTO hh.user_posts (user_id, username, email, post_id, topic_id, content, created_at) VALUES  (9, 'user9', 'user9@example.com', 17, 9, 'Content 17', '2023-12-14 02:00:00');
INSERT INTO hh.user_posts (user_id, username, email, post_id, topic_id, content, created_at) VALUES  (9, 'user9', 'user9@example.com', 18, 9, 'Content 18', '2023-12-14 03:00:00');
INSERT INTO hh.user_posts (user_id, username, email, post_id, topic_id, content, created_at) VALUES  (10, 'user10', 'user10@example.com', 19, 10, 'Content 19', '2023-12-14 04:00:00');
INSERT INTO hh.user_posts (user_id, username, email, post_id, topic_id, content, created_at) VALUES  (10, 'user10', 'user10@example.com', 20, 10, 'Content 20', '2023-12-14 05:00:00');

INSERT INTO hh.topic_posts (user_id, username, email, post_id, topic_id, content, created_at, date) VALUES (1, 'user1', 'user1@example.com', 1, 1, 'Content 1', '2023-12-13 10:00:00', '2023-12-13');
INSERT INTO hh.topic_posts (user_id, username, email, post_id, topic_id, content, created_at, date) VALUES  (1, 'user1', 'user1@example.com', 2, 1, 'Content 2', '2023-12-13 11:00:00', '2023-12-13');
INSERT INTO hh.topic_posts (user_id, username, email, post_id, topic_id, content, created_at, date) VALUES  (2, 'user2', 'user2@example.com', 3, 2, 'Content 3', '2023-12-13 12:00:00', '2023-12-13');
INSERT INTO hh.topic_posts (user_id, username, email, post_id, topic_id, content, created_at, date) VALUES  (2, 'user2', 'user2@example.com', 4, 2, 'Content 4', '2023-12-13 13:00:00', '2023-12-13');
INSERT INTO hh.topic_posts (user_id, username, email, post_id, topic_id, content, created_at, date) VALUES  (3, 'user3', 'user3@example.com', 5, 3, 'Content 5', '2023-12-13 14:00:00', '2023-12-13');
INSERT INTO hh.topic_posts (user_id, username, email, post_id, topic_id, content, created_at, date) VALUES  (3, 'user3', 'user3@example.com', 6, 3, 'Content 6', '2023-12-13 15:00:00', '2023-12-13');
INSERT INTO hh.topic_posts (user_id, username, email, post_id, topic_id, content, created_at, date) VALUES  (4, 'user4', 'user4@example.com', 7, 4, 'Content 7', '2023-12-13 16:00:00', '2023-12-13');
INSERT INTO hh.topic_posts (user_id, username, email, post_id, topic_id, content, created_at, date) VALUES  (4, 'user4', 'user4@example.com', 8, 4, 'Content 8', '2023-12-13 17:00:00', '2023-12-13');
INSERT INTO hh.topic_posts (user_id, username, email, post_id, topic_id, content, created_at, date) VALUES  (5, 'user5', 'user5@example.com', 9, 5, 'Content 9', '2023-12-13 18:00:00', '2023-12-13');
INSERT INTO hh.topic_posts (user_id, username, email, post_id, topic_id, content, created_at, date) VALUES  (5, 'user5', 'user5@example.com', 10, 5, 'Content 10', '2023-12-13 19:00:00', '2023-12-13');
INSERT INTO hh.topic_posts (user_id, username, email, post_id, topic_id, content, created_at, date) VALUES  (6, 'user6', 'user6@example.com', 11, 6, 'Content 11', '2023-12-13 20:00:00', '2023-12-13');
INSERT INTO hh.topic_posts (user_id, username, email, post_id, topic_id, content, created_at, date) VALUES  (6, 'user6', 'user6@example.com', 12, 6, 'Content 12', '2023-12-13 21:00:00', '2023-12-13');
INSERT INTO hh.topic_posts (user_id, username, email, post_id, topic_id, content, created_at, date) VALUES  (7, 'user7', 'user7@example.com', 13, 7, 'Content 13', '2023-12-13 22:00:00', '2023-12-13');
INSERT INTO hh.topic_posts (user_id, username, email, post_id, topic_id, content, created_at, date) VALUES  (7, 'user7', 'user7@example.com', 14, 7, 'Content 14', '2023-12-13 23:00:00', '2023-12-13');
INSERT INTO hh.topic_posts (user_id, username, email, post_id, topic_id, content, created_at, date) VALUES  (8, 'user8', 'user8@example.com', 15, 8, 'Content 15', '2023-12-14 00:00:00', '2023-12-14');
INSERT INTO hh.topic_posts (user_id, username, email, post_id, topic_id, content, created_at, date) VALUES  (8, 'user8', 'user8@example.com', 16, 8, 'Content 16', '2023-12-14 01:00:00', '2023-12-14');
INSERT INTO hh.topic_posts (user_id, username, email, post_id, topic_id, content, created_at, date) VALUES  (9, 'user9', 'user9@example.com', 17, 9, 'Content 17', '2023-12-14 02:00:00', '2023-12-14');
INSERT INTO hh.topic_posts (user_id, username, email, post_id, topic_id, content, created_at, date) VALUES  (9, 'user9', 'user9@example.com', 18, 9, 'Content 18', '2023-12-14 03:00:00', '2023-12-14');
INSERT INTO hh.topic_posts (user_id, username, email, post_id, topic_id, content, created_at, date) VALUES  (10, 'user10', 'user10@example.com', 19, 10, 'Content 19', '2023-12-14 04:00:00', '2023-12-14');
INSERT INTO hh.topic_posts (user_id, username, email, post_id, topic_id, content, created_at, date) VALUES  (10, 'user10', 'user10@example.com', 20, 10, 'Content 20', '2023-12-14 05:00:00', '2023-12-14');

select post_id, content, created_at from hh.user_posts where user_id = 1;

select post_id, content, created_at from hh.user_posts where user_id = 1 limit 1;

select post_id, content, created_at from hh.user_posts where user_id = 1 and created_at > '2023-12-12 24:00:00';

select user_id, username, post_id from hh.topic_posts where date = '2023-12-13' and topic_id = 1;
