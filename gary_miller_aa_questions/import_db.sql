--Users

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname CHAR(30) NOT NULL,
    lname CHAR(30) NOT NULL
);

--Questions

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    questioner_id INTEGER NOT NULL,
    title CHAR(50) NOT NULL,
    body CHAR(500) NOT NULL,
    
    FOREIGN KEY (questioner_id) REFERENCES users(id)
);

--Question Follows

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    follower_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (follower_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

--Replies

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    parent_reply_id INTEGER,
    replier_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    body CHAR(250) NOT NULL,

    FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
    FOREIGN KEY (replier_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

--Question Likes

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    liker_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (liker_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

--SEED TABLE DATA

INSERT INTO
    users (fname, lname)
VALUES
    ('Bruce', 'Lee'),
    ('Bruce', 'Wayne'),
    ('Bob', 'Marley'),
    ('Atlas', 'Anomolous');

INSERT INTO
    questions (questioner_id, title, body)
VALUES
    ((SELECT id FROM users WHERE lname = 'Lee'), 'Pointing Finger', 'Is one form of martial art better than another, and if so which one?'),
    ((SELECT id FROM users WHERE lname = 'Wayne'), 'Social Life?', 'What do rich guy play boys do for fun?'),
    ((SELECT id FROM users WHERE lname = 'Marley'), 'Get Up, Stand Up!', 'How can I get the world to listen to my songs?'),
    ((SELECT id FROM users WHERE lname = 'Anomolous'), 'How to Bring Change?', 'How much software do I have to write on my own before I can get a big company to give me a shot?');

INSERT INTO
    question_follows (follower_id, question_id)
VALUES
    ((SELECT id FROM users WHERE lname = 'Anomolous'), (SELECT id FROM questions WHERE title = 'Pointing Finger')),
    ((SELECT id FROM users WHERE lname = 'Anomolous'), (SELECT id FROM questions WHERE title = 'Social Life?')),
    ((SELECT id FROM users WHERE lname = 'Anomolous'), (SELECT id FROM questions WHERE title = 'Get Up, Stand Up!')),
    ((SELECT id FROM users WHERE lname = 'Wayne'), (SELECT id FROM questions WHERE title = 'Pointing Finger')),
    ((SELECT id FROM users WHERE lname = 'Marley'), (SELECT id FROM questions WHERE title = 'Pointing Finger'));

INSERT INTO 
    replies (parent_reply_id, replier_id, question_id, body)
VALUES
    (NULL, (SELECT id FROM users WHERE lname = 'Marley'), (SELECT id FROM questions WHERE title = 'Social Life?'), ('I myself spend my time smoking ganja, playing music, and talking politics.')),
    (NULL, (SELECT id FROM users WHERE lname = 'Lee'), (SELECT id FROM questions WHERE title = 'Social Life?'), ('I could teach you gung fu. I will bring my pads and heavy bag. They are in my trunk right now.'));

INSERT INTO
    replies (parent_reply_id, replier_id, question_id, body)
VALUES
    ((SELECT id FROM replies WHERE body = 'I could teach you gung fu. I will bring my pads and heavy bag. They are in my trunk right now.'), (SELECT id FROM users WHERE lname = 'Wayne'), (SELECT id FROM questions WHERE title = 'Social Life?'), 'I would like to spare with another Bruce who can hold their own. As long as Bob brings that ganja.');

