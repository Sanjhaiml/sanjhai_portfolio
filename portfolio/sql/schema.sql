-- Optional schema for storing contact-form messages in MySQL.
-- Only needed if you switch ContactServlet from FileMessageStore
-- to ContactDAO (see the comment at the top of ContactDAO.java).

CREATE DATABASE IF NOT EXISTS portfolio_db;
USE portfolio_db;

CREATE TABLE IF NOT EXISTS contact_messages (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(120)  NOT NULL,
    email       VARCHAR(160)  NOT NULL,
    subject     VARCHAR(200)  NOT NULL,
    body        TEXT          NOT NULL,
    received_at DATETIME      NOT NULL
);
