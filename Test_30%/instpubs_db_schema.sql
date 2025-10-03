DROP DATABASE IF EXISTS pubs;

CREATE DATABASE IF NOT EXISTS  pubs ;

USE pubs;


CREATE TABLE IF NOT EXISTS authors
(
   au_id          varchar(11),
   au_lname       varchar(40)       NOT NULL,
   au_fname       varchar(20)       NOT NULL,
   phone          char(12)          NOT NULL    DEFAULT 'UNKNOWN',
   address        varchar(40)           NULL,
   city           varchar(20)           NULL,
   state          char(2)               NULL,
   zip            char(5)               NULL,
   contract       bit               NOT NULL, 
   primary key(au_id)
);



CREATE TABLE  IF NOT EXISTS publishers
(
   pub_id         char(4)           NOT NULL,
	pub_name       varchar(40)           NULL,
   city           varchar(20)           NULL,
   state          char(2)               NULL,
   country        varchar(30)           NULL       DEFAULT 'USA',
   primary key(pub_id)
);


CREATE TABLE  IF NOT EXISTS titles
(
   title_id       varchar(6),
   title          varchar(80)       NOT NULL,
   genre           char(12)          NOT NULL     DEFAULT 'UNDECIDED',
   pub_id         char(4)               NULL,
   price          DECIMAL                 NULL,
   advance        DECIMAL               NULL,
   royalty        int                   NULL,
   ytd_sales      int                   NULL,
   notes          varchar(200)          NULL,
   pubdate        datetime              NULL,
   primary key(title_id),
	foreign key (pub_id) references publishers(pub_id)         
);

CREATE TABLE IF NOT EXISTS titleauthor
(
   au_id          varchar(11),
   title_id       varchar(6),
   au_ord         tinyint               NULL,
   royaltyper     int                   NULL,
   PRIMARY KEY (au_id, title_id),
   FOREIGN KEY (au_id) references authors(au_id),
   FOREIGN KEY(title_id) references titles(title_id)
);


CREATE TABLE IF NOT EXISTS stores
(
   stor_id        char(4)           NOT NULL,
   stor_name      varchar(40)           NULL,
   stor_address   varchar(40)           NULL,
   city           varchar(20)           NULL,
   state          char(2)               NULL,
   zip            char(5)               NULL, 
   PRIMARY KEY(stor_id)
); 


CREATE TABLE IF NOT EXISTS sales
(
   stor_id        char(4)           NOT NULL,
   ord_num        varchar(20)       NOT NULL,
   ord_date       datetime          NOT NULL,
   qty            smallint          NOT NULL,
   payterms       varchar(12)       NOT NULL,
   title_id       varchar(6),
   PRIMARY KEY (stor_id, ord_num, title_id),
   FOREIGN KEY(stor_id) references stores(stor_id),
   FOREIGN KEY(title_id) references titles(title_id)
);


CREATE TABLE IF NOT EXISTS roysched
(
   title_id       varchar(6),
   lorange        int                   NULL,
   hirange        int                   NULL,
   royalty        int                   NULL,
   FOREIGN KEY (title_id) references titles(title_id)
);

CREATE TABLE IF NOT EXISTS discounts
(
   discounttype   varchar(40)       NOT NULL,
   stor_id        char(4) NULL,
   lowqty         smallint              NULL,
   highqty        smallint              NULL,
   discount       dec(4,2)          NOT NULL,
   FOREIGN KEY(stor_id) references stores(stor_id)
);


CREATE TABLE IF NOT EXISTS jobs
(
   job_id         smallint          AUTO_INCREMENT,
   job_desc       varchar(50)       NOT NULL      DEFAULT 'New Position - title not formalized yet',
   min_lvl        smallint           NOT NULL      CHECK (min_lvl >= 10),
   max_lvl        smallint           NOT NULL      CHECK (max_lvl <= 250),
   PRIMARY KEY(job_id)      
);

CREATE TABLE IF NOT EXISTS pub_info
(
   pub_id         char(4)           NOT NULL,
   logo           blob                 NULL,
   pr_info        text                  NULL, 
   PRIMARY KEY (pub_id),
   FOREIGN KEY (pub_id) references publishers(pub_id)
);


CREATE TABLE IF NOT EXISTS employee
(
   emp_id         varchar(9),
   fname          varchar(20)       NOT NULL,
   minit          char(1)               NULL,
   lname          varchar(30)       NOT NULL,
   job_id         smallint          NOT NULL     DEFAULT 1,

   job_lvl        smallint           DEFAULT 10,
   pub_id         char(4)           NOT NULL     DEFAULT '9952', 
   hire_date      datetime          NULL, 
   PRIMARY KEY (emp_id),
   FOREIGN KEY  (job_id) references jobs(job_id),
   FOREIGN KEY  (pub_id) references publishers(pub_id)
);