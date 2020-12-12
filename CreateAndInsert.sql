DROP TABLE IF EXISTS employer CASCADE;
DROP TABLE IF EXISTS area CASCADE;
DROP TABLE IF EXISTS vacancy CASCADE;
DROP TABLE IF EXISTS cv CASCADE;
DROP TABLE IF EXISTS response CASCADE;
DROP TABLE IF EXISTS resume CASCADE;

CREATE TABLE employer
(
    employer_id   serial PRIMARY KEY,
    employer_name text    NOT NULL,
    area_id       integer NOT NULL
);

CREATE TABLE area
(
    area_id serial PRIMARY KEY,
    area_name text NOT NULL
);

CREATE TABLE vacancy
(
    vacancy_id         serial PRIMARY KEY,
    employer_id        integer     NOT NULL REFERENCES employer (employer_id),
    position_name      text        NOT NULL,
    compensation_from  integer,
    compensation_to    integer,
    compensation_gross boolean,
    created_on         timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE cv
(
    cv_id        serial PRIMARY KEY,
    cv_firstname text NOT NULL,
    cv_lastname  text NOT NULL,
    cv_body      text,
    cv_area      integer,
    cv_email     text NOT NULL UNIQUE
);

CREATE TABLE response
(
    response_id   serial PRIMARY KEY,
    vacancy_id    integer     NOT NULL REFERENCES vacancy (vacancy_id),
    cv_id         integer     NOT NULL REFERENCES cv (cv_id),
    created_on    timestamptz NOT NULL DEFAULT now()
);

INSERT INTO employer (employer_name, area_id)
VALUES ('Head Hunter', 1),
       ('Yandex', 1),
       ('X5 Retail Group', 1),
       ('Bork', 1),
       ('Gazprom', 1),
       ('Honda Motor Co.', 3),
       ('Samsung', 6),
       ('Rossiya Airlines', 2),
       ('LVMH Moët Hennessy', 3),
       ('Adobe', 4),
       ('Corel', 5),
       ('Sony Corporation', 5),
       ('S7 Airlines', 3),
       ('Apple', 1),
       ('Jensen Group', 2),
       ('Google', 6),
       ('JetBrains', 2),
       ('DHL', 6);

INSERT INTO area (area_name)
VALUES ('Moscow'),
       ('Saint Petersburg'),
       ('Novosibirsk'),
       ('Ekaterinburg'),
       ('Kazan'),
       ('Nizhny Novgorod');

INSERT INTO vacancy(employer_id, position_name, compensation_from, compensation_to, compensation_gross)
VALUES (18, 'Sales Representative', 100, 300, true),
       (3, 'Help Desk Worker', 150, null, false),
       (1, 'Graphic Designer', 200, 400, false),
       (8, 'Electrician', 150, 150, true),
       (4, 'Cloud Architect', null, null, null),
       (1, 'Application Developer', 500, 600, true),
       (3, 'Cashier', null, 120, true),
       (5, 'Human Resources', 100, 200, false),
       (14, 'Financial Analyst', 200, 301, false),
       (7, 'B2B Sales Specialist', null, 200, true),
       (10, 'Client Service Specialist', 200, 300, false),
       (5, 'Plumber', 100, 150, false),
       (8, 'Safety Engineer', null, null, null),
       (15, 'Sales Representative', 100, 112, true),
       (2, 'Receptionist', 90, 170, true),
       (9, 'Market Researcher', null, null, null),
       (17, 'Professor', 200, 300, true),
       (12, 'Motion Picture Director', null, 700, false),
       (8, 'Flight Attendant', 300, null, true),
       (5, 'Chef', 200, 246, false);

--populating vacancy with random timestamps
UPDATE vacancy
SET created_on = now() + (random() * (INTERVAL '2 days'))
WHERE created_on IS NOT NULL;

INSERT INTO cv (cv_firstname, cv_lastname, cv_body, cv_area, cv_email)
VALUES ('Vasiliy', 'Popov', 'Some important info about Vasiliy', 2, 'vasia@email.com'),
       ('Anastasia', 'Turgenev', 'Some important info about Anastasia', 1, 'anastasia@email.com'),
       ('Petr', 'Lohovsky', 'Some important info about Petr', 6, 'petia@email.com'),
       ('Dimitry', 'Pupkin', 'Some important info about Dimitry', 3, 'dmitry@email.com'),
       ('Lisa', 'Voronina', 'Some important info about Lisa', 1, 'lisa@email.com'),
       ('Dimitry', 'Volodin', 'Some important info about Dimitry V.', 1, 'dmitry.v@email.com'),
       ('Oleg', 'Smirnof', 'Some important info about Oleg', 1, 'oleg@email.com'),
       ('Nikita', 'Lebedev', 'Some important info about Nikita', 1, 'nikita@email.com'),
       ('Alina', 'Kuznetsova', 'Some important info about Alina', 3, 'alina@email.com'),
       ('Uri', 'Sokolov', 'Some important info about Uri', 1, 'uri@email.com'),
       ('Zlata', 'Chunova', 'Some important info about Zlata', 2, 'zlata@email.com'),
       ('Georgy', 'Durov', 'Some important info about Georgy', 1, 'georgy@email.com'),
       ('Nina', 'Ezhovenko', 'Some important info about Nina', 6, 'nina@email.com'),
       ('Pavel', 'Zandulski', 'Some important info about Pavel', 5, 'pavel@email.com'),
       ('Leonid', 'Dubenko', 'Some important info about Leonid', 1, 'leonid@email.com'),
       ('Jael', 'Tupenko', 'Some important info about Jael', 5, 'jael@email.com'),
       ('Lera', 'Zandulskaia', 'Some important info about Lera', 1, 'lera@email.com'),
       ('Geralt', 'Dobrev', 'Some important info about Geralt', 2, 'geralt@email.com'),
       ('Andrey', 'Volkov', 'Some important info about Andrey', 1, 'andrey@email.com'),
       ('Vladimir', 'Volkov', 'Some important info about Vladimir', 3, 'vladimir@email.com'),
       ('Bogdan', 'Dubenko', 'Some important info about Bogdan', 2, 'bogdan@email.com'),
       ('Miroslav', 'Smirnov', 'Some important info about Miroslav', 1, 'miroslav@email.com'),
       ('Marina', 'Yahontova', 'Some important info about Marina', 1, 'marina@email.com');

INSERT INTO response (vacancy_id, cv_id)
VALUES (1, 1),
       (2, 2),
       (2, 3),
       (3, 4),
       (4, 5),
       (5, 6),
       (6, 7),
       (6, 8),
       (6, 9),
       (7, 10),
       (8, 11),
       (9, 12),
       (10, 13),
       (11, 14),
       (12, 15),
       (12, 16),
       (13, 17),
       (14, 18),
       (15, 19),
       (16, 20),
       (17, 21),
       (18, 22),
       (18, 23);

--populating response with random timestamps
UPDATE response
SET created_on = now() + (random() * (INTERVAL '10 days')) + '2 days'
WHERE created_on IS NOT NULL;
