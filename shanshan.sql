/*
SQLyog Ultimate
MySQL - 5.7.26 : Database - shanshan
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`shanshan` /*!40100 DEFAULT CHARACTER SET utf8 */;

/*Table structure for table `tp_auth` */

CREATE TABLE `tp_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `auth_num` int(6) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

/*Data for the table `tp_auth` */

insert  into `tp_auth`(`id`,`auth_num`,`state`) values (18,397635,NULL);
insert  into `tp_auth`(`id`,`auth_num`,`state`) values (17,235522,'不可用');
insert  into `tp_auth`(`id`,`auth_num`,`state`) values (30,154634,NULL);
insert  into `tp_auth`(`id`,`auth_num`,`state`) values (29,754975,NULL);

/*Table structure for table `tp_comments` */

CREATE TABLE `tp_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` varchar(20) DEFAULT NULL,
  `goodsid` int(20) DEFAULT NULL,
  `username` varchar(200) DEFAULT NULL,
  `comment` varchar(500) DEFAULT NULL,
  `degree` int(11) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `imgs` varchar(400) DEFAULT NULL,
  `imgnums` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=231 DEFAULT CHARSET=utf8;

/*Data for the table `tp_comments` */

insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (168,'2203280857466347',13,'admin2','啊啊啊啊啊啊啊',5,'2022-03-28 09:02:52','/comments/20220328\\7f2f7e3d2bc48086464a7adef0d461e1.jfif,/comments/20220328\\0ea12052a46aca5b902edb4b58d1ae0e.png,/comments/20220328\\d2b9ea3b5f47aafa7e4fb045c6a0a377.png,/comments/20220328\\eb3b0f78fda196ae529c6be60eb731ef.png,/comments/20220328\\92935d25ca6fb94ec23894aab4bbe2f7.png',5);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (167,'2203280857466347',5,'admin2','为什么每次只能上传一张',5,'2022-03-28 09:02:35','/comments/20220328\\5476e525d19c383ea1a68eb7ff2c8608.png,/comments/20220328\\cd8988debe6d637dfed2c600d5bfed6d.png,/comments/20220328\\d9dbbafd255a4f332be07c230b092d15.png,/comments/20220328\\25d6641628e15607fd137ebb47486961.png,/comments/20220328\\dcc00b9265823d307c8e80d121aae359.png',5);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (166,'2203280857048599',13,'admin2','更好发挥分隔符',5,'2022-03-28 09:01:56','/comments/20220328\\223e82040dfc49ab90dc001f2bdd8685.png,/comments/20220328\\66a2e27d048fc9b3dce91c3a4eb75a59.png,/comments/20220328\\ee9899e42d3a7c6dfa4f6c30dd4a8f6f.png,/comments/20220328\\a608f490a275369a895267bba281e777.png,/comments/20220328\\b95372bbde4d65a303fe16612548ca8a.png',5);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (165,'2203280857189913',7,'admin2','啊啊啊啊啊啊啊啊',5,'2022-03-28 09:00:27','/comments/20220328\\c02fed4d08243f275863701b4648b170.jfif,/comments/20220328\\be93ee58e59a95a87d6e14f2f6c5e1ab.png,/comments/20220328\\07c6d43381fdb20bd931e0b540a28615.png,/comments/20220328\\bf20611c0dc59211b00403676bbda76f.png,/comments/20220328\\ae9b25340b1b9f113f04a195535f09d4.png',5);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (164,'2203280846055457',14,'admin2','我爱吃核桃啊啊啊啊啊',5,'2022-03-28 08:48:58','/comments/20220328\\5933cad97fa9c4e7f003c77afcea5961.jpg,/comments/20220328\\ad3c9b0d651cb4d4a18a4986d6b0401e.png,/comments/20220328\\23622054542a3f1c1a5295f36baa93e9.jpg,/comments/20220328\\a2ae64a473c1df31903fa99b0c678c66.jpg,/comments/20220328\\8cc658f38bf2e0cf36b26fdf7a65ca5b.jfif',5);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (162,'2203280843500121',12,'admin2','啊啊啊啊啊啊',3,'2022-03-28 08:45:11',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (163,'2203280845584336',14,'admin2','啊啊啊啊啊啊啊',5,'2022-03-28 08:46:36','/comments/20220328\\31fc95a80a4b52fcecdce2b4d71c3dcc.jpg',1);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (160,'2203272252559510',14,'admin1','小洋有点傻逼，哈哈哈哈',4,'2022-03-27 22:53:54',NULL,3);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (161,'2203280844204703',12,'admin2','酷酷酷酷酷酷酷酷',5,'2022-03-28 08:44:51','/comments/20220328\\3733d4839f2bda6e8c956edafe41312b.jfif',1);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (158,'2203272252344493',12,'admin1','',2,'2022-03-27 22:53:46',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (159,'2203272252489219',12,'admin1','',4,'2022-03-27 22:53:50',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (157,'2203272253047341',12,'admin1','',5,'2022-03-27 22:53:42',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (169,'2203280857466347',10,'admin2','啊沙发上大苏打撒旦撒',5,'2022-03-28 09:03:10','/comments/20220328\\79da8f5d04ca419aa729a750ab15f0f1.jpg,/comments/20220328\\ac918ef027aa1484554f061054f7c354.jpg,/comments/20220328\\958ef06b2dab84f072a4ec0edfe9f82b.jpg,/comments/20220328\\fb6ded6c3b4492e344736e84852e27d9.jpg,/comments/20220328\\62f621327ae5e5b26d5a11a81cc55a63.jpg',5);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (170,'2203281011265092',14,'admin1','aaaaaaaaa',5,'2022-03-28 10:12:20',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (171,'2203281037044108',14,'admin1','',5,'2022-03-28 11:06:23','/comments/20220328\\8bff70e928490ad4e1e7b91521295a37.jpg',1);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (172,'2203281036131115',13,'admin1','',5,'2022-03-28 11:07:35','/comments/20220328\\a702f454d11ff52844f973935c48fad0.jpg',1);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (173,'2203281036131115',5,'admin1','',5,'2022-03-28 11:18:31',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (174,'2203281037044108',10,'admin1','',5,'2022-03-28 11:24:40',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (175,'2203281116559415',14,'admin1','',5,'2022-03-28 11:27:18',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (176,'2203281116559415',7,'admin1','',5,'2022-03-28 11:27:19',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (177,'2203281036131115',12,'admin1','',5,'2022-03-28 12:28:31',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (178,'2203281011110893',13,'admin1','',2,'2022-03-28 14:35:38',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (179,'2204011602118383',12,'admin1','',5,'2022-04-01 18:27:45',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (180,'2204011337555472',NULL,'admin1','',5,'2022-04-01 18:35:41',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (181,'2204011337555472',NULL,'admin1','',5,'2022-04-01 18:36:54',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (182,'2204011337555472',1,'admin1','终于好了，哇哇哇哇哇哇哇哇哇哇哇哇哇',5,'2022-04-01 18:37:41',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (183,'2204011337555472',1,'admin1','终于好了，哇哇哇哇哇哇哇哇哇哇哇哇哇',5,'2022-04-01 18:39:39',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (184,'2204011840242192',12,'admin1','',5,'2022-04-01 18:42:14',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (185,'2204011336527131',5,'admin1','',5,'2022-04-01 18:44:59',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (186,'2204011336527131',1,'admin1','',5,'2022-04-01 18:46:12',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (187,'2204011846251049',12,'admin1','',5,'2022-04-01 18:46:38',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (188,'2204011336527131',13,'admin1','',5,'2022-04-01 18:51:10',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (189,'2204011336242612',5,'admin1','',5,'2022-04-01 18:56:14',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (190,'2204011336242612',12,'admin1','',5,'2022-04-01 18:56:20',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (191,'2204011336242612',12,'admin1','',5,'2022-04-01 18:56:36',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (192,'2204011857243609',7,'admin1','',5,'2022-04-01 18:57:58',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (193,'2204011857243609',5,'admin1','',5,'2022-04-01 18:58:21',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (194,'2204011857243609',13,'admin1','',5,'2022-04-01 18:58:45',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (195,'2204011857243609',12,'admin1','',5,'2022-04-01 19:00:25',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (196,'2204011901547983',10,'admin1','',5,'2022-04-01 19:02:37',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (197,'2204011901547983',14,'admin1','',5,'2022-04-01 19:02:42',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (198,'2204011901547983',7,'admin1','',5,'2022-04-01 19:02:49',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (199,'2204011901547983',5,'admin1','',5,'2022-04-01 19:02:53',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (200,'2204011901547983',13,'admin1','',5,'2022-04-01 19:02:58',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (201,'2204011901547983',12,'admin1','',5,'2022-04-01 19:03:04',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (202,'2204011904229502',13,'admin1','',5,'2022-04-01 19:04:42',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (203,'2204011904229502',12,'admin1','',5,'2022-04-01 19:04:45',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (204,'2204011640372482',12,'admin2','',5,'2022-04-02 13:15:45','/comments/20220402\\ed0572293a9bbc80cb7503089e3907ee.png',1);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (205,'2204021419093012',13,'admin2','唉唉唉',5,'2022-04-02 14:19:46','/comments/20220402\\47d89dc34404f28d5f257e80ce92e02e.jfif',1);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (206,'2204021419093012',12,'admin2','啊阿萨大大大大大丰富v广告贴用户体验和',5,'2022-04-02 14:22:17','/comments/20220402\\783ee9675d46a1964b3bbb625f3ddec6.jpg',1);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (207,'2204021422488258',13,'admin2','',5,'2022-04-02 14:23:15','/comments/20220402\\f6293359494b52e7d152d7fc6d42f369.png',1);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (208,'2204021422488258',12,'admin2','',5,'2022-04-02 14:24:48','/comments/20220402\\9254f8eec26496feebe8d807bd9785f6.jfif',1);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (209,'2204171940350813',14,'admin1','aa',2,'2022-04-17 19:42:57',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (210,'2204171940350813',12,'admin1','aaa',3,'2022-04-17 19:43:01',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (211,'2204171940350813',7,'admin1','wwwwwwww',1,'2022-04-17 19:43:04',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (212,'2204171940350813',13,'admin1','wwwwwwww',4,'2022-04-17 19:43:08',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (213,'2204171940350813',5,'admin1','eeeeeeeeeee',5,'2022-04-17 19:43:13',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (214,'2204171944266189',14,'admin1','',1,'2022-04-17 19:44:52',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (215,'2204171944266189',7,'admin1','',2,'2022-04-17 19:44:54',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (216,'2204171944266189',5,'admin1','',3,'2022-04-17 19:44:56',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (217,'2204171944266189',13,'admin1','',4,'2022-04-17 19:44:57',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (218,'2204171944266189',12,'admin1','',5,'2022-04-17 19:44:58',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (219,'2204171940093710',12,'admin1','',2,'2022-04-17 19:50:28',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (220,'2204171954545732',5,'admin1','',1,'2022-04-17 19:56:14','/comments/20220417\\ea9eca4a1d41a6ff1a68c56a1c29f042.png',1);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (221,'2204171954199322',5,'admin1','',4,'2022-04-17 19:56:37','/comments/20220417\\cdc8e7b8af9390760b896ecf61958071.jpg',1);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (222,'2204171954489057',14,'admin1','',3,'2022-04-17 19:57:33',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (223,'2204171954436817',10,'admin1','',1,'2022-04-17 19:57:36',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (224,'2204171954382778',12,'admin1','',1,'2022-04-17 19:57:38',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (225,'2204171954317339',12,'admin1','',3,'2022-04-17 19:57:41',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (226,'2204171954199322',13,'admin1','',5,'2022-04-17 19:57:43',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (227,'2204171954199322',12,'admin1','',3,'2022-04-17 19:57:46',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (228,'2204171954042106',5,'admin1','',4,'2022-04-17 19:57:48',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (229,'2204171954042106',13,'admin1','',3,'2022-04-17 19:57:51',NULL,0);
insert  into `tp_comments`(`id`,`orderid`,`goodsid`,`username`,`comment`,`degree`,`time`,`imgs`,`imgnums`) values (230,'2204171954042106',12,'admin1','',2,'2022-04-17 19:57:54',NULL,0);

/*Table structure for table `tp_goods` */

CREATE TABLE `tp_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goodsname` varchar(100) DEFAULT NULL,
  `goodstype` int(6) DEFAULT NULL,
  `goodsprice` decimal(10,2) DEFAULT NULL,
  `goodsimg` varchar(300) DEFAULT NULL,
  `goodsman` varchar(30) DEFAULT 'admin',
  `like` tinyint(1) DEFAULT '0',
  `likes` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

/*Data for the table `tp_goods` */

insert  into `tp_goods`(`id`,`goodsname`,`goodstype`,`goodsprice`,`goodsimg`,`goodsman`,`like`,`likes`) values (12,'redmi k40',1001,1999.00,'/uploads/goods/20220307\\ccf6a43176c1302f20b29ed620d3a05a.jpg','admin',0,6);
insert  into `tp_goods`(`id`,`goodsname`,`goodstype`,`goodsprice`,`goodsimg`,`goodsman`,`like`,`likes`) values (13,'大手机',1001,3999.00,'/uploads/goods/20220307\\393062e47667f7468da0eafc6b15c7d2.png','admin',0,5);
insert  into `tp_goods`(`id`,`goodsname`,`goodstype`,`goodsprice`,`goodsimg`,`goodsman`,`like`,`likes`) values (5,'笔记本',1002,6999.00,'/uploads/goods/20220306\\7284707d7c60bfc798fc224a8cc942fd.jpg','admin',0,3);
insert  into `tp_goods`(`id`,`goodsname`,`goodstype`,`goodsprice`,`goodsimg`,`goodsman`,`like`,`likes`) values (7,'苹果',2001,4.00,'/uploads/goods/20220306\\0d5a2a7415dc34bb3c6d836fd2f2b6e4.jfif','admin',0,1);
insert  into `tp_goods`(`id`,`goodsname`,`goodstype`,`goodsprice`,`goodsimg`,`goodsman`,`like`,`likes`) values (14,'核桃',2001,6.00,'/uploads/goods/20220309\\1bb97835c3e639b2f158bd27a50d5189.jfif','admin',0,2);
insert  into `tp_goods`(`id`,`goodsname`,`goodstype`,`goodsprice`,`goodsimg`,`goodsman`,`like`,`likes`) values (10,'祁东辣霸王',2003,3.00,'/uploads/goods/20220306\\f28bc2a0a0f3162b3907d197b0868339.jfif','admin',0,1);
insert  into `tp_goods`(`id`,`goodsname`,`goodstype`,`goodsprice`,`goodsimg`,`goodsman`,`like`,`likes`) values (17,'Redmi K50',1001,3999.00,'/uploads/goods/20220320\\de7b4110b47e2fd376373d0fca88db56.png','lycwss',0,1);
insert  into `tp_goods`(`id`,`goodsname`,`goodstype`,`goodsprice`,`goodsimg`,`goodsman`,`like`,`likes`) values (18,'我的',2001,22.00,'/uploads/goods/20220321\\e95e4a69b8ed929546e7fea868be0b1d.jpg','lycwss',0,2);
insert  into `tp_goods`(`id`,`goodsname`,`goodstype`,`goodsprice`,`goodsimg`,`goodsman`,`like`,`likes`) values (19,'啊啊啊',2001,2222.00,'/uploads/goods/20220325\\78a3f7ea2ea8fb7aa779a57240b1b47b.jfif','lycwss',0,1);

/*Table structure for table `tp_goodstype` */

CREATE TABLE `tp_goodstype` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `typeid` int(6) DEFAULT NULL,
  `typename` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `tp_goodstype` */

insert  into `tp_goodstype`(`id`,`typeid`,`typename`) values (1,1001,'手机数码');
insert  into `tp_goodstype`(`id`,`typeid`,`typename`) values (2,1002,'电脑数码');
insert  into `tp_goodstype`(`id`,`typeid`,`typename`) values (3,2001,'水果');
insert  into `tp_goodstype`(`id`,`typeid`,`typename`) values (4,2002,'零食');
insert  into `tp_goodstype`(`id`,`typeid`,`typename`) values (5,2003,'辣条');

/*Table structure for table `tp_like` */

CREATE TABLE `tp_like` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `goodsid` int(11) DEFAULT NULL,
  `like` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

/*Data for the table `tp_like` */

insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (33,'admin1',12,1);
insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (35,'admin1',13,1);
insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (39,'admin1',14,1);
insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (44,'123123',5,1);
insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (36,'admin1',5,1);
insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (37,'admin1',7,1);
insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (38,'admin2',12,1);
insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (40,'admin1',10,1);
insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (41,'admin1',17,1);
insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (42,'admin1',18,1);
insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (55,'admin1',19,1);
insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (43,'admin2',13,0);
insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (45,'123123',12,1);
insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (46,'123123',13,1);
insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (47,'123123',14,1);
insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (48,'520520',12,1);
insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (49,'520520',13,1);
insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (50,'520520',5,1);
insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (51,'admin00',12,1);
insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (52,'admin00',13,1);
insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (53,'admin6',12,1);
insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (54,'admin6',13,1);
insert  into `tp_like`(`id`,`username`,`goodsid`,`like`) values (56,'13203079767',18,1);

/*Table structure for table `tp_order` */

CREATE TABLE `tp_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` varchar(20) DEFAULT NULL,
  `goodsname` varchar(300) DEFAULT NULL,
  `goodsprice` decimal(10,2) DEFAULT NULL,
  `goodsimg` varchar(500) DEFAULT NULL,
  `goodsnum` int(10) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `state` int(10) DEFAULT NULL COMMENT '单商品订单状态',
  `username` varchar(300) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `type` int(1) DEFAULT '1' COMMENT '为1单种商品',
  `nums` varchar(300) DEFAULT NULL,
  `prices` varchar(300) DEFAULT NULL,
  `statename` varchar(100) DEFAULT '待发货',
  `expiration` datetime DEFAULT NULL,
  `goodsman` varchar(500) DEFAULT NULL,
  `goodsid` varchar(100) DEFAULT NULL,
  `comstate` varchar(100) DEFAULT NULL COMMENT '评论状态',
  `states` varchar(50) DEFAULT NULL COMMENT '多商品订单状态',
  `reback` varchar(50) DEFAULT NULL,
  `rebacks` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=440 DEFAULT CHARSET=utf8;

/*Data for the table `tp_order` */

insert  into `tp_order`(`id`,`orderid`,`goodsname`,`goodsprice`,`goodsimg`,`goodsnum`,`total`,`state`,`username`,`time`,`type`,`nums`,`prices`,`statename`,`expiration`,`goodsman`,`goodsid`,`comstate`,`states`,`reback`,`rebacks`) values (431,'2204171940350813','核桃,redmi k40,苹果,笔记本,大手机',NULL,'/uploads/goods/20220309\\1bb97835c3e639b2f158bd27a50d5189.jfif,/uploads/goods/20220307\\ccf6a43176c1302f20b29ed620d3a05a.jpg,/uploads/goods/20220306\\0d5a2a7415dc34bb3c6d836fd2f2b6e4.jfif,/uploads/goods/20220306\\7284707d7c60bfc798fc224a8cc942fd.jpg,/uploads/goods/20220307\\393062e47667f7468da0eafc6b15c7d2.png',5,13007.00,5,'admin1','2022-04-17 19:40:35',0,'1,1,1,1,1','6.00,1999.00,4.00,6999.00,3999.00','已评价',NULL,'admin,admin,admin,admin,admin','14,12,7,5,13','1,1,1,1,1','5,5,5,5,5',NULL,NULL);
insert  into `tp_order`(`id`,`orderid`,`goodsname`,`goodsprice`,`goodsimg`,`goodsnum`,`total`,`state`,`username`,`time`,`type`,`nums`,`prices`,`statename`,`expiration`,`goodsman`,`goodsid`,`comstate`,`states`,`reback`,`rebacks`) values (432,'2204171944266189','核桃,苹果,笔记本,大手机,redmi k40',NULL,'/uploads/goods/20220309\\1bb97835c3e639b2f158bd27a50d5189.jfif,/uploads/goods/20220306\\0d5a2a7415dc34bb3c6d836fd2f2b6e4.jfif,/uploads/goods/20220306\\7284707d7c60bfc798fc224a8cc942fd.jpg,/uploads/goods/20220307\\393062e47667f7468da0eafc6b15c7d2.png,/uploads/goods/20220307\\ccf6a43176c1302f20b29ed620d3a05a.jpg',6,17006.00,5,'admin1','2022-04-17 19:44:26',0,'1,1,1,2,1','6.00,4.00,6999.00,3999.00,1999.00','已评价',NULL,'admin,admin,admin,admin,admin','14,7,5,13,12','1,1,1,1,1','5,5,5,5,5',NULL,NULL);
insert  into `tp_order`(`id`,`orderid`,`goodsname`,`goodsprice`,`goodsimg`,`goodsnum`,`total`,`state`,`username`,`time`,`type`,`nums`,`prices`,`statename`,`expiration`,`goodsman`,`goodsid`,`comstate`,`states`,`reback`,`rebacks`) values (430,'2204171940190271','我的',22.00,'/uploads/goods/20220321\\e95e4a69b8ed929546e7fea868be0b1d.jpg',1,22.00,2,'admin1','2022-04-17 19:40:19',1,NULL,NULL,'待发货',NULL,'lycwss','18','0',NULL,NULL,NULL);
insert  into `tp_order`(`id`,`orderid`,`goodsname`,`goodsprice`,`goodsimg`,`goodsnum`,`total`,`state`,`username`,`time`,`type`,`nums`,`prices`,`statename`,`expiration`,`goodsman`,`goodsid`,`comstate`,`states`,`reback`,`rebacks`) values (406,'2204011640372482','redmi k40',1999.00,'/uploads/goods/20220307\\ccf6a43176c1302f20b29ed620d3a05a.jpg',0,1999.00,6,'admin2','2022-04-01 16:40:37',1,NULL,NULL,'交易失败',NULL,'admin','12','1',NULL,'1',NULL);
insert  into `tp_order`(`id`,`orderid`,`goodsname`,`goodsprice`,`goodsimg`,`goodsnum`,`total`,`state`,`username`,`time`,`type`,`nums`,`prices`,`statename`,`expiration`,`goodsman`,`goodsid`,`comstate`,`states`,`reback`,`rebacks`) values (419,'2204031300114454','redmi k40',1999.00,'/uploads/goods/20220307\\ccf6a43176c1302f20b29ed620d3a05a.jpg',1,1999.00,4,'admin2','2022-04-03 13:00:11',1,NULL,NULL,'待评价',NULL,'admin','12','0',NULL,NULL,NULL);
insert  into `tp_order`(`id`,`orderid`,`goodsname`,`goodsprice`,`goodsimg`,`goodsnum`,`total`,`state`,`username`,`time`,`type`,`nums`,`prices`,`statename`,`expiration`,`goodsman`,`goodsid`,`comstate`,`states`,`reback`,`rebacks`) values (420,'2204031300163264','redmi k40',1999.00,'/uploads/goods/20220307\\ccf6a43176c1302f20b29ed620d3a05a.jpg',0,1999.00,6,'admin2','2022-04-03 13:00:16',1,NULL,NULL,'交易失败',NULL,'admin','12','0',NULL,'1',NULL);
insert  into `tp_order`(`id`,`orderid`,`goodsname`,`goodsprice`,`goodsimg`,`goodsnum`,`total`,`state`,`username`,`time`,`type`,`nums`,`prices`,`statename`,`expiration`,`goodsman`,`goodsid`,`comstate`,`states`,`reback`,`rebacks`) values (421,'2204031300257362','核桃,redmi k40',NULL,'/uploads/goods/20220309\\1bb97835c3e639b2f158bd27a50d5189.jfif,/uploads/goods/20220307\\ccf6a43176c1302f20b29ed620d3a05a.jpg',6,10001.00,4,'admin2','2022-04-03 13:00:25',0,'1,5','6.00,1999.00','待评价',NULL,'admin,admin','14,12','0,0','4,4',NULL,NULL);
insert  into `tp_order`(`id`,`orderid`,`goodsname`,`goodsprice`,`goodsimg`,`goodsnum`,`total`,`state`,`username`,`time`,`type`,`nums`,`prices`,`statename`,`expiration`,`goodsman`,`goodsid`,`comstate`,`states`,`reback`,`rebacks`) values (426,'2204031731454039','redmi k40',1999.00,'/uploads/goods/20220307\\ccf6a43176c1302f20b29ed620d3a05a.jpg',1,1999.00,3,'admin2','2022-04-03 17:31:45',1,NULL,NULL,'待收货',NULL,'admin','12','0',NULL,NULL,NULL);
insert  into `tp_order`(`id`,`orderid`,`goodsname`,`goodsprice`,`goodsimg`,`goodsnum`,`total`,`state`,`username`,`time`,`type`,`nums`,`prices`,`statename`,`expiration`,`goodsman`,`goodsid`,`comstate`,`states`,`reback`,`rebacks`) values (423,'2204031302455569','苹果,大手机,笔记本,redmi k40',NULL,'/uploads/goods/20220306\\0d5a2a7415dc34bb3c6d836fd2f2b6e4.jfif,/uploads/goods/20220307\\393062e47667f7468da0eafc6b15c7d2.png,/uploads/goods/20220306\\7284707d7c60bfc798fc224a8cc942fd.jpg,/uploads/goods/20220307\\ccf6a43176c1302f20b29ed620d3a05a.jpg',11,40994.00,4,'admin2','2022-04-03 13:02:45',0,'1,3,3,4','4.00,3999.00,6999.00,1999.00','待评价',NULL,'admin,admin,admin,admin','7,13,5,12','0,0,0,0','4,4,4,4',NULL,NULL);
insert  into `tp_order`(`id`,`orderid`,`goodsname`,`goodsprice`,`goodsimg`,`goodsnum`,`total`,`state`,`username`,`time`,`type`,`nums`,`prices`,`statename`,`expiration`,`goodsman`,`goodsid`,`comstate`,`states`,`reback`,`rebacks`) values (427,'2204031819510353','redmi k40',1999.00,'/uploads/goods/20220307\\ccf6a43176c1302f20b29ed620d3a05a.jpg',1,1999.00,1,'admin2','2022-04-03 18:19:51',1,NULL,NULL,'待付款','2022-04-04 18:19:51','admin','12','0',NULL,NULL,NULL);
insert  into `tp_order`(`id`,`orderid`,`goodsname`,`goodsprice`,`goodsimg`,`goodsnum`,`total`,`state`,`username`,`time`,`type`,`nums`,`prices`,`statename`,`expiration`,`goodsman`,`goodsid`,`comstate`,`states`,`reback`,`rebacks`) values (428,'2204171940093710','redmi k40',1999.00,'/uploads/goods/20220307\\ccf6a43176c1302f20b29ed620d3a05a.jpg',1,1999.00,5,'admin1','2022-04-17 19:40:08',1,NULL,NULL,'已评价',NULL,'admin','12','1',NULL,NULL,NULL);
insert  into `tp_order`(`id`,`orderid`,`goodsname`,`goodsprice`,`goodsimg`,`goodsnum`,`total`,`state`,`username`,`time`,`type`,`nums`,`prices`,`statename`,`expiration`,`goodsman`,`goodsid`,`comstate`,`states`,`reback`,`rebacks`) values (429,'2204171940141351','Redmi K50',3999.00,'/uploads/goods/20220320\\de7b4110b47e2fd376373d0fca88db56.png',1,3999.00,2,'admin1','2022-04-17 19:40:14',1,NULL,NULL,'待发货',NULL,'lycwss','17','0',NULL,NULL,NULL);
insert  into `tp_order`(`id`,`orderid`,`goodsname`,`goodsprice`,`goodsimg`,`goodsnum`,`total`,`state`,`username`,`time`,`type`,`nums`,`prices`,`statename`,`expiration`,`goodsman`,`goodsid`,`comstate`,`states`,`reback`,`rebacks`) values (410,'2204011901547983','祁东辣霸王,核桃,苹果,笔记本,大手机,redmi k40',NULL,'/uploads/goods/20220306\\f28bc2a0a0f3162b3907d197b0868339.jfif,/uploads/goods/20220309\\1bb97835c3e639b2f158bd27a50d5189.jfif,/uploads/goods/20220306\\0d5a2a7415dc34bb3c6d836fd2f2b6e4.jfif,/uploads/goods/20220306\\7284707d7c60bfc798fc224a8cc942fd.jpg,/uploads/goods/20220307\\393062e47667f7468da0eafc6b15c7d2.png,/uploads/goods/20220307\\ccf6a43176c1302f20b29ed620d3a05a.jpg',6,13010.00,5,'admin1','2022-04-01 19:01:54',0,'1,1,1,1,1,0','3.00,6.00,4.00,6999.00,3999.00,1999.00','已评价',NULL,'admin,admin,admin,admin,admin,admin','10,14,7,5,13,12','1,1,1,1,1,1','5,5,5,5,5,6','1',1999);
insert  into `tp_order`(`id`,`orderid`,`goodsname`,`goodsprice`,`goodsimg`,`goodsnum`,`total`,`state`,`username`,`time`,`type`,`nums`,`prices`,`statename`,`expiration`,`goodsman`,`goodsid`,`comstate`,`states`,`reback`,`rebacks`) values (411,'2204011904229502','大手机,redmi k40',NULL,'/uploads/goods/20220307\\393062e47667f7468da0eafc6b15c7d2.png,/uploads/goods/20220307\\ccf6a43176c1302f20b29ed620d3a05a.jpg',2,5998.00,5,'admin1','2022-04-01 19:04:22',0,'1,1','3999.00,1999.00','已评价',NULL,'admin,admin','13,12','1,1','5,5',NULL,NULL);
insert  into `tp_order`(`id`,`orderid`,`goodsname`,`goodsprice`,`goodsimg`,`goodsnum`,`total`,`state`,`username`,`time`,`type`,`nums`,`prices`,`statename`,`expiration`,`goodsman`,`goodsid`,`comstate`,`states`,`reback`,`rebacks`) values (412,'2204021419093012','大手机,redmi k40',NULL,'/uploads/goods/20220307\\393062e47667f7468da0eafc6b15c7d2.png,/uploads/goods/20220307\\ccf6a43176c1302f20b29ed620d3a05a.jpg',4,11996.00,5,'admin2','2022-04-02 14:19:09',0,'2,2','3999.00,1999.00','已评价',NULL,'admin,admin','13,12','1,1','5,5',NULL,NULL);
insert  into `tp_order`(`id`,`orderid`,`goodsname`,`goodsprice`,`goodsimg`,`goodsnum`,`total`,`state`,`username`,`time`,`type`,`nums`,`prices`,`statename`,`expiration`,`goodsman`,`goodsid`,`comstate`,`states`,`reback`,`rebacks`) values (433,'2204171954042106','笔记本,大手机,redmi k40',NULL,'/uploads/goods/20220306\\7284707d7c60bfc798fc224a8cc942fd.jpg,/uploads/goods/20220307\\393062e47667f7468da0eafc6b15c7d2.png,/uploads/goods/20220307\\ccf6a43176c1302f20b29ed620d3a05a.jpg',3,12997.00,5,'admin1','2022-04-17 19:54:04',0,'1,1,1','6999.00,3999.00,1999.00','已评价',NULL,'admin,admin,admin','5,13,12','1,1,1','5,5,5',NULL,NULL);
insert  into `tp_order`(`id`,`orderid`,`goodsname`,`goodsprice`,`goodsimg`,`goodsnum`,`total`,`state`,`username`,`time`,`type`,`nums`,`prices`,`statename`,`expiration`,`goodsman`,`goodsid`,`comstate`,`states`,`reback`,`rebacks`) values (434,'2204171954199322','笔记本,大手机,redmi k40',NULL,'/uploads/goods/20220306\\7284707d7c60bfc798fc224a8cc942fd.jpg,/uploads/goods/20220307\\393062e47667f7468da0eafc6b15c7d2.png,/uploads/goods/20220307\\ccf6a43176c1302f20b29ed620d3a05a.jpg',3,12997.00,5,'admin1','2022-04-17 19:54:19',0,'1,1,1','6999.00,3999.00,1999.00','已评价',NULL,'admin,admin,admin','5,13,12','1,1,1','5,5,5',NULL,NULL);
insert  into `tp_order`(`id`,`orderid`,`goodsname`,`goodsprice`,`goodsimg`,`goodsnum`,`total`,`state`,`username`,`time`,`type`,`nums`,`prices`,`statename`,`expiration`,`goodsman`,`goodsid`,`comstate`,`states`,`reback`,`rebacks`) values (435,'2204171954317339','redmi k40',1999.00,'/uploads/goods/20220307\\ccf6a43176c1302f20b29ed620d3a05a.jpg',1,1999.00,5,'admin1','2022-04-17 19:54:31',1,NULL,NULL,'已评价',NULL,'admin','12','1',NULL,NULL,NULL);
insert  into `tp_order`(`id`,`orderid`,`goodsname`,`goodsprice`,`goodsimg`,`goodsnum`,`total`,`state`,`username`,`time`,`type`,`nums`,`prices`,`statename`,`expiration`,`goodsman`,`goodsid`,`comstate`,`states`,`reback`,`rebacks`) values (436,'2204171954382778','redmi k40',1999.00,'/uploads/goods/20220307\\ccf6a43176c1302f20b29ed620d3a05a.jpg',1,1999.00,5,'admin1','2022-04-17 19:54:38',1,NULL,NULL,'已评价',NULL,'admin','12','1',NULL,NULL,NULL);
insert  into `tp_order`(`id`,`orderid`,`goodsname`,`goodsprice`,`goodsimg`,`goodsnum`,`total`,`state`,`username`,`time`,`type`,`nums`,`prices`,`statename`,`expiration`,`goodsman`,`goodsid`,`comstate`,`states`,`reback`,`rebacks`) values (437,'2204171954436817','祁东辣霸王',3.00,'/uploads/goods/20220306\\f28bc2a0a0f3162b3907d197b0868339.jfif',1,3.00,5,'admin1','2022-04-17 19:54:43',1,NULL,NULL,'已评价',NULL,'admin','10','1',NULL,NULL,NULL);
insert  into `tp_order`(`id`,`orderid`,`goodsname`,`goodsprice`,`goodsimg`,`goodsnum`,`total`,`state`,`username`,`time`,`type`,`nums`,`prices`,`statename`,`expiration`,`goodsman`,`goodsid`,`comstate`,`states`,`reback`,`rebacks`) values (438,'2204171954489057','核桃',6.00,'/uploads/goods/20220309\\1bb97835c3e639b2f158bd27a50d5189.jfif',1,6.00,5,'admin1','2022-04-17 19:54:48',1,NULL,NULL,'已评价',NULL,'admin','14','1',NULL,NULL,NULL);
insert  into `tp_order`(`id`,`orderid`,`goodsname`,`goodsprice`,`goodsimg`,`goodsnum`,`total`,`state`,`username`,`time`,`type`,`nums`,`prices`,`statename`,`expiration`,`goodsman`,`goodsid`,`comstate`,`states`,`reback`,`rebacks`) values (439,'2204171954545732','笔记本',6999.00,'/uploads/goods/20220306\\7284707d7c60bfc798fc224a8cc942fd.jpg',1,6999.00,5,'admin1','2022-04-17 19:54:54',1,NULL,NULL,'已评价',NULL,'admin','5','1',NULL,NULL,NULL);

/*Table structure for table `tp_people` */

CREATE TABLE `tp_people` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `imgurl` varchar(500) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `tp_people` */

insert  into `tp_people`(`id`,`username`,`password`,`imgurl`,`name`) values (1,'admin1','533533','/uploads/20220305\\4959d66de874388cac13cd64d705d491.png',NULL);
insert  into `tp_people`(`id`,`username`,`password`,`imgurl`,`name`) values (2,'admin2','533533','/uploads/20220305\\efe4a05852c27d8048dfa50168f6d81f.jfif',NULL);
insert  into `tp_people`(`id`,`username`,`password`,`imgurl`,`name`) values (4,'1805030230','123123','/uploads/20220322\\00051a533add291448ae13e3a85a3885.jfif',NULL);
insert  into `tp_people`(`id`,`username`,`password`,`imgurl`,`name`) values (5,'123123','123123','/uploads/20220322\\1dd860ae3a8fac234e1c85be506486b8.jfif',NULL);
insert  into `tp_people`(`id`,`username`,`password`,`imgurl`,`name`) values (6,'520520','123123','/uploads/20220322\\415792908e6000b38e2589ed76674812.png',NULL);
insert  into `tp_people`(`id`,`username`,`password`,`imgurl`,`name`) values (7,'admin00','123123','/uploads/20220322\\70d3007f94af9c854b07e10d743c8a8e.png',NULL);
insert  into `tp_people`(`id`,`username`,`password`,`imgurl`,`name`) values (8,'admin6','123123','/uploads/20220322\\0391a142e16090de0f63e2e5af8f7c46.png',NULL);
insert  into `tp_people`(`id`,`username`,`password`,`imgurl`,`name`) values (9,'13203079767','533533.','/uploads/20220330\\31823ddcd85f1129b9a48b71723e1fbc.jpg',NULL);
insert  into `tp_people`(`id`,`username`,`password`,`imgurl`,`name`) values (10,'123890','123123','/uploads/20220405\\4ccdc125f592bfc5efa1b580336089a9.jpg','雷扬超');

/*Table structure for table `tp_peopleinfo` */

CREATE TABLE `tp_peopleinfo` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `username` varchar(500) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `flag` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

/*Data for the table `tp_peopleinfo` */

insert  into `tp_peopleinfo`(`id`,`username`,`address`,`phone`,`name`,`flag`) values (36,'admin2','沈阳理工大学','11111111111','雷扬超',0);
insert  into `tp_peopleinfo`(`id`,`username`,`address`,`phone`,`name`,`flag`) values (16,'1805030230','湖南省衡阳市祁东县蒋家桥镇龙兴村18组','15524237806','雷扬超',0);
insert  into `tp_peopleinfo`(`id`,`username`,`address`,`phone`,`name`,`flag`) values (17,'13203079767','雷杨超哈醒','13203079767','伍珊珊',0);
insert  into `tp_peopleinfo`(`id`,`username`,`address`,`phone`,`name`,`flag`) values (39,'admin1','沈阳理工大学','11111111111','雷扬超',1);
insert  into `tp_peopleinfo`(`id`,`username`,`address`,`phone`,`name`,`flag`) values (38,'123890','沈阳理工大学','11','雷扬超',1);
insert  into `tp_peopleinfo`(`id`,`username`,`address`,`phone`,`name`,`flag`) values (34,'admin2','广东省东莞市长安镇步步高大道Vivo4号门','13203079767','我老婆',1);
insert  into `tp_peopleinfo`(`id`,`username`,`address`,`phone`,`name`,`flag`) values (40,'admin1','qq','qq','qq',0);

/*Table structure for table `tp_shopping` */

CREATE TABLE `tp_shopping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `goodsname` varchar(300) DEFAULT NULL,
  `goodsimg` varchar(500) DEFAULT NULL,
  `goodsnum` int(6) DEFAULT NULL,
  `goodsprice` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `goodsid` int(6) DEFAULT NULL,
  `state` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=633 DEFAULT CHARSET=utf8;

