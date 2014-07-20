CREATE TABLE "distributori" (
  "id" int(6) NOT NULL PRIMARY KEY,
  "name" varchar(100) NOT NULL,
  "bnd" varchar(30) NOT NULL,
  "lat" float NOT NULL,
  "lon" float NOT NULL,
  "addr" varchar(100) NOT NULL,
  "comune" varchar(30) NOT NULL,
  "provincia" varchar(4) NOT NULL
);

CREATE TABLE "prezzi" (
  "id_d" int(6) NOT NULL,
  "dIns" datetime NOT NULL,
  "carb" varchar(20) NOT NULL,
  "isSelf" int(1) NOT NULL,
  "prezzo" float NOT NULL
);
