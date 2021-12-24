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
