CREATE DATABASE  IF NOT EXISTS `hawkerfood` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hawkerfood`;
-- MySQL dump 10.13  Distrib 8.0.24, for macos11 (x86_64)
--
-- Host: 127.0.0.1    Database: hawkerfood
-- ------------------------------------------------------
-- Server version	8.0.25

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `cat_id` int NOT NULL,
  `category_name` varchar(45) NOT NULL,
  `category_picture` varchar(255) NOT NULL,
  PRIMARY KEY (`cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Chinese','https://static.onecms.io/wp-content/uploads/sites/19/2017/08/17/GettyImages-545286388-2000.jpg'),(2,'Light Bites','https://hw-media.herworld.com/public/2019/05/story/kushikatsu-tanaka.jpg'),(3,'Malay','https://sites.google.com/site/foodparadiseinmalaysia/_/rsrc/1433693351348/home/malaysian-food.jpg'),(4,'Indian','https://static.toiimg.com/thumb/53338316.cms?imgsize=223266&width=800&height=800'),(5,'Western','https://singaporelocalfavourites.com/wp-content/uploads/2018/08/singapore-western-food-recipes.jpg');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food`
--

DROP TABLE IF EXISTS `food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food` (
  `food_id` int NOT NULL AUTO_INCREMENT,
  `food_name` varchar(45) NOT NULL,
  `brief_description` varchar(115) NOT NULL,
  `cost_price` double NOT NULL,
  `retail_price` double NOT NULL,
  `stock` int NOT NULL,
  `category` int NOT NULL,
  `picture` varchar(255) DEFAULT 'https://danielfooddiary.com/wp-content/uploads/2018/02/marketstreet18.jpg',
  `detail_description` longtext,
  `sales` int DEFAULT NULL,
  PRIMARY KEY (`food_id`),
  UNIQUE KEY `food_id_UNIQUE` (`food_id`),
  UNIQUE KEY `food_name_UNIQUE` (`food_name`),
  KEY `category_id_idx` (`category`),
  CONSTRAINT `category_id` FOREIGN KEY (`category`) REFERENCES `category` (`cat_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food`
--

LOCK TABLES `food` WRITE;
/*!40000 ALTER TABLE `food` DISABLE KEYS */;
INSERT INTO `food` VALUES (1,'Curry puff','Hand-made curry puffs ( potato fillings )',1,2.8,20,2,'./img/1628627736148Karipap_Daging.jpg','Simply delicious. A traditional pastry that is loved by locals. The smell of the puffs usually permeate the air at the hawker centre.',0),(2,'Nasi Lemak','Fried chicken, egg , otak , vegetables , peanuts , ikan billis and special-made sambal sauce',4,5.5,15,3,'https://images.weserv.nl/?url=https://s3-ap-southeast-1.amazonaws.com/v3-live.image.oddle.me/product/S04SetCNasiLemak58d43e.jpg&w=500&h=500&fit=cover','Nasi lemak is a dish that comprises rice made fragrant with coconut cream and pandan leaves. A light meal that is believed to be Malay in origin, it is traditionally accompanied by fried anchovies, sliced cucumbers, fried fish known as ikan selar, and a sweet chili sauce.',NULL),(4,'Roti Prata set','1 plain, 1 egg, with chicken curry and sauces',3.5,4.5,20,4,'https://images.weserv.nl/?url=https://s3-ap-southeast-1.amazonaws.com/v3-live.image.oddle.me/product/S10RotiPrata3af775.jpg&w=500&h=500&fit=cover','A soft and yet crisp flatbread, roti prata or paratha is often eaten together with mutton or dhal curry. It is sold mostly by Indian Muslim stallholders at coffeeshops and hawker centres.1 There are two common types of roti prata sold in Singapore – plain prata and prata with egg.',NULL),(6,'Ayam Penyet set','Ayam Penyet is a fried chicken dish.',4,6.5,28,3,'https://images.weserv.nl/?url=https://s3-ap-southeast-1.amazonaws.com/v3-live.image.oddle.me/product/S34AyamPenyetf72a45.jpg&w=500&h=500&fit=cover','Ayam penyet Javanese for smashed fried chicken is Indonesian cuisine — fried chicken dish consisting of fried chicken that is smashed with the pestle against mortar to make it softer, served with sambal, slices of cucumbers, fried tofu and tempeh.',NULL),(7,'Waffle','Choose from 4 flavours : kaya, chocolate, peanut butter, plain',0.5,1.5,35,2,'https://images.weserv.nl/?url=https://s3-ap-southeast-1.amazonaws.com/v3-live.image.oddle.me/product/S44Waffle800313.jpg&w=500&h=500&fit=cover','Enjoy your waffle with a generous slab of kaya or chocolate or peanut butter or just have it plain!',NULL),(8,'Munchi Pancake','3 flavours : Peanut, Red bean, Coconut ',0.8,1.4,30,2,'https://images.weserv.nl/?url=https://s3-ap-southeast-1.amazonaws.com/v3-live.image.oddle.me/product/S43TraditionalPancake088d4d.jpg&w=500&h=500&fit=cover','Pancake, 3 GREAT flavours, Peanut, Red Bean Coconut, affordable yet delicious!',NULL),(9,'Nasi Lemak special set','Fried chicken, fish, egg, peanuts, ikan billis and special-made sambal sauce',3.8,5.3,20,3,'https://images.weserv.nl/?url=https://s3-ap-southeast-1.amazonaws.com/v3-live.image.oddle.me/product/S33FishChickencacc4a.jpg&w=500&h=500&fit=cover','Nasi lemak is a dish that comprises rice made fragrant with coconut cream and pandan leaves.1 A light meal that is believed to be Malay in origin, it is traditionally accompanied by fried anchovies, sliced cucumbers, fried fish known as ikan selar, and a sweet chili sauce.',NULL),(10,'Roasted Chicken rice','Comes with roasted chicken, 1 egg and soup',3,4,25,1,'https://images.weserv.nl/?url=https://s3-ap-southeast-1.amazonaws.com/v3-live.image.oddle.me/product/S32ChickenRice5def59.jpg&w=500&h=500&fit=cover','Roasted chicken rice is a favourite among the locals in Malaysia and Singapore. The meat is juicy while the crispy golden-brown skin is smooth and tender with a light hint of sweetness. A delicious dish to have at any time of the day.',NULL),(11,'Nasi Briyani','Homemade',4.8,7,20,3,'https://images.weserv.nl/?url=https://s3-ap-southeast-1.amazonaws.com/v3-live.image.oddle.me/product/S13NasiBriyanif50c67.jpg&w=500&h=500&fit=cover','Nasi Briyani is a traditional Indian rice-based dish accompanied by meat, vegetables and a gravy or curry. The long grain basmati rice is cooked with garlic, yogurt, aromatic spices, onions and sometimes with ghee or a substitute for this unique butter.',NULL),(12,'Baked Salmon','Sashimi grade baked salmon with grilled brocolli and sides',11,15.8,12,5,'https://images.weserv.nl/?url=https://s3-ap-southeast-1.amazonaws.com/v3-live.image.oddle.me/product/S37SashimiGradeBakedSalmonb1ca17.jpg&w=500&h=500&fit=cover','Tender garlic butter baked salmon with crispy roast potatoes, asparagus and a delicious garlic butter sauce! all baked on a sheet pan for an easy meal.',NULL),(13,'Fish & Chips','Serves with fries, salad and sauces',6.9,9.8,15,5,'https://images.weserv.nl/?url=https://s3-ap-southeast-1.amazonaws.com/v3-live.image.oddle.me/product/S37FishChips25a387.jpg&w=500&h=500&fit=cover','A hot dish consisting of fried fish in batter, served with chips. french fries or wedges. The dish originated in England, where these two components had been introduced from separate immigrant cultures',NULL),(14,'Yuan yang carrot cake','White and black carrot cake mix',2.5,6,30,3,'https://images.weserv.nl/?url=https://s3-ap-southeast-1.amazonaws.com/v3-live.image.oddle.me/product/S41YuanYangCarrotCake32aa25.jpg&w=500&h=500&fit=cover','Fried carrot cake, or chai tow kway in the Teochew dialect, consists of cubes of radish cake stir-fried with garlic, eggs and preserved radish. The dish has two common versions: the white version, which is seasoned with light soya sauce, and the black version, where dark soya sauce is added instead. Yuan yang is the combination of both.',NULL),(15,'Carbonara','Pasta with cream cheese sauces, mushrooms, bacon and ham',4.5,9.9,25,5,'https://images.weserv.nl/?url=https://s3-ap-southeast-1.amazonaws.com/v3-live.image.oddle.me/product/S36CarbonaraPasta173e44.jpg&w=500&h=500&fit=cover','Carbonara is an Italian pasta dish from Rome made with egg, hard cheese, cured pork, and black pepper.The cheese is usually Pecorino Romano, Parmigiano-Reggiano, or a combination of the two. Spaghetti is the most common pasta, but fettuccine, rigatoni, linguine, or bucatini are also used.',NULL),(16,'Naan','A plain leavened, oven-baked flatbread.',2,3.5,20,4,'https://static.toiimg.com/thumb/53338316.cms?imgsize=223266&width=800&height=800','A teardrop-shaped bread that is baked in a tandoor (traditional Indian clay oven) and served with various curries. The tandoor is rounded and has a beehive shape.',NULL),(17,'Chicken 65','A spicy, deep-fried chicken dish with full of spices.',1.5,2.2,30,4,'https://myfoodstory.com/wp-content/uploads/2021/05/Chicken-65-Spicy-Crispy-3-500x500.jpg','Chicken 65 is a spicy, deep-fried chicken dish originating from Hotel Buhari, Chennai, India, as an entrée, or quick snack. The flavour of the dish can be attributed to red chillies, but the exact set of ingredients for the recipe can vary. It can be prepared using boneless or bone-in chicken and is usually served with onion and lemon garnish.',NULL),(18,'Hainanese Steamed Chicken Rice','Comes with steamed chicken, 1 egg and soup',1,1,1,1,'https://s3-ap-southeast-1.amazonaws.com/tz-mag-media/wp-content/uploads/2018/06/26095127/hk2.png','The Hainanese chicken rice is a dish that consists of succulent steamed white chicken cut into bite-size pieces and served on fragrant rice with some light soy sauce. The dish is topped with sprigs of coriander leaf and sesame oil, and accompanied by a garlic-chilli dip.',NULL),(19,'Cauliflower 65','A spicy, deep-fried cauliflower dish with full of spices.',1.5,3,2,4,'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Chicken_65_%28Dish%29.jpg/1920px-Chicken_65_%28Dish%29.jpg','A spicy, deep-fried cauliflower dish with full of spices. Legend says that 65 chilli spices are used to make the dish.',NULL),(20,'Next','NEXFT',2,4,3,2,'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Chicken_65_%28Dish%29.jpg/1920px-Chicken_65_%28Dish%29.jpg','NEXT',NULL),(22,'Garden Forest Desert','Taste nature in your mouth.',2,3,1,2,'./img/1627922039920IMG_1090.png','Nature in your mouth, an unforgettable taste that is forever ingrained.',NULL),(31,'omg','yeah',2,3,2,5,'./img/1628587503451IMG_9463.jpg','',0);
/*!40000 ALTER TABLE `food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_history`
--

DROP TABLE IF EXISTS `order_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_history` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `totalAmount` double NOT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_id_UNIQUE` (`order_id`),
  KEY `userId_idx` (`user_id`),
  CONSTRAINT `userId` FOREIGN KEY (`user_id`) REFERENCES `user` (`userid`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_history`
--

LOCK TABLES `order_history` WRITE;
/*!40000 ALTER TABLE `order_history` DISABLE KEYS */;
INSERT INTO `order_history` VALUES (1,4,5,'2021-08-10 18:09:12'),(2,3,5,'2021-08-10 20:19:17'),(3,3,5.1,'2021-08-10 20:21:25');
/*!40000 ALTER TABLE `order_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_history`
--

DROP TABLE IF EXISTS `purchase_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_history` (
  `history_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `food_id` int NOT NULL,
  PRIMARY KEY (`history_id`),
  UNIQUE KEY `history_id_UNIQUE` (`history_id`),
  KEY `orderId_idx` (`order_id`),
  CONSTRAINT `orderId` FOREIGN KEY (`order_id`) REFERENCES `order_history` (`order_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_history`
--

LOCK TABLES `purchase_history` WRITE;
/*!40000 ALTER TABLE `purchase_history` DISABLE KEYS */;
INSERT INTO `purchase_history` VALUES (1,1,10),(2,1,18),(3,2,10),(4,2,18),(5,3,1),(6,3,1),(7,3,7);
/*!40000 ALTER TABLE `purchase_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userid` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `phoneNumber` varchar(255) NOT NULL,
  `roadName` varchar(255) NOT NULL,
  `floorNumber` varchar(115) DEFAULT NULL,
  `country` varchar(255) NOT NULL,
  `cityState` varchar(255) NOT NULL,
  `zip` int NOT NULL,
  `role` varchar(45) NOT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Monika','monika@mon.com','monmonk','434309434','Monika Road','','New Zealand','Auckland',292002,'admin'),(2,'customer1','c1@gmail.com','customer1','98279281','Blk 39 Iris Road','#33-234','Australia','Victoria',910192,'customer'),(3,'testing','testing@right.com','ihopeitsrightnow','342432','20 Makeshift Road','','Singapore','Singapore',282920,'customer'),(4,'Isaac','isaactbk218@gmail.com','isaac','34896863243','34 Isla Road',NULL,'UK','London',309493,'customer'),(6,'Isaac 2','isaac.tbk217@gmail.com','Isaac2','43293489349','34 Isla Road','','UK','London',430349,'admin'),(7,'Taylor','taylor@abc.com','mirrorball','34203929','35 Mahogany Road',NULL,'USA','California',495069,'customer'),(9,'yesh','yesh@yesh.com','ok','94930490','Blk 490 Dover Road','#20-349','Singapore','Singapore',584599,'customer'),(10,'Make','make@gmail.com','yeshMAKE','928209181718','Blk 4839 Farrer Road','','Singapore','Singapore',58493,'customer'),(11,'admin2','admin2@gmail.com','admin2jkdkd','83838939272293','48 Main Street','#15-930','Australia','Victoria Melbourne',383922,'admin'),(13,'admin4','admin4@gmail.com','fkldlkas2','flkw33r','Jing Wen Street','','Jing Wen Nation!!!!','Jing Wen',888448,'admin'),(14,'make3','make3@gmail.com','ame','3990','3904 Main','','Singapore','Singapore',793029,'customer'),(15,'tesing4','tesign4@gmail.com','fjsdlk','4930320','Main Street','','SG','SG',304290,'admin'),(16,'Monika3','jwmonika@gmail.com','JWMON','8219191818181','Main St','','Singapore','Singapore',3820933,'customer'),(17,'nama','isa@gmail.com','isa34','383933839383','Middle Road','','Singapore','Singapore',5848290,'customer'),(18,'PLSWORK','pleasework@gmail.com','pofsdi3928','92811092290','Main Street','#09-393','Singapore','Singapore',49303,'customer');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'hawkerfood'
--

--
-- Dumping routines for database 'hawkerfood'
--
/*!50003 DROP PROCEDURE IF EXISTS `addFood` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addFood`(IN foodid INT, foodname VARCHAR(45),briefdes VARCHAR(115), costprice DOUBLE, retailprice DOUBLE,
									stockinput INT, categoryid INT, pictureURL VARCHAR(255),detaildes VARCHAR(255), sales INT)
BEGIN
	INSERT INTO food SET 
    food_id = foodid, food_name = foodname, brief_description = briefdes , cost_price = costprice, retail_price = retailprice, 
    stock = stockinput, category = categoryid, picture = pictureURL, detail_description = detaildes, sales = sales ;  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteFoodById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteFoodById`(IN foodId INT)
BEGIN
	DELETE FROM food WHERE food_id = foodId ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `editFoodById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `editFoodById`(IN foodname VARCHAR(45),briefdes VARCHAR(115), costprice DOUBLE, retailprice DOUBLE,
									stockinput INT, categoryid INT, pictureURL VARCHAR(255),detaildes VARCHAR(255), sales INT, foodid INT)
BEGIN
	UPDATE food SET food_name = foodname, brief_description = briefdes , cost_price = costprice, retail_price = retailprice, 
    stock = stockinput, category = categoryid, picture = pictureURL, detail_description = detaildes, sales = sales WHERE food_id = foodid ;  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAllFood` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllFood`()
BEGIN
SELECT food.food_id, food.food_name, food.brief_description, food.retail_price, food.cost_price, 
	   food.stock, food.picture, food.detail_description, food.sales, category.category_name FROM food JOIN category 
       WHERE category = cat_id ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAllFoodByCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllFoodByCategory`(IN categoryid INT)
BEGIN
SELECT food.food_id, food.food_name, food.brief_description, food.retail_price, food.cost_price, 
	   food.stock, food.picture, food.detail_description, food.sales, category.category_name FROM food JOIN category 
       WHERE category = cat_id && cat_id = categoryid ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-08-11  5:01:48
