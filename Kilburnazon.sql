-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 29, 2022 at 12:19 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Kilburnazon`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Current_Month_Birthdays` ()   BEGIN
    	SELECT 
        CONCAT(Employee_Details.First_Name, ' ', Employee_Details.Last_Name) AS Full_Name, 
        Employees.Number, Departments.Name, Employee_Details.DOB 
        FROM 
        Employee_Details 
        INNER JOIN 
        Employees 
        ON 
        Employee_Details.NIN = Employees.NIN 
        INNER JOIN 
        Departments 
        ON 
        Departments.Number = Employees.Department_Number
        WHERE
        MONTH(CURRENT_DATE()) = MONTH(Employee_Details.DOB);
    END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Area`
--

CREATE TABLE `Area` (
  `Name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Area`
--

INSERT INTO `Area` (`Name`) VALUES
('Aberdeen'),
('Armagh'),
('Bangor'),
('Bath'),
('Belfast'),
('Birmingham'),
('Bradford'),
('Brighton & Hove'),
('Bristol'),
('Cambridge'),
('Canterbury'),
('Cardiff'),
('Carlisle'),
('Chelmsford'),
('Chester'),
('Chichester'),
('Colchester'),
('Coventry'),
('Derby'),
('Doncaster'),
('Dundee'),
('Dunfermline'),
('Durham'),
('Edinburgh'),
('Ely'),
('Exeter'),
('Glasgow'),
('Gloucester'),
('Hereford'),
('Inverness'),
('Kingston-upon-Hull'),
('Lancaster'),
('Leeds'),
('Leicester'),
('Lichfield'),
('Lincoln'),
('Lisburn'),
('Liverpool'),
('London'),
('Londonderry'),
('Manchester'),
('Milton Keynes'),
('Newcastle-upon-Tyne'),
('Newport'),
('Newry'),
('Norwich'),
('Nottingham'),
('Oxford'),
('Perth'),
('Peterborough'),
('Plymouth'),
('Portsmouth'),
('Preston'),
('Ripon'),
('Salford'),
('Salisbury'),
('Sheffield'),
('Southampton'),
('Southend-on-Sea'),
('St Albans'),
('St Asaph'),
('St Davids'),
('Stirling'),
('Stoke on Trent'),
('Sunderland'),
('Swansea'),
('Truro'),
('Wakefield'),
('Wells'),
('Westminster'),
('Winchester'),
('Wolverhampton'),
('Worcester'),
('Wrexham'),
('York');

-- --------------------------------------------------------

--
-- Table structure for table `Auditing_Employees_Table`
--

CREATE TABLE `Auditing_Employees_Table` (
  `Employee_Number_Deleted` varchar(10) NOT NULL,
  `Date_Deleted` date NOT NULL,
  `Time_Deleted` time NOT NULL,
  `Employee_Who_Deleted` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Auditing_Employees_Table`
--

INSERT INTO `Auditing_Employees_Table` (`Employee_Number_Deleted`, `Date_Deleted`, `Time_Deleted`, `Employee_Who_Deleted`) VALUES
('01-6146269', '2022-11-29', '11:18:26', '00-4334715'),
('12-2323909', '2022-11-27', '23:26:15', '00-4334715'),
('71-7374760', '2022-11-27', '23:23:51', '00-4334715');

-- --------------------------------------------------------

--
-- Table structure for table `Building`
--

