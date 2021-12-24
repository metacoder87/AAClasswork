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

