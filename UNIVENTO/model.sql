SET FOREIGN_KEY_CHECKS=0;


-- Drop Tables, Stored Procedures and Views //
DROP TABLE IF EXISTS EventTags CASCADE;
DROP TABLE IF EXISTS CategoryTags CASCADE;
DROP TABLE IF EXISTS Tags CASCADE;
DROP TABLE IF EXISTS Colaborator CASCADE;
DROP TABLE IF EXISTS Rate CASCADE;
DROP TABLE IF EXISTS Registration CASCADE;
DROP TABLE IF EXISTS Normal CASCADE;
DROP TABLE IF EXISTS EventDate CASCADE;
DROP TABLE IF EXISTS Local CASCADE;
DROP TABLE IF EXISTS Image CASCADE;
DROP TABLE IF EXISTS Spotify CASCADE;
DROP TABLE IF EXISTS Youtube CASCADE;
DROP TABLE IF EXISTS Event CASCADE;
DROP TABLE IF EXISTS Category CASCADE;
DROP TABLE IF EXISTS Promoter CASCADE;
DROP TABLE IF EXISTS User CASCADE;

-- Create Tables //
CREATE TABLE Category
(
	name VARCHAR(50) NULL,
	categoryID INTEGER NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (categoryID)

) ;


CREATE TABLE CategoryTags
(
	tagsID INTEGER NULL,
	categoryID INTEGER NULL,
	KEY (tagsID),
	KEY (categoryID)

) ;


CREATE TABLE Colaborator
(
	promoterID INTEGER NULL,
	normalID INTEGER NULL,
	KEY (promoterID),
	KEY (normalID)

) ;


CREATE TABLE EventDate
(
	startDate DATE NULL,
	preco DOUBLE NULL,
	endDate DATE NULL,
	dateID INTEGER NOT NULL AUTO_INCREMENT,
	eventID INTEGER NULL,
	localID INTEGER NULL,
	PRIMARY KEY (dateID),
	KEY (eventID),
	KEY (localID)

) ;


CREATE TABLE Event
(
	descrition TEXT NULL,
	name VARCHAR(50) NULL,
	propose BOOL NULL,
	averageRate DOUBLE NULL,
	numRates int NULL,
	active BOOL NULL,
	docsID VARCHAR(50) NULL,
	eventID INTEGER NOT NULL AUTO_INCREMENT,
	categoryID INTEGER NULL,
	promoterID INTEGER NULL,
	PRIMARY KEY (eventID),
	KEY (categoryID),
	KEY (promoterID)

) ;


CREATE TABLE EventTags
(
	eventID INTEGER NULL,
	tagsID INTEGER NULL,
	KEY (eventID),
	KEY (tagsID)

) ;


CREATE TABLE Image
(
	name VARCHAR(50) NULL,
	imageID INTEGER NOT NULL AUTO_INCREMENT,
	eventID INTEGER NULL,
	PRIMARY KEY (imageID),
	KEY (eventID)

) ;


CREATE TABLE Local
(
	address VARCHAR(50) NULL,
	latitude int NULL,
	longitude int NULL,
	localID INTEGER NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (localID)

) ;


CREATE TABLE Normal
(
	birthday DATE NULL,
	first_name VARCHAR(50) NULL,
	gender VARCHAR(50) NULL,
	last_name VARCHAR(50) NULL,
	normalID INTEGER NOT NULL,
	PRIMARY KEY (normalID)

) ;


CREATE TABLE Promoter
(
	contact VARCHAR(50) NULL,
	institution VARCHAR(50) NULL,
	name VARCHAR(50) NULL,
	website VARCHAR(50) NULL,
	promoterID INTEGER NOT NULL,
	PRIMARY KEY (promoterID)

) ;


CREATE TABLE Rate
(
	rate int NULL,
	rateID INTEGER NOT NULL AUTO_INCREMENT,
	eventID INTEGER NULL,
	normalID INTEGER NULL,
	PRIMARY KEY (rateID),
	KEY (eventID),
	KEY (normalID)

) ;


CREATE TABLE Registration
(
	eventID INTEGER NULL,
	normalID INTEGER NULL,
	KEY (eventID),
	KEY (normalID)

) ;


CREATE TABLE Spotify
(
	playListLink VARCHAR(50) NULL,
	spotifyID INTEGER NOT NULL AUTO_INCREMENT,
	eventID INTEGER NULL,
	PRIMARY KEY (spotifyID),
	KEY (eventID)

) ;


