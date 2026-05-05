/*
SQLyog Ultimate v11.33 (64 bit)
MySQL - 5.0.45-community-nt : Database - studentinnvotive
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`studentinnvotive` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `studentinnvotive`;

/*Table structure for table `event` */

DROP TABLE IF EXISTS `event`;

CREATE TABLE `event` (
  `event_id` varchar(20) NOT NULL,
  `event_name` varchar(100) default NULL,
  `start_date` date default NULL,
  `end_date` date default NULL,
  `categories` text,
  `status` varchar(200) default NULL,
  PRIMARY KEY  (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `event` */

insert  into `event`(`event_id`,`event_name`,`start_date`,`end_date`,`categories`,`status`) values ('EID1','Campus Hacker 2026','2026-04-17','2026-04-24','Coding,Software Development,Problem Solving','Open'),('EID2','Cultural Fest (Utsav)','2026-04-19','2026-04-25','Cultural,Arts,Entertainment','Open'),('EID3','Rock With Robos (Robotics Competition)','2026-04-16','2026-04-22','Robotics,Automation,Technical','Open'),('EID4','CampusGreen','2026-03-31','2026-04-07','Greenary,Plantation activities includes fun,Raising awareness about public cleanliness ','Open');

/*Table structure for table `feedback` */

DROP TABLE IF EXISTS `feedback`;

CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL auto_increment,
  `student_id` varchar(20) default NULL,
  `category` varchar(100) default NULL,
  `rating` int(11) default NULL,
  `message` text,
  `feedback_date` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`feedback_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `feedback` */

insert  into `feedback`(`feedback_id`,`student_id`,`category`,`rating`,`message`,`feedback_date`) values (1,'22711A0540','Website Experience',3,'I am not receiving notifications fast so i can respond more fastly','2026-04-17 15:02:07');

/*Table structure for table `idea_votes` */

DROP TABLE IF EXISTS `idea_votes`;

CREATE TABLE `idea_votes` (
  `vote_id` int(11) NOT NULL auto_increment,
  `idea_id` int(11) default NULL,
  `student_id` varchar(20) default NULL,
  `vote_type` varchar(10) default NULL,
  `vote_date` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `faculty_id` varchar(10) default NULL,
  PRIMARY KEY  (`vote_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Data for the table `idea_votes` */

insert  into `idea_votes`(`vote_id`,`idea_id`,`student_id`,`vote_type`,`vote_date`,`faculty_id`) values (1,1,'22711A0546','LIKE','2026-04-17 13:06:20',NULL),(2,1,'22711A0553','LIKE','2026-04-17 13:49:35',NULL),(3,1,NULL,'LIKE','2026-04-17 14:03:54','FID1'),(4,2,NULL,'LIKE','2026-04-17 14:03:57','FID1'),(5,3,NULL,'DISLIKE','2026-04-17 14:51:15','FID2'),(6,2,NULL,'LIKE','2026-04-17 14:51:24','FID2'),(7,1,NULL,'LIKE','2026-04-17 14:51:26','FID2'),(8,1,'22711A0540','LIKE','2026-04-17 15:00:16',NULL),(9,2,'22711A0540','LIKE','2026-04-17 15:00:17',NULL),(10,3,'22711A0540','LIKE','2026-04-17 15:00:19',NULL);

/*Table structure for table `login` */

DROP TABLE IF EXISTS `login`;

CREATE TABLE `login` (
  `id` int(10) NOT NULL auto_increment,
  `username` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `auth` int(10) NOT NULL,
  PRIMARY KEY  (`username`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `login` */

insert  into `login`(`id`,`username`,`password`,`auth`) values (9,'22711A0506','12345',2),(8,'22711A0540','12345',2),(6,'22711A0546','12345',2),(7,'22711A0553','12345',2),(1,'admin','admin',0),(2,'FID1','12345',1),(3,'FID2','12345',1),(4,'FID3','12345',1),(5,'FID4','12345',1);

/*Table structure for table `remarks` */

DROP TABLE IF EXISTS `remarks`;

CREATE TABLE `remarks` (
  `id` int(11) NOT NULL auto_increment,
  `idea_id` int(11) default NULL,
  `faculty_id` varchar(100) default NULL,
  `remark` text,
  `created_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `idea_id` (`idea_id`,`faculty_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `remarks` */

insert  into `remarks`(`id`,`idea_id`,`faculty_id`,`remark`,`created_at`) values (1,3,'FID1','Game setup requires a more physical setup and management so propose a more possible of implementation and cost details','2026-04-17 14:06:10'),(2,2,'FID2','Disaster management requires a quite few robots more than one or two is it possible for  students to jointly create various robots to demonstrate the real-time disastrous situations','2026-04-17 14:56:42'),(3,3,'FID2','can you mention type of games','2026-04-17 14:57:04'),(4,1,'FID2','I think its definitely going to be fun ','2026-04-17 14:57:42');

/*Table structure for table `staff` */

DROP TABLE IF EXISTS `staff`;

CREATE TABLE `staff` (
  `stid` varchar(10) NOT NULL,
  `stname` varchar(250) NOT NULL,
  `dname` varchar(250) NOT NULL,
  `designation` varchar(250) NOT NULL,
  `password` varchar(250) NOT NULL,
  `status` varchar(250) NOT NULL,
  PRIMARY KEY  (`stid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `staff` */

insert  into `staff`(`stid`,`stname`,`dname`,`designation`,`password`,`status`) values ('FID1','V. Kusuma Priya','CSE','Assistant Professor','12345','Active'),('FID2','P. Anand Kumar','ECE','Associate Professor','12345','Active'),('FID3','N.Aruna Kumari','MCA','Professor','12345','Active'),('FID4','Dr . Madhukar','CSE','Professor','12345','Active');

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `srno` varchar(10) NOT NULL,
  `sname` varchar(250) NOT NULL,
  `dname` varchar(100) NOT NULL,
  `year` varchar(100) NOT NULL,
  `sem` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL default '12345',
  `status` varchar(100) NOT NULL,
  `email` varchar(250) default NULL,
  PRIMARY KEY  (`srno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `student` */

insert  into `student`(`srno`,`sname`,`dname`,`year`,`sem`,`password`,`status`,`email`) values ('22711A0506','B . Ankitha','CSE','IV','II','12345','Active','ankithabadolu@gmail.com'),('22711A0540','N . Neelaveni','CSE','IV','II','12345','Active','nandipatineelaveni@gmail.com'),('22711A0546','P. Samanvitha','CSE','IV','II','12345','Active','samanvithapavuralla@gmail.com'),('22711A0553','SK .Alfiya','CSE','IV','II','12345','Active','alfiyashaik44@gmail.com');

/*Table structure for table `submissions` */

DROP TABLE IF EXISTS `submissions`;

CREATE TABLE `submissions` (
  `id` int(11) NOT NULL auto_increment,
  `student_id` varchar(20) default NULL,
  `student_name` varchar(100) default NULL,
  `event_id` varchar(20) default NULL,
  `idea_title` varchar(200) default NULL,
  `idea_description` text,
  `submission_date` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `score` int(10) default '0',
  `filename` varchar(100) default NULL,
  `filepath` varchar(250) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `submissions` */

insert  into `submissions`(`id`,`student_id`,`student_name`,`event_id`,`idea_title`,`idea_description`,`submission_date`,`score`,`filename`,`filepath`) values (1,'22711A0546','P. Samanvitha','EID3','RoboDance Arena','RoboDance Arena is an exciting idea where robots are programmed to perform dance movements synchronized with music. Participants design robots that can move rhythmically and creatively, showcasing both technical and artistic skills. This event adds entertainment value to the robotics competition while attracting a wider audience. It combines creativity, programming, and coordination in a fun and engaging way.','2026-04-17 13:06:09',5,'1776411369488_RoboDance_Arena.pdf','C:/IdeaUploads\\1776411369488_RoboDance_Arena.pdf'),(2,'22711A0553','SK .Alfiya','EID3','RescueBot Challenge','RescueBot Challenge is a robotics event where participants design robots to simulate rescue operations in disaster scenarios. Robots must navigate obstacles and complete specific tasks such as picking objects or reaching target locations. This idea focuses on real-world problem-solving and practical applications of robotics. It encourages students to think innovatively and develop socially impactful solutions.','2026-04-17 13:59:19',3,'1776414559526_RescueBot_Challenge.pdf','C:/IdeaUploads\\1776414559526_RescueBot_Challenge.pdf'),(3,'22711A0540','N . Neelaveni','EID3','RoboGame Zone','RoboGame Zone introduces interactive robot-based games where participants create robots to play mini-games like line-following races or object collection challenges. This idea makes robotics more engaging and accessible to all students, including non-technical participants. It promotes teamwork, creativity, and competitive spirit. The event adds a fun and energetic element to the robotics competition.','2026-04-17 14:02:04',1,'1776414724400_RoboGame_Zone.pdf','C:/IdeaUploads\\1776414724400_RoboGame_Zone.pdf'),(4,'22711A0540','N . Neelaveni','EID1','Smart Campus Navigation System','Smart Campus Navigation System is an idea to help students and visitors easily locate classrooms, labs, and event venues within the campus using a web or mobile interface. The system provides real-time directions and interactive maps for efficient navigation. It reduces confusion during large events and improves accessibility. This idea enhances the overall campus experience using simple technology.','2026-04-17 15:04:41',NULL,'1776418481354_Smart_Campus_Navigation_System.pdf','C:/IdeaUploads\\1776418481354_Smart_Campus_Navigation_System.pdf');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