CREATE TABLE `Building` (
  `ID` int(11) NOT NULL,
  `Area_Name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Building`
--

INSERT INTO `Building` (`ID`, `Area_Name`) VALUES
(13, 'Armagh'),
(35, 'Belfast'),
(29, 'Birmingham'),
(34, 'Birmingham'),
(4, 'Brighton & Hove'),
(15, 'Canterbury'),
(8, 'Colchester'),
(7, 'Coventry'),
(14, 'Coventry'),
(11, 'Edinburgh'),
(16, 'Edinburgh'),
(28, 'Gloucester'),
(12, 'Inverness'),
(19, 'Inverness'),
(21, 'Inverness'),
(18, 'Kingston-upon-Hull'),
(25, 'Lancaster'),
(23, 'Liverpool'),
(17, 'London'),
(33, 'London'),
(31, 'Londonderry'),
(3, 'Manchester'),
(6, 'Manchester'),
(20, 'Manchester'),
(27, 'Newport'),
(10, 'Plymouth'),
(30, 'Ripon'),
(9, 'Salford'),
(5, 'Salisbury'),
(1, 'Southampton'),
(26, 'St Asaph'),
(22, 'Stirling'),
(2, 'Winchester'),
(32, 'Winchester'),
(24, 'Wrexham');

-- --------------------------------------------------------

--
-- Table structure for table `Complaints`
--

CREATE TABLE `Complaints` (
  `ID` int(11) NOT NULL,
  `Complaint_Date` date NOT NULL,
  `Customer_First_Name` varchar(20) NOT NULL,
  `Customer_Last_Name` varchar(20) NOT NULL,
  `Reason` varchar(500) NOT NULL,
  `HR_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Departments`
--

CREATE TABLE `Departments` (
  `Number` int(11) NOT NULL,
  `Name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Departments`
--

INSERT INTO `Departments` (`Number`, `Name`) VALUES
(1, 'Drivers'),
(2, 'HR'),
(3, 'Management'),
(4, 'Packagers');

-- --------------------------------------------------------

--
-- Table structure for table `Department_Details`
--

CREATE TABLE `Department_Details` (
  `Name` varchar(20) NOT NULL,
  `Manager_First_Name` varchar(20) NOT NULL,
  `Manager_Last_Name` varchar(20) NOT NULL,
  `Employee_Count` int(11) NOT NULL DEFAULT 0,
  `Head_Office` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Department_Details`
--

INSERT INTO `Department_Details` (`Name`, `Manager_First_Name`, `Manager_Last_Name`, `Employee_Count`, `Head_Office`) VALUES
('Drivers', 'Velvet', 'Carbine', 215, 'Liverpool'),
('HR', 'Cyrus', 'Willmetts', 65, 'London'),
('Management', 'Fredericka', 'Mathivat', 16, 'Manchester'),
('Packagers', 'Alfie', 'Dean', 202, 'Sheffield');

-- --------------------------------------------------------

--
-- Table structure for table `Drivers`
--

CREATE TABLE `Drivers` (
  `ID` int(11) NOT NULL,
  `Hours_Per_Week` float NOT NULL,
  `Employee_Number` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Drivers`
--

INSERT INTO `Drivers` (`ID`, `Hours_Per_Week`, `Employee_Number`) VALUES
(1, 17, '78-6321379'),
(2, 44, '43-8492699'),
(3, 42, '55-0320348'),
(4, 38, '98-1678319'),
(5, 26, '05-1945849'),
(6, 42, '86-2503827'),
(7, 26, '43-2037577'),
(8, 31, '75-6520267'),
(9, 22, '61-9391449'),
(10, 17, '53-7191465'),
(11, 17, '30-2374884'),
(12, 14, '50-0945563'),
(13, 34, '66-7576883'),
(14, 15, '14-1209073'),
(15, 48, '98-4762907'),
(16, 44, '69-0803348'),
(17, 45, '76-3367992'),
(18, 48, '05-1128789'),
(19, 39, '16-0283796'),
(20, 50, '72-7823438'),
(21, 27, '75-0958781'),
(22, 19, '58-8249246'),
(23, 30, '44-4915402'),
(24, 41, '67-7636850'),
(25, 17, '15-5837614'),
(26, 20, '45-6995640'),
(27, 17, '97-9018441'),
(29, 26, '29-5105992'),
(30, 20, '11-9162644'),
(31, 24, '73-7147493'),
(32, 24, '16-1242322'),
(33, 34, '09-4856118'),
(34, 34, '97-3138911'),
(35, 36, '36-4580826'),
(36, 50, '34-8601206'),
(37, 26, '17-5831110'),
(38, 29, '68-5871521'),
(39, 18, '57-7596762'),
(40, 20, '94-4705277'),
(41, 43, '63-6111701'),
(42, 35, '17-1342407'),
(43, 36, '52-1336694'),
(44, 20, '26-3324931'),
(45, 46, '85-3334513'),
(46, 25, '35-6685131'),
(47, 26, '53-0431396'),
(48, 24, '20-5440287'),
(49, 49, '14-9076003'),
(50, 26, '70-2965789'),
(51, 50, '84-3457422'),
(52, 17, '93-0686984'),
(53, 50, '71-3652304'),
(54, 31, '81-4865027'),
(55, 32, '97-5683996'),
(56, 26, '51-7315582'),
(57, 43, '76-2727093'),
(58, 44, '29-6656577'),
(59, 34, '22-3052971'),
(60, 26, '79-0464882'),
(61, 50, '04-2758260'),
(62, 25, '38-9798664'),
(63, 49, '45-7500187'),
(64, 38, '31-8312411'),
(65, 44, '21-1787461'),
(66, 45, '32-4834306'),
(67, 40, '62-7120162'),
(68, 15, '77-7401728'),
(69, 44, '10-6680137'),
(70, 45, '58-0824770'),
(71, 41, '53-9062912'),
(72, 19, '77-8203719'),
(73, 20, '28-4979315'),
(74, 26, '24-6851371'),
(75, 31, '73-6200004'),
(76, 36, '45-5773014'),
(77, 30, '09-2857613'),
(78, 20, '99-4615801'),
(79, 47, '10-9736161'),
(80, 13, '49-5299749'),
(81, 12, '90-3945672'),
(82, 45, '20-9516100'),
(83, 36, '31-9709677'),
(84, 30, '90-6409982'),
(85, 37, '78-4344207'),
(86, 15, '92-9715314'),
(87, 14, '11-5411031'),
(88, 43, '49-1457327'),
(89, 40, '48-1799687'),
(90, 45, '66-5805863'),
(91, 12, '76-0099650'),
(92, 35, '95-1174328'),
(93, 39, '46-4344763'),
(94, 38, '14-0432288'),
(95, 22, '68-3132421'),
(96, 28, '45-2811300'),
(97, 37, '04-1386775'),
(98, 46, '53-5630368'),
(99, 16, '70-4763276'),
(100, 30, '60-6428015'),
(101, 21, '30-8953969'),
(102, 20, '67-6284946'),
(103, 40, '58-0128736'),
(104, 33, '75-9134355'),
(105, 46, '79-9536595'),
(106, 36, '72-6079643'),
(107, 25, '40-1037983'),
(108, 21, '60-3158201'),
(109, 26, '02-4109274'),
(110, 30, '76-8791360'),
(111, 41, '32-3604971'),
(112, 33, '35-2689059'),
(113, 31, '27-8387260'),
(114, 15, '38-3647372'),
(115, 35, '87-1949652'),
(116, 30, '33-1261585'),
(117, 31, '89-4176534'),
(118, 42, '80-7938995'),
(119, 21, '15-6949928'),
(120, 21, '89-6058656'),
(121, 42, '01-9065592'),
(122, 27, '69-5458568'),
(123, 24, '50-5810953'),
(124, 22, '45-3804689'),
(125, 30, '83-1217063'),
(126, 45, '54-7676865'),
(127, 17, '04-2608361'),
(128, 13, '42-1134854'),
(129, 41, '92-9480837'),
(130, 29, '55-3650046'),
(131, 28, '31-5831645'),
(132, 12, '86-1870935'),
(133, 22, '79-4798875'),
(134, 48, '38-1884801'),
(135, 48, '82-9457047'),
(136, 36, '36-4190617'),
(137, 36, '38-4369228'),
(138, 48, '42-0131259'),
(139, 42, '27-1540713'),
(140, 32, '22-0788973'),
(141, 47, '06-7381402'),
(142, 31, '20-3044693'),
(143, 45, '41-3268639'),
(144, 26, '84-9275069'),
(145, 37, '58-8390431'),
(146, 27, '47-5302795'),
(147, 28, '20-6300983'),
(148, 42, '26-9050326'),
(149, 38, '75-1340477'),
(150, 36, '05-5646283'),
(151, 20, '31-7111614'),
(152, 40, '95-1790755'),
(153, 36, '63-8802366'),
(154, 29, '76-4086283'),
(155, 29, '56-0484045'),
(156, 39, '68-6940299'),
(157, 44, '78-0380118'),
(158, 38, '21-4089887'),
(159, 27, '94-6907133'),
(160, 42, '44-1072008'),
(161, 43, '78-1195027'),
(162, 45, '97-6528129'),
(163, 48, '05-9682452'),
(165, 38, '52-6674444'),
(166, 40, '37-6605556'),
(167, 25, '40-1136806'),
(168, 36, '81-0188200'),
(169, 33, '62-2186332'),
(170, 17, '67-5304822'),
(171, 16, '25-6187206'),
(172, 21, '49-6102253'),
(173, 41, '22-7191567'),
(174, 19, '43-7385696'),
(175, 47, '98-3556505'),
(176, 41, '25-4103329'),
(177, 16, '82-1629865'),
(178, 32, '66-1883695'),
(179, 47, '74-9747670'),
(180, 24, '08-5459846'),
(181, 38, '82-2981878'),
(182, 47, '51-9601829'),
(183, 13, '49-1036239'),
(184, 41, '78-8816060'),
(185, 25, '06-3850682'),
(186, 19, '02-6214516'),
(187, 47, '51-7472749'),
(188, 20, '87-3376412'),
(189, 29, '62-7019089'),
(190, 29, '80-8617080'),
(191, 29, '71-7837650'),
(192, 26, '59-5937939'),
(193, 37, '84-0386773'),
(194, 48, '51-6967096'),
(195, 18, '19-6732633'),
(196, 24, '40-6943405'),
(197, 18, '77-5513461'),
(198, 25, '36-1132600'),
(199, 28, '81-5031235'),
(200, 27, '81-5228790'),
(201, 14, '08-7213723'),
(202, 36, '84-5153657'),
(203, 23, '84-8762859'),
(204, 48, '66-2765926'),
(205, 28, '68-7504033'),
(206, 49, '75-6891165'),
(207, 30, '54-1117411'),
(208, 19, '41-1429269'),
(209, 24, '26-0938951'),
(210, 17, '96-1648398'),
(211, 16, '92-9623071'),
(212, 29, '41-9645109'),
(213, 37, '87-4453963'),
(214, 35, '49-9705882'),
(215, 38, '49-1159362'),
(216, 17, '63-1925261'),
(224, 41, '55-3623151');

-- --------------------------------------------------------

--
-- Table structure for table `Emergency_Contacts`
--

CREATE TABLE `Emergency_Contacts` (
  `ID` int(11) NOT NULL,
  `First_Name` varchar(20) NOT NULL,
  `Last_Name` varchar(20) NOT NULL,
  `Relationship` varchar(15) NOT NULL,
  `Phone_Number` varchar(11) NOT NULL,
  `Employee_Number` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Emergency_Contacts`
--

INSERT INTO `Emergency_Contacts` (`ID`, `First_Name`, `Last_Name`, `Relationship`, `Phone_Number`, `Employee_Number`) VALUES
(1, 'Jereme', 'Slayford', 'Girlfriend', '07721065357', '22-3708071'),
(2, 'Nessy', 'Panting', 'Civil Partner', '07326502172', '49-2217652'),
(3, 'Kipp', 'Lavens', 'Boyfriend', '07489365686', '40-5288701'),
(4, 'Theo', 'Sheard', 'Mother', '07356401825', '78-6321379'),
(5, 'Joly', 'Doram', 'Girlfriend', '07106575891', '41-3659990'),
(6, 'Baird', 'Fingleton', 'Boyfriend', '07789751694', '43-8492699'),
(7, 'Patty', 'Horsburgh', 'Husband', '07924918978', '68-4171892'),
(8, 'Frazier', 'Snelman', 'Boyfriend', '07235513354', '72-5913162'),
(9, 'Regan', 'Yarn', 'Mother', '07231462728', '07-4517183'),
(10, 'Zita', 'Stanborough', 'Mother', '07532693273', '55-0320348'),
(11, 'Norrie', 'Aggis', 'Husband', '07390692263', '59-8314806'),
(12, 'Eada', 'Silmon', 'Wife', '07007182872', '66-0739491'),
(13, 'Maryjo', 'Elgie', 'Wife', '07007723133', '98-1678319'),
(14, 'Bastian', 'Walliker', 'Civil Partner', '07695349556', '30-1322103'),
(15, 'Winfred', 'Moncey', 'Wife', '07510608683', '31-7167962'),
(16, 'Michaelina', 'Brahms', 'Civil Partner', '07996211011', '05-1945849'),
(17, 'Tabbitha', 'Shemmans', 'Wife', '07625474049', '36-7073092'),
(18, 'Jone', 'Tatersale', 'Mother', '07761255990', '86-2503827'),
(19, 'Quinn', 'Goodfellow', 'Husband', '07755486861', '29-7832408'),
(20, 'Flory', 'Billham', 'Husband', '07184248686', '35-8208617'),
(21, 'Alyosha', 'Halewood', 'Boyfriend', '07204386023', '43-2037577'),
(22, 'Simone', 'Kitchenman', 'Father', '07958325944', '50-9092071'),
(23, 'Tyler', 'Rowsell', 'Wife', '07753973466', '75-6520267'),
(24, 'Renee', 'Kubatsch', 'Mother', '07643213336', '12-5128654'),
(25, 'Ivett', 'Rapier', 'Boyfriend', '07016239710', '10-4168432'),
(26, 'Margot', 'Santos', 'Girlfriend', '07915649295', '85-7718619'),
(27, 'Alis', 'Plaster', 'Father', '07547928939', '61-9391449'),
(28, 'Jon', 'McAlester', 'Husband', '07015001355', '59-6274425'),
(29, 'Cori', 'Phillipps', 'Husband', '07572306041', '53-7191465'),
(30, 'Alonzo', 'Whilder', 'Boyfriend', '07404498162', '30-2374884'),
(31, 'Leslie', 'Keningham', 'Father', '07765606938', '40-0786243'),
(32, 'Tim', 'Stiff', 'Girlfriend', '07764772037', '50-0945563'),
(33, 'Arthur', 'Landsborough', 'Mother', '07679670222', '45-3951342'),
(34, 'Golda', 'Preston', 'Father', '07636377875', '66-7576883'),
(35, 'Stevy', 'Cestard', 'Husband', '07510562958', '06-9710935'),
(36, 'Leesa', 'Bonhome', 'Wife', '07668929915', '14-1209073'),
(38, 'Joycelin', 'Mushet', 'Father', '07772470745', '67-5029558'),
(39, 'Ewart', 'Benton', 'Civil Partner', '07888475034', '98-4762907'),
(40, 'Lloyd', 'Pidon', 'Boyfriend', '07416146403', '69-0803348'),
(41, 'Nolie', 'Turfitt', 'Boyfriend', '07872652134', '03-3544565'),
(42, 'Vinnie', 'Parr', 'Father', '07792234252', '90-1403954'),
(43, 'Milty', 'Corney', 'Husband', '07432348532', '76-3367992'),
(44, 'Alaine', 'Gozney', 'Girlfriend', '07874802135', '20-2758343'),
(45, 'Bambie', 'Bennell', 'Father', '07411921600', '05-1128789'),
(46, 'Antoine', 'De', 'Father', '07676274711', '33-7614004'),
(47, 'Margette', 'Osman', 'Girlfriend', '07794678823', '41-6555988'),
(48, 'Zita', 'Greasty', 'Father', '07672610977', '16-0283796'),
(49, 'Wain', 'Savine', 'Civil Partner', '07473391474', '90-0686303'),
(50, 'Taylor', 'Screach', 'Civil Partner', '07029866049', '72-7823438'),
(51, 'Haroun', 'Izakovitz', 'Husband', '07369136446', '29-6571924'),
(52, 'Lorri', 'Elkington', 'Girlfriend', '07692074959', '75-0958781'),
(53, 'Rosabella', 'Howlin', 'Father', '07545233448', '83-4865660'),
(54, 'Freddie', 'Lorie', 'Husband', '07975207662', '10-6127924'),
(55, 'Paxton', 'Aspole', 'Boyfriend', '07789380331', '63-9116461'),
(56, 'Seumas', 'Ivantsov', 'Husband', '07643549188', '52-0404205'),
(57, 'Hieronymus', 'Eldon', 'Mother', '07315598289', '22-9529013'),
(58, 'Theresina', 'Tring', 'Civil Partner', '07536036354', '58-8249246'),
(59, 'Eilis', 'Domenici', 'Civil Partner', '07141393691', '80-6524018'),
(60, 'Paten', 'Velten', 'Husband', '07747283371', '30-3058947'),
(61, 'Franz', 'Barribal', 'Mother', '07304601591', '44-4915402'),
(62, 'Coleen', 'McPhater', 'Father', '07695675287', '39-4788866'),
(63, 'Montague', 'Giles', 'Girlfriend', '07602582994', '60-9203590'),
(64, 'Amabelle', 'McFaell', 'Mother', '07406136450', '60-1691051'),
(65, 'Codee', 'Hurndall', 'Boyfriend', '07296394678', '67-7636850'),
(66, 'Lazarus', 'Pomeroy', 'Boyfriend', '07288097464', '15-5837614'),
(67, 'Troy', 'Connock', 'Boyfriend', '07603307243', '45-6995640'),
(68, 'Rorie', 'Silverton', 'Civil Partner', '07675154777', '97-9018441'),
(70, 'Sumner', 'Armer', 'Civil Partner', '07124699528', '62-6894804'),
(71, 'Ashley', 'Jeenes', 'Wife', '07512219266', '99-0222188'),
(72, 'Bobby', 'Breslin', 'Boyfriend', '07156132741', '29-5105992'),
(73, 'Gerry', 'Bastone', 'Boyfriend', '07831515385', '11-9162644'),
(74, 'Alysa', 'Bonavia', 'Husband', '07998104368', '73-7147493'),
(75, 'Jon', 'Guisby', 'Boyfriend', '07770964956', '16-1242322'),
(76, 'Krisha', 'Mingasson', 'Mother', '07594793358', '09-4856118'),
(77, 'Inness', 'Hendrick', 'Father', '07196056242', '24-4677621'),
(78, 'Troy', 'Danielis', 'Boyfriend', '07543372808', '06-0280761'),
(79, 'Sal', 'Bruckstein', 'Wife', '07113310488', '97-3138911'),
(80, 'Trey', 'Shannon', 'Husband', '07275260538', '36-4580826'),
(81, 'Wanids', 'Dunckley', 'Boyfriend', '07415773406', '93-5928498'),
(82, 'Dagmar', 'Ranahan', 'Mother', '07367105969', '75-8250680'),
(83, 'Pandora', 'Furnell', 'Husband', '07519157083', '34-8601206'),
(84, 'Rora', 'Windross', 'Boyfriend', '07964139091', '59-1166943'),
(85, 'Hurley', 'Nadin', 'Husband', '07141801105', '17-5831110'),
(86, 'Sella', 'Ronca', 'Civil Partner', '07235827256', '19-1277494'),
(87, 'Paolina', 'Rosenwasser', 'Wife', '07405739948', '55-6072477'),
(88, 'Rollo', 'Olczak', 'Mother', '07268021034', '42-0717807'),
(89, 'Scarlet', 'Maps', 'Girlfriend', '07959819817', '57-4162757'),
(90, 'Ernestine', 'Syne', 'Father', '07699779427', '68-5871521'),
(91, 'Emmy', 'Giraldo', 'Boyfriend', '07456139081', '57-7596762'),
(92, 'Timothy', 'Reck', 'Civil Partner', '07149504735', '94-4705277'),
(93, 'Berty', 'Brimblecomb', 'Girlfriend', '07765565720', '63-6111701'),
(94, 'Reed', 'Easterfield', 'Civil Partner', '07523340134', '74-0303597'),
(95, 'Joyce', 'Jaynes', 'Civil Partner', '07184014200', '76-4036199'),
(96, 'Sibyl', 'Mabson', 'Civil Partner', '07924859819', '41-3975053'),
(97, 'Traci', 'Hammersley', 'Wife', '07950182116', '17-1342407'),
(98, 'Gloriana', 'McFade', 'Husband', '07061354829', '52-1336694'),
(99, 'Kristopher', 'Pawfoot', 'Boyfriend', '07623018398', '63-0638100'),
(100, 'Jaime', 'Picford', 'Mother', '07745996565', '26-3324931'),
(101, 'Bron', 'Danby', 'Mother', '07385290163', '85-3334513'),
(102, 'Bibbie', 'Tradewell', 'Wife', '07829257797', '40-2208062'),
(103, 'Ada', 'Vaissiere', 'Girlfriend', '07065792686', '35-6685131'),
(104, 'Emelen', 'Spender', 'Father', '07345326453', '53-0431396'),
(105, 'Husain', 'Yerborn', 'Civil Partner', '07241523713', '59-4684006'),
(106, 'Adena', 'Vasyuchov', 'Husband', '07515558479', '20-5440287'),
(107, 'Denys', 'Tuckwood', 'Father', '07099769526', '69-0536291'),
(108, 'Nathalia', 'Frake', 'Boyfriend', '07568334465', '14-9076003'),
(109, 'Dickie', 'Prophet', 'Wife', '07596027218', '83-5537250'),
(110, 'Shara', 'Bernardy', 'Mother', '07045228558', '60-7601093'),
(111, 'Domingo', 'Zuppa', 'Boyfriend', '07642910675', '70-2965789'),
(112, 'Dixie', 'Glazebrook', 'Mother', '07427129714', '84-3457422'),
(113, 'Sansone', 'Harragin', 'Mother', '07946591368', '93-0686984'),
(114, 'Stanley', 'Duffitt', 'Boyfriend', '07136718165', '36-6348131'),
(115, 'Ilyse', 'Schultheiss', 'Wife', '07228818773', '71-3652304'),
(116, 'Rouvin', 'Von', 'Mother', '07950739212', '81-4865027'),
(117, 'Murielle', 'Suett', 'Husband', '07932036011', '85-5431069'),
(118, 'Conway', 'Howman', 'Husband', '07285064810', '56-4309508'),
(119, 'Darci', 'Milbourne', 'Civil Partner', '07035959026', '97-5683996'),
(120, 'Monro', 'Piatkowski', 'Girlfriend', '07439078961', '60-2276889'),
(121, 'Braden', 'Sabben', 'Girlfriend', '07264110068', '51-7315582'),
(122, 'Ross', 'Little', 'Father', '07811367312', '65-7661186'),
(123, 'Joe', 'MacCleay', 'Mother', '07329779233', '76-2727093'),
(124, 'Harrietta', 'Arpin', 'Mother', '07469896525', '18-0534773'),
(125, 'Gearard', 'Lindback', 'Father', '07918823802', '57-1609142'),
(126, 'Mose', 'Pulham', 'Boyfriend', '07818864970', '29-6656577'),
(127, 'Thain', 'Kellard', 'Boyfriend', '07540241186', '12-8760096'),
(128, 'Goddard', 'Schenkel', 'Boyfriend', '07248542532', '22-3052971'),
(129, 'Erie', 'Wardingly', 'Civil Partner', '07055738740', '33-0489054'),
(130, 'Leia', 'MacMearty', 'Father', '07525541001', '52-4567561'),
(131, 'Perla', 'Sokill', 'Girlfriend', '07455033890', '97-5558458'),
(132, 'Megen', 'Vynall', 'Wife', '07100762873', '34-2543597'),
(133, 'Becka', 'Card', 'Father', '07503035492', '79-0464882'),
(134, 'Filberto', 'Railton', 'Wife', '07719120956', '04-2758260'),
(135, 'Calv', 'Alelsandrovich', 'Boyfriend', '07717918115', '38-9798664'),
(136, 'Francene', 'Licquorish', 'Husband', '07831756132', '18-3911956'),
(137, 'Agnella', 'Wyman', 'Husband', '07269336319', '45-7500187'),
(138, 'Fae', 'Whales', 'Boyfriend', '07698294787', '55-9616651'),
(139, 'Nickolaus', 'Riepel', 'Girlfriend', '07194463040', '31-8312411'),
(140, 'Jacquette', 'Cardenosa', 'Civil Partner', '07642004857', '33-7183053'),
(141, 'Joel', 'Laxson', 'Girlfriend', '07781001495', '72-3040567'),
(142, 'Forster', 'Naisby', 'Civil Partner', '07236732030', '02-9566746'),
(143, 'Margot', 'Barabich', 'Boyfriend', '07585007222', '06-3396053'),
(144, 'Brittan', 'Rubroe', 'Girlfriend', '07620851960', '21-1787461'),
(145, 'Corabella', 'Bitten', 'Boyfriend', '07918827977', '32-4834306'),
(146, 'Malissa', 'Scurrah', 'Wife', '07189813349', '62-7120162'),
(147, 'Eben', 'Samms', 'Wife', '07923010205', '77-7401728'),
(148, 'Matias', 'Ruckert', 'Girlfriend', '07792360390', '50-6111855'),
(149, 'Annette', 'Bydaway', 'Boyfriend', '07670530361', '64-6879023'),
(150, 'Dion', 'Tolson', 'Mother', '07154115530', '10-6680137'),
(151, 'Johna', 'Radki', 'Civil Partner', '07783704124', '58-0824770'),
(152, 'Asher', 'Ferrarotti', 'Civil Partner', '07460150758', '97-4110845'),
(153, 'Roddie', 'O\'', 'Boyfriend', '07464651444', '53-9062912'),
(154, 'Veradis', 'Glidder', 'Girlfriend', '07392244305', '77-8203719'),
(155, 'Nichol', 'Rawsthorne', 'Civil Partner', '07508127404', '28-4979315'),
(156, 'Toma', 'Van\'t', 'Boyfriend', '07866974051', '87-1470903'),
(157, 'Esme', 'MacGlory', 'Girlfriend', '07291150140', '24-6851371'),
(158, 'Thibaud', 'Bladder', 'Mother', '07357406936', '73-6200004'),
(159, 'Ken', 'Sloane', 'Mother', '07771820262', '45-5773014'),
(160, 'Paule', 'Willingham', 'Father', '07689398886', '46-0059406'),
(161, 'Lorrin', 'Morman', 'Boyfriend', '07627803411', '09-2857613'),
(162, 'Ogden', 'Wynne', 'Father', '07740998062', '11-6489646'),
(163, 'Mikey', 'Vedeniktov', 'Boyfriend', '07326764405', '99-4615801'),
(164, 'Sibyl', 'Danovich', 'Girlfriend', '07655343095', '12-0104092'),
(165, 'Cecil', 'Gathercoal', 'Wife', '07480391714', '10-9736161'),
(166, 'Farleigh', 'Norwich', 'Husband', '07452090283', '49-5299749'),
(167, 'Conrado', 'Laker', 'Girlfriend', '07004401178', '61-7469906'),
(168, 'Jenn', 'Sander', 'Wife', '07434841982', '59-4661298'),
(169, 'Cornie', 'Moodie', 'Girlfriend', '07878023821', '90-9258513'),
(170, 'Lee', 'Burt', 'Mother', '07001392333', '95-7092127'),
(171, 'Jacenta', 'Slimme', 'Boyfriend', '07903181488', '90-3945672'),
(172, 'Noelle', 'Physick', 'Mother', '07224883037', '20-9516100'),
(173, 'Klara', 'Eckford', 'Girlfriend', '07580481684', '17-1925809'),
(174, 'Thedric', 'Kenwright', 'Father', '07519455911', '56-7734821'),
(175, 'Granville', 'Hacket', 'Husband', '07058101214', '93-5661312'),
(176, 'Penelope', 'Hancill', 'Mother', '07018375399', '34-8695852'),
(177, 'Amye', 'Brecknock', 'Mother', '07633415279', '35-7212754'),
(178, 'Neila', 'Haimes', 'Girlfriend', '07794407646', '12-6888959'),
(179, 'Orelie', 'Balasin', 'Civil Partner', '07971986560', '31-9709677'),
(180, 'Bobbette', 'Ruddlesden', 'Civil Partner', '07116235571', '47-1387266'),
(181, 'Krissy', 'Clayworth', 'Mother', '07448190979', '90-6409982'),
(182, 'Cassandra', 'Merle', 'Mother', '07220743776', '87-6633787'),
(183, 'Cull', 'Harraway', 'Mother', '07970418060', '13-9234597'),
(184, 'Griffith', 'Witherow', 'Father', '07449485950', '78-4344207'),
(185, 'Frasquito', 'Legerwood', 'Mother', '07484895380', '92-9715314'),
(186, 'Damian', 'Elsworth', 'Wife', '07934375220', '11-5411031'),
(187, 'Sallee', 'Hughes', 'Mother', '07731937530', '49-1457327'),
(188, 'Prudi', 'Blum', 'Girlfriend', '07262636173', '48-1799687'),
(189, 'Goran', 'Lamburn', 'Father', '07304482930', '69-3965258'),
(190, 'Brose', 'Jepp', 'Husband', '07935559320', '42-7240015'),
(191, 'Tasha', 'Bromilow', 'Civil Partner', '07666955404', '10-6321236'),
(192, 'Dominick', 'Schirach', 'Girlfriend', '07814696449', '66-5805863'),
(193, 'Phyllys', 'Lamey', 'Boyfriend', '07427306598', '76-0099650'),
(194, 'Ham', 'Snalum', 'Father', '07513042679', '95-1174328'),
(195, 'Hollie', 'Hebble', 'Mother', '07399003920', '33-5159037'),
(196, 'Rorke', 'Biles', 'Father', '07204662049', '46-4344763'),
(197, 'Noland', 'Doret', 'Boyfriend', '07157222552', '22-6627032'),
(198, 'Georgena', 'Clappison', 'Husband', '07584205419', '33-1897506'),
(199, 'Casie', 'MacAirt', 'Civil Partner', '07394653792', '59-0150604'),
(200, 'Palmer', 'Vial', 'Civil Partner', '07277220402', '14-0432288'),
(201, 'Mike', 'Tiron', 'Girlfriend', '07100728296', '97-3703178'),
(202, 'Cristina', 'Ervine', 'Civil Partner', '07854566028', '98-9650752'),
(203, 'Arielle', 'Etock', 'Boyfriend', '07312873616', '53-6948800'),
(204, 'Raphaela', 'Fishlee', 'Girlfriend', '07691368084', '68-3132421'),
(205, 'Odo', 'Frame', 'Mother', '07142691496', '45-2811300'),
(206, 'Lief', 'Wilhelmy', 'Boyfriend', '07972492545', '64-0636526'),
(207, 'Judas', 'Tonn', 'Mother', '07354878768', '04-1386775'),
(208, 'Concordia', 'Marklund', 'Civil Partner', '07959795234', '19-1079892'),
(209, 'Bradford', 'Rudolf', 'Girlfriend', '07753919257', '53-5630368'),
(210, 'Letitia', 'Ellph', 'Boyfriend', '07764688949', '70-4763276'),
(211, 'Kimmie', 'McKevitt', 'Boyfriend', '07591865044', '55-9770243'),
(212, 'Shannon', 'McGinty', 'Girlfriend', '07499192522', '24-9067553'),
(213, 'Angus', 'Ranscome', 'Boyfriend', '07105859928', '72-3549258'),
(214, 'Birgitta', 'Naerup', 'Wife', '07161526613', '60-6428015'),
(215, 'Aaren', 'Lomaz', 'Civil Partner', '07117843636', '30-8953969'),
(216, 'Leena', 'Gorry', 'Father', '07049508215', '99-1372878'),
(217, 'Cindelyn', 'Gallant', 'Husband', '07583588628', '90-5035577'),
(218, 'Iolanthe', 'Carlick', 'Girlfriend', '07006963911', '38-1272080'),
(219, 'Bastien', 'Hollingshead', 'Girlfriend', '07250548384', '29-5209106'),
(220, 'Alameda', 'Iacobacci', 'Wife', '07244048879', '67-6284946'),
(221, 'Welbie', 'Hearon', 'Mother', '07174233681', '89-4884561'),
(222, 'Ethelbert', 'Warret', 'Boyfriend', '07813571441', '58-0128736'),
(223, 'Alie', 'Lutz', 'Civil Partner', '07880354813', '75-9134355'),
(224, 'Alikee', 'O\'Malley', 'Girlfriend', '07352836056', '87-8762204'),
(225, 'Rustie', 'Ridge', 'Husband', '07462515206', '41-3216938'),
(226, 'Brien', 'Narrie', 'Girlfriend', '07567015757', '48-5840838'),
(227, 'Eduino', 'Gainsboro', 'Civil Partner', '07169495661', '52-4726377'),
(228, 'Cybil', 'Bemrose', 'Mother', '07078712010', '79-9536595'),
(229, 'Harlan', 'Foxton', 'Husband', '07054759828', '72-6079643'),
(230, 'Lanny', 'Pendred', 'Boyfriend', '07493098720', '40-1037983'),
(231, 'Cooper', 'Sillars', 'Husband', '07228676244', '45-1060690'),
(232, 'Reeba', 'Lamartine', 'Mother', '07726563483', '87-8002965'),
(233, 'Christoforo', 'Decker', 'Husband', '07396626394', '37-0478226'),
(234, 'Davey', 'Gregan', 'Mother', '07204221186', '68-7096348'),
(235, 'Cordy', 'Sudell', 'Father', '07007011997', '67-4076527'),
(236, 'Stearne', 'Chaffer', 'Mother', '07640868506', '25-9736142'),
(237, 'Rolph', 'Reast', 'Wife', '07388570448', '14-2911172'),
(238, 'Bren', 'Epperson', 'Girlfriend', '07295123244', '38-0609594'),
(239, 'Nola', 'Yeowell', 'Mother', '07556127597', '36-1480567'),
(240, 'Alberik', 'Meaton', 'Boyfriend', '07785086128', '63-9446221'),
(241, 'Joanie', 'Scholtz', 'Husband', '07244882292', '97-0147786'),
(242, 'Hiram', 'Imrie', 'Husband', '07218567891', '60-3158201'),
(243, 'Marianne', 'Elion', 'Mother', '07866004620', '72-9006336'),
(244, 'Aksel', 'Ticehurst', 'Girlfriend', '07496100258', '02-4109274'),
(245, 'Ryley', 'Schieferstein', 'Mother', '07941015817', '76-8791360'),
(246, 'Lucila', 'Farlamb', 'Husband', '07665666934', '77-1835914'),
(247, 'Levon', 'Bratt', 'Boyfriend', '07123594714', '82-2609006'),
(248, 'Sim', 'Sacher', 'Father', '07962176107', '82-6558984'),
(249, 'Janela', 'Jeffels', 'Wife', '07747406557', '66-2361006'),
(250, 'Bord', 'Bartoletti', 'Mother', '07369214958', '15-4783339'),
(251, 'Dougy', 'Hamlen', 'Boyfriend', '07003409288', '32-3604971'),
(252, 'Brnaby', 'Snoday', 'Husband', '07570183764', '03-2826761'),
(253, 'Ossie', 'McBean', 'Civil Partner', '07137684264', '79-1576734'),
(254, 'Jacki', 'Tupling', 'Boyfriend', '07890810674', '81-8060778'),
(255, 'Wain', 'Corneck', 'Girlfriend', '07089659356', '35-2689059'),
(256, 'Sara-ann', 'Knoller', 'Civil Partner', '07189537844', '27-8387260'),
(257, 'Sigmund', 'McLafferty', 'Wife', '07996723103', '47-3147567'),
(258, 'Giuseppe', 'Petican', 'Wife', '07685471321', '38-3647372'),
(259, 'Elisa', 'McNamee', 'Boyfriend', '07173106494', '20-7886428'),
(260, 'Gina', 'Manueli', 'Boyfriend', '07640597771', '62-4020686'),
(261, 'Ezmeralda', 'Ertel', 'Boyfriend', '07929318804', '41-9319442'),
(262, 'Lelia', 'Heppenspall', 'Mother', '07865407286', '87-1949652'),
(263, 'Darby', 'Lias', 'Husband', '07194892472', '30-7334418'),
(264, 'Samuele', 'Solesbury', 'Wife', '07037038101', '75-0328049'),
(265, 'Damara', 'Dudny', 'Mother', '07425771845', '51-0122715'),
(266, 'Lew', 'O\'Dempsey', 'Mother', '07885465113', '67-6903314'),
(267, 'Benni', 'Botting', 'Wife', '07639903071', '33-1261585'),
(268, 'Clotilda', 'Blues', 'Girlfriend', '07754815231', '99-6209168'),
(269, 'Hadleigh', 'Twining', 'Civil Partner', '07302069966', '99-4988360'),
(270, 'Aristotle', 'MacGrath', 'Boyfriend', '07717401856', '68-3172017'),
(271, 'Byran', 'Greaser', 'Husband', '07556017337', '27-8094243'),
(272, 'Zaneta', 'Shrubb', 'Father', '07613479105', '89-4176534'),
(273, 'Debera', 'Itzkovich', 'Mother', '07196432406', '59-0997098'),
(274, 'Joyann', 'Spellessy', 'Husband', '07873688139', '06-2857563'),
(275, 'Fiorenze', 'Elvey', 'Father', '07902274458', '80-7938995'),
(276, 'Marwin', 'Haburne', 'Husband', '07467024579', '15-6949928'),
(277, 'Hagen', 'Lantoph', 'Wife', '07512531127', '18-3863597'),
(278, 'Sydel', 'Dexter', 'Father', '07795010970', '08-4428147'),
(279, 'Shannon', 'Purdy', 'Mother', '07885597859', '56-3682739'),
(280, 'Morley', 'Mastrantone', 'Mother', '07615396907', '64-0621633'),
(281, 'Clyve', 'Pedroli', 'Father', '07680068925', '77-6317806'),
(282, 'Natassia', 'Ludvigsen', 'Father', '07785317092', '66-2522703'),
(283, 'Michale', 'Kluger', 'Husband', '07685967303', '83-7810679'),
(284, 'Caryl', 'Coyle', 'Girlfriend', '07142015007', '95-3517999'),
(285, 'Violet', 'Doutch', 'Wife', '07346373537', '89-6058656'),
(286, 'Zachariah', 'Trassler', 'Girlfriend', '07670477662', '01-9065592'),
(287, 'Justinn', 'Maginot', 'Civil Partner', '07255258700', '69-5458568'),
(288, 'Hurlee', 'Bendle', 'Father', '07016639458', '50-5810953'),
(289, 'Cathyleen', 'Lindfors', 'Husband', '07119333689', '62-4959178'),
(290, 'Staci', 'Normadell', 'Girlfriend', '07035352138', '75-0131682'),
(291, 'Willis', 'Deary', 'Girlfriend', '07475627111', '29-6350132'),
(292, 'Marlie', 'Schwaiger', 'Civil Partner', '07055302769', '84-3853067'),
(293, 'Zaria', 'Tallet', 'Boyfriend', '07473173088', '97-0913105'),
(294, 'Tam', 'Howler', 'Boyfriend', '07107484803', '45-3804689'),
(295, 'Francois', 'Goodrick', 'Civil Partner', '07224909347', '83-1217063'),
(296, 'Manfred', 'Morston', 'Wife', '07857880717', '54-7676865'),
(297, 'Ileana', 'Wicken', 'Girlfriend', '07816723310', '04-2608361'),
(298, 'Allie', 'Hambleton', 'Wife', '07583207317', '42-1134854'),
(299, 'Poul', 'Poznan', 'Wife', '07353747279', '48-9328765'),
(300, 'Chaddie', 'Kelcey', 'Husband', '07135140819', '38-5473326'),
(301, 'Llywellyn', 'Buckley', 'Girlfriend', '07978885045', '10-8148353'),
(302, 'Nickie', 'Driscoll', 'Husband', '07163688713', '43-6568300'),
(303, 'Tallie', 'Huggon', 'Father', '07493025274', '92-9480837'),
(304, 'Papageno', 'Baiyle', 'Girlfriend', '07413999083', '42-2072103'),
(305, 'Harper', 'Crutchley', 'Father', '07349039768', '42-7011523'),
(306, 'Nanete', 'Hassard', 'Boyfriend', '07005200200', '55-3650046'),
(307, 'Coleen', 'Tolley', 'Father', '07220519362', '31-5831645'),
(308, 'Mindy', 'Gatch', 'Girlfriend', '07074285151', '80-3234805'),
(309, 'Bald', 'Bennoe', 'Wife', '07580556646', '54-6428980'),
(310, 'Nancy', 'Masterson', 'Father', '07031588061', '59-2576093'),
(311, 'Augustine', 'Corstorphine', 'Father', '07793242869', '07-4724394'),
(312, 'Helen', 'Gouda', 'Boyfriend', '07268106425', '63-2539882'),
(313, 'Adolph', 'Hedgeman', 'Wife', '07295967993', '46-2600043'),
(314, 'Philis', 'Gulleford', 'Father', '07838716945', '86-1870935'),
(315, 'Selia', 'Sopp', 'Husband', '07937394557', '10-1743239'),
(316, 'Mile', 'Scholler', 'Father', '07558144894', '79-4798875'),
(317, 'Porter', 'Nance', 'Civil Partner', '07097155888', '54-8296596'),
(318, 'Alden', 'Bourthoumieux', 'Boyfriend', '07435864662', '55-5908272'),
(319, 'Christan', 'Leupoldt', 'Husband', '07699612785', '62-1957072'),
(320, 'Karel', 'Gully', 'Father', '07088509851', '13-8722134'),
(321, 'Waldemar', 'Plunket', 'Civil Partner', '07417261693', '38-1884801'),
(322, 'Brnaby', 'Hilhouse', 'Girlfriend', '07346042351', '82-9457047'),
(323, 'Nap', 'Muzzlewhite', 'Wife', '07942102464', '36-4190617'),
(324, 'Samaria', 'Rennie', 'Civil Partner', '07366799382', '38-4369228'),
(325, 'Friedrich', 'Howsego', 'Father', '07787734288', '88-4435308'),
(326, 'Ruggiero', 'Kilgrove', 'Civil Partner', '07100170818', '81-7038918'),
(327, 'Beitris', 'Morison', 'Boyfriend', '07455807075', '60-0655971'),
(328, 'Cassandre', 'Attawell', 'Wife', '07612472814', '42-0131259'),
(329, 'Mariejeanne', 'Prendeville', 'Mother', '07474771437', '11-4556284'),
(330, 'Baudoin', 'Danigel', 'Girlfriend', '07315752509', '27-1540713'),
(331, 'Cris', 'Melladew', 'Mother', '07427006306', '83-6435523'),
(332, 'Bradly', 'Mitrovic', 'Husband', '07708980078', '55-4384947'),
(333, 'Eunice', 'Chmarny', 'Father', '07717672468', '22-0788973'),
(334, 'Brear', 'Kluge', 'Husband', '07267762763', '09-4017521'),
(335, 'Melodee', 'Sillars', 'Boyfriend', '07822069566', '06-7381402'),
(336, 'Jennee', 'Costock', 'Father', '07362630943', '85-7355238'),
(337, 'Xaviera', 'Chaves', 'Mother', '07054012385', '27-8037561'),
(338, 'Caroline', 'Brinicombe', 'Father', '07276959298', '20-3044693'),
(339, 'Leoine', 'Ayrs', 'Boyfriend', '07403137340', '19-0713712'),
(340, 'Towny', 'Deetch', 'Civil Partner', '07086691240', '76-4940799'),
(341, 'Melinda', 'Edelston', 'Mother', '07607490054', '41-3268639'),
(342, 'Rozelle', 'McCullouch', 'Husband', '07387875939', '84-9275069'),
(343, 'Tootsie', 'Holdey', 'Wife', '07329818995', '54-5318903'),
(344, 'Cordey', 'Peer', 'Girlfriend', '07645326285', '21-2689388'),
(345, 'Bendicty', 'Macek', 'Husband', '07726134897', '58-8390431'),
(346, 'Nobie', 'Scardifeild', 'Mother', '07035382913', '34-4740678'),
(347, 'Haley', 'Kellock', 'Girlfriend', '07487727188', '47-5302795'),
(348, 'Clayton', 'Segar', 'Mother', '07030174840', '77-5748543'),
(349, 'Kristin', 'Stanhope', 'Civil Partner', '07095123826', '63-5722038'),
(350, 'Gabi', 'Crooks', 'Father', '07021173423', '59-8381667'),
(351, 'Caresa', 'McGeown', 'Girlfriend', '07546091676', '20-6300983'),
(352, 'Cully', 'Galilee', 'Civil Partner', '07898839206', '26-9050326'),
(353, 'Edi', 'Haygreen', 'Husband', '07382538132', '75-1340477'),
(354, 'Jacky', 'Schwandt', 'Father', '07787718899', '05-5646283'),
(355, 'Ardyce', 'McAree', 'Mother', '07648096231', '31-7111614'),
(356, 'Iseabal', 'Leidl', 'Girlfriend', '07683879132', '24-9840403'),
(357, 'Audrey', 'Calafate', 'Boyfriend', '07905196224', '38-8885296'),
(358, 'Charmain', 'Ewbanck', 'Husband', '07876106377', '09-8147999'),
(359, 'Florentia', 'Cornelisse', 'Wife', '07465428558', '30-8456021'),
(360, 'Sayre', 'Faint', 'Girlfriend', '07320940413', '95-1790755'),
(361, 'Libbey', 'Van', 'Civil Partner', '07623894854', '68-8976238'),
(362, 'Galvan', 'Kaszper', 'Girlfriend', '07814082485', '44-7083318'),
(363, 'Joscelin', 'Dumblton', 'Wife', '07719695663', '63-8802366'),
(364, 'Joela', 'Artois', 'Boyfriend', '07419063793', '05-5059849'),
(365, 'Krishna', 'Payle', 'Mother', '07834640631', '76-4086283'),
(366, 'Hermine', 'Sapsed', 'Boyfriend', '07245144587', '56-0484045'),
(367, 'Carling', 'Jell', 'Civil Partner', '07345068432', '93-8667645'),
(368, 'Emmet', 'Speedy', 'Husband', '07964772320', '83-1009344'),
(369, 'Jeane', 'Fleet', 'Girlfriend', '07452139490', '11-0990160'),
(370, 'Fifi', 'Lamputt', 'Father', '07477278621', '68-6940299'),
(371, 'Sanders', 'Firsby', 'Husband', '07483322111', '60-6270362'),
(372, 'Marjorie', 'Fraine', 'Wife', '07037535429', '78-0380118'),
(373, 'Durand', 'Klassman', 'Father', '07324591670', '21-3155551'),
(374, 'Aksel', 'Gallimore', 'Father', '07677246578', '21-4089887'),
(375, 'Dorthy', 'Savoury', 'Mother', '07911839364', '72-0413596'),
(376, 'Jamison', 'Richardet', 'Civil Partner', '07608960744', '64-6729020'),
(377, 'Torrence', 'Fowells', 'Civil Partner', '07620698046', '94-6907133'),
(378, 'Dorise', 'Polin', 'Civil Partner', '07030945316', '42-5263028'),
(379, 'Alica', 'Adnam', 'Civil Partner', '07339364526', '71-4783541'),
(380, 'Merlina', 'Adolthine', 'Civil Partner', '07498555907', '44-1072008'),
(381, 'George', 'Barczynski', 'Girlfriend', '07927318789', '86-5274202'),
(382, 'Donella', 'Scullard', 'Boyfriend', '07764317881', '65-1738561'),
(383, 'Stearne', 'Coveny', 'Girlfriend', '07552624180', '22-2051613'),
(384, 'Brendis', 'Saunder', 'Mother', '07747163685', '81-2733835'),
(385, 'Justina', 'Steinson', 'Girlfriend', '07978286641', '50-7117246'),
(386, 'Duke', 'Ruske', 'Father', '07775640640', '69-6968657'),
(387, 'Meridith', 'Lowes', 'Civil Partner', '07881576200', '78-1195027'),
(388, 'Eilis', 'Decent', 'Husband', '07190067060', '97-6528129'),
(389, 'Marybeth', 'Dibben', 'Boyfriend', '07888296305', '45-1168337'),
(390, 'Dianne', 'Pease', 'Wife', '07983466814', '01-9983285'),
(391, 'Salem', 'Courtliff', 'Boyfriend', '07239492326', '58-2471319'),
(392, 'Joel', 'Fairham', 'Girlfriend', '07080664959', '29-2364794'),
(393, 'Hayden', 'Monkley', 'Wife', '07958131810', '42-8848918'),
(394, 'Odelle', 'Godsmark', 'Wife', '07530434901', '05-9682452'),
(396, 'Emera', 'Yearne', 'Father', '07206048771', '52-6674444'),
(397, 'Essa', 'Sor', 'Husband', '07629867802', '89-0022888'),
(398, 'Goldia', 'Nisard', 'Girlfriend', '07475211884', '37-6605556'),
(399, 'Katusha', 'Kirkham', 'Civil Partner', '07216578917', '69-5925327'),
(400, 'Scotti', 'Nowill', 'Boyfriend', '07797601369', '40-1136806'),
(401, 'Corabella', 'Possek', 'Girlfriend', '07171514291', '04-2798023'),
(402, 'Gabriela', 'Wehden', 'Mother', '07904464506', '54-7904459'),
(403, 'Frederique', 'Wheatman', 'Civil Partner', '07068255984', '81-0188200'),
(404, 'Delmore', 'Borel', 'Civil Partner', '07050832727', '62-2186332'),
(405, 'Giustina', 'Stephen', 'Wife', '07101430354', '38-2126707'),
(406, 'Gustave', 'Benedikt', 'Husband', '07689714850', '01-5576008'),
(407, 'Taylor', 'Micka', 'Civil Partner', '07239031455', '67-5304822'),
(408, 'Ulick', 'Snyder', 'Father', '07013596878', '36-6943031'),
(409, 'Sandye', 'De', 'Husband', '07383021093', '25-6187206'),
(410, 'Gideon', 'Gillivrie', 'Boyfriend', '07257411126', '49-6102253'),
(411, 'Jeremiah', 'Pavlasek', 'Father', '07425200343', '22-7191567'),
(412, 'Maritsa', 'McGann', 'Wife', '07389587350', '43-7385696'),
(413, 'Layne', 'Laurenty', 'Boyfriend', '07925739484', '17-3967296'),
(414, 'El', 'Grishagin', 'Husband', '07888438593', '58-5912504'),
(415, 'Lynsey', 'Moraleda', 'Wife', '07652112844', '98-3556505'),
(416, 'Alasteir', 'McKeand', 'Wife', '07373224784', '37-1673392'),
(417, 'Baxie', 'De', 'Wife', '07594266644', '25-4103329'),
(418, 'Nikaniki', 'Stenhouse', 'Husband', '07585388400', '82-1629865'),
(419, 'Tildy', 'Donett', 'Civil Partner', '07996433549', '66-1883695'),
(420, 'Gerik', 'Graeser', 'Girlfriend', '07753745592', '74-9747670'),
(421, 'Verney', 'Essam', 'Husband', '07173823511', '77-2348932'),
(422, 'Claudetta', 'Plaistowe', 'Civil Partner', '07358746653', '08-5459846'),
(423, 'Erhart', 'Husset', 'Boyfriend', '07683714091', '82-2981878'),
(424, 'Nicol', 'Dockray', 'Wife', '07174952329', '51-9601829'),
(425, 'Reinold', 'Kaubisch', 'Husband', '07005138853', '49-1036239'),
(426, 'Leshia', 'Allcorn', 'Mother', '07341771237', '78-9623211'),
(427, 'Reeta', 'Feary', 'Wife', '07985842262', '72-2448628'),
(428, 'Rivy', 'Gensavage', 'Husband', '07544911166', '78-8816060'),
(429, 'Harmon', 'Gindghill', 'Civil Partner', '07285352836', '06-3850682'),
(430, 'Waylan', 'Kochlin', 'Boyfriend', '07629713818', '52-5735024'),
(431, 'Amabelle', 'Ferreiro', 'Wife', '07395862130', '02-6214516'),
(432, 'Lesya', 'Phebey', 'Wife', '07741907270', '57-2548391'),
(433, 'Daloris', 'Lanon', 'Mother', '07102109240', '79-5517945'),
(434, 'Bernadene', 'Lowey', 'Wife', '07937182672', '69-0393201'),
(435, 'Peyton', 'MacShirie', 'Girlfriend', '07219511447', '51-7472749'),
(436, 'Jabez', 'Yewman', 'Father', '07280779671', '62-6726896'),
(437, 'Valaree', 'Treadgold', 'Civil Partner', '07427564348', '87-3376412'),
(438, 'Bondie', 'Schruyers', 'Father', '07868628411', '62-7019089'),
(439, 'Delainey', 'Benedtti', 'Mother', '07621668278', '80-8617080'),
(440, 'Eimile', 'Vial', 'Husband', '07477622496', '29-2785103'),
(441, 'Malory', 'Hawes', 'Husband', '07066178667', '71-7837650'),
(442, 'Lizbeth', 'Curbishley', 'Father', '07104138411', '59-5937939'),
(443, 'Randall', 'Corriea', 'Husband', '07654630110', '84-0386773'),
(444, 'Shelly', 'Gimblet', 'Boyfriend', '07107706065', '51-6967096'),
(445, 'Augustus', 'Goodluck', 'Mother', '07997004063', '18-6142811'),
(446, 'Nariko', 'Illsley', 'Civil Partner', '07008281309', '24-4585192'),
(447, 'Caz', 'Dartnell', 'Mother', '07448651046', '28-7818998'),
(448, 'Ramsey', 'Denacamp', 'Boyfriend', '07342317379', '19-6732633'),
(449, 'Terrijo', 'Piatto', 'Husband', '07870877830', '32-6251861'),
(450, 'Diannne', 'Streight', 'Boyfriend', '07974403769', '14-6532726'),
(451, 'Marylinda', 'Titta', 'Girlfriend', '07410675062', '40-6943405'),
(452, 'Bryan', 'Shawdforth', 'Father', '07939930407', '72-9328783'),
(453, 'Charla', 'Crickmore', 'Boyfriend', '07512743229', '85-4557957'),
(454, 'Leroi', 'Dingivan', 'Husband', '07244918390', '80-7941049'),
(455, 'Budd', 'Follacaro', 'Girlfriend', '07569513210', '89-5714177'),
(456, 'Dante', 'Snozzwell', 'Boyfriend', '07066007108', '77-5513461'),
(457, 'Adam', 'Roderighi', 'Husband', '07503037843', '85-0601601'),
(458, 'Madonna', 'McCague', 'Wife', '07187549944', '36-1132600'),
(459, 'Rafaellle', 'Tweedlie', 'Wife', '07036754544', '81-5031235'),
(460, 'Ilsa', 'McAusland', 'Boyfriend', '07064930835', '54-9522118'),
(461, 'Vilhelmina', 'Wrangle', 'Mother', '07750131976', '73-2251057'),
(462, 'Fidela', 'Heaviside', 'Wife', '07081377359', '37-8247167'),
(463, 'Phillie', 'Eles', 'Husband', '07925034405', '76-2985832'),
(464, 'Katee', 'Dilrew', 'Father', '07612660166', '81-5228790'),
(465, 'Melody', 'Brotherwood', 'Wife', '07735358950', '08-7213723'),
(466, 'Colette', 'Reisk', 'Husband', '07457814451', '39-1227728'),
(467, 'Hamnet', 'Hamly', 'Wife', '07692458187', '84-5153657'),
(468, 'Abbey', 'Waryk', 'Boyfriend', '07260273133', '75-0124112'),
(469, 'Pattie', 'Bohl', 'Girlfriend', '07158470617', '89-1889473'),
(470, 'Izzy', 'Ahlf', 'Father', '07044089640', '84-8762859'),
(471, 'Anastasia', 'Camamile', 'Civil Partner', '07043627535', '00-4334715'),
(472, 'Rand', 'Madrell', 'Civil Partner', '07252015009', '66-2765926'),
(473, 'Zaneta', 'Deddum', 'Mother', '07529897607', '14-4001908'),
(474, 'Elston', 'Loins', 'Girlfriend', '07930606296', '87-8745898'),
(475, 'Arlie', 'Korfmann', 'Husband', '07348062445', '05-3647243'),
(476, 'Madelaine', 'Hutt', 'Mother', '07734801502', '33-0071114'),
(477, 'Leon', 'McCotter', 'Father', '07126636219', '37-7900056'),
(478, 'Glenden', 'Livett', 'Civil Partner', '07613591203', '68-7504033'),
(479, 'Ferrell', 'Scruton', 'Boyfriend', '07455760917', '83-3514873'),
(480, 'Stepha', 'Doohan', 'Husband', '07728862325', '75-6891165'),
(481, 'Sisely', 'Castelin', 'Mother', '07152080965', '54-1117411'),
(482, 'Northrup', 'Pittendreigh', 'Mother', '07603027379', '41-1429269'),
(483, 'Kev', 'Bradmore', 'Boyfriend', '07180333916', '26-0938951'),
(484, 'Wallache', 'Ropkins', 'Girlfriend', '07410226285', '63-1545651'),
(485, 'Agatha', 'Nulty', 'Girlfriend', '07895871178', '76-0000021'),
(486, 'Tobe', 'Vazquez', 'Boyfriend', '07936699391', '96-1648398'),
(487, 'Umberto', 'Mulrooney', 'Boyfriend', '07291039769', '92-9623071'),
(488, 'Creighton', 'Hinzer', 'Girlfriend', '07394851273', '41-9645109'),
(489, 'Duane', 'Mitton', 'Civil Partner', '07087447204', '68-7037451'),
(490, 'Kane', 'Piers', 'Husband', '07453022869', '87-7188668'),
(491, 'Nonie', 'Ledgard', 'Girlfriend', '07316951272', '87-4453963'),
(492, 'Kass', 'Haysman', 'Girlfriend', '07480332736', '49-9705882'),
(493, 'Marsh', 'Abilowitz', 'Wife', '07026832505', '18-9171336'),
(494, 'Ahmad', 'Muge', 'Boyfriend', '07028898207', '28-7012669'),
(495, 'Der', 'Merner', 'Girlfriend', '07472485627', '49-1159362'),
(496, 'Sallyanne', 'Minchinton', 'Father', '07491768068', '63-1925261'),
(497, 'Grove', 'Spellissy', 'Husband', '07555870467', '20-7194686'),
(498, 'Boony', 'Hardwell', 'Wife', '07211259256', '06-3776558'),
(499, 'Shannon', 'Kesteven', 'Father', '07543934498', '34-2817296'),
(500, 'Danny', 'Heinsen', 'Father', '07194408632', '96-0987852'),
(510, 'Marcie', 'Pragginton', 'Mother', '07297230400', '55-3623151');

-- --------------------------------------------------------

--
-- Table structure for table `Employees`
--

CREATE TABLE `Employees` (
  `Number` varchar(10) NOT NULL,
  `NIN` varchar(9) NOT NULL,
  `Department_Number` int(11) NOT NULL,
  `Manager_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Employees`
--

INSERT INTO `Employees` (`Number`, `NIN`, `Department_Number`, `Manager_ID`) VALUES
('00-4334715', 'XN991742P', 2, 3),
('01-5576008', 'IR187391U', 4, 6),
('01-9065592', 'GL907590T', 1, 3),
('01-9983285', 'PZ402630G', 2, 3),
('02-4109274', 'JK980246H', 1, 5),
('02-6214516', 'WA104983F', 1, 3),
('02-9566746', 'XS400698X', 4, 7),
('03-2826761', 'YS435194S', 4, 7),
('03-3544565', 'EN390360S', 4, 3),
('04-1386775', 'ZZ594734B', 1, 1),
('04-2608361', 'KU802868L', 1, 3),
('04-2758260', 'QL275702I', 1, 1),
('04-2798023', 'BL772452L', 4, 8),
('05-1128789', 'DS948250K', 1, 7),
('05-1945849', 'XZ796669H', 1, 3),
('05-3647243', 'KC608204K', 4, 8),
('05-5059849', 'TU153415T', 4, 7),
('05-5646283', 'NP061992L', 1, 2),
('05-9682452', 'BO740928H', 1, 3),
('06-0280761', 'RZ638367H', 2, 2),
('06-2857563', 'YA877759R', 3, 2),
('06-3396053', 'JM300330R', 4, 4),
('06-3776558', 'PW205885R', 4, 3),
('06-3850682', 'LW782748U', 1, 8),
('06-7381402', 'RB727027L', 1, 8),
('06-9710935', 'NO969473Z', 4, 2),
('07-4517183', 'RZ111360G', 4, 4),
('07-4724394', 'VW694872R', 4, 2),
('08-4428147', 'AD905076O', 4, 5),
('08-5459846', 'XZ369649I', 1, 2),
('08-7213723', 'QA101983V', 1, 5),
('09-2857613', 'YH126921T', 1, 3),
('09-4017521', 'SB614856M', 2, 6),
('09-4856118', 'HG982259Y', 1, 6),
('09-8147999', 'PQ325071U', 4, 3),
('10-1743239', 'TX858508R', 4, 8),
('10-4168432', 'EU934314Q', 4, 6),
('10-6127924', 'FT026339D', 4, 4),
('10-6321236', 'VW739034C', 2, 3),
('10-6680137', 'XZ020089E', 1, 6),
('10-8148353', 'KW816523W', 2, 2),
('10-9736161', 'FA725896G', 1, 3),
('11-0990160', 'EL763944V', 4, 3),
('11-4556284', 'IU795663W', 4, 7),
('11-5411031', 'DI653042T', 1, 4),
('11-6489646', 'KC363601G', 2, 6),
('11-9162644', 'QI586048L', 1, 4),
('12-0104092', 'PC545418R', 4, 4),
('12-5128654', 'TF577069V', 4, 8),
('12-6888959', 'YC393041Q', 4, 1),
('12-8760096', 'GB976841W', 4, 5),
('13-8722134', 'GD959536A', 4, 5),
('13-9234597', 'HE783674O', 4, 3),
('14-0432288', 'FP824869E', 1, 3),
('14-1209073', 'FJ377449J', 1, 5),
('14-2911172', 'OX915931W', 4, 1),
('14-4001908', 'GB391445Q', 4, 7),
('14-6532726', 'OS724826W', 4, 2),
('14-9076003', 'WS394988S', 1, 8),
('15-4783339', 'QH838641Y', 2, 1),
('15-5837614', 'TX310999B', 1, 2),
('15-6949928', 'JZ826946H', 1, 8),
('16-0283796', 'MX935884P', 1, 4),
('16-1242322', 'SP696523T', 1, 3),
('17-1342407', 'KF326923S', 1, 5),
('17-1925809', 'XR596082Y', 4, 6),
('17-3967296', 'FI082187Y', 4, 7),
('17-5831110', 'VX435216W', 1, 3),
('18-0534773', 'NY144248G', 4, 3),
('18-3863597', 'DM359618L', 4, 3),
('18-3911956', 'YK522444D', 2, 3),
('18-6142811', 'QJ120357R', 4, 6),
('18-9171336', 'YX656704N', 4, 6),
('19-0713712', 'VI744437V', 4, 4),
('19-1079892', 'UW710251U', 4, 2),
('19-1277494', 'BS437833J', 4, 5),
('19-6732633', 'XB032437G', 1, 3),
('20-2758343', 'DW797814S', 2, 2),
('20-3044693', 'UZ970481U', 1, 6),
('20-5440287', 'OJ166622V', 1, 3),
('20-6300983', 'BX776119O', 1, 3),
('20-7194686', 'YB039141A', 2, 3),
('20-7886428', 'EE121177L', 4, 1),
('20-9516100', 'MU901992I', 1, 3),
('21-1787461', 'QN206371I', 1, 1),
('21-2689388', 'KP709951V', 4, 3),
('21-3155551', 'HN280217C', 4, 4),
('21-4089887', 'KM813203W', 1, 2),
('22-0788973', 'EI247057V', 1, 4),
('22-2051613', 'RS859776Q', 4, 1),
('22-3052971', 'JK018371C', 1, 5),
('22-3708071', 'RB499211C', 2, 4),
('22-6627032', 'AL340446B', 4, 1),
('22-7191567', 'LX057194P', 1, 2),
('22-9529013', 'JU954932E', 4, 4),
('24-4585192', 'SA107205Q', 4, 3),
('24-4677621', 'QB596623C', 4, 5),
('24-6851371', 'MH954487U', 1, 3),
('24-9067553', 'XO554182R', 4, 8),
('24-9840403', 'WW328815I', 4, 3),
('25-4103329', 'RI926857Q', 1, 3),
('25-6187206', 'FG558529Z', 1, 7),
('25-9736142', 'BI255825P', 4, 3),
('26-0938951', 'CC841112D', 1, 7),
('26-3324931', 'QJ455525D', 1, 5),
('26-9050326', 'LM182202B', 1, 2),
('27-1540713', 'RY550614D', 1, 6),
('27-8037561', 'CX516631K', 4, 4),
('27-8094243', 'SH464311U', 4, 5),
('27-8387260', 'VD818340C', 1, 4),
('28-4979315', 'TP697018E', 1, 7),
('28-7012669', 'KZ848071O', 2, 4),
('28-7818998', 'TP307139N', 4, 1),
('29-2364794', 'IN158664I', 3, 6),
('29-2785103', 'KK792060S', 4, 1),
('29-5105992', 'HM134578N', 1, 2),
('29-5209106', 'WN277158X', 4, 1),
('29-6350132', 'FV388894K', 4, 4),
('29-6571924', 'UX813250N', 4, 5),
('29-6656577', 'RG151568Q', 1, 6),
('29-7832408', 'PK696816M', 4, 3),
('30-1322103', 'ZW251674D', 4, 2),
('30-2374884', 'EI636866Y', 1, 7),
('30-3058947', 'AN167975T', 4, 4),
('30-7334418', 'YH523785H', 4, 2),
('30-8456021', 'SR314203N', 4, 8),
('30-8953969', 'RK384949O', 1, 1),
('31-5831645', 'VA211893V', 1, 8),
('31-7111614', 'BP682069W', 1, 2),
('31-7167962', 'QY726870D', 2, 3),
('31-8312411', 'EO514879Y', 1, 3),
('31-9709677', 'FP198238E', 1, 3),
('32-3604971', 'EH265089X', 1, 6),
('32-4834306', 'RW267230V', 1, 8),
('32-6251861', 'RS647299I', 4, 7),
('33-0071114', 'AQ503711L', 2, 7),
('33-0489054', 'XA033094E', 4, 3),
('33-1261585', 'FH221614B', 1, 4),
('33-1897506', 'UN133384D', 3, 5),
('33-5159037', 'VK466721D', 4, 4),
('33-7183053', 'NN735991O', 2, 5),
('33-7614004', 'ZZ664726S', 4, 3),
('34-2543597', 'DY170889S', 4, 3),
('34-2817296', 'DW387671H', 4, 6),
('34-4740678', 'YO417120D', 4, 7),
('34-8601206', 'ZA364662Q', 1, 1),
('34-8695852', 'LR289379R', 2, 8),
('35-2689059', 'PR407605T', 1, 7),
('35-6685131', 'PS562104C', 1, 2),
('35-7212754', 'UW834458R', 3, 6),
('35-8208617', 'JR596419T', 4, 6),
('36-1132600', 'DC106173C', 1, 3),
('36-1480567', 'IB067151Y', 2, 8),
('36-4190617', 'GR760688U', 1, 3),
('36-4580826', 'DJ312271A', 1, 7),
('36-6348131', 'BM829464Z', 4, 7),
('36-6943031', 'OP535073Z', 4, 7),
('36-7073092', 'BL221585Z', 4, 3),
('37-0478226', 'PW357899L', 4, 8),
('37-1673392', 'CT112101I', 2, 8),
('37-6605556', 'VG977309D', 1, 3),
('37-7900056', 'VD479897L', 4, 8),
('37-8247167', 'EO273727Q', 4, 2),
('38-0609594', 'KU940218F', 4, 5),
('38-1272080', 'ZX396808C', 4, 3),
('38-1884801', 'HY568138E', 1, 8),
('38-2126707', 'VN364397S', 4, 6),
('38-3647372', 'LB767754C', 1, 7),
('38-4369228', 'EF765749D', 1, 7),
('38-5473326', 'KZ832424W', 4, 7),
('38-8885296', 'PS334310V', 4, 3),
('38-9798664', 'FL067205Y', 1, 2),
('39-1227728', 'GO119787T', 2, 4),
('39-4788866', 'PG674068R', 4, 6),
('40-0786243', 'LH106861M', 2, 1),
('40-1037983', 'BK920804K', 1, 3),
('40-1136806', 'QR454157Y', 1, 4),
('40-2208062', 'ZS026946U', 4, 1),
('40-5288701', 'DT545040M', 4, 1),
('40-6943405', 'VZ886203M', 1, 6),
('41-1429269', 'RP562470Q', 1, 3),
('41-3216938', 'ZI901356N', 4, 1),
('41-3268639', 'UO254689S', 1, 8),
('41-3659990', 'QF137469L', 4, 3),
('41-3975053', 'PU346240T', 2, 3),
('41-6555988', 'DP016938U', 2, 3),
('41-9319442', 'JI602428K', 4, 3),
('41-9645109', 'LS403208X', 1, 1),
('42-0131259', 'NM508435W', 1, 5),
('42-0717807', 'MU698813C', 4, 1),
('42-1134854', 'GQ875183D', 1, 8),
('42-2072103', 'IE180913G', 4, 5),
('42-5263028', 'KC800413C', 4, 6),
('42-7011523', 'XH499685D', 4, 8),
('42-7240015', 'HG523274C', 4, 4),
('42-8848918', 'VV722651O', 4, 3),
('43-2037577', 'NJ080641O', 1, 8),
('43-6568300', 'HX200738R', 4, 3),
('43-7385696', 'TK845900K', 1, 1),
('43-8492699', 'ZT656754O', 1, 3),
('44-1072008', 'ZI651705L', 1, 1),
('44-4915402', 'YG637206I', 1, 3),
('44-7083318', 'KU592945Q', 4, 2),
('45-1060690', 'VR974451G', 2, 1),
('45-1168337', 'EB401601E', 4, 3),
('45-2811300', 'VE944995L', 1, 3),
('45-3804689', 'AC869050U', 1, 1),
('45-3951342', 'IO334297G', 2, 6),
('45-5773014', 'ND673205L', 1, 8),
('45-6995640', 'FI299116A', 1, 3),
('45-7500187', 'ZF490474B', 1, 4),
('46-0059406', 'YS652384Q', 4, 3),
('46-2600043', 'TT394813Q', 4, 3),
('46-4344763', 'SQ353921L', 1, 4),
('47-1387266', 'CE665632S', 4, 4),
('47-3147567', 'YZ717919V', 3, 6),
('47-5302795', 'RB204617T', 1, 7),
('48-1799687', 'LW132386N', 1, 4),
('48-5840838', 'YL966209U', 2, 5),
('48-9328765', 'TQ009471B', 4, 3),
('49-1036239', 'SO040048U', 1, 3),
('49-1159362', 'XD817271X', 1, 3),
('49-1457327', 'HP128399X', 1, 2),
('49-2217652', 'HT175666X', 4, 3),
('49-5299749', 'AH996640U', 1, 4),
('49-6102253', 'DL892664I', 1, 2),
('49-9705882', 'FM907610K', 1, 2),
('50-0945563', 'UJ306006A', 1, 1),
('50-5810953', 'FE255201P', 1, 6),
('50-6111855', 'NG987509R', 4, 2),
('50-7117246', 'PK662258W', 4, 3),
('50-9092071', 'QZ236393M', 4, 5),
('51-0122715', 'KK311112P', 4, 8),
('51-6967096', 'ED732328N', 1, 3),
('51-7315582', 'DN632963A', 1, 2),
('51-7472749', 'SI278865G', 1, 3),
('51-9601829', 'ER279775R', 1, 7),
('52-0404205', 'DD271029J', 4, 7),
('52-1336694', 'NZ535691O', 1, 6),
('52-4567561', 'LC856388D', 4, 3),
('52-4726377', 'RY740755S', 2, 3),
('52-5735024', 'WN058972W', 4, 4),
('52-6674444', 'KU840832K', 1, 6),
('53-0431396', 'WD175217C', 1, 6),
('53-5630368', 'EE740794T', 1, 3),
('53-6948800', 'CD290362A', 4, 3),
('53-7191465', 'VK993165I', 1, 6),
('53-9062912', 'ZH337987I', 1, 3),
('54-1117411', 'SH512546I', 1, 5),
('54-5318903', 'SW345892X', 2, 7),
('54-6428980', 'HM636135W', 4, 3),
('54-7676865', 'II522336E', 1, 1),
('54-7904459', 'SL566148H', 4, 7),
('54-8296596', 'TM808573F', 4, 7),
('54-9522118', 'VM874796Y', 3, 3),
('55-0320348', 'DR180938W', 1, 3),
('55-3623151', 'it152291r', 1, 3),
('55-3650046', 'XH198735C', 1, 3),
('55-4384947', 'MZ193764K', 4, 6),
('55-5908272', 'LY831340G', 4, 3),
('55-6072477', 'MG195096H', 4, 2),
('55-9616651', 'TN328405L', 4, 3),
('55-9770243', 'PU508250S', 4, 8),
('56-0484045', 'NP848289H', 1, 8),
('56-3682739', 'TG734644M', 2, 7),
('56-4309508', 'OF985665X', 4, 5),
('56-7734821', 'NH139989U', 4, 8),
('57-1609142', 'MD982609A', 4, 5),
('57-2548391', 'NS537861H', 4, 4),
('57-4162757', 'RO435900H', 4, 5),
('57-7596762', 'OK001999U', 1, 5),
('58-0128736', 'WJ636565X', 1, 3),
('58-0824770', 'HX158296G', 1, 6),
('58-2471319', 'VZ575305Z', 4, 5),
('58-5912504', 'GE941219F', 4, 4),
('58-8249246', 'RB919501K', 1, 2),
('58-8390431', 'IB637202U', 1, 1),
('59-0150604', 'VV093891D', 2, 1),
('59-0997098', 'CM005454H', 4, 3),
('59-1166943', 'XP081647H', 4, 7),
('59-2576093', 'JX648488C', 4, 7),
('59-4661298', 'VU851838J', 2, 1),
('59-4684006', 'DF003975R', 4, 7),
('59-5937939', 'ZP730277W', 1, 1),
('59-6274425', 'AE100121F', 4, 5),
('59-8314806', 'GX924268X', 4, 3),
('59-8381667', 'DK443174L', 2, 1),
('60-0655971', 'AP253442H', 2, 3),
('60-1691051', 'QV299811C', 4, 4),
('60-2276889', 'UU534964W', 4, 3),
('60-3158201', 'LO612272U', 1, 6),
('60-6270362', 'QF112815J', 4, 3),
('60-6428015', 'RN693599V', 1, 4),
('60-7601093', 'RF462586D', 2, 7),
('60-9203590', 'EE740085I', 4, 1),
('61-7469906', 'NS990887T', 2, 7),
('61-9391449', 'MT812263O', 1, 5),
('62-1957072', 'ND981367Q', 2, 4),
('62-2186332', 'VW612487D', 1, 5),
('62-4020686', 'IE609169K', 4, 3),
('62-4959178', 'OH486872E', 4, 6),
('62-6726896', 'KT951067X', 2, 4),
('62-6894804', 'CQ847516D', 4, 3),
('62-7019089', 'YZ407625P', 1, 7),
('62-7120162', 'NA997468X', 1, 6),
('63-0638100', 'AU549358U', 4, 7),
('63-1545651', 'ZC732912G', 4, 3),
('63-1925261', 'VY468006G', 1, 3),
('63-2539882', 'PG514115J', 4, 4),
('63-5722038', 'HX643872O', 4, 6),
('63-6111701', 'IA005234G', 1, 3),
('63-8802366', 'FU609000B', 1, 3),
('63-9116461', 'QJ799086Z', 2, 3),
('63-9446221', 'GI458830F', 4, 1),
('64-0621633', 'AU449889P', 4, 7),
('64-0636526', 'HB766263L', 4, 3),
('64-6729020', 'YH646941O', 4, 8),
('64-6879023', 'YZ865649D', 4, 3),
('65-1738561', 'TJ978150H', 3, 8),
('65-7661186', 'JB039257N', 4, 2),
('66-0739491', 'NZ662678P', 3, 3),
('66-1883695', 'QL642076F', 1, 7),
('66-2361006', 'OG602265E', 2, 7),
('66-2522703', 'GY674145H', 2, 2),
('66-2765926', 'SH419152D', 1, 6),
('66-5805863', 'NA778983R', 1, 6),
('66-7576883', 'JD412382Q', 1, 4),
('67-4076527', 'KH895707V', 4, 5),
('67-5029558', 'VE628368Y', 2, 6),
('67-5304822', 'IG939447U', 1, 6),
('67-6284946', 'WS189951J', 1, 1),
('67-6903314', 'UL176502B', 4, 3),
('67-7636850', 'VL606950T', 1, 3),
('68-3132421', 'PR574429Q', 1, 3),
('68-3172017', 'YH345037B', 4, 5),
('68-4171892', 'TO907441W', 4, 5),
('68-5871521', 'VG613456A', 1, 4),
('68-6940299', 'MW253204T', 1, 6),
('68-7037451', 'CT629800A', 4, 4),
('68-7096348', 'GD794016Y', 4, 5),
('68-7504033', 'KN988197T', 1, 5),
('68-8976238', 'UB855681N', 2, 8),
('69-0393201', 'EP586696M', 4, 8),
('69-0536291', 'DZ195791X', 4, 1),
('69-0803348', 'MK604551H', 1, 3),
('69-3965258', 'GK840892X', 4, 5),
('69-5458568', 'OB669602J', 1, 8),
('69-5925327', 'AP767547I', 4, 3),
('69-6968657', 'LW629488E', 4, 2),
('70-2965789', 'SV922230Q', 1, 3),
('70-4763276', 'UU528507S', 1, 5),
('71-3652304', 'WC844307P', 1, 3),
('71-4783541', 'FM459704K', 4, 6),
('71-7837650', 'YX527895G', 1, 8),
('72-0413596', 'MO726896P', 2, 5),
('72-2448628', 'TV211484W', 4, 1),
('72-3040567', 'NO949821C', 4, 4),
('72-3549258', 'ZE015887N', 4, 3),
('72-5913162', 'DU615694I', 4, 3),
('72-6079643', 'QV402258L', 1, 3),
('72-7823438', 'UV348158A', 1, 3),
('72-9006336', 'QF846140G', 2, 6),
('72-9328783', 'TX491950I', 4, 3),
('73-2251057', 'CB298473A', 3, 3),
('73-6200004', 'KW585002H', 1, 3),
('73-7147493', 'DF426741G', 1, 4),
('74-0303597', 'TX085395S', 3, 3),
('74-9747670', 'AQ304702R', 1, 7),
('75-0124112', 'MA973579K', 4, 3),
('75-0131682', 'BJ869010D', 4, 2),
('75-0328049', 'SG232892L', 4, 5),
('75-0958781', 'OF014519K', 1, 7),
('75-1340477', 'NU487701K', 1, 5),
('75-6520267', 'LP500272N', 1, 5),
('75-6891165', 'LQ983512U', 1, 7),
('75-8250680', 'US717372T', 4, 3),
('75-9134355', 'EW007431M', 1, 3),
('76-0000021', 'XX491915V', 2, 1),
('76-0099650', 'WW210857J', 1, 5),
('76-2727093', 'MG608324J', 1, 3),
('76-2985832', 'UC493497V', 3, 7),
('76-3367992', 'SJ533699H', 1, 6),
('76-4036199', 'YL605202H', 4, 3),
('76-4086283', 'FC920310O', 1, 4),
('76-4940799', 'VV690440B', 4, 6),
('76-8791360', 'UU202177X', 1, 3),
('77-1835914', 'MP067841C', 4, 7),
('77-2348932', 'RO907653Y', 2, 6),
('77-5513461', 'ZK782722R', 1, 1),
('77-5748543', 'XY286906N', 4, 2),
('77-6317806', 'HJ451937L', 2, 4),
('77-7401728', 'BN687310Q', 1, 6),
('77-8203719', 'VY489059E', 1, 5),
('78-0380118', 'MO353148N', 1, 4),
('78-1195027', 'UL369491O', 1, 2),
('78-4344207', 'SK062184B', 1, 8),
('78-6321379', 'VB943949C', 1, 2),
('78-8816060', 'LH695834Z', 1, 3),
('78-9623211', 'UV389552L', 4, 6),
('79-0464882', 'DT884304C', 1, 1),
('79-1576734', 'NV658761A', 4, 4),
('79-4798875', 'VV771459V', 1, 3),
('79-5517945', 'RC413749A', 4, 3),
('79-9536595', 'NT307553S', 1, 3),
('80-3234805', 'RY037414U', 4, 2),
('80-6524018', 'TN459758P', 4, 1),
('80-7938995', 'LY992939E', 1, 6),
('80-7941049', 'PS295181Z', 2, 4),
('80-8617080', 'CC846598U', 1, 3),
('81-0188200', 'EB645921X', 1, 8),
('81-2733835', 'RR316532P', 2, 6),
('81-4865027', 'VK802431Y', 1, 8),
('81-5031235', 'VG667583E', 1, 5),
('81-5228790', 'VY525798F', 1, 5),
('81-7038918', 'DR489342O', 4, 2),
('81-8060778', 'SF717839D', 2, 8),
('82-1629865', 'DZ430103G', 1, 1),
('82-2609006', 'GX740846K', 2, 3),
('82-2981878', 'EJ657352G', 1, 4),
('82-6558984', 'KD209714D', 3, 4),
('82-9457047', 'LF092320A', 1, 3),
('83-1009344', 'NF421951O', 4, 5),
('83-1217063', 'ZB232750V', 1, 7),
('83-3514873', 'LV730967L', 4, 2),
('83-4865660', 'AK984038N', 3, 8),
('83-5537250', 'LA176569W', 4, 5),
('83-6435523', 'WA954782V', 4, 3),
('83-7810679', 'XQ363276D', 4, 3),
('84-0386773', 'RS150649P', 1, 3),
('84-3457422', 'XE947994R', 1, 6),
('84-3853067', 'XA610379G', 2, 4),
('84-5153657', 'VG979335T', 1, 3),
('84-8762859', 'NK424390J', 1, 2),
('84-9275069', 'XD785936E', 1, 3),
('85-0601601', 'XC467370V', 2, 6),
('85-3334513', 'OP270447A', 1, 5),
('85-4557957', 'JU063558Q', 4, 3),
('85-5431069', 'XB125807V', 2, 3),
('85-7355238', 'UX496294H', 4, 5),
('85-7718619', 'OF102924M', 2, 5),
('86-1870935', 'DS178316S', 1, 7),
('86-2503827', 'CZ046288U', 1, 6),
('86-5274202', 'CW848240K', 4, 3),
('87-1470903', 'VU807135V', 4, 6),
('87-1949652', 'WU157014Q', 1, 2),
('87-3376412', 'JN422060L', 1, 2),
('87-4453963', 'ER088315J', 1, 3),
('87-6633787', 'SM423704X', 3, 3),
('87-7188668', 'KT389837B', 2, 3),
('87-8002965', 'RP358778T', 3, 8),
('87-8745898', 'YZ604658J', 4, 4),
('87-8762204', 'LB704495E', 4, 4),
('88-4435308', 'JI880896F', 4, 7),
('89-0022888', 'NR398078M', 4, 7),
('89-1889473', 'AP444024O', 4, 5),
('89-4176534', 'UI092814R', 1, 8),
('89-4884561', 'US493269A', 2, 3),
('89-5714177', 'VY437276R', 4, 1),
('89-6058656', 'BU861195Y', 1, 3),
('90-0686303', 'SK016695U', 4, 1),
('90-1403954', 'QL321121L', 4, 3),
('90-3945672', 'JT347163F', 1, 5),
('90-5035577', 'SN878406K', 2, 1),
('90-6409982', 'MS059474N', 1, 7),
('90-9258513', 'IS015669M', 4, 8),
('92-9480837', 'WH734079V', 1, 7),
('92-9623071', 'BN415170D', 1, 3),
('92-9715314', 'BT371843I', 1, 1),
('93-0686984', 'JC445141X', 1, 6),
('93-5661312', 'HM085014V', 3, 3),
('93-5928498', 'IK578743B', 4, 2),
('93-8667645', 'GJ588599M', 2, 5),
('94-4705277', 'XH603239M', 1, 3),
('94-6907133', 'MW080326P', 1, 8),
('95-1174328', 'UB404168R', 1, 8),
('95-1790755', 'LW151180L', 1, 4),
('95-3517999', 'HP673805W', 4, 5),
('95-7092127', 'DO305555K', 4, 7),
('96-0987852', 'RC734008G', 4, 4),
('96-1648398', 'VA219127U', 1, 1),
('97-0147786', 'WX774255I', 2, 3),
('97-0913105', 'OB677832O', 2, 7),
('97-3138911', 'AO592540G', 1, 4),
('97-3703178', 'GM065123W', 2, 4),
('97-4110845', 'KC825703Y', 2, 8),
('97-5558458', 'QU905290S', 4, 4),
('97-5683996', 'VS049545N', 1, 3),
('97-6528129', 'AI316031Z', 1, 2),
('97-9018441', 'PO115732F', 1, 1),
('98-1678319', 'WH660279O', 1, 3),
('98-3556505', 'WK661827Y', 1, 8),
('98-4762907', 'KD444344U', 1, 3),
('98-9650752', 'HM391563J', 4, 8),
('99-0222188', 'GB123108S', 4, 3),
('99-1372878', 'ZY295345W', 2, 5),
('99-4615801', 'KV498760U', 1, 5),
('99-4988360', 'EV422969A', 4, 2),
('99-6209168', 'TM559297A', 2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `Employee_Details`
--

CREATE TABLE `Employee_Details` (
  `NIN` varchar(9) NOT NULL,
  `First_Name` varchar(20) NOT NULL,
  `Last_Name` varchar(20) NOT NULL,
  `Street_Address` varchar(50) NOT NULL,
  `City` varchar(20) NOT NULL,
  `Postcode` varchar(7) NOT NULL,
  `Salary` float NOT NULL,
  `DOB` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Employee_Details`
--

INSERT INTO `Employee_Details` (`NIN`, `First_Name`, `Last_Name`, `Street_Address`, `City`, `Postcode`, `Salary`, `DOB`) VALUES
('AC869050U', 'Pauly', 'McDell', '4 Fordem Trail', 'Edinburgh', 'NH24136', 66117.5, '2001-09-18'),
('AD905076O', 'Daryl', 'Chartman', '2413 Ramsey Avenue', 'Exeter', 'MS75491', 58749.2, '1996-08-06'),
('AE100121F', 'Talbert', 'Abbotts', '29565 Jenifer Court', 'Oxford', 'NJ63521', 92884.1, '1996-08-13'),
('AH996640U', 'Vonny', 'Meeny', '06702 Lawn Plaza', 'Canterbury', 'MP38228', 83205.6, '1982-01-24'),
('AI316031Z', 'Darn', 'O\'Lunny', '228 Porter Street', 'Wolverhampton', 'AK16483', 23811.8, '1962-06-23'),
('AK984038N', 'Jase', 'Fulk', '80 Pennsylvania Center', 'Wells', 'AZ53324', 90530, '1984-03-29'),
('AL340446B', 'Brynna', 'Dyble', '0 Bonner Pass', 'Sheffield', 'KS70869', 23496.3, '1979-05-05'),
('AN167975T', 'Hettie', 'Broadbent', '5 Rowland Road', 'Glasgow', 'DC79671', 74439.6, '1950-05-29'),
('AO592540G', 'Alvina', 'Paterno', '09 Golf Drive', 'Dunfermline', 'KY10922', 23002.8, '1986-06-21'),
('AP253442H', 'Cherie', 'Murch', '3340 Gale Way', 'Newry', 'AP07910', 12502.4, '1963-12-02'),
('AP444024O', 'Alysa', 'Marley', '0906 Duke Point', 'Manchester', 'AE19168', 79091.5, '1988-05-14'),
('AP767547I', 'Sydelle', 'Pelzer', '34635 Dawn Drive', 'Wakefield', 'HI98497', 15069.4, '1973-11-12'),
('AQ304702R', 'Hymie', 'Dows', '12 Dwight Terrace', 'Aberdeen', 'AZ35044', 62699.6, '1965-11-16'),
('AQ503711L', 'Nola', 'Wilcox', '7055 Southridge Drive', 'Durham', 'MH19457', 61500.7, '1985-01-06'),
('AU449889P', 'Sigismundo', 'FitzGibbon', '8 Gina Terrace', 'Wrexham', 'GA47011', 55410.5, '1981-06-14'),
('AU549358U', 'Edd', 'Speere', '812 High Crossing Junction', 'Wells', 'AA26007', 13662.8, '1950-01-05'),
('BI255825P', 'Aurore', 'Neilson', '9 Darwin Parkway', 'Perth', 'FL26133', 53082.8, '1981-02-17'),
('BJ869010D', 'Charlot', 'Dignall', '950 Arizona Terrace', 'Wrexham', 'MA18834', 15154, '1972-05-12'),
('BK920804K', 'Odelinda', 'Wardingly', '069 Mesta Road', 'Doncaster', 'MA99435', 90622.5, '1980-07-07'),
('BL221585Z', 'Thelma', 'Wilkie', '113 Badeau Plaza', 'Edinburgh', 'AK30236', 32280.2, '1984-10-01'),
('BL772452L', 'Cinda', 'Plesing', '57518 Chinook Park', 'Salisbury', 'AK44892', 49509.4, '1988-06-29'),
('BM829464Z', 'Tedda', 'Daggett', '12 Lindbergh Place', 'Sheffield', 'PA14084', 25694.3, '1989-05-30'),
('BN415170D', 'Wait', 'Prate', '0367 Moose Hill', 'Wrexham', 'IA58164', 95732.2, '2000-08-24'),
('BN687310Q', 'Cloris', 'Truckell', '84521 Pearson Street', 'Carlisle', 'HI82444', 72938.5, '1995-05-03'),
('BO740928H', 'Dorothee', 'Pennell', '90 Rutledge Circle', 'Lancaster', 'NY80423', 44159.4, '1977-04-27'),
('BP682069W', 'Artemis', 'Adami', '99842 Spenser Point', 'Cambridge', 'NJ06014', 58500.5, '1960-06-17'),
('BS437833J', 'Perice', 'Abramovitz', '2354 Jenifer Place', 'Colchester', 'AE63325', 55612.5, '1964-09-30'),
('BT371843I', 'Larissa', 'Holtham', '8751 Hoepker Circle', 'Sunderland', 'AL68031', 97254.4, '1969-01-15'),
('BU861195Y', 'Yorgos', 'Philippard', '8976 Dakota Terrace', 'Milton Keynes', 'WI75501', 60909.8, '1968-07-13'),
('BX776119O', 'Juliann', 'Profit', '047 Mandrake Drive', 'Peterborough', 'AP18270', 59829.9, '1963-05-11'),
('CB298473A', 'Lodovico', 'Ashborne', '7312 Shoshone Court', 'Bangor', 'WI95075', 72963.4, '1983-08-24'),
('CC841112D', 'Fabe', 'Lief', '94 Gerald Crossing', 'St Asaph', 'WY73878', 56639.6, '1980-01-02'),
('CC846598U', 'Salomi', 'Lintin', '29507 Bartillon Terrace', 'Wakefield', 'WV31004', 78695.1, '1985-04-26'),
('CD290362A', 'Dorothea', 'Trewinnard', '0 Stephen Way', 'Stoke on Trent', 'TX57066', 74486.9, '1998-02-16'),
('CE665632S', 'Bevon', 'Gaskoin', '549 Oakridge Avenue', 'Coventry', 'RI39468', 56671.6, '2000-06-06'),
('CM005454H', 'Aila', 'Paolillo', '41 Esker Terrace', 'Winchester', 'AR74577', 14148.3, '1975-03-19'),
('CQ847516D', 'Merrie', 'Stayt', '0 Manufacturers Alley', 'Stirling', 'CA58397', 39159.9, '1995-10-04'),
('CT112101I', 'Constantine', 'Gilfillan', '87 Washington Junction', 'Perth', 'VA89321', 32245.8, '1961-12-01'),
('CT629800A', 'Saree', 'Starling', '1 Artisan Drive', 'Dunfermline', 'TN37662', 34145.2, '1973-10-07'),
('CW848240K', 'Holden', 'Artharg', '61 Vera Crossing', 'St Davids', 'VA57413', 55750.5, '1971-08-11'),
('CX516631K', 'Junina', 'McAirt', '45 Ramsey Junction', 'Hereford', 'PR55339', 39500.1, '1988-07-08'),
('CZ046288U', 'Nikola', 'Henbury', '8116 Erie Junction', 'London', 'OH04029', 95300.5, '1968-03-28'),
('DC106173C', 'Danyette', 'Kendrew', '1 Karstens Point', 'Leeds', 'DE34750', 98386.6, '2000-06-23'),
('DD271029J', 'Pierce', 'Kemp', '63008 Raven Place', 'York', 'CA25978', 82902.4, '1984-06-29'),
('DF003975R', 'Angie', 'Waddams', '82 Truax Crossing', 'Dundee', 'MO88442', 62378.7, '1996-01-10'),
('DF426741G', 'Chelsea', 'Robertucci', '94833 Northview Way', 'Inverness', 'GU06769', 78083.3, '1956-12-28'),
('DI653042T', 'Joaquin', 'Eringey', '890 Brickson Park Circle', 'Bangor', 'FL38561', 76521.2, '1959-03-09'),
('DJ312271A', 'Olivia', 'MacPhee', '09 Saint Paul Point', 'Bath', 'WI07872', 85391.8, '1963-02-01'),
('DK443174L', 'Emmey', 'Dallywater', '98705 Forest Run Avenue', 'Sunderland', 'NH97056', 92664.3, '1953-04-10'),
('DL892664I', 'Annabelle', 'Fairnie', '12384 Warrior Point', 'Cardiff', 'MO87954', 60436.1, '1992-11-27'),
('DM359618L', 'Tamiko', 'Holton', '49 Cody Lane', 'Portsmouth', 'TX49014', 97318.4, '1960-10-15'),
('DN632963A', 'Kathy', 'Goodnow', '24494 Kenwood Alley', 'Winchester', 'OH33288', 94364.5, '1988-05-05'),
('DO305555K', 'Dulciana', 'Duxfield', '44249 Westridge Drive', 'Bangor', 'AE44806', 62408.1, '1964-10-18'),
('DP016938U', 'Marwin', 'Raybould', '925 Novick Lane', 'Wolverhampton', 'HI97861', 51081.3, '1983-05-31'),
('DR180938W', 'Granville', 'McKitterick', '04 Rieder Parkway', 'Salford', 'MO20206', 83664.8, '1965-02-20'),
('DR489342O', 'Fraze', 'Maletratt', '96 Rockefeller Circle', 'Dundee', 'MD35898', 30986.2, '1993-04-02'),
('DS178316S', 'Gwynne', 'Garrow', '2648 Old Gate Circle', 'Belfast', 'SD68803', 66379.5, '2000-03-21'),
('DS948250K', 'Paulita', 'Casewell', '18 Riverside Trail', 'Birmingham', 'GU34346', 73099.8, '1995-06-15'),
('DT545040M', 'Ame', 'Balser', '2282 Sutteridge Lane', 'Oxford', 'KY65380', 71557.8, '1998-01-22'),
('DT884304C', 'Lia', 'Hargreaves', '721 Graceland Alley', 'Nottingham', 'MP53966', 13755.8, '1995-08-03'),
('DU615694I', 'Rudolfo', 'Norridge', '22 Golf Court', 'Newport', 'PR72269', 37428, '1968-08-24'),
('DW387671H', 'Jemmy', 'Levens', '298 Elka Alley', 'Swansea', 'AE91251', 31521.7, '1950-09-26'),
('DW797814S', 'Harrison', 'Waller-Bridge', '73899 Sachtjen Alley', 'Bristol', 'TX99742', 39846.5, '1991-04-25'),
('DY170889S', 'Rodina', 'Ofener', '5556 Schmedeman Court', 'Carlisle', 'ND56622', 92118.3, '1973-07-13'),
('DZ195791X', 'Jaime', 'Woolhouse', '59 Jenna Park', 'Salford', 'CT30998', 34370.5, '1977-05-01'),
('DZ430103G', 'Dag', 'Choules', '53 Blue Bill Park Center', 'Cardiff', 'AK23544', 23537.8, '1998-08-16'),
('EB401601E', 'Jade', 'Yaakov', '13 Parkside Avenue', 'Preston', 'AA63366', 95249.9, '1986-02-17'),
('EB645921X', 'Nadine', 'Davidson', '0 Jana Alley', 'Derby', 'ME99333', 23660.4, '1998-05-19'),
('ED732328N', 'Bertina', 'Berard', '1 Almo Place', 'Southend-on-Sea', 'GU81949', 21320.8, '1961-10-18'),
('EE121177L', 'Dael', 'Confort', '0533 Grasskamp Park', 'Ely', 'AZ11176', 56391.8, '1999-12-30'),
('EE740085I', 'Shoshana', 'Downie', '8416 Carberry Crossing', 'Plymouth', 'MA26646', 83867, '1998-05-02'),
('EE740794T', 'Evey', 'Luckman', '898 Butternut Point', 'Gloucester', 'SD78590', 26964.7, '1992-08-10'),
('EF765749D', 'Merwin', 'Partener', '29021 Clemons Terrace', 'Nottingham', 'KY99137', 13685.1, '1988-04-16'),
('EH265089X', 'Sterling', 'Elgood', '428 8th Point', 'Wells', 'NY40011', 14163, '1999-12-05'),
('EI247057V', 'Kalvin', 'Corrado', '770 Fallview Trail', 'Truro', 'FM05641', 59688.8, '1980-11-07'),
('EI636866Y', 'Felicdad', 'Escala', '26 Holy Cross Place', 'Chichester', 'SD95019', 22260.8, '1976-11-27'),
('EJ657352G', 'Cherida', 'Gocke', '395 Comanche Center', 'Swansea', 'AK38027', 31735.7, '1951-12-06'),
('EL763944V', 'Rhea', 'Saffle', '77051 Shasta Circle', 'Canterbury', 'MA30350', 37908, '1999-06-12'),
('EN390360S', 'Feodor', 'Inge', '5 Knutson Plaza', 'Lisburn', 'WI91257', 91614.5, '1961-12-03'),
('EO273727Q', 'Elaina', 'Ramplee', '9 Merry Hill', 'Nottingham', 'NH82697', 70979.9, '1983-09-12'),
('EO514879Y', 'Georgine', 'Winspare', '2732 Cottonwood Way', 'Birmingham', 'WV52837', 50921.8, '1966-10-10'),
('EP586696M', 'Lissa', 'Egalton', '28673 Bultman Junction', 'Chichester', 'NY38632', 77974.8, '1978-07-16'),
('ER088315J', 'Sibeal', 'Fullard', '6296 Pleasure Road', 'Chelmsford', 'OH34390', 46783.8, '1978-12-16'),
('ER279775R', 'Maressa', 'Hans', '73 Coolidge Park', 'Portsmouth', 'OK08982', 21773.2, '2001-10-13'),
('EU934314Q', 'Robinetta', 'Triswell', '5 Independence Trail', 'Colchester', 'CT06366', 74033.4, '1956-09-29'),
('EV422969A', 'Carlie', 'Braganza', '806 Sachs Parkway', 'Plymouth', 'WY73757', 31442.1, '1964-05-16'),
('EW007431M', 'Ramonda', 'Overpool', '12879 Mayfield Lane', 'Armagh', 'MT66042', 28892.1, '1958-03-01'),
('FA725896G', 'Pet', 'Littrik', '19 Haas Pass', 'Edinburgh', 'NV89057', 99117.2, '1981-10-01'),
('FC920310O', 'Laird', 'Stalley', '75447 Norway Maple Park', 'Swansea', 'MI08794', 91412.4, '1953-12-05'),
('FE255201P', 'Jarad', 'Thorowgood', '01 East Hill', 'Oxford', 'TN66405', 80581.9, '2000-03-24'),
('FG558529Z', 'Farlay', 'Haughan', '99 Schurz Plaza', 'Wrexham', 'SD60496', 63905.1, '1984-08-21'),
('FH221614B', 'Bary', 'Skoof', '20630 Tony Avenue', 'Belfast', 'IN55713', 95728.7, '2001-12-02'),
('FI082187Y', 'Tiffany', 'Wessing', '422 Darwin Lane', 'Bradford', 'AL41156', 69965, '1983-03-09'),
('FI299116A', 'Sigfrid', 'Mankor', '9773 Old Shore Way', 'Newport', 'NH87492', 12758, '1997-07-13'),
('FJ377449J', 'Cheri', 'Cancellieri', '97763 Anhalt Way', 'Ely', 'AP45072', 62678.3, '1993-09-07'),
('FL067205Y', 'Minor', 'Bennion', '9756 Cottonwood Lane', 'Chester', 'MH19356', 17020.2, '1958-07-14'),
('FM459704K', 'Brandise', 'Kondrachenko', '3 Kenwood Alley', 'Peterborough', 'KS93906', 49472, '1961-02-28'),
('FM907610K', 'Quentin', 'Devine', '09 Knutson Park', 'Southampton', 'OH44303', 23326.8, '1962-02-08'),
('FP198238E', 'Heda', 'Cathersides', '7 Laurel Park', 'Belfast', 'AE63502', 32079.6, '1995-10-05'),
('FP824869E', 'Marius', 'Brosnan', '94941 Fairfield Terrace', 'Salisbury', 'AZ84365', 35816.4, '1996-07-07'),
('FT026339D', 'Joshuah', 'Faircliffe', '8 Merry Center', 'Cambridge', 'AA14426', 30666.2, '1992-09-16'),
('FU609000B', 'Cody', 'Peasey', '6 Dixon Point', 'Winchester', 'AP58158', 54393.8, '1974-01-26'),
('FV388894K', 'Pietro', 'Ochterlony', '75 Weeping Birch Junction', 'Swansea', 'AP54579', 51249.8, '1989-08-28'),
('GB123108S', 'Lonnie', 'Niessen', '754 Lien Road', 'Birmingham', 'MO38106', 95600.6, '1977-04-12'),
('GB391445Q', 'Wilmette', 'Jerrom', '6 Monica Way', 'Dundee', 'WV90316', 34082.1, '1974-10-30'),
('GB976841W', 'Mallorie', 'De', '1 Lillian Drive', 'Wolverhampton', 'AL75548', 27166.7, '1987-05-25'),
('GD794016Y', 'Darsey', 'Fryman', '996 Sauthoff Circle', 'Oxford', 'WI13576', 80568.8, '1974-11-30'),
('GD959536A', 'Adler', 'Wheeliker', '018 Lakewood Parkway', 'Bangor', 'WY24671', 97905.4, '1979-01-25'),
('GE941219F', 'Nappy', 'Ludmann', '3329 Sheridan Junction', 'Ely', 'AK16204', 51318.6, '1991-08-15'),
('GI458830F', 'Tybie', 'Exell', '1 Anderson Plaza', 'Stirling', 'WY18008', 56541.6, '1985-09-03'),
('GJ588599M', 'Marna', 'Abramski', '6 Scoville Pass', 'Portsmouth', 'PW21190', 13595.2, '1985-10-15'),
('GK840892X', 'Archie', 'Godden', '7 Marcy Road', 'Bangor', 'NE89098', 33511.9, '1979-12-08'),
('GL907590T', 'Catina', 'Josovitz', '09 Center Alley', 'Milton Keynes', 'AS15551', 78353.1, '1974-12-09'),
('GM065123W', 'Thatch', 'Kinvig', '9 Fuller Street', 'Durham', 'WA53852', 31866.5, '1983-03-16'),
('GO119787T', 'Tandy', 'Goodbourn', '719 Sloan Drive', 'Lincoln', 'FM94818', 47852.9, '1996-10-03'),
('GQ875183D', 'Norma', 'Budgeon', '5061 Northland Place', 'Sheffield', 'DE87162', 45208.7, '1986-01-19'),
('GR760688U', 'Glyn', 'Canet', '565 Glendale Park', 'Truro', 'OR73642', 54281.3, '1999-11-25'),
('GX740846K', 'Cyrus', 'Willmetts', '470 Oakridge Circle', 'Hereford', 'ID76137', 70654.7, '1986-08-02'),
('GX924268X', 'Scotty', 'Keson', '14 Kipling Point', 'Worcester', 'AP83110', 67107.3, '1967-08-12'),
('GY674145H', 'Alyss', 'Nance', '0974 Red Cloud Junction', 'Coventry', 'CT36663', 20417, '1952-09-07'),
('HB766263L', 'Antonetta', 'Beefon', '68 Blackbird Drive', 'Southend-on-Sea', 'TX87700', 39943.1, '1961-12-17'),
('HE783674O', 'Katya', 'Ilewicz', '68697 Sutteridge Road', 'Canterbury', 'MH81866', 62528.8, '1977-08-21'),
('HG523274C', 'Godfrey', 'Napoleon', '030 Fallview Court', 'Southend-on-Sea', 'OH23568', 89542.8, '1966-10-12'),
('HG982259Y', 'Sofie', 'Cavaney', '12677 Northridge Alley', 'Hereford', 'GU63092', 19096.7, '1966-10-24'),
('HJ451937L', 'Keelby', 'Pelling', '5 Jay Trail', 'Doncaster', 'AP25055', 57007.2, '1965-12-22'),
('HM085014V', 'Gordie', 'Gaynesford', '4 Fordem Circle', 'Durham', 'WA37236', 67381.6, '1986-10-24'),
('HM134578N', 'Borg', 'Szymanzyk', '41 Amoth Crossing', 'Gloucester', 'NJ78150', 77828.8, '1998-02-26'),
('HM391563J', 'Alene', 'Amiss', '07913 Jenna Trail', 'Londonderry', 'WI85941', 94129.6, '1977-08-25'),
('HM636135W', 'Janek', 'Semeradova', '12015 Dayton Trail', 'Southend-on-Sea', 'AP80784', 89572.3, '1966-08-06'),
('HN280217C', 'Alaric', 'Santarelli', '8757 Thompson Trail', 'Newry', 'KY49249', 24449.2, '1959-09-28'),
('HP128399X', 'Sinclair', 'Byfford', '201 Melody Parkway', 'Derby', 'WI62658', 50636.9, '1981-12-10'),
('HP673805W', 'Garald', 'Greenrde', '15302 Independence Drive', 'Lisburn', 'PW60112', 56092.8, '1975-09-04'),
('HT175666X', 'Georas', 'Divisek', '25 Moulton Lane', 'St Albans', 'WY46416', 87452.1, '1951-05-10'),
('HX158296G', 'Zared', 'Klulicek', '62958 Canary Junction', 'Preston', 'WA47892', 40677.9, '1966-07-22'),
('HX200738R', 'Gillan', 'Stolberger', '04255 Mayfield Way', 'Newcastle-upon-Tyne', 'WA48754', 92147.3, '1985-06-01'),
('HX643872O', 'Vikki', 'Guthrie', '6 Farragut Road', 'Inverness', 'MT07498', 95626.8, '1976-04-10'),
('HY568138E', 'Valida', 'Bootes', '06 Bluejay Way', 'Winchester', 'NE11805', 75580.4, '1968-07-23'),
('IA005234G', 'Fayre', 'Tomney', '1506 Ryan Point', 'Exeter', 'VI33192', 58829.3, '1979-07-23'),
('IB067151Y', 'Skell', 'Swainson', '31 Sundown Terrace', 'Wakefield', 'TX97927', 80604.8, '1994-05-12'),
('IB637202U', 'Brandi', 'Andreassen', '008 Service Alley', 'Kingston-upon-Hull', 'WY63480', 19209.8, '2000-07-12'),
('IE180913G', 'Oates', 'Snepp', '684 Park Meadow Junction', 'Ely', 'RI02578', 42019.2, '1967-07-29'),
('IE609169K', 'Tait', 'Bremeyer', '82 Calypso Junction', 'Southend-on-Sea', 'MT96236', 83142.5, '1950-05-29'),
('IG939447U', 'Taber', 'Nuton', '94646 Charing Cross Parkway', 'Bath', 'KY29410', 85586.6, '1966-01-29'),
('II522336E', 'Pepillo', 'Maha', '2025 Waxwing Drive', 'Lancaster', 'AA70907', 38143.5, '1953-02-26'),
('IK578743B', 'Sukey', 'Roddan', '5 Gulseth Center', 'St Albans', 'IN39970', 18304.6, '1979-04-06'),
('IN158664I', 'Guido', 'Hoopper', '51 Prairieview Alley', 'Chelmsford', 'MN93785', 78530.2, '1986-07-16'),
('IO334297G', 'Chris', 'Skittrell', '174 Namekagon Court', 'Stoke on Trent', 'MO01958', 80039.4, '1986-08-23'),
('IR187391U', 'Jaquenetta', 'Rankin', '3249 Dahle Plaza', 'St Albans', 'VT39193', 42698.6, '1988-12-28'),
('IS015669M', 'Yank', 'Mullan', '94728 5th Center', 'Durham', 'TN72619', 82932.3, '1986-01-25'),
('it152291r', 'Malissia', 'Osgardby', '29416 Grover Alley', 'Manchester', 'M14 4PL', 17424, '1989-12-26'),
('IU795663W', 'Joceline', 'Oats', '8 East Pass', 'Truro', 'MO60600', 19329.6, '1963-08-11'),
('JB039257N', 'Lombard', 'Debling', '36 Mayer Drive', 'Lisburn', 'NJ49919', 53121.9, '1989-01-13'),
('JC445141X', 'Dirk', 'Perrott', '679 Summer Ridge Road', 'Wakefield', 'HI17490', 82551.6, '1995-10-17'),
('JD412382Q', 'Dur', 'Janodet', '91175 Northland Hill', 'Brighton & Hove', 'FL51138', 54589.4, '1950-04-17'),
('JI602428K', 'Luisa', 'Burtonwood', '554 Marcy Crossing', 'Exeter', 'MN73402', 48099.8, '1975-12-02'),
('JI880896F', 'Cedric', 'Chazotte', '77 Ilene Parkway', 'Derby', 'AE65144', 84592, '1965-07-07'),
('JK018371C', 'Giorgia', 'McCrohon', '80323 Myrtle Court', 'Newcastle-upon-Tyne', 'GA33794', 91699.7, '1984-02-09'),
('JK980246H', 'Efren', 'Sealove', '7623 Lien Center', 'Londonderry', 'WA93580', 59217.9, '1967-03-30'),
('JM300330R', 'Hayes', 'Butting', '120 Lotheville Pass', 'Coventry', 'CO91505', 50125.7, '1958-09-26'),
('JN422060L', 'Michaela', 'Shrieve', '78 Raven Road', 'Preston', 'IL53249', 70070.3, '1958-10-13'),
('JR596419T', 'Sayre', 'Simnel', '761 Kennedy Lane', 'Oxford', 'NV53086', 72894, '1952-05-19'),
('JT347163F', 'Lianna', 'Seden', '655 Superior Alley', 'Leicester', 'ID77803', 37009.1, '1964-07-19'),
('JU063558Q', 'Barr', 'Eefting', '234 Susan Lane', 'Lincoln', 'KS01526', 44265.6, '1976-11-12'),
('JU954932E', 'Reginauld', 'Oak', '8 Pleasure Drive', 'Belfast', 'LA23580', 80693.8, '1955-03-25'),
('JX648488C', 'Katerina', 'Barnfield', '34404 Bellgrove Avenue', 'Westminster', 'MH57464', 61807.5, '2000-10-26'),
('JZ826946H', 'Dominique', 'Causon', '2 Mallard Way', 'Wells', 'MA26613', 61194.1, '1978-11-16'),
('KC363601G', 'Alfie', 'Glasebrook', '5942 Del Mar Court', 'Ripon', 'ME24357', 24207.5, '1987-08-25'),
('KC608204K', 'Yank', 'Vasilyonok', '5 Debs Alley', 'Derby', 'RI95137', 38871.3, '1999-02-23'),
('KC800413C', 'Corny', 'Leynham', '8 Hansons Drive', 'Lisburn', 'AE39106', 82698.6, '1972-03-03'),
('KC825703Y', 'Judah', 'Groomebridge', '1714 Clyde Gallagher Point', 'Aberdeen', 'RI08020', 52171.6, '1959-10-25'),
('KD209714D', 'Hebert', 'Zaniolini', '8 Buell Place', 'Sunderland', 'KS59859', 50633.7, '1991-09-05'),
('KD444344U', 'Nari', 'Crawshaw', '40 Debra Center', 'Dunfermline', 'OR25683', 91733.9, '1992-03-21'),
('KF326923S', 'Mala', 'Eyree', '6 Dorton Circle', 'Gloucester', 'NJ87285', 24532.9, '1993-07-14'),
('KH895707V', 'Clarissa', 'Houson', '1 Granby Pass', 'Norwich', 'NH73904', 35964.4, '1975-05-12'),
('KK311112P', 'Ardyce', 'Calcraft', '953 Green Trail', 'Chester', 'MN65811', 63482, '1982-08-31'),
('KK792060S', 'Agnes', 'Dendon', '158 Twin Pines Crossing', 'Westminster', 'DC51248', 17734.2, '1986-02-17'),
('KM813203W', 'Corette', 'Mourbey', '246 Wayridge Hill', 'Liverpool', 'VI41293', 76423.3, '1983-06-04'),
('KN988197T', 'Brandi', 'Clayson', '7 Myrtle Circle', 'Swansea', 'MS67270', 37302, '1963-11-22'),
('KP709951V', 'Mildrid', 'Ethington', '4 Buhler Pass', 'Newry', 'OR25778', 18703, '1950-01-06'),
('KT389837B', 'Salli', 'Oulner', '26 Pepper Wood Parkway', 'Inverness', 'NE21066', 90004.6, '1957-10-24'),
('KT951067X', 'Marje', 'Cranage', '15 Crescent Oaks Junction', 'Nottingham', 'PW90908', 82421.9, '1981-02-23'),
('KU592945Q', 'Dari', 'Siene', '57 Randy Point', 'Swansea', 'MD01493', 85262.1, '1971-01-29'),
('KU802868L', 'Homer', 'Bresman', '84058 Hayes Parkway', 'Chester', 'MS01880', 66224.5, '1970-03-21'),
('KU840832K', 'Codie', 'Stambridge', '38 Schurz Pass', 'Leicester', 'SC85511', 29289, '1953-02-11'),
('KU940218F', 'Bev', 'Yakunikov', '50563 Waubesa Point', 'Portsmouth', 'AL61905', 69660.7, '1973-02-07'),
('KV498760U', 'Meggi', 'Abbado', '3078 Hoffman Junction', 'Brighton & Hove', 'GA20155', 50699.7, '1966-02-17'),
('KW585002H', 'Marie', 'Gummoe', '4 Debra Terrace', 'Norwich', 'FL61548', 45954.8, '1954-07-31'),
('KW816523W', 'Frannie', 'Pedron', '85 Meadow Valley Avenue', 'Brighton & Hove', 'SC84421', 20034.3, '1979-10-10'),
('KZ832424W', 'Feodora', 'Benning', '620 Sachtjen Center', 'Milton Keynes', 'AP93932', 89549.8, '1994-02-18'),
('KZ848071O', 'Rahel', 'Gallo', '798 Karstens Parkway', 'Aberdeen', 'PR58476', 60391.4, '1997-05-15'),
('LA176569W', 'Arly', 'Bartolommeo', '759 Esch Way', 'Canterbury', 'LA12446', 67921.9, '1960-02-12'),
('LB704495E', 'Patric', 'Izsak', '02 Comanche Place', 'Stirling', 'ND11230', 65976.3, '1959-09-10'),
('LB767754C', 'Carey', 'Netley', '279 Helena Place', 'York', 'AR27954', 67072.1, '1963-10-22'),
('LC856388D', 'Braden', 'Wigin', '9641 Loftsgordon Park', 'Derby', 'NM00931', 85762, '1983-10-31'),
('LF092320A', 'Merralee', 'Vannuchi', '7 Vera Place', 'Perth', 'IA53260', 56425.5, '1986-01-20'),
('LH106861M', 'Oswell', 'Beddingham', '12989 Village Green Street', 'Glasgow', 'VA23146', 97980.9, '1953-04-24'),
('LH695834Z', 'Marilyn', 'Glassborow', '6 Waubesa Crossing', 'Ripon', 'SC21096', 90675.1, '1978-11-19'),
('LM182202B', 'Dode', 'Hurtado', '12322 Cottonwood Point', 'Exeter', 'OR70953', 40814.6, '2002-02-06'),
('LO612272U', 'Carlee', 'Shearmur', '2 Vermont Terrace', 'Truro', 'IL26312', 78619.5, '1966-06-28'),
('LP500272N', 'Truda', 'Edleston', '37994 Green Ridge Drive', 'Bristol', 'RI63790', 23646.9, '1966-03-07'),
('LQ983512U', 'Robinett', 'Iacopini', '2224 Kensington Street', 'Newport', 'PW63676', 62045.7, '1961-08-27'),
('LR289379R', 'Reg', 'Lanphier', '049 Cambridge Road', 'Bangor', 'MH73537', 93925.1, '1979-12-09'),
('LS403208X', 'Merrel', 'Miklem', '00 Marcy Trail', 'Portsmouth', 'NH70729', 39131.1, '2000-07-27'),
('LV730967L', 'Roscoe', 'Honeyghan', '89 Golden Leaf Drive', 'Leeds', 'NH56330', 93281.9, '1977-11-11'),
('LW132386N', 'Charissa', 'Peattie', '6497 Haas Park', 'Wakefield', 'PW61362', 32502.4, '1952-06-23'),
('LW151180L', 'Staford', 'Klarzynski', '02676 Mesta Junction', 'Newport', 'SC41082', 62596.9, '1951-03-09'),
('LW629488E', 'Diannne', 'Scala', '96290 Bunker Hill Hill', 'Southampton', 'MO38626', 86102.6, '1955-07-09'),
('LW782748U', 'Celinda', 'Joberne', '5 Jana Way', 'Edinburgh', 'NM82654', 61612.7, '1993-12-03'),
('LX057194P', 'Goddard', 'Bagot', '362 Coleman Way', 'Preston', 'KS32472', 90644, '1980-05-24'),
('LY831340G', 'Petronille', 'Squelch', '67 Golden Leaf Park', 'Lancaster', 'MD30418', 65853.5, '1987-01-30'),
('LY992939E', 'Armstrong', 'Ivachyov', '41681 Welch Court', 'Chelmsford', 'AP98236', 36204.5, '1973-12-10'),
('MA973579K', 'Jennica', 'Welbeck', '78916 Green Ridge Trail', 'Wolverhampton', 'FL43092', 57947, '1952-04-18'),
('MD982609A', 'Jilly', 'Skirvane', '4227 Darwin Circle', 'Southampton', 'AE98724', 91296.5, '1961-04-27'),
('MG195096H', 'Waring', 'Durkin', '9597 Towne Center', 'Lincoln', 'WA39966', 82141, '1984-03-07'),
('MG608324J', 'Nesta', 'Dottrell', '6 Ridgeway Court', 'Newcastle-upon-Tyne', 'NV31631', 71905.3, '1981-04-26'),
('MH954487U', 'Puff', 'Speeding', '22016 New Castle Hill', 'Hereford', 'MO23220', 78841.8, '1951-11-12'),
('MK604551H', 'Editha', 'Anney', '271 Browning Plaza', 'Londonderry', 'MI12385', 67023.8, '2001-08-23'),
('MO353148N', 'Dewitt', 'Gabby', '8 Montana Park', 'Leicester', 'ME41980', 93187.3, '1961-06-07'),
('MO726896P', 'Philly', 'Halliberton', '33 Sheridan Road', 'Coventry', 'IN55145', 15689.3, '1994-08-23'),
('MP067841C', 'Annabelle', 'Caddies', '66 Loomis Alley', 'Nottingham', 'IN78588', 94451, '1964-03-26'),
('MS059474N', 'Irv', 'Tomsen', '0 Harper Way', 'Liverpool', 'GA08139', 66853, '1995-08-05'),
('MT812263O', 'Lester', 'Carmo', '6 Buell Trail', 'Norwich', 'TX76457', 37061.3, '1997-02-02'),
('MU698813C', 'Robin', 'Bartkowiak', '5559 Shelley Circle', 'Wakefield', 'MS42165', 89053.2, '1988-07-14'),
('MU901992I', 'Cordula', 'Redsull', '3 Sullivan Lane', 'Hereford', 'LA59381', 70412.3, '1953-05-14'),
('MW080326P', 'Alica', 'Barthel', '80231 Twin Pines Center', 'Leicester', 'IL87439', 82703, '1987-09-02'),
('MW253204T', 'Tobi', 'Bute', '46 Jenifer Plaza', 'Preston', 'OK16767', 97878.3, '1986-01-31'),
('MX935884P', 'Delphinia', 'Skelhorn', '115 Cody Point', 'Lichfield', 'AA45026', 91026.2, '1969-08-29'),
('MZ193764K', 'Eudora', 'Marten', '6 Corry Road', 'Cardiff', 'KS92830', 80059.9, '1981-08-19'),
('NA778983R', 'Vincents', 'De', '3 Claremont Parkway', 'Ripon', 'OH03098', 81193.2, '1983-03-20'),
('NA997468X', 'Fanni', 'Melrose', '33 Sutteridge Parkway', 'Bristol', 'MI23719', 97520.7, '1962-06-10'),
('ND673205L', 'Patric', 'Etienne', '87269 Huxley Place', 'Colchester', 'AE77106', 22053.5, '1954-12-24'),
('ND981367Q', 'Elliot', 'Allitt', '8 Redwing Court', 'Nottingham', 'MD13669', 41808.8, '1978-03-17'),
('NF421951O', 'Eba', 'Fiander', '0094 Fallview Terrace', 'Manchester', 'PR97937', 61818.4, '1993-10-17'),
('NG987509R', 'Shepard', 'Johansson', '22 Hudson Trail', 'Newcastle-upon-Tyne', 'PW92058', 86414.2, '1986-07-24'),
('NH139989U', 'Micki', 'Wyness', '26 Novick Plaza', 'Leicester', 'UT41990', 38060.4, '1974-12-06'),
('NJ080641O', 'Leisha', 'Mieville', '027 Clarendon Center', 'Canterbury', 'DC85383', 68826.3, '1950-11-23'),
('NK424390J', 'Hewett', 'Collcutt', '453 Emmet Center', 'Portsmouth', 'MT20828', 21438.3, '1953-07-05'),
('NM508435W', 'Kelsi', 'Cunney', '5 Toban Terrace', 'Leeds', 'CO76064', 92101.7, '1955-07-02'),
('NN735991O', 'Lucinda', 'McGhee', '625 Mitchell Point', 'Norwich', 'TN04186', 53031.5, '1981-03-26'),
('NO949821C', 'Tanney', 'Marques', '9382 Prairie Rose Alley', 'Milton Keynes', 'AR32876', 70585.8, '1966-02-19'),
('NO969473Z', 'Wileen', 'Elwell', '82 Tennyson Alley', 'Swansea', 'AP65938', 78678.5, '1991-09-21'),
('NP061992L', 'Karole', 'Roderighi', '6281 Hovde Road', 'Milton Keynes', 'CA35273', 83507.6, '1988-12-22'),
('NP848289H', 'Lyn', 'Topp', '20 Sloan Circle', 'Cambridge', 'ME33832', 36487.5, '1979-06-06'),
('NR398078M', 'Nelli', 'Esche', '78814 Summer Ridge Court', 'Truro', 'MA14416', 15353.8, '1994-01-04'),
('NS537861H', 'Wynne', 'Flowitt', '8 Harbort Road', 'Lancaster', 'AR93104', 45230.7, '1961-11-09'),
('NS990887T', 'Demetre', 'Headrick', '98692 Forster Hill', 'Cardiff', 'MN06002', 88965.3, '1963-10-11'),
('NT307553S', 'Noni', 'Abbatucci', '1 Monterey Center', 'Chester', 'AE04696', 14602.6, '1989-03-18'),
('NU487701K', 'Ferd', 'Uccello', '90243 Karstens Pass', 'Gloucester', 'WY60323', 72024.8, '1997-01-09'),
('NV658761A', 'Malchy', 'Kempshall', '5 Melby Plaza', 'Newcastle-upon-Tyne', 'SD40067', 48789, '1950-04-08'),
('NY144248G', 'Alix', 'Ambrogelli', '60 North Place', 'Glasgow', 'CT42697', 62229.8, '1960-10-22'),
('NZ535691O', 'Renaldo', 'Fussey', '7 Northland Street', 'Cardiff', 'AZ29644', 46099.9, '1955-04-11'),
('NZ662678P', 'Latashia', 'McGaugan', '1386 Artisan Parkway', 'Stoke on Trent', 'IN15824', 58941.5, '1992-07-08'),
('OB669602J', 'Elvina', 'Matuszynski', '6 Grover Road', 'Liverpool', 'AS26432', 76167.8, '1956-05-27'),
('OB677832O', 'Kelly', 'Farragher', '6 Meadow Vale Trail', 'Edinburgh', 'IL62255', 52644.4, '1980-10-20'),
('OF014519K', 'Velvet', 'Carbine', '682 Kensington Drive', 'Bradford', 'PW07152', 31440.8, '1987-04-12'),
('OF102924M', 'Rhody', 'Yaxley', '90344 Merrick Crossing', 'Bangor', 'MA08706', 98055.4, '1983-01-24'),
('OF985665X', 'Tessy', 'Cartan', '75834 Burning Wood Parkway', 'Kingston-upon-Hull', 'LA35415', 85017.7, '1985-02-04'),
('OG602265E', 'Hillard', 'Milan', '9010 Straubel Park', 'Chichester', 'AK16176', 81724.4, '1967-04-06'),
('OH486872E', 'Josie', 'Henricsson', '8035 Brown Lane', 'Truro', 'WY23564', 64586.9, '2001-03-06'),
('OJ166622V', 'Doralyn', 'Freemantle', '33 Gateway Crossing', 'Wrexham', 'AA93761', 36023.6, '1994-05-11'),
('OK001999U', 'Joelie', 'Bacchus', '0374 Pawling Hill', 'St Albans', 'MN46148', 14722.3, '1978-10-09'),
('OP270447A', 'Benita', 'Taffarello', '89784 Hollow Ridge Avenue', 'Inverness', 'RI48955', 58884.2, '1991-11-24'),
('OP535073Z', 'Wolfgang', 'Frake', '97152 Waubesa Center', 'Norwich', 'WA40191', 21505.7, '1982-01-28'),
('OS724826W', 'Salim', 'Cator', '74 Lyons Place', 'Wakefield', 'SC22769', 40060, '1988-05-30'),
('OX915931W', 'Koren', 'McCluskey', '6677 Evergreen Plaza', 'Southampton', 'RI42481', 73800.9, '1955-08-11'),
('PC545418R', 'Gerladina', 'MacGinney', '270 Melody Park', 'Chelmsford', 'IN62507', 26606.6, '1992-12-29'),
('PG514115J', 'Darelle', 'Peverell', '52683 Aberg Parkway', 'Lisburn', 'NJ58817', 80717.2, '1978-08-08'),
('PG674068R', 'Phillida', 'Musicka', '111 Twin Pines Center', 'Lichfield', 'VA18924', 84543.4, '1973-10-22'),
('PK662258W', 'Everett', 'Hoggetts', '4809 Gale Trail', 'Peterborough', 'WA04667', 99084.2, '1999-11-15'),
('PK696816M', 'Lexine', 'Joney', '73817 Muir Court', 'Durham', 'DC05616', 19232.4, '1974-04-07'),
('PO115732F', 'Morganica', 'Dracksford', '867 Pierstorff Hill', 'Nottingham', 'AA55652', 91483.7, '1986-08-03'),
('PQ325071U', 'Alfonso', 'Pirdue', '201 Garrison Crossing', 'Bath', 'PW52912', 60175.7, '1950-01-27'),
('PR407605T', 'Junette', 'Hackforth', '74801 Lakewood Trail', 'Winchester', 'MI29362', 36180.9, '1998-03-26'),
('PR574429Q', 'Catlaina', 'McInerney', '19 Aberg Plaza', 'Glasgow', 'TN63381', 69134.7, '1953-11-03'),
('PS295181Z', 'Chiarra', 'Dundridge', '04 Porter Avenue', 'Birmingham', 'NH95981', 67648.8, '1972-01-10'),
('PS334310V', 'Ginelle', 'Morgon', '411 2nd Pass', 'Coventry', 'AZ47004', 84423.5, '1960-04-26'),
('PS562104C', 'Shaw', 'Brandsen', '55545 Toban Trail', 'Edinburgh', 'AA50405', 47949.9, '1974-10-22'),
('PU346240T', 'Felipe', 'Ferschke', '5508 Hauk Terrace', 'Swansea', 'VT69681', 63359.8, '1986-12-25'),
('PU508250S', 'Janeva', 'Carlet', '5557 Washington Point', 'Colchester', 'UT62564', 35334.8, '1974-07-18'),
('PW205885R', 'Kristofer', 'Janson', '18140 Straubel Road', 'Cambridge', 'VI55546', 94483.6, '1972-03-01'),
('PW357899L', 'Jenn', 'Alsina', '281 Marquette Drive', 'Leeds', 'DE26651', 40753.2, '1987-12-08'),
('PZ402630G', 'Evvy', 'Burrill', '18 Pennsylvania Crossing', 'Chelmsford', 'AR98802', 65007.1, '1994-08-02'),
('QA101983V', 'Dorie', 'Brazener', '7720 Miller Way', 'Glasgow', 'CA38899', 14357.1, '1966-01-19'),
('QB596623C', 'Derril', 'Scaife', '4 Tony Street', 'Wells', 'MP79763', 82281.3, '1965-01-08'),
('QF112815J', 'Theressa', 'Prentice', '2026 Oak Valley Hill', 'Wells', 'GU90154', 78594.8, '1973-02-18'),
('QF137469L', 'Ruperta', 'Stobie', '2825 Pepper Wood Center', 'Ripon', 'AR18667', 83681.2, '1976-09-17'),
('QF846140G', 'Ikey', 'Sholl', '62 North Place', 'Lisburn', 'GA23219', 77016, '1985-07-23'),
('QH838641Y', 'Ermengarde', 'Breitling', '2376 Brentwood Place', 'Lichfield', 'GA90112', 18516.5, '1963-07-06'),
('QI586048L', 'Ninnette', 'Reach', '018 2nd Parkway', 'Salisbury', 'AE01034', 33411.9, '2002-04-11'),
('QJ120357R', 'Starr', 'Akhurst', '42 Golf Course Hill', 'Southampton', 'OR02920', 16005.6, '1951-06-01'),
('QJ455525D', 'Nelle', 'Thams', '04 Weeping Birch Junction', 'Stoke on Trent', 'DC61743', 12571.3, '1982-12-16'),
('QJ799086Z', 'Aylmer', 'Gabbatiss', '8828 Blue Bill Park Avenue', 'Oxford', 'UT53746', 27880.5, '1950-09-20'),
('QL275702I', 'Simeon', 'Dilworth', '749 Summit Circle', 'Doncaster', 'MI46647', 63320, '1974-04-10'),
('QL321121L', 'Jeffy', 'Camel', '067 Columbus Street', 'Canterbury', 'NE68827', 8815.19, '1987-11-19'),
('QL642076F', 'Jorge', 'Bonham', '8 2nd Trail', 'Cardiff', 'OH58718', 33284.8, '1998-03-19'),
('QN206371I', 'Stefa', 'Stringman', '3 Lake View Lane', 'Coventry', 'KY91107', 76206.4, '1987-12-09'),
('QR454157Y', 'Julio', 'Featherstonhalgh', '35498 Jackson Pass', 'Wrexham', 'OR74891', 89162.3, '1987-02-20'),
('QU905290S', 'Sarina', 'Kalb', '565 Annamark Alley', 'Coventry', 'HI73292', 45860, '1950-11-14'),
('QV299811C', 'Winnah', 'Gillott', '40711 Dayton Plaza', 'Lancaster', 'ID30715', 48040.5, '1982-12-31'),
('QV402258L', 'Leonelle', 'Claridge', '09468 Lunder Place', 'Leeds', 'NY99661', 61662.4, '1974-01-15'),
('QY726870D', 'Emanuele', 'Strickland', '3772 Dawn Drive', 'Londonderry', 'HI32304', 15549.2, '1967-04-14'),
('QZ236393M', 'Jodie', 'Busswell', '8 Pepper Wood Avenue', 'Carlisle', 'CA39690', 14441.4, '1958-12-07'),
('RB204617T', 'Gerardo', 'Brosio', '6949 Bonner Junction', 'Leeds', 'FM49056', 92669.4, '1968-03-20'),
('RB499211C', 'Rab', 'Feast', '9503 Buell Drive', 'Durham', 'ID46569', 30397.6, '1986-04-01'),
('RB727027L', 'Pansy', 'Benasik', '777 Welch Junction', 'Newcastle-upon-Tyne', 'AA36259', 41672.3, '1953-03-04'),
('RB919501K', 'Maggi', 'Hamshar', '92344 Main Avenue', 'Bangor', 'ND81317', 34269.4, '1950-04-19'),
('RC413749A', 'Darryl', 'Payfoot', '62334 Prairie Rose Drive', 'Carlisle', 'NE79776', 84841.6, '1955-10-15'),
('RC734008G', 'Nataline', 'Roycroft', '52339 Eastlawn Crossing', 'Preston', 'MS16001', 81005, '1967-06-04'),
('RF462586D', 'Elnar', 'Tabrett', '280 Drewry Way', 'Bradford', 'DC13191', 85741.9, '1963-03-15'),
('RG151568Q', 'Lynne', 'Muccino', '65 Northland Avenue', 'Chichester', 'DC02920', 63251.2, '1960-05-27'),
('RI926857Q', 'Elfrieda', 'Slessar', '5536 Stone Corner Terrace', 'Belfast', 'WA13599', 64639.4, '1954-02-02'),
('RK384949O', 'Will', 'Craik', '50 Florence Junction', 'Nottingham', 'LA09117', 85698.4, '1998-04-23'),
('RN693599V', 'Fayette', 'Hackin', '212 Loomis Trail', 'Winchester', 'MN18106', 51844.5, '1986-03-31'),
('RO435900H', 'Beulah', 'Vala', '07601 Sunfield Hill', 'Ripon', 'AZ80932', 37954.9, '1951-09-09'),
('RO907653Y', 'Sal', 'Dominy', '88006 Charing Cross Hill', 'Kingston-upon-Hull', 'CO12963', 39168.5, '1994-07-30'),
('RP358778T', 'Fredericka', 'Mathivat', '370 Mendota Court', 'Londonderry', 'WA12562', 68554.8, '1989-04-17'),
('RP562470Q', 'Jacki', 'Rumin', '84 Kipling Parkway', 'Liverpool', 'CA23408', 81648.5, '1991-01-21'),
('RR316532P', 'Magdalen', 'McIlwrick', '2099 Debra Trail', 'Wakefield', 'MS93476', 41997.2, '1974-01-19'),
('RS150649P', 'Nady', 'Yvens', '84 Mayer Court', 'Lisburn', 'MP30167', 82751.4, '1993-05-26'),
('RS647299I', 'Frederic', 'Ginnaly', '2 Drewry Circle', 'Durham', 'PA25247', 98924.5, '1971-10-02'),
('RS859776Q', 'Alys', 'Feye', '000 Grayhawk Court', 'Gloucester', 'TX33594', 50021.5, '1975-01-21'),
('RW267230V', 'Andra', 'Bamfield', '9799 Russell Crossing', 'Carlisle', 'AE15327', 59706.6, '1967-12-08'),
('RY037414U', 'Greer', 'Durnford', '44200 Sauthoff Terrace', 'Sheffield', 'MI41101', 82703.4, '1996-11-16'),
('RY550614D', 'Raphaela', 'Symon', '41109 Stephen Plaza', 'Chichester', 'GA71516', 72118.4, '1983-03-07'),
('RY740755S', 'Vania', 'Simonsson', '666 Hoffman Parkway', 'Brighton & Hove', 'CA12798', 90719.7, '2001-12-22'),
('RZ111360G', 'Rochell', 'O&#039;Doohaine', '1802 Hayes Court', 'Wrexham', 'MI16210', 33027.2, '1973-11-08'),
('RZ638367H', 'Odey', 'Smeeth', '46584 Kedzie Point', 'Ely', 'GU35622', 97871, '2000-07-23'),
('SA107205Q', 'Elvira', 'Vinson', '37 Kipling Lane', 'Westminster', 'DE12719', 91216.8, '1966-06-10'),
('SB614856M', 'Flemming', 'Arnoll', '2 Eggendart Crossing', 'Portsmouth', 'WI43330', 22873, '2002-08-03'),
('SF717839D', 'Estevan', 'Francesco', '2 Troy Avenue', 'Manchester', 'VT68374', 85869.3, '1970-09-16'),
('SG232892L', 'Cassy', 'Hiddersley', '9902 Starling Circle', 'Kingston-upon-Hull', 'MD84834', 71258.1, '1999-09-03'),
('SH419152D', 'Jacinta', 'Partleton', '3957 Hoard Place', 'Aberdeen', 'DE93482', 96193.5, '1962-10-15'),
('SH464311U', 'Rhodia', 'Realy', '2748 Wayridge Junction', 'Wakefield', 'WA07649', 54901.5, '1959-12-23'),
('SH512546I', 'Schuyler', 'Stoffels', '31 Carioca Terrace', 'Bangor', 'WI85203', 41087.6, '1980-09-20'),
('SI278865G', 'Bonnibelle', 'Disley', '9 Vermont Trail', 'Wrexham', 'TX72259', 32710.5, '1987-07-30'),
('SJ533699H', 'Pammy', 'Sterling', '466 Northfield Alley', 'Oxford', 'VI94373', 86046.5, '1966-04-21'),
('SK016695U', 'Ludovika', 'Blucher', '0141 Forest Alley', 'Preston', 'WV13349', 59728, '1956-01-13'),
('SK062184B', 'Aldridge', 'Kensett', '94 Dunning Trail', 'Wells', 'AA91454', 86064.2, '1987-12-04'),
('SL566148H', 'Alexandros', 'Ormesher', '664 Gale Plaza', 'Manchester', 'DE04874', 51642.7, '1998-03-15'),
('SM423704X', 'Vivie', 'Jagels', '77 Dovetail Drive', 'London', 'MT46068', 41830.5, '1964-12-06'),
('SN878406K', 'Isacco', 'Chaperling', '71120 West Crossing', 'Durham', 'VI84809', 81126.9, '1975-11-03'),
('SO040048U', 'Onofredo', 'Joontjes', '938 2nd Way', 'Birmingham', 'WA84837', 36626.2, '1990-04-01'),
('SP696523T', 'Gris', 'Elington', '12 School Way', 'York', 'AS34942', 40776.9, '1963-12-30'),
('SQ353921L', 'Benny', 'Lander', '86904 Montana Road', 'London', 'UT56687', 88061.5, '1991-01-06'),
('SR314203N', 'Tandi', 'Dmitrovic', '5447 Lyons Center', 'St Davids', 'MN83385', 99223.3, '1970-01-19'),
('SV922230Q', 'Lyell', 'Brannan', '7 Anzinger Center', 'Ripon', 'MH59940', 49943.1, '1984-09-05'),
('SW345892X', 'Stanislaus', 'Ferreli', '5 Northland Park', 'London', 'AP11586', 51816.2, '1975-04-20'),
('TF577069V', 'Hadlee', 'Stealey', '0 4th Court', 'Belfast', 'AP87326', 52510.1, '1997-11-17'),
('TG734644M', 'Melany', 'Klugel', '14577 Truax Alley', 'Carlisle', 'MO84208', 41959.6, '1955-05-18'),
('TJ978150H', 'Say', 'Lodwig', '54399 Forest Dale Avenue', 'Colchester', 'VA37959', 17891.1, '1987-08-27'),
('TK845900K', 'Nicky', 'Ipplett', '7153 Merrick Terrace', 'Chelmsford', 'FL64252', 48895.3, '1983-10-25'),
('TM559297A', 'Renaud', 'Skpsey', '4430 Fieldstone Alley', 'Aberdeen', 'NV75498', 44136.5, '2002-01-26'),
('TM808573F', 'Tommie', 'Vallintine', '37 Superior Parkway', 'Swansea', 'GU78527', 87912.4, '1973-11-21'),
('TN328405L', 'Murdock', 'Linsay', '8 Shelley Terrace', 'Londonderry', 'MH89481', 55605.6, '1992-12-08'),
('TN459758P', 'Ambur', 'Challenor', '2 Morning Crossing', 'Milton Keynes', 'PW81860', 47034, '1955-09-17'),
('TO907441W', 'Yoshi', 'Peakman', '641 Warner Point', 'Leicester', 'CT96905', 20293.4, '1953-03-06'),
('TP307139N', 'Alfi', 'MacFadzean', '6 Old Shore Center', 'Brighton & Hove', 'CT51809', 45825.5, '1983-05-07'),
('TP697018E', 'Sashenka', 'Artin', '71 Talmadge Drive', 'Southampton', 'NV90380', 36543.6, '1982-09-22'),
('TQ009471B', 'Orsola', 'Francillo', '31360 Debra Junction', 'Chichester', 'MN89518', 98161.1, '1970-06-06'),
('TT394813Q', 'Del', 'Fitter', '4290 Superior Terrace', 'St Asaph', 'TX68242', 54544.3, '1982-11-26'),
('TU153415T', 'Giffard', 'Endecott', '13672 Caliangt Terrace', 'Bradford', 'WV28472', 30809.2, '1953-03-14'),
('TV211484W', 'Gina', 'Macrae', '607 Northport Center', 'Durham', 'WI33173', 36331.8, '1961-05-14'),
('TX085395S', 'Bria', 'Thomkins', '7 Homewood Road', 'Inverness', 'NM71727', 88871.6, '1952-04-01'),
('TX310999B', 'Loren', 'Kupper', '24 West Plaza', 'Leicester', 'VA86763', 92010.3, '1999-07-10'),
('TX491950I', 'Constantia', 'Privett', '162 Moland Terrace', 'Peterborough', 'AP06525', 25686.8, '1980-01-29'),
('TX858508R', 'Clareta', 'Bamlet', '1038 Bellgrove Parkway', 'Southend-on-Sea', 'NE52811', 46543, '1964-04-09'),
('UB404168R', 'Heath', 'Manvell', '77 Westridge Road', 'Belfast', 'ME32971', 29749, '1970-02-28'),
('UB855681N', 'Florie', 'Reyes', '2 Heffernan Center', 'Wrexham', 'FL28982', 98224.3, '1999-11-28'),
('UC493497V', 'Desirae', 'Gooch', '6306 Reinke Circle', 'Bath', 'MA79410', 42779.3, '1979-01-07'),
('UI092814R', 'Conni', 'Orhrt', '92 Moose Park', 'Milton Keynes', 'SD27276', 14137.7, '2000-05-09'),
('UJ306006A', 'Ashbey', 'England', '3 Oneill Crossing', 'Wolverhampton', 'AR17412', 66223.5, '1979-09-18'),
('UL176502B', 'Dorene', 'Ipplett', '87 Cardinal Court', 'Southampton', 'WI78613', 93942.9, '1986-11-16'),
('UL369491O', 'Meade', 'Ketteman', '47 Nevada Center', 'Cardiff', 'VI53998', 17823.3, '1950-07-30'),
('UN133384D', 'Verla', 'Seacroft', '0134 Fieldstone Trail', 'Brighton & Hove', 'WV31313', 52928.2, '2000-05-18'),
('UO254689S', 'Sherlocke', 'Cornner', '00811 Morning Crossing', 'Westminster', 'LA81632', 43444.8, '1960-03-15'),
('US493269A', 'Wynn', 'Winterscale', '931 Warbler Road', 'Derby', 'MS75863', 76837.1, '1989-12-12'),
('US717372T', 'Conney', 'Ferras', '43048 American Ash Hill', 'Bristol', 'MN60263', 93389.4, '1993-07-19'),
('UU202177X', 'Afton', 'Cassels', '4 Grover Way', 'Lisburn', 'PW79809', 30662.9, '1984-06-15'),
('UU528507S', 'Nikaniki', 'Scarman', '81 Fallview Avenue', 'Chester', 'WI04434', 92757.8, '1994-12-05'),
('UU534964W', 'Ransell', 'Seakings', '1 Ramsey Park', 'Newcastle-upon-Tyne', 'IN88222', 43734.6, '1995-07-22'),
('UV348158A', 'Adrienne', 'Myall', '9 Oneill Place', 'Worcester', 'LA35140', 31683.2, '1972-08-11'),
('UV389552L', 'Margaretha', 'Kikke', '24 Logan Circle', 'Bristol', 'AR34111', 25726.1, '2000-01-08'),
('UW710251U', 'Charline', 'Saggers', '32 Burning Wood Alley', 'Cambridge', 'AP08522', 85860.6, '1995-11-26'),
('UW834458R', 'Dorian', 'Claringbold', '7422 Crownhardt Avenue', 'Oxford', 'AK76136', 13347.3, '1955-11-18'),
('UX496294H', 'Kial', 'Labden', '55507 Bultman Circle', 'Southend-on-Sea', 'MN58032', 39885.2, '1998-03-07'),
('UX813250N', 'Arne', 'Bosson', '77803 Messerschmidt Park', 'Chichester', 'IL83171', 73371.6, '2001-01-28'),
('UZ970481U', 'Raina', 'Yearn', '7 Havey Point', 'Wolverhampton', 'IL26186', 91757.2, '1972-09-03'),
('VA211893V', 'Sofia', 'Skoof', '47354 Clyde Gallagher Point', 'Wells', 'KS08543', 58714.1, '1965-11-26'),
('VA219127U', 'Hugues', 'Tavner', '78 Parkside Point', 'Bath', 'AA13863', 37393.7, '1980-12-03'),
('VB943949C', 'Thea', 'Bradborne', '3118 Lien Circle', 'Stirling', 'DE01424', 35666, '1967-09-27'),
('VD479897L', 'Victoir', 'Loveitt', '7 Judy Parkway', 'Doncaster', 'WI63864', 24486.5, '1996-02-05'),
('VD818340C', 'Annetta', 'Cock', '76245 Hoffman Court', 'Preston', 'MD68269', 90559.9, '1984-07-16'),
('VE628368Y', 'Gianina', 'Leppington', '1 Jenifer Park', 'Newry', 'VI47791', 77499.4, '1979-05-27'),
('VE944995L', 'Veradis', 'Wagstaff', '592 Sullivan Pass', 'Wells', 'PW99518', 54982.9, '1951-08-08'),
('VG613456A', 'Bearnard', 'Parysowna', '60052 Monument Alley', 'Bangor', 'VA61155', 85175.3, '1985-09-08'),
('VG667583E', 'Gill', 'Fulford', '9 Susan Avenue', 'Chichester', 'AZ12643', 46429.9, '1968-03-20'),
('VG977309D', 'Jacobo', 'Pashba', '101 Linden Crossing', 'Dunfermline', 'NY06485', 67037, '1976-05-15'),
('VG979335T', 'Catharine', 'Sharpous', '081 Hermina Trail', 'Birmingham', 'NC91043', 98273.9, '1983-08-10'),
('VI744437V', 'Georg', 'De', '06 Hermina Terrace', 'Portsmouth', 'WV62831', 37144.2, '1993-01-18'),
('VK466721D', 'Ina', 'Farrans', '65968 Fairview Center', 'Portsmouth', 'NC01751', 67306, '1952-03-10'),
('VK802431Y', 'Annette', 'Josephs', '532 Kipling Place', 'Stirling', 'MH56822', 46710.6, '1960-03-07'),
('VK993165I', 'Delila', 'Folland', '5993 Warner Park', 'Dunfermline', 'MD65132', 32281.5, '1955-11-27'),
('VL606950T', 'Felice', 'Plaide', '0617 Daystar Drive', 'Salisbury', 'MT51549', 58909.3, '1953-03-05'),
('VM874796Y', 'Nari', 'Chowne', '169 Clemons Drive', 'London', 'ND47336', 40585.8, '1979-01-17'),
('VN364397S', 'Vinni', 'Champneys', '38416 Susan Plaza', 'Bath', 'TX39546', 35513.2, '1976-05-01'),
('VR974451G', 'Morgen', 'Shortland', '3 Doe Crossing Trail', 'Ripon', 'OK42144', 81649.1, '2002-08-17'),
('VS049545N', 'Cornie', 'Hub', '564 Muir Alley', 'Bath', 'AP63288', 13017.6, '1999-04-01'),
('VU807135V', 'Stafani', 'Clampe', '8 Bultman Avenue', 'Plymouth', 'IN15982', 28092.3, '1954-05-05'),
('VU851838J', 'Stearne', 'Stennet', '664 Warrior Drive', 'Perth', 'ND17349', 37835.1, '1993-04-08'),
('VV093891D', 'Florry', 'Oblein', '5 Elmside Lane', 'Lisburn', 'SC68330', 87584.2, '1984-12-20'),
('VV690440B', 'Anderea', 'Challicombe', '8 Melvin Terrace', 'Bangor', 'NJ84957', 87575.3, '1999-03-21'),
('VV722651O', 'Zahara', 'Pepis', '15 2nd Crossing', 'Truro', 'AR07688', 17215.7, '1992-03-16'),
('VV771459V', 'Iorgo', 'Dowsey', '904 Pond Park', 'St Davids', 'NC21457', 14568.8, '2001-07-08'),
('VW612487D', 'Meridith', 'Bolton', '9 Hooker Avenue', 'Leicester', 'OH42784', 81390.7, '1951-01-06'),
('VW694872R', 'Christiane', 'Barnes', '2958 Butterfield Point', 'Southampton', 'PA49974', 51949.1, '1965-08-25'),
('VW739034C', 'Janot', 'Kleinsinger', '4324 Huxley Point', 'Wolverhampton', 'WY47084', 59407.5, '1982-10-05'),
('VX435216W', 'Viviana', 'Dreschler', '3 Oak Terrace', 'Wells', 'MH03406', 56587.8, '1954-11-28'),
('VY437276R', 'Bobbye', 'Pottinger', '4633 Scott Street', 'Swansea', 'WA75300', 99191.4, '1953-12-04'),
('VY468006G', 'Willyt', 'Ezzy', '61751 Burrows Drive', 'Lichfield', 'CO75310', 14811.1, '1983-06-12'),
('VY489059E', 'Netta', 'McCabe', '1 Lakewood Gardens Plaza', 'Coventry', 'MA95283', 45095.6, '1998-02-26'),
('VY525798F', 'Rene', 'Waddup', '47 Southridge Parkway', 'Doncaster', 'CA44411', 40348.7, '1992-08-08'),
('VZ575305Z', 'Constantino', 'Phlippsen', '52 Nevada Road', 'Leicester', 'FL65276', 77184, '1965-08-21'),
('VZ886203M', 'Charlena', 'Marques', '2800 Dahle Avenue', 'Inverness', 'IA44865', 83307.3, '1966-11-24'),
('WA104983F', 'Merrill', 'Joust', '75 Portage Center', 'Derby', 'PR66544', 51515.8, '1958-01-16'),
('WA954782V', 'Bevan', 'Durrell', '18 Butternut Road', 'Doncaster', 'MN18227', 24202.1, '1950-02-09'),
('WC844307P', 'Esteban', 'Ziemen', '4832 Pankratz Road', 'Winchester', 'AS08400', 16929.8, '1956-07-01'),
('WD175217C', 'Demetrius', 'Lowmass', '8 Stone Corner Crossing', 'Bangor', 'NE35910', 99061.5, '1968-07-24'),
('WH660279O', 'Lamar', 'Chesters', '2234 Heffernan Place', 'Nottingham', 'AP60163', 97090.5, '1952-02-01'),
('WH734079V', 'Phyllis', 'Lalevee', '77169 Sullivan Crossing', 'Dundee', 'KY81816', 38220.8, '1962-03-06'),
('WJ636565X', 'Sandye', 'How', '2 Fordem Street', 'Chester', 'OK27862', 13440, '1963-05-24'),
('WK661827Y', 'Douglas', 'MacArdle', '14 Laurel Court', 'Birmingham', 'HI36808', 92356.6, '1991-07-15'),
('WN058972W', 'Donica', 'Hewell', '2911 Southridge Hill', 'Exeter', 'MI05043', 34806.5, '1978-01-03'),
('WN277158X', 'Mellisa', 'Mapam', '65 Maryland Junction', 'Kingston-upon-Hull', 'GA80804', 85398.2, '1961-12-21'),
('WS189951J', 'Alia', 'Sygroves', '7 Roth Alley', 'Bangor', 'AL61093', 19945.2, '1967-12-20'),
('WS394988S', 'Padgett', 'Casel', '3552 Towne Road', 'Chester', 'IN93680', 61058.4, '1956-06-02'),
('WU157014Q', 'Malcolm', 'Louys', '2 Ronald Regan Pass', 'Manchester', 'OK83337', 72398, '1996-02-13'),
('WW210857J', 'Tymon', 'Smeal', '22635 Toban Court', 'Swansea', 'KS41776', 65314.5, '1983-12-07'),
('WW328815I', 'Ashley', 'Barcke', '7 Eastlawn Alley', 'Plymouth', 'RI29658', 33391.1, '1968-07-30'),
('WX774255I', 'Haze', 'Rosenbush', '0 Kropf Alley', 'Newry', 'AP77622', 89561.6, '1995-11-10'),
('XA033094E', 'Onfre', 'Woolmore', '7868 Pearson Hill', 'Derby', 'CO27044', 61377.2, '1983-11-22'),
('XA610379G', 'Bianka', 'Druce', '5 Pierstorff Plaza', 'York', 'MD64999', 98768.8, '1955-02-28'),
('XB032437G', 'Ferrell', 'Lages', '39705 Goodland Center', 'Gloucester', 'IN19197', 63515.1, '1996-04-23'),
('XB125807V', 'Marney', 'Kolak', '5 Merrick Road', 'Durham', 'DC43558', 97251.7, '1978-10-15'),
('XC467370V', 'Dotti', 'Busek', '32564 Veith Circle', 'Exeter', 'IL29610', 12043.6, '1984-06-06'),
('XD785936E', 'Julina', 'Copnar', '8 Randy Court', 'Belfast', 'OK14930', 55255.9, '1991-06-01'),
('XD817271X', 'Valeria', 'Proschek', '6 Red Cloud Court', 'Belfast', 'KS97025', 97436.1, '1996-02-18'),
('XE947994R', 'Ernestus', 'Dewsnap', '937 Springs Road', 'Bangor', 'HI72470', 65304.5, '1963-09-14'),
('XH198735C', 'Gerek', 'Bardnam', '91085 Maple Court', 'Londonderry', 'AS31255', 51185.6, '1966-12-29'),
('XH499685D', 'Giorgia', 'Hynes', '23948 Ruskin Place', 'Carlisle', 'PR30995', 44916.4, '1963-01-15'),
('XH603239M', 'Orton', 'Willmore', '4 Pine View Street', 'Wrexham', 'LA10122', 14870.4, '1985-01-31'),
('XN991742P', 'Stormie', 'Lowndes', '280 Thompson Plaza', 'Durham', 'IA87644', 66017.9, '1964-11-20'),
('XO554182R', 'Lief', 'Schimann', '4786 Rowland Trail', 'Liverpool', 'CA74611', 87146.7, '1957-07-01'),
('XP081647H', 'Parker', 'Filippov', '9 Granby Terrace', 'Oxford', 'GA59906', 65946.5, '1995-03-05'),
('XQ363276D', 'Davie', 'Cutill', '61998 Fisk Lane', 'London', 'NH97536', 92319.5, '1961-12-28'),
('XR596082Y', 'Donella', 'Chinery', '3 Tennessee Street', 'Brighton & Hove', 'AP71355', 31438.7, '1970-02-12'),
('XS400698X', 'Dud', 'Firman', '467 Lighthouse Bay Junction', 'Oxford', 'IA99656', 35155.6, '1961-08-08'),
('XX491915V', 'Norton', 'Bygrove', '0412 Packers Lane', 'Aberdeen', 'GA82240', 43733.5, '1952-12-09'),
('XY286906N', 'Fanchon', 'Stebbings', '77689 Donald Alley', 'Wolverhampton', 'NY23134', 38753.9, '1966-11-15'),
('XZ020089E', 'Burnaby', 'McGreay', '55 Hansons Center', 'Stoke on Trent', 'AP49786', 54552.7, '1971-09-13'),
('XZ369649I', 'Leola', 'Dayly', '1 Tony Avenue', 'Cambridge', 'ID45466', 43761.9, '1995-02-24'),
('XZ796669H', 'Cherilyn', 'Jepps', '062 Nevada Parkway', 'Bristol', 'GU62158', 85550.3, '1971-10-30'),
('YA877759R', 'Osgood', 'Sutherby', '88855 Merrick Road', 'Milton Keynes', 'IL61451', 27045.6, '1990-08-20'),
('YB039141A', 'Carolin', 'Jagson', '57891 Bultman Circle', 'Chester', 'PA30599', 56278.6, '1953-12-06'),
('YC393041Q', 'Benoit', 'Collman', '827 Erie Junction', 'Winchester', 'CO83832', 74923, '1982-12-12'),
('YG637206I', 'Phaidra', 'Ivey', '46 Toban Lane', 'Stirling', 'NV54260', 61580.9, '1970-01-02'),
('YH126921T', 'Faunie', 'Testo', '903 Pawling Terrace', 'Inverness', 'MI73759', 42813.1, '1952-09-02'),
('YH345037B', 'Hayyim', 'Fleay', '3644 Blaine Court', 'Leicester', 'FM76000', 55384, '1974-02-05'),
('YH523785H', 'Lorita', 'Fere', '9899 Johnson Park', 'Bristol', 'CA28495', 64340.9, '1973-07-26'),
('YH646941O', 'Sarajane', 'Abrams', '26499 Warrior Avenue', 'Canterbury', 'AR75132', 87543.1, '1985-01-02'),
('YK522444D', 'Rafferty', 'Edowes', '96 Helena Crossing', 'Nottingham', 'IL91171', 41496, '1988-07-24'),
('YL605202H', 'Noni', 'Szymoni', '6 Kedzie Circle', 'Kingston-upon-Hull', 'DE73219', 90864.7, '1959-02-09'),
('YL966209U', 'Raquel', 'Stave', '8 Springview Plaza', 'Chelmsford', 'IL66763', 91219.8, '1998-06-21'),
('YO417120D', 'Germain', 'Stockow', '102 Haas Junction', 'Leeds', 'GU72150', 56278.6, '1981-05-30'),
('YS435194S', 'Pyotr', 'Ingham', '81 John Wall Junction', 'Chichester', 'OR41516', 38532.1, '1990-01-17'),
('YS652384Q', 'Marylou', 'McClunaghan', '7 Bluestem Pass', 'Nottingham', 'MS94960', 60710.9, '1982-09-24'),
('YX527895G', 'Shelley', 'Camilletti', '91311 Hauk Avenue', 'Sunderland', 'AE76045', 67736.1, '1974-12-25'),
('YX656704N', 'Sallie', 'Hardwell', '6 Golf View Pass', 'Brighton & Hove', 'MA56104', 80829.1, '1983-09-20'),
('YZ407625P', 'Agnese', 'Murrhardt', '4666 Jay Court', 'Lisburn', 'AA20992', 88965.8, '1955-12-18'),
('YZ604658J', 'Harwell', 'Lain', '11 Bartelt Terrace', 'Chelmsford', 'MI93887', 60453.9, '1978-01-31'),
('YZ717919V', 'Britta', 'Northin', '757 Ramsey Terrace', 'Preston', 'WV55268', 74080.5, '1959-09-11'),
('YZ865649D', 'Brose', 'Niece', '18466 Village Green Plaza', 'Exeter', 'VA67872', 74713, '1964-02-02'),
('ZA364662Q', 'Dulcia', 'Antonutti', '9 Kingsford Plaza', 'Ely', 'MT24831', 61015.9, '1996-07-19'),
('ZB232750V', 'Viola', 'Holleran', '877 Twin Pines Plaza', 'Newry', 'NV10255', 94882.8, '1984-03-23'),
('ZC732912G', 'Dedra', 'MacConnulty', '22342 Sauthoff Center', 'Truro', 'OR50795', 85921.5, '1989-05-13'),
('ZE015887N', 'Bailey', 'Lewington', '3 Bobwhite Center', 'Southampton', 'AP34629', 90668.8, '1993-02-02'),
('ZF490474B', 'Juditha', 'Pesterfield', '076 Heath Drive', 'Ely', 'AR07235', 37428.3, '1952-10-19'),
('ZH337987I', 'Doralynn', 'Suddaby', '4 Springview Plaza', 'Newcastle-upon-Tyne', 'AL19604', 59458.1, '1952-09-16'),
('ZI651705L', 'Jacob', 'Kelf', '48033 Forest Run Parkway', 'Newry', 'MT33099', 66228.1, '1965-11-25');
INSERT INTO `Employee_Details` (`NIN`, `First_Name`, `Last_Name`, `Street_Address`, `City`, `Postcode`, `Salary`, `DOB`) VALUES
('ZI901356N', 'Joeann', 'Beckerleg', '6442 Dennis Street', 'Carlisle', 'GA02474', 56988.5, '1992-12-14'),
('ZK782722R', 'Noell', 'Azam', '66 Brown Hill', 'Preston', 'SD48212', 60586.8, '1974-05-19'),
('ZP730277W', 'Blancha', 'McMillian', '59 Buhler Trail', 'Kingston-upon-Hull', 'OR58824', 89177.1, '1991-07-21'),
('ZS026946U', 'Sonny', 'Tabrett', '25326 Briar Crest Hill', 'Colchester', 'LA23204', 62818.8, '1989-01-29'),
('ZT656754O', 'Hortense', 'Berecloth', '2 Barby Parkway', 'Cardiff', 'TX10776', 38548, '1987-07-29'),
('ZW251674D', 'Earl', 'Wagerfield', '34 Lillian Center', 'Peterborough', 'VI85497', 91770.3, '1998-04-05'),
('ZX396808C', 'Mozes', 'Fishleigh', '2636 Burning Wood Crossing', 'Armagh', 'FM21242', 42919.3, '1952-04-10'),
('ZY295345W', 'Annnora', 'Leabeater', '931 Waxwing Pass', 'Armagh', 'VT42132', 84021.4, '1962-07-22'),
('ZZ594734B', 'Omero', 'Hurles', '878 Vidon Point', 'Bristol', 'AZ86912', 85092.3, '1985-05-25'),
('ZZ664726S', 'Modesty', 'Chicchelli', '74 Bashford Pass', 'Glasgow', 'MO78188', 23376.6, '1961-01-22');

--
-- Triggers `Employee_Details`
--
DELIMITER $$
CREATE TRIGGER `On_Employee_Delete` BEFORE DELETE ON `Employee_Details` FOR EACH ROW BEGIN
        	DECLARE EmployeeID VARCHAR(10);
            SELECT Employees.Number INTO EmployeeID FROM Employees INNER JOIN Employee_Details ON Employees.NIN = Employee_Details.NIN WHERE Employee_Details.NIN = OLD.NIN;
        	INSERT INTO Auditing_Employees_Table(Employee_Number_Deleted, Date_Deleted, Time_Deleted) VALUES(EmployeeID, CURRENT_DATE(), CURRENT_TIME());
        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `HR`
--

CREATE TABLE `HR` (
  `ID` int(11) NOT NULL,
  `Employee_Number` varchar(10) NOT NULL,
  `Office_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `HR`
--

INSERT INTO `HR` (`ID`, `Employee_Number`, `Office_ID`) VALUES
(1, '22-3708071', 18),
(2, '31-7167962', 12),
(3, '85-7718619', 1),
(4, '40-0786243', 9),
(5, '45-3951342', 3),
(6, '67-5029558', 19),
(7, '20-2758343', 8),
(8, '41-6555988', 3),
(9, '63-9116461', 2),
(10, '06-0280761', 13),
(11, '41-3975053', 15),
(12, '60-7601093', 19),
(13, '85-5431069', 18),
(14, '18-3911956', 1),
(15, '33-7183053', 15),
(16, '97-4110845', 16),
(17, '11-6489646', 2),
(18, '61-7469906', 6),
(19, '59-4661298', 15),
(20, '34-8695852', 5),
(21, '10-6321236', 7),
(22, '59-0150604', 5),
(23, '97-3703178', 6),
(24, '99-1372878', 11),
(25, '90-5035577', 17),
(26, '89-4884561', 2),
(27, '48-5840838', 6),
(28, '52-4726377', 5),
(29, '45-1060690', 1),
(30, '36-1480567', 11),
(31, '97-0147786', 13),
(32, '72-9006336', 10),
(33, '82-2609006', 17),
(34, '66-2361006', 3),
(35, '15-4783339', 17),
(36, '81-8060778', 9),
(37, '99-6209168', 18),
(38, '56-3682739', 14),
(39, '77-6317806', 6),
(40, '66-2522703', 18),
(41, '84-3853067', 6),
(42, '97-0913105', 2),
(43, '10-8148353', 12),
(44, '62-1957072', 6),
(45, '60-0655971', 19),
(46, '09-4017521', 19),
(47, '54-5318903', 2),
(48, '59-8381667', 5),
(49, '68-8976238', 4),
(50, '93-8667645', 8),
(51, '72-0413596', 2),
(52, '81-2733835', 16),
(53, '01-9983285', 18),
(54, '37-1673392', 20),
(55, '77-2348932', 17),
(56, '62-6726896', 13),
(57, '80-7941049', 8),
(58, '85-0601601', 2),
(59, '39-1227728', 14),
(60, '00-4334715', 2),
(61, '33-0071114', 9),
(62, '76-0000021', 3),
(63, '87-7188668', 16),
(64, '28-7012669', 3),
(65, '20-7194686', 12);

-- --------------------------------------------------------

--
-- Table structure for table `Management`
--

CREATE TABLE `Management` (
  `ID` int(11) NOT NULL,
  `Employee_Number` varchar(10) NOT NULL,
  `Office_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Management`
--

INSERT INTO `Management` (`ID`, `Employee_Number`, `Office_ID`) VALUES
(1, '66-0739491', 20),
(2, '83-4865660', 3),
(3, '74-0303597', 3),
(4, '93-5661312', 20),
(5, '35-7212754', 19),
(6, '87-6633787', 16),
(7, '33-1897506', 14),
(8, '87-8002965', 20),
(9, '82-6558984', 20),
(10, '47-3147567', 15),
(11, '06-2857563', 11),
(12, '65-1738561', 14),
(13, '29-2364794', 15),
(14, '54-9522118', 7),
(15, '73-2251057', 3),
(16, '76-2985832', 15);

-- --------------------------------------------------------

--
-- Table structure for table `Managers`
--

CREATE TABLE `Managers` (
  `ID` int(11) NOT NULL,
  `Management_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Managers`
--

INSERT INTO `Managers` (`ID`, `Management_ID`) VALUES
(6, 2),
(1, 3),
(3, 4),
(5, 5),
(8, 7),
(2, 10),
(4, 12),
(7, 15);

-- --------------------------------------------------------

--
-- Table structure for table `Offices`
--

CREATE TABLE `Offices` (
  `ID` int(11) NOT NULL,
  `Building_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Offices`
--

INSERT INTO `Offices` (`ID`, `Building_ID`) VALUES
(18, 2),
(19, 3),
(15, 4),
(4, 5),
(11, 6),
(2, 7),
(8, 8),
(1, 9),
(7, 14),
(5, 15),
(9, 22),
(20, 23),
(16, 25),
(6, 27),
(13, 28),
(14, 29),
(10, 30),
(17, 31),
(3, 33),
(12, 35);

-- --------------------------------------------------------

--
-- Table structure for table `Ordered_Products`
--

CREATE TABLE `Ordered_Products` (
  `Order_ID` int(11) NOT NULL,
  `Product_ID` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Orders`
--

CREATE TABLE `Orders` (
  `ID` int(11) NOT NULL,
  `Customer_First_Name` varchar(20) NOT NULL,
  `Customer_Last_Name` varchar(20) NOT NULL,
  `Customer_Email_Name` varchar(100) NOT NULL,
  `Street_Address` varchar(50) NOT NULL,
  `City` varchar(20) NOT NULL,
  `Postcode` varchar(7) NOT NULL,
  `Route_Name` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Packagers`
--

CREATE TABLE `Packagers` (
  `ID` int(11) NOT NULL,
  `Employee_Number` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Packagers`
--

INSERT INTO `Packagers` (`ID`, `Employee_Number`) VALUES
(171, '01-5576008'),
(60, '02-9566746'),
(97, '03-2826761'),
(18, '03-3544565'),
(168, '04-2798023'),
(195, '05-3647243'),
(151, '05-5059849'),
(61, '06-3396053'),
(201, '06-3776558'),
(16, '06-9710935'),
(6, '07-4517183'),
(126, '07-4724394'),
(111, '08-4428147'),
(148, '09-8147999'),
(129, '10-1743239'),
(14, '10-4168432'),
(23, '10-6127924'),
(153, '11-0990160'),
(135, '11-4556284'),
(66, '12-0104092'),
(13, '12-5128654'),
(71, '12-6888959'),
(53, '12-8760096'),
(132, '13-8722134'),
(73, '13-9234597'),
(93, '14-2911172'),
(193, '14-4001908'),
(186, '14-6532726'),
(69, '17-1925809'),
(173, '17-3967296'),
(51, '18-0534773'),
(110, '18-3863597'),
(182, '18-6142811'),
(200, '18-9171336'),
(140, '19-0713712'),
(81, '19-1079892'),
(37, '19-1277494'),
(99, '20-7886428'),
(142, '21-2689388'),
(155, '21-3155551'),
(160, '22-2051613'),
(77, '22-6627032'),
(25, '22-9529013'),
(183, '24-4585192'),
(33, '24-4677621'),
(83, '24-9067553'),
(146, '24-9840403'),
(92, '25-9736142'),
(139, '27-8037561'),
(108, '27-8094243'),
(184, '28-7818998'),
(181, '29-2785103'),
(86, '29-5209106'),
(117, '29-6350132'),
(22, '29-6571924'),
(10, '29-7832408'),
(8, '30-1322103'),
(27, '30-3058947'),
(102, '30-7334418'),
(149, '30-8456021'),
(185, '32-6251861'),
(54, '33-0489054'),
(76, '33-5159037'),
(20, '33-7614004'),
(57, '34-2543597'),
(202, '34-2817296'),
(143, '34-4740678'),
(11, '35-8208617'),
(47, '36-6348131'),
(172, '36-6943031'),
(9, '36-7073092'),
(89, '37-0478226'),
(196, '37-7900056'),
(190, '37-8247167'),
(94, '38-0609594'),
(85, '38-1272080'),
(170, '38-2126707'),
(119, '38-5473326'),
(147, '38-8885296'),
(28, '39-4788866'),
(43, '40-2208062'),
(2, '40-5288701'),
(88, '41-3216938'),
(3, '41-3659990'),
(101, '41-9319442'),
(39, '42-0717807'),
(121, '42-2072103'),
(157, '42-5263028'),
(122, '42-7011523'),
(75, '42-7240015'),
(165, '42-8848918'),
(120, '43-6568300'),
(150, '44-7083318'),
(163, '45-1168337'),
(65, '46-0059406'),
(128, '46-2600043'),
(72, '47-1387266'),
(118, '48-9328765'),
(1, '49-2217652'),
(62, '50-6111855'),
(161, '50-7117246'),
(12, '50-9092071'),
(104, '51-0122715'),
(24, '52-0404205'),
(55, '52-4567561'),
(177, '52-5735024'),
(79, '53-6948800'),
(124, '54-6428980'),
(169, '54-7904459'),
(130, '54-8296596'),
(137, '55-4384947'),
(131, '55-5908272'),
(38, '55-6072477'),
(58, '55-9616651'),
(82, '55-9770243'),
(48, '56-4309508'),
(70, '56-7734821'),
(52, '57-1609142'),
(178, '57-2548391'),
(40, '57-4162757'),
(164, '58-2471319'),
(174, '58-5912504'),
(109, '59-0997098'),
(36, '59-1166943'),
(125, '59-2576093'),
(44, '59-4684006'),
(15, '59-6274425'),
(7, '59-8314806'),
(30, '60-1691051'),
(49, '60-2276889'),
(154, '60-6270362'),
(29, '60-9203590'),
(100, '62-4020686'),
(115, '62-4959178'),
(31, '62-6894804'),
(42, '63-0638100'),
(198, '63-1545651'),
(127, '63-2539882'),
(145, '63-5722038'),
(95, '63-9446221'),
(112, '64-0621633'),
(80, '64-0636526'),
(156, '64-6729020'),
(63, '64-6879023'),
(50, '65-7661186'),
(91, '67-4076527'),
(105, '67-6903314'),
(107, '68-3172017'),
(4, '68-4171892'),
(199, '68-7037451'),
(90, '68-7096348'),
(180, '69-0393201'),
(45, '69-0536291'),
(74, '69-3965258'),
(167, '69-5925327'),
(162, '69-6968657'),
(158, '71-4783541'),
(176, '72-2448628'),
(59, '72-3040567'),
(84, '72-3549258'),
(5, '72-5913162'),
(187, '72-9328783'),
(191, '75-0124112'),
(116, '75-0131682'),
(103, '75-0328049'),
(35, '75-8250680'),
(41, '76-4036199'),
(141, '76-4940799'),
(96, '77-1835914'),
(144, '77-5748543'),
(175, '78-9623211'),
(98, '79-1576734'),
(179, '79-5517945'),
(123, '80-3234805'),
(26, '80-6524018'),
(134, '81-7038918'),
(152, '83-1009344'),
(197, '83-3514873'),
(46, '83-5537250'),
(136, '83-6435523'),
(113, '83-7810679'),
(188, '85-4557957'),
(138, '85-7355238'),
(159, '86-5274202'),
(64, '87-1470903'),
(194, '87-8745898'),
(87, '87-8762204'),
(133, '88-4435308'),
(166, '89-0022888'),
(192, '89-1889473'),
(189, '89-5714177'),
(21, '90-0686303'),
(19, '90-1403954'),
(67, '90-9258513'),
(34, '93-5928498'),
(114, '95-3517999'),
(68, '95-7092127'),
(203, '96-0987852'),
(56, '97-5558458'),
(78, '98-9650752'),
(32, '99-0222188'),
(106, '99-4988360');

-- --------------------------------------------------------

--
-- Table structure for table `Products`
--

CREATE TABLE `Products` (
  `ID` int(11) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Description` varchar(500) DEFAULT NULL,
  `Price` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Reported_Drivers`
--

CREATE TABLE `Reported_Drivers` (
  `Warehouse_ID` int(11) NOT NULL,
  `Driver_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Reported_Packagers`
--

CREATE TABLE `Reported_Packagers` (
  `Warehouse_ID` int(11) NOT NULL,
  `Packager_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Routes`
--

CREATE TABLE `Routes` (
  `Name` varchar(10) NOT NULL,
  `Driver_ID` int(11) DEFAULT NULL,
  `Vehicle_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Stops`
--

CREATE TABLE `Stops` (
  `ID` int(11) NOT NULL,
  `Start_Location` varchar(50) NOT NULL,
  `End_Location` varchar(50) NOT NULL,
  `Start_Time` datetime NOT NULL,
  `End_Time` datetime NOT NULL,
  `Route_Name` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Vehicles`
--

CREATE TABLE `Vehicles` (
  `ID` int(11) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Operating_Area` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Warehouses`
--

CREATE TABLE `Warehouses` (
  `ID` int(11) NOT NULL,
  `Street_Address` varchar(50) NOT NULL,
  `City` varchar(20) NOT NULL,
  `Postcode` varchar(7) NOT NULL,
  `Size` float NOT NULL,
  `Purpose` varchar(20) NOT NULL,
  `Building_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Warehouse_Products`
--

CREATE TABLE `Warehouse_Products` (
  `Warehouse_ID` int(11) NOT NULL,
  `Product_ID` int(11) NOT NULL,
  `Quantity_Remaining` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Area`
--
ALTER TABLE `Area`
  ADD PRIMARY KEY (`Name`);

--
-- Indexes for table `Auditing_Employees_Table`
--
ALTER TABLE `Auditing_Employees_Table`
  ADD PRIMARY KEY (`Employee_Number_Deleted`);

--
-- Indexes for table `Building`
--
ALTER TABLE `Building`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Area_Name` (`Area_Name`);

--
-- Indexes for table `Complaints`
--
ALTER TABLE `Complaints`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `HR_ID` (`HR_ID`);

--
-- Indexes for table `Departments`
--
ALTER TABLE `Departments`
  ADD PRIMARY KEY (`Number`),
  ADD KEY `Name` (`Name`);

--
-- Indexes for table `Department_Details`
--
ALTER TABLE `Department_Details`
  ADD PRIMARY KEY (`Name`);

--
-- Indexes for table `Drivers`
--
ALTER TABLE `Drivers`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Employee_Number` (`Employee_Number`);

--
-- Indexes for table `Emergency_Contacts`
--
ALTER TABLE `Emergency_Contacts`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Employee_Number` (`Employee_Number`);

--
-- Indexes for table `Employees`
--
ALTER TABLE `Employees`
  ADD PRIMARY KEY (`Number`),
  ADD KEY `NIN` (`NIN`),
  ADD KEY `Department_Number` (`Department_Number`),
  ADD KEY `Manager_ID` (`Manager_ID`);

--
-- Indexes for table `Employee_Details`
--
ALTER TABLE `Employee_Details`
  ADD PRIMARY KEY (`NIN`);

--
-- Indexes for table `HR`
--
ALTER TABLE `HR`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Employee_Number` (`Employee_Number`),
  ADD KEY `Office_ID` (`Office_ID`);

--
-- Indexes for table `Management`
--
ALTER TABLE `Management`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Employee_Number` (`Employee_Number`),
  ADD KEY `Office_ID` (`Office_ID`);

--
-- Indexes for table `Managers`
--
ALTER TABLE `Managers`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Management_ID` (`Management_ID`);

--
-- Indexes for table `Offices`
--
ALTER TABLE `Offices`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Building_ID` (`Building_ID`);

--
-- Indexes for table `Ordered_Products`
--
ALTER TABLE `Ordered_Products`
  ADD PRIMARY KEY (`Order_ID`,`Product_ID`);

--
-- Indexes for table `Orders`
--
ALTER TABLE `Orders`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Route_Name` (`Route_Name`);

--
-- Indexes for table `Packagers`
--
ALTER TABLE `Packagers`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Employee_Number` (`Employee_Number`);

--
-- Indexes for table `Products`
--
ALTER TABLE `Products`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Reported_Drivers`
--
ALTER TABLE `Reported_Drivers`
  ADD PRIMARY KEY (`Warehouse_ID`,`Driver_ID`);

--
-- Indexes for table `Reported_Packagers`
--
ALTER TABLE `Reported_Packagers`
  ADD PRIMARY KEY (`Warehouse_ID`,`Packager_ID`);

--
-- Indexes for table `Routes`
--
ALTER TABLE `Routes`
  ADD PRIMARY KEY (`Name`),
  ADD KEY `Driver_ID` (`Driver_ID`),
  ADD KEY `Vehicle_ID` (`Vehicle_ID`);

--
-- Indexes for table `Stops`
--
ALTER TABLE `Stops`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Route_Name` (`Route_Name`);

--
-- Indexes for table `Vehicles`
--
ALTER TABLE `Vehicles`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Warehouses`
--
ALTER TABLE `Warehouses`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Building_ID` (`Building_ID`);

--
-- Indexes for table `Warehouse_Products`
--
ALTER TABLE `Warehouse_Products`
  ADD PRIMARY KEY (`Warehouse_ID`,`Product_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Building`
--
ALTER TABLE `Building`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `Complaints`
--
ALTER TABLE `Complaints`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Departments`
--
ALTER TABLE `Departments`
  MODIFY `Number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Drivers`
--
ALTER TABLE `Drivers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=225;

--
-- AUTO_INCREMENT for table `Emergency_Contacts`
--
ALTER TABLE `Emergency_Contacts`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=511;

--
-- AUTO_INCREMENT for table `HR`
--
ALTER TABLE `HR`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `Management`
--
ALTER TABLE `Management`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `Managers`
--
ALTER TABLE `Managers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `Offices`
--
ALTER TABLE `Offices`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `Orders`
--
ALTER TABLE `Orders`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Packagers`
--
ALTER TABLE `Packagers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=206;

--
-- AUTO_INCREMENT for table `Products`
--
ALTER TABLE `Products`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Stops`
--
ALTER TABLE `Stops`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Vehicles`
--
ALTER TABLE `Vehicles`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Warehouses`
--
ALTER TABLE `Warehouses`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Building`
--
ALTER TABLE `Building`
  ADD CONSTRAINT `Building_ibfk_1` FOREIGN KEY (`Area_Name`) REFERENCES `Area` (`Name`) ON UPDATE CASCADE;

--
-- Constraints for table `Complaints`
--
ALTER TABLE `Complaints`
  ADD CONSTRAINT `Complaints_ibfk_1` FOREIGN KEY (`HR_ID`) REFERENCES `HR` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `Departments`
--
ALTER TABLE `Departments`
  ADD CONSTRAINT `Departments_ibfk_1` FOREIGN KEY (`Name`) REFERENCES `Department_Details` (`Name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Drivers`
--
ALTER TABLE `Drivers`
  ADD CONSTRAINT `Drivers_ibfk_1` FOREIGN KEY (`Employee_Number`) REFERENCES `Employees` (`Number`) ON DELETE CASCADE;

--
-- Constraints for table `Emergency_Contacts`
--
ALTER TABLE `Emergency_Contacts`
  ADD CONSTRAINT `Emergency_Contacts_ibfk_1` FOREIGN KEY (`Employee_Number`) REFERENCES `Employees` (`Number`) ON DELETE CASCADE;

--
-- Constraints for table `Employees`
--
ALTER TABLE `Employees`
  ADD CONSTRAINT `Employees_ibfk_1` FOREIGN KEY (`NIN`) REFERENCES `Employee_Details` (`NIN`) ON DELETE CASCADE,
  ADD CONSTRAINT `Employees_ibfk_2` FOREIGN KEY (`Department_Number`) REFERENCES `Departments` (`Number`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Employees_ibfk_3` FOREIGN KEY (`Manager_ID`) REFERENCES `Managers` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `HR`
--
ALTER TABLE `HR`
  ADD CONSTRAINT `HR_ibfk_1` FOREIGN KEY (`Employee_Number`) REFERENCES `Employees` (`Number`) ON DELETE CASCADE,
  ADD CONSTRAINT `HR_ibfk_2` FOREIGN KEY (`Office_ID`) REFERENCES `Offices` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `Management`
--
ALTER TABLE `Management`
  ADD CONSTRAINT `Management_ibfk_1` FOREIGN KEY (`Employee_Number`) REFERENCES `Employees` (`Number`) ON DELETE CASCADE,
  ADD CONSTRAINT `Management_ibfk_2` FOREIGN KEY (`Office_ID`) REFERENCES `Offices` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `Managers`
--
ALTER TABLE `Managers`
  ADD CONSTRAINT `Managers_ibfk_1` FOREIGN KEY (`Management_ID`) REFERENCES `Management` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Offices`
--
ALTER TABLE `Offices`
  ADD CONSTRAINT `Offices_ibfk_1` FOREIGN KEY (`Building_ID`) REFERENCES `Building` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Orders`
--
ALTER TABLE `Orders`
  ADD CONSTRAINT `Orders_ibfk_1` FOREIGN KEY (`Route_Name`) REFERENCES `Routes` (`Name`) ON UPDATE CASCADE;

--
-- Constraints for table `Packagers`
--
ALTER TABLE `Packagers`
  ADD CONSTRAINT `Packagers_ibfk_1` FOREIGN KEY (`Employee_Number`) REFERENCES `Employees` (`Number`) ON DELETE CASCADE;

--
-- Constraints for table `Routes`
--
ALTER TABLE `Routes`
  ADD CONSTRAINT `Routes_ibfk_1` FOREIGN KEY (`Driver_ID`) REFERENCES `Drivers` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Routes_ibfk_2` FOREIGN KEY (`Vehicle_ID`) REFERENCES `Vehicles` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `Stops`
--
ALTER TABLE `Stops`
  ADD CONSTRAINT `Stops_ibfk_1` FOREIGN KEY (`Route_Name`) REFERENCES `Routes` (`Name`) ON UPDATE CASCADE;

--
-- Constraints for table `Warehouses`
--
ALTER TABLE `Warehouses`
  ADD CONSTRAINT `Warehouses_ibfk_1` FOREIGN KEY (`Building_ID`) REFERENCES `Building` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
