-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.6.0-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- bbs 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `bbs` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `bbs`;

-- 테이블 bbs.assignment 구조 내보내기
CREATE TABLE IF NOT EXISTS `assignment` (
  `userID` varchar(20) DEFAULT NULL,
  `index` int(6) NOT NULL,
  `asgTitle` varchar(20) DEFAULT NULL,
  `asgWriter` varchar(20) DEFAULT NULL,
  `asgText` text DEFAULT NULL,
  `asgCreate` date DEFAULT NULL,
  PRIMARY KEY (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 bbs.assignment:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `assignment` ENABLE KEYS */;

-- 테이블 bbs.attendance 구조 내보내기
CREATE TABLE IF NOT EXISTS `attendance` (
  `userID` varchar(20) DEFAULT NULL,
  `atdDate` date DEFAULT NULL,
  `atdCheck` varchar(20) DEFAULT NULL,
  `atdpName` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 bbs.attendance:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;

-- 테이블 bbs.attendanceplace 구조 내보내기
CREATE TABLE IF NOT EXISTS `attendanceplace` (
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `atdpName` varchar(20) DEFAULT NULL,
  `qrID` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 bbs.attendanceplace:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `attendanceplace` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendanceplace` ENABLE KEYS */;

-- 테이블 bbs.notice 구조 내보내기
CREATE TABLE IF NOT EXISTS `notice` (
  `userID` varchar(20) DEFAULT NULL,
  `index` int(6) NOT NULL,
  `noticeTitle` varchar(20) DEFAULT NULL,
  `noticeWriter` varchar(20) DEFAULT NULL,
  `noticeText` text DEFAULT NULL,
  `noticeCreate` date DEFAULT NULL,
  `noticeCnt` int(9) DEFAULT NULL,
  PRIMARY KEY (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 bbs.notice:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;

-- 테이블 bbs.survey 구조 내보내기
CREATE TABLE IF NOT EXISTS `survey` (
  `userID` varchar(20) DEFAULT NULL,
  `index` int(6) NOT NULL,
  `surveyQ1` varchar(20) DEFAULT NULL,
  `surveyQ2` varchar(20) DEFAULT NULL,
  `surveyQ3` varchar(20) DEFAULT NULL,
  `surveyQ4` varchar(20) DEFAULT NULL,
  `surveyQ5` varchar(20) DEFAULT NULL,
  `surveyQ6` varchar(20) DEFAULT NULL,
  `surveyQ7` varchar(20) DEFAULT NULL,
  `surveyQ8` varchar(20) DEFAULT NULL,
  `surveyQ9` varchar(20) DEFAULT NULL,
  `surveyQ10` text DEFAULT NULL,
  PRIMARY KEY (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 bbs.survey:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `survey` DISABLE KEYS */;
/*!40000 ALTER TABLE `survey` ENABLE KEYS */;

-- 테이블 bbs.user 구조 내보내기
CREATE TABLE IF NOT EXISTS `user` (
  `userID` varchar(20) NOT NULL,
  `userPassword` varchar(20) DEFAULT NULL,
  `userName` varchar(20) DEFAULT NULL,
  `userGender` varchar(20) DEFAULT NULL,
  `userBirth` date DEFAULT NULL,
  `userUniversity` varchar(20) DEFAULT NULL,
  `userMajor` varchar(20) DEFAULT NULL,
  `userPhone` varchar(20) DEFAULT NULL,
  `userEmail` varchar(30) DEFAULT NULL,
  `userAddress` varchar(50) DEFAULT NULL,
  `userAdmin` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`userID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 bbs.user:~3 rows (대략적) 내보내기
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`userID`, `userPassword`, `userName`, `userGender`, `userBirth`, `userUniversity`, `userMajor`, `userPhone`, `userEmail`, `userAddress`, `userAdmin`) VALUES
	('admin', '1234', '관리자', '여자', '2022-06-18', '대대학교', '전전공', '1041621654', 'admin@naver.com', '경상북도 하양 어딘가', 1),
	('test', '1234', '신태흔', '남자', '1999-09-24', '한국대', '컴퓨터공학', '01012345678', 'test@naver.com', '신천북로 12길 16-7', 0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
