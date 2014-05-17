CREATE DATABASE  IF NOT EXISTS `dw_opencart` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `dw_opencart`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: 127.0.0.1    Database: dw_opencart
-- ------------------------------------------------------
-- Server version	5.5.24-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `dim_cliente`
--

DROP TABLE IF EXISTS `dim_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_cliente` (
  `fk_cliente` int(11) NOT NULL,
  `cod_cliente` int(11) DEFAULT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `sobrenome` varchar(100) DEFAULT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `data_inicial` date DEFAULT NULL,
  `data_final` date DEFAULT NULL,
  `versao` int(11) DEFAULT NULL,
  PRIMARY KEY (`fk_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_cliente`
--

LOCK TABLES `dim_cliente` WRITE;
/*!40000 ALTER TABLE `dim_cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `dim_cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_produto`
--

DROP TABLE IF EXISTS `dim_produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_produto` (
  `fk_produto` int(11) NOT NULL,
  `cod_produto` varchar(45) DEFAULT NULL,
  `preco` varchar(45) DEFAULT NULL,
  `descricao` blob,
  `modelo` varchar(45) DEFAULT NULL,
  `fornecedor` varchar(60) DEFAULT NULL,
  `departamento` varchar(45) DEFAULT NULL,
  `qtd_visualizacoes` int(8) DEFAULT NULL,
  `qtd_comprados` int(8) DEFAULT NULL,
  `qtd_estoque` int(8) DEFAULT NULL,
  PRIMARY KEY (`fk_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_produto`
--

LOCK TABLES `dim_produto` WRITE;
/*!40000 ALTER TABLE `dim_produto` DISABLE KEYS */;
/*!40000 ALTER TABLE `dim_produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_regiao`
--

DROP TABLE IF EXISTS `dim_regiao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_regiao` (
  `fk_regiao` int(11) NOT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `regiao` varchar(45) DEFAULT NULL,
  `pais` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`fk_regiao`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_regiao`
--

LOCK TABLES `dim_regiao` WRITE;
/*!40000 ALTER TABLE `dim_regiao` DISABLE KEYS */;
/*!40000 ALTER TABLE `dim_regiao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_tempo`
--

DROP TABLE IF EXISTS `dim_tempo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dim_tempo` (
  `fk_tempo` int(11) NOT NULL,
  `mes` int(11) DEFAULT NULL,
  `trimestre` int(11) DEFAULT NULL,
  `ano` int(11) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `descmes` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`fk_tempo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_tempo`
--

LOCK TABLES `dim_tempo` WRITE;
/*!40000 ALTER TABLE `dim_tempo` DISABLE KEYS */;
/*!40000 ALTER TABLE `dim_tempo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fato_pedidos`
--

DROP TABLE IF EXISTS `fato_pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fato_pedidos` (
  `fk_cliente` int(11) NOT NULL,
  `fk_produto` int(11) NOT NULL,
  `fk_tempo` int(11) NOT NULL,
  `fk_regiao` int(11) NOT NULL,
  `fk_situacao_pedidos` int(11) NOT NULL,
  `qtd_venda` int(11) NOT NULL,
  `vlr_venda` float NOT NULL,
  PRIMARY KEY (`fk_cliente`,`fk_produto`,`fk_tempo`,`fk_regiao`,`fk_situacao_pedidos`),
  KEY `fk_fato_pedidos_dim_produto1_idx` (`fk_produto`),
  KEY `fk_fato_pedidos_dim_tempo1_idx` (`fk_tempo`),
  KEY `fk_fato_pedidos_dim_regiao1_idx` (`fk_regiao`),
  CONSTRAINT `fk_fato_pedidos_dim_cliente` FOREIGN KEY (`fk_cliente`) REFERENCES `dim_cliente` (`fk_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_pedidos_dim_produto1` FOREIGN KEY (`fk_produto`) REFERENCES `dim_produto` (`fk_produto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_pedidos_dim_tempo1` FOREIGN KEY (`fk_tempo`) REFERENCES `dim_tempo` (`fk_tempo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_fato_pedidos_dim_regiao1` FOREIGN KEY (`fk_regiao`) REFERENCES `dim_regiao` (`fk_regiao`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fato_pedidos`
--

LOCK TABLES `fato_pedidos` WRITE;
/*!40000 ALTER TABLE `fato_pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `fato_pedidos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-05-17 18:19:23