CREATE TABLE Tags
(
	name VARCHAR(50) NULL,
	tagsID INTEGER NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (tagsID)

) ;


 CREATE TABLE User (
  password varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  admin tinyint(1) DEFAULT NULL,
  userID int(11) NOT NULL AUTO_INCREMENT,
  email varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  encrypted_password varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  reset_password_token varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  reset_password_sent_at datetime DEFAULT NULL,
  remember_created_at datetime DEFAULT NULL,
  sign_in_count int(11) NOT NULL DEFAULT '0',
  current_sign_in_at datetime DEFAULT NULL,
  last_sign_in_at datetime DEFAULT NULL,
  current_sign_in_ip varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  last_sign_in_ip varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  provider varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  uid varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (userID),
  UNIQUE KEY index_User_on_email (email),
  UNIQUE KEY index_User_on_reset_password_token (reset_password_token),
  KEY index_User_on_provider (provider),
  KEY index_User_on_uid (uid)
) ;


CREATE TABLE Youtube
(
	videoID VARCHAR(50) NULL,
	youtubeID INTEGER NOT NULL AUTO_INCREMENT,
	eventID INTEGER NULL,
	PRIMARY KEY (youtubeID),
	KEY (eventID)

) ;



SET FOREIGN_KEY_CHECKS=1;


-- Create Foreign Key Constraints //
ALTER TABLE CategoryTags ADD CONSTRAINT FK_CategoryTags_Tags
	FOREIGN KEY (tagsID) REFERENCES Tags (tagsID);

ALTER TABLE CategoryTags ADD CONSTRAINT FK_CategoryTags_Category 
	FOREIGN KEY (categoryID) REFERENCES Category (categoryID);

ALTER TABLE Colaborator ADD CONSTRAINT FK_Colaborator_Promoter
	FOREIGN KEY (promoterID) REFERENCES Promoter (promoterID);

ALTER TABLE Colaborator ADD CONSTRAINT FK_Colaborator_Normal 
	FOREIGN KEY (normalID) REFERENCES Normal (normalID);

ALTER TABLE EventDate ADD CONSTRAINT FK_Date_Event 
	FOREIGN KEY (eventID) REFERENCES Event (eventID);

ALTER TABLE EventDate ADD CONSTRAINT FK_Date_Local 
	FOREIGN KEY (localID) REFERENCES Local (localID);

ALTER TABLE Event ADD CONSTRAINT FK_Event_Category 
	FOREIGN KEY (categoryID) REFERENCES Category (categoryID);

ALTER TABLE Event ADD CONSTRAINT FK_Event_Promoter 
	FOREIGN KEY (promoterID) REFERENCES Promoter (promoterID);

ALTER TABLE EventTags ADD CONSTRAINT FK_EventTags_Event
	FOREIGN KEY (eventID) REFERENCES Event (eventID);

ALTER TABLE EventTags ADD CONSTRAINT FK_EventTags_Tags
	FOREIGN KEY (tagsID) REFERENCES Tags (tagsID);

ALTER TABLE Image ADD CONSTRAINT FK_Image_Event 
	FOREIGN KEY (eventID) REFERENCES Event (eventID);

ALTER TABLE Normal ADD CONSTRAINT FK_Normal_User 
	FOREIGN KEY (normalID) REFERENCES User (userID);

ALTER TABLE Promoter ADD CONSTRAINT FK_Promoter_User 
	FOREIGN KEY (promoterID) REFERENCES User (userID);

ALTER TABLE Rate ADD CONSTRAINT FK_Rate_Event 
	FOREIGN KEY (eventID) REFERENCES Event (eventID);

ALTER TABLE Rate ADD CONSTRAINT FK_Rate_Normal 
	FOREIGN KEY (normalID) REFERENCES Normal (normalID);

ALTER TABLE Registration ADD CONSTRAINT FK_Registration_Event 
	FOREIGN KEY (eventID) REFERENCES Event (eventID);

ALTER TABLE Registration ADD CONSTRAINT FK_Registration_Normal 
	FOREIGN KEY (normalID) REFERENCES Normal (normalID);

ALTER TABLE Spotify ADD CONSTRAINT FK_Spotify_Event 
	FOREIGN KEY (eventID) REFERENCES Event (eventID);

ALTER TABLE Youtube ADD CONSTRAINT FK_Youtube_Event 
	FOREIGN KEY (eventID) REFERENCES Event (eventID);
