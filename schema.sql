/*  Execute this file from the command line by typing:
 *    mysql -u <USER> < schema.sql
 *    OR
 *    mysql -u <USER> -p < schema.sql
 *  On your personal computer, if you haven't set up
 *  a password, it'll be
 *    mysql -u root < schema.sql
*/

DROP DATABASE IF EXISTS pass_database;

CREATE DATABASE pass_database;

USE pass_database;

CREATE TABLE users (
  id int PRIMARY KEY AUTO_INCREMENT,
  user_name VARCHAR(50),
  email VARCHAR(50) UNIQUE,
  password VARCHAR(100),
  salt VARCHAR(50),
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  phone VARCHAR(10),
  created_at DATE,
  updated_at DATE
  );

CREATE TABLE sessions (
    id int PRIMARY KEY AUTO_INCREMENT,
    hash VARCHAR(100),
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id)
  );

CREATE TABLE reviews (
  id int PRIMARY KEY AUTO_INCREMENT,
  review_receiver_id int,
  review_giver_id int,
  transaction_type VARCHAR(15),
  rating_given DECIMAL(2,1),
  comment_text VARCHAR(255),
  created_at DATE,
  updated_at DATE,
  FOREIGN KEY (review_receiver_id) REFERENCES users(id),
  FOREIGN KEY (review_giver_id) REFERENCES users(id)
);

CREATE TABLE messages (
    id int PRIMARY KEY AUTO_INCREMENT,
    sender_id int,
    reciever_id int,
    time_sent DATETIME,
    text VARCHAR(255),
    FOREIGN KEY (sender_id) REFERENCES users(id),
    FOREIGN KEY (reciever_id) REFERENCES users(id)
  );

CREATE TABLE sold_passes (
    id int PRIMARY KEY AUTO_INCREMENT,
    seller_id int,
    buyer_id int,
    notes VARCHAR(255),
    sell_date DATE,
    FOREIGN KEY (seller_id) REFERENCES users(id),
    FOREIGN KEY (buyer_id) REFERENCES users(id)
  );

CREATE TABLE restricted_list (
    id int PRIMARY KEY AUTO_INCREMENT,
    studio VARCHAR(100),
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id)
  );


CREATE TABLE for_sale_block (
  id int PRIMARY KEY AUTO_INCREMENT,
  pass_volume int,
  seller_id int,
  current_price DECIMAL(5,2),
  period_start DATE,
  period_end DATE,
  passes_sold int,
  FOREIGN KEY (seller_id) REFERENCES users(id)
);

CREATE TABLE restricted_studios (
    block_id int,
    exempt_studio_id int,
    FOREIGN KEY (block_id) REFERENCES for_sale_block(id),
    FOREIGN KEY (exempt_studio_id) REFERENCES restricted_list(id)
  );

INSERT INTO users (
  user_name,
  email,
  password,
  salt,
  first_name,
  last_name,
  phone,
  created_at,
  updated_at
  ) VALUES (
  'BB123',
  'billy@bob.com',
  'Svds356password1',
  'cPjfn67sdvfg456salt1',
  'Kelly',
  'Cody-Martin',
  '3332224444',
  '2017-03-05',
  '2017-03-09'
  ), (
  'SallySeller',
  'sally@sal.com',
  'oniyGyf67password2',
  '8nJHBh665vhJhsalt2',
  'Brenda',
  'Brenton',
  '1112224444',
  '2017-04-15',
  NULL),(
  'DavidD',
  'david45@gmail.com',
  'Lcdf87gf8HJpassword3',
  'vByt76912salt3',
  'David',
  'Drummer',
  '9998887777',
  '2017-06-09',
  NULL),(
  'KimKimmy',
  'kim@gmail.com',
  'pH78J76GJHbghj',
  'Ghyt7x67dp',
  'Kim',
  'Kimmers',
  '1112223333',
  '2017-05-10',
  NULL),(
  'SuperSeller',
  'Seller123@gmail.com',
  'nkj6hf84ngiJ',
  'jUh6G72hIhkK',
  'Sammy',
  'Saul',
  '5556667777',
  '2017-06-07',
  NULL
  );

INSERT INTO sessions (
    hash,
    user_id
  ) VALUES (
    'HASHcacfG65H78jkjIp0i',
    2
  ),(
    'HASHacdnfd87v6bYT',
    1
  );

INSERT INTO reviews (
  review_receiver_id,
  review_giver_id,
  transaction_type,
  rating_given,
  comment_text,
  created_at,
  updated_at
  ) VALUES (
  2,
  1,
  'sale',
  5.0,
  'Amazing person to work with!',
  '2017-02-01',
  '2017-04-03'
  ), (
  3,
  1,
  'conversation',
  2.4,
  'Avoid them. They are super flaky.',
  '2017-04-21',
  NULL
  );

INSERT INTO for_sale_block (
    pass_volume,
    seller_id,
    current_price,
    period_start,
    period_end,
    passes_sold
  ) VALUES (
    15,
    2,
    8.90,
    '2017-04-11',
    '2017-04-30',
    4
  ), (
    9,
    2,
    9.00,
    '2017-05-03',
    '2017-06-01',
    1
  ), (
    8,
    2,
    9.20,
    '2017-06-07',
    '2017-06-14',
    1
  ), (
    7,
    3,
    9.10,
    '2017-05-03',
    '2017-06-01',
    2
  ), (
    11,
    1,
    10.00,
    '2017-03-03',
    '2017-03-15',
    1
  );

INSERT INTO messages (
    sender_id,
    reciever_id,
    time_sent,
    text
  ) VALUES (
    1,
    2,
    '2017-05-06 11:12:13',
    'Hi, how are you doing?'
  ), (
    2,
    1,
    '2017-05-06 11:12:45',
    'I\'m great! Do you have class passes?'
  ), (
    1,
    2,
    '2017-05-06 11:13:40',
    'Absolutely!'
  ), (
    2,
    1,
    '2017-05-06 11:20:10',
    'I would like to buy 9 passes.'
  ), (
    2,
    3,
    '2017-02-05 15:38:52',
    'Thanks for reaching out. I do have passes to sell.'
  ), (
    3,
    2,
    '2017-02-05 15:40:01',
    'I\'d like to buy passes from you.'
  );

INSERT INTO sold_passes (
    seller_id,
    buyer_id,
    notes,
    sell_date
  ) VALUES (
    1,
    2,
    'Easy to work with',
    '2017-02-05'
  ),(
    3,
    2,
    NULL,
    '2017-07-12'
);

INSERT INTO restricted_list (
    id,
    studio,
    user_id
  ) VALUES (
    1,
    'C.C. Cycling',
    2
  ), (
    2,
    'Edmond Climbing, Gold Gym',
    1
  );

INSERT INTO restricted_studios (
    block_id,
    exempt_studio_id
  ) VALUES (
    1,
    2
  );
