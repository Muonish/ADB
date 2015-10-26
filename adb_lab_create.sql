-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2015-09-28 00:39:16.459




-- tables
-- Table city
CREATE TABLE city (
    name varchar(100)  NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY (name)
);

-- Table disability
CREATE TABLE disability (
    disability_id int  NOT NULL,
    name varchar(30)  NOT NULL,
    CONSTRAINT disability_pk PRIMARY KEY (disability_id)
);

-- Table family_status
CREATE TABLE family_status (
    family_status_id int  NOT NULL,
    name varchar(50)  NOT NULL,
    CONSTRAINT family_status_pk PRIMARY KEY (family_status_id)
);

-- Table nationality
CREATE TABLE nationality (
    nationality_id int  NOT NULL,
    name varchar(50)  NOT NULL,
    CONSTRAINT nationality_pk PRIMARY KEY (nationality_id)
);

-- Table passport
CREATE TABLE passport (
    passport_id int  NOT NULL,
    seria varchar(5)  NOT NULL,
    number varchar(15)  NOT NULL,
    place_of_issue varchar(200)  NOT NULL,
    date date  NOT NULL,
    ident_number varchar(30)  NOT NULL,
    CONSTRAINT passport_pk PRIMARY KEY (passport_id)
);

-- Table user
CREATE TABLE user (
    user_id int  NOT NULL,
    first_name varchar(50)  NOT NULL,
    last_name varchar(50)  NOT NULL,
    date_of_birth date  NOT NULL,
    sex bool  NOT NULL,
    place_of_birth varchar(200)  NOT NULL,
    living_address varchar(200)  NOT NULL,
    phone_home varchar(15)  NULL,
    phone_mob varchar(15)  NULL,
    e_mail varchar(50)  NULL,
    place_of_work varchar(200)  NULL,
    position varchar(100)  NULL,
    registration_address varchar(200)  NOT NULL,
    pensioner bool  NOT NULL,
    monthly_income int  NOT NULL,
    passport_id int  NOT NULL,
    family_status_id int  NOT NULL,
    nationality_id int  NOT NULL,
    disability_id int  NOT NULL,
    living_city_name varchar(100)  NOT NULL,
    CONSTRAINT user_pk PRIMARY KEY (user_id)
);





-- foreign keys
-- Reference:  user_city (table: user)


ALTER TABLE user ADD CONSTRAINT user_city FOREIGN KEY user_city (living_city_name)
    REFERENCES city (name);
-- Reference:  user_disability (table: user)


ALTER TABLE user ADD CONSTRAINT user_disability FOREIGN KEY user_disability (disability_id)
    REFERENCES disability (disability_id);
-- Reference:  user_family_status (table: user)


ALTER TABLE user ADD CONSTRAINT user_family_status FOREIGN KEY user_family_status (family_status_id)
    REFERENCES family_status (family_status_id);
-- Reference:  user_nationality (table: user)


ALTER TABLE user ADD CONSTRAINT user_nationality FOREIGN KEY user_nationality (nationality_id)
    REFERENCES nationality (nationality_id);
-- Reference:  user_passport (table: user)


ALTER TABLE user ADD CONSTRAINT user_passport FOREIGN KEY user_passport (passport_id)
    REFERENCES passport (passport_id);



-- End of file.

