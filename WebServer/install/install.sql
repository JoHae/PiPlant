CREATE DATABASE IF NOT EXISTS PiPlant;

DROP TABLE DeviceAttribute;
DROP TABLE Actions;
DROP TABLE DeviceType;
DROP TABLE Device;

CREATE TABLE DeviceType (
	name VARCHAR(50) NOT NULL,
	description BLOB,
	busSystem VARCHAR(50),
	PRIMARY KEY (name)
);

CREATE TABLE Device (
	id VARCHAR(50) NOT NULL,
	name VARCHAR(50) NOT NULL,
	description BLOB,
	busAdress VARCHAR(50),
	deviceTypeName VARCHAR(50),
	FOREIGN KEY (deviceTypeName) REFERENCES DeviceType(name) ON DELETE CASCADE,
	PRIMARY KEY (id)
);

CREATE TABLE DeviceAttribute (
	name VARCHAR(50) NOT NULL,
	deviceId VARCHAR(50),
	FOREIGN KEY (deviceId) REFERENCES Device(id) ON DELETE CASCADE,
	PRIMARY KEY (name)
);

CREATE TABLE Actions (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	description BLOB,
	parameter VARCHAR(100),
	script VARCHAR(50),
	deviceTypeName VARCHAR(50),
	FOREIGN KEY (deviceTypeName) REFERENCES DeviceType(name) ON DELETE CASCADE,
	PRIMARY KEY (id)
);

CREATE TABLE StringValues (
	version BIGINT NOT NULL,
	[value] VARCHAR(100),
	[timestamp] TIMESTAMP,
	attributeName VARCHAR(50),
	FOREIGN KEY (attributeName) REFERENCES DeviceAttribute(name) ON DELETE CASCADE,
	PRIMARY KEY (version)
);

CREATE TABLE IntValues (
	version BIGINT NOT NULL,
	[value] INT,
	[timestamp] TIMESTAMP,
	attributeName VARCHAR(50),
	FOREIGN KEY (attributeName) REFERENCES DeviceAttribute(name) ON DELETE CASCADE,
	PRIMARY KEY (version)
);

CREATE TABLE DoubleValues (
	version BIGINT NOT NULL,
	[value] DOUBLE,
	[timestamp] TIMESTAMP,
	attributeName VARCHAR(50),
	FOREIGN KEY (attributeName) REFERENCES DeviceAttribute(name) ON DELETE CASCADE,
	PRIMARY KEY (version)
);