/*Data for the table `tp_shopping` */

insert  into `tp_shopping`(`id`,`username`,`goodsname`,`goodsimg`,`goodsnum`,`goodsprice`,`total`,`goodsid`,`state`) values (632,'admin1','大手机','/uploads/goods/20220307\\393062e47667f7468da0eafc6b15c7d2.png',1,3999.00,3999.00,13,0);
insert  into `tp_shopping`(`id`,`username`,`goodsname`,`goodsimg`,`goodsnum`,`goodsprice`,`total`,`goodsid`,`state`) values (631,'admin1','redmi k40','/uploads/goods/20220307\\ccf6a43176c1302f20b29ed620d3a05a.jpg',1,1999.00,1999.00,12,0);
insert  into `tp_shopping`(`id`,`username`,`goodsname`,`goodsimg`,`goodsnum`,`goodsprice`,`total`,`goodsid`,`state`) values (608,'admin2','redmi k40','/uploads/goods/20220307\\ccf6a43176c1302f20b29ed620d3a05a.jpg',1,1999.00,1999.00,12,1);
insert  into `tp_shopping`(`id`,`username`,`goodsname`,`goodsimg`,`goodsnum`,`goodsprice`,`total`,`goodsid`,`state`) values (412,'13203079767','我的','/uploads/goods/20220321\\e95e4a69b8ed929546e7fea868be0b1d.jpg',6,22.00,132.00,18,1);
insert  into `tp_shopping`(`id`,`username`,`goodsname`,`goodsimg`,`goodsnum`,`goodsprice`,`total`,`goodsid`,`state`) values (145,'1805030230','redmi k40','/uploads/goods/20220307\\ccf6a43176c1302f20b29ed620d3a05a.jpg',1,1999.00,1999.00,12,1);
insert  into `tp_shopping`(`id`,`username`,`goodsname`,`goodsimg`,`goodsnum`,`goodsprice`,`total`,`goodsid`,`state`) values (146,'123123','redmi k40','/uploads/goods/20220307\\ccf6a43176c1302f20b29ed620d3a05a.jpg',1,1999.00,1999.00,12,1);

/*Table structure for table `tp_user` */

CREATE TABLE `tp_user` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(20) DEFAULT NULL,
  `user_password` varchar(50) DEFAULT NULL,
  `user_num` varchar(50) DEFAULT NULL,
  `user_email` varchar(50) DEFAULT NULL,
  `auth_num` int(6) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `tp_user` */

insert  into `tp_user`(`id`,`user_name`,`user_password`,`user_num`,`user_email`,`auth_num`,`name`) values (1,'1','shanshan','15386035686',NULL,123456,NULL);
insert  into `tp_user`(`id`,`user_name`,`user_password`,`user_num`,`user_email`,`auth_num`,`name`) values (3,'lycwss','123456','15386035686','2831297211@qq.com',397635,NULL);
insert  into `tp_user`(`id`,`user_name`,`user_password`,`user_num`,`user_email`,`auth_num`,`name`) values (4,'admin','533533','13686155863','1696104853@qq.com',NULL,NULL);
insert  into `tp_user`(`id`,`user_name`,`user_password`,`user_num`,`user_email`,`auth_num`,`name`) values (5,'533533','123456','15386035686','2831297211@qq.com',797762,NULL);
insert  into `tp_user`(`id`,`user_name`,`user_password`,`user_num`,`user_email`,`auth_num`,`name`) values (6,'533533533','533533','15386035686','1696104853@qq.com',235522,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
