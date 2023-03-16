CREATE TABLE users (
    id serial PRIMARY KEY,
    username varchar NOT NULL,
    email varchar,
    full_name varchar,
    disabled boolean,
    hashed_password varchar NOT NULL
);
