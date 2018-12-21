CREATE USER 'username'@'%' IDENTIFIED BY 'password';
GRANT All privileges ON *.* TO 'username'@'%';

CREATE DATABASE IF NOT EXISTS LabelMe;

use LabelMe;
create table user(
   id INT NOT NULL AUTO_INCREMENT,
   username VARCHAR(100) NOT NULL,
   password VARCHAR(40) NOT NULL,
   PRIMARY KEY ( id )
);


INSERT INTO user(username,password)
VALUES ('user1','233');
