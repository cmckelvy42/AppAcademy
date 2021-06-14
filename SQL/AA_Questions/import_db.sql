DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_tags;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;
PRAGMA foreign_keys = ON;


CREATE TABLE users
(
    id INTEGER PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL
);
INSERT INTO
  users (fname, lname)
VALUES
  ('Chris', 'McKelvy'), ('Kathy', 'Chan');

CREATE TABLE questions
(
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('Chris Question', 'CHRIS CHRIS CHRIS', (SELECT users.id FROM users WHERE users.fname = 'Chris' AND users.lname = 'McKelvy')),
  ('Chris Question 2', 'TEST TEST TEST', (SELECT users.id FROM users WHERE users.fname = 'Chris' AND users.lname = 'McKelvy')),
  ('Chris Question 3', 'TEST TEST TEST', (SELECT users.id FROM users WHERE users.fname = 'Chris' AND users.lname = 'McKelvy')),
  ('Kat Question', 'MEOW MEOW MEOW', (SELECT users.id FROM users WHERE users.fname = 'Kathy' AND users.lname = 'Chan'));

CREATE TABLE question_follows
(
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  question_follows (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Chris' AND lname = 'McKelvy'),
  (SELECT id FROM questions WHERE title = 'Kat Question')),

  ((SELECT id FROM users WHERE fname = 'Chris' AND lname = 'McKelvy'),
  (SELECT id FROM questions WHERE title = 'Chris Question')),

  ((SELECT id FROM users WHERE fname = 'Kathy' AND lname = 'Chan'),
  (SELECT id FROM questions WHERE title = 'Chris Question'));

  CREATE TABLE replies
(
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    parent_reply_id INTEGER,
    author_id INTEGER NOT NULL,
    body TEXT NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
    FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO
  replies (question_id, parent_reply_id, author_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = 'Kat Question'),
  NULL,
  (SELECT id FROM users WHERE fname = 'Chris' AND lname = 'McKelvy'),
  'Did you say NOW NOW NOW?'
);

INSERT INTO
  replies (question_id, parent_reply_id, author_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = 'Kat Question'),
  (SELECT id FROM replies WHERE body = 'Did you say NOW NOW NOW?'),
  (SELECT id FROM users WHERE fname = 'Kathy' AND lname = 'Chan'),
  'I said MEOW MEOW MEOW.'
);

CREATE TABLE question_likes
(
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO question_likes (user_id, question_id) VALUES (1, 1);
INSERT INTO question_likes (user_id, question_id) VALUES (1, 4);
INSERT INTO question_likes (user_id, question_id) VALUES (2, 1);