-- phpMyAdmin SQL Dump
-- version 3.5.8.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 14, 2015 at 09:39 AM
-- Server version: 5.5.29-0ubuntu1
-- PHP Version: 5.4.9-4ubuntu2.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `db_stasher`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_access_tokens`
--

CREATE TABLE IF NOT EXISTS `tbl_access_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mkey` varchar(50) NOT NULL,
  `mtoken` varchar(255) NOT NULL,
  `inserted_date` datetime NOT NULL,
  `status` enum('0','1','2') NOT NULL DEFAULT '2',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `tbl_access_tokens`
--

INSERT INTO `tbl_access_tokens` (`id`, `mkey`, `mtoken`, `inserted_date`, `status`) VALUES
(1, 'oabiphone', 'd4fhf576ggh895qqwh90', '2014-11-11 12:05:48', '2'),
(2, 'oabandroid', 'd4fhf576ggh895qqwh90', '2014-11-11 12:05:48', '2');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_badges`
--

CREATE TABLE IF NOT EXISTS `tbl_badges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `image` varchar(255) NOT NULL,
  `inserted_date` datetime NOT NULL,
  `status` enum('0','1','2') NOT NULL DEFAULT '2' COMMENT '0: logical delete;1: inactive;2:active',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `tbl_badges`
--

INSERT INTO `tbl_badges` (`id`, `parentId`, `title`, `image`, `inserted_date`, `status`) VALUES
(1, 1, 'Junior Agent / Rookie', '', '2015-01-06 00:00:00', '2'),
(2, 1, 'Training Day', '', '2015-01-06 00:00:00', '2'),
(3, 1, 'First Mission', '', '2015-01-06 00:00:00', '2'),
(4, 1, 'Busy Bee', '', '2015-01-06 00:00:00', '2'),
(5, 1, 'Master Stasher', '', '2015-03-27 10:33:41', '2');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_countries`
--

CREATE TABLE IF NOT EXISTS `tbl_countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_code` varchar(2) NOT NULL DEFAULT '',
  `country_name` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=243 ;

--
-- Dumping data for table `tbl_countries`
--

INSERT INTO `tbl_countries` (`id`, `country_code`, `country_name`) VALUES
(1, 'US', 'United States'),
(2, 'CA', 'Canada'),
(3, 'AF', 'Afghanistan'),
(4, 'AL', 'Albania'),
(5, 'DZ', 'Algeria'),
(6, 'DS', 'American Samoa'),
(7, 'AD', 'Andorra'),
(8, 'AO', 'Angola'),
(9, 'AI', 'Anguilla'),
(10, 'AQ', 'Antarctica'),
(11, 'AG', 'Antigua and/or Barbuda'),
(12, 'AR', 'Argentina'),
(13, 'AM', 'Armenia'),
(14, 'AW', 'Aruba'),
(15, 'AU', 'Australia'),
(16, 'AT', 'Austria'),
(17, 'AZ', 'Azerbaijan'),
(18, 'BS', 'Bahamas'),
(19, 'BH', 'Bahrain'),
(20, 'BD', 'Bangladesh'),
(21, 'BB', 'Barbados'),
(22, 'BY', 'Belarus'),
(23, 'BE', 'Belgium'),
(24, 'BZ', 'Belize'),
(25, 'BJ', 'Benin'),
(26, 'BM', 'Bermuda'),
(27, 'BT', 'Bhutan'),
(28, 'BO', 'Bolivia'),
(29, 'BA', 'Bosnia and Herzegovina'),
(30, 'BW', 'Botswana'),
(31, 'BV', 'Bouvet Island'),
(32, 'BR', 'Brazil'),
(33, 'IO', 'British lndian Ocean Territory'),
(34, 'BN', 'Brunei Darussalam'),
(35, 'BG', 'Bulgaria'),
(36, 'BF', 'Burkina Faso'),
(37, 'BI', 'Burundi'),
(38, 'KH', 'Cambodia'),
(39, 'CM', 'Cameroon'),
(40, 'CV', 'Cape Verde'),
(41, 'KY', 'Cayman Islands'),
(42, 'CF', 'Central African Republic'),
(43, 'TD', 'Chad'),
(44, 'CL', 'Chile'),
(45, 'CN', 'China'),
(46, 'CX', 'Christmas Island'),
(47, 'CC', 'Cocos (Keeling) Islands'),
(48, 'CO', 'Colombia'),
(49, 'KM', 'Comoros'),
(50, 'CG', 'Congo'),
(51, 'CK', 'Cook Islands'),
(52, 'CR', 'Costa Rica'),
(53, 'HR', 'Croatia (Hrvatska)'),
(54, 'CU', 'Cuba'),
(55, 'CY', 'Cyprus'),
(56, 'CZ', 'Czech Republic'),
(57, 'DK', 'Denmark'),
(58, 'DJ', 'Djibouti'),
(59, 'DM', 'Dominica'),
(60, 'DO', 'Dominican Republic'),
(61, 'TP', 'East Timor'),
(62, 'EC', 'Ecuador'),
(63, 'EG', 'Egypt'),
(64, 'SV', 'El Salvador'),
(65, 'GQ', 'Equatorial Guinea'),
(66, 'ER', 'Eritrea'),
(67, 'EE', 'Estonia'),
(68, 'ET', 'Ethiopia'),
(69, 'FK', 'Falkland Islands (Malvinas)'),
(70, 'FO', 'Faroe Islands'),
(71, 'FJ', 'Fiji'),
(72, 'FI', 'Finland'),
(73, 'FR', 'France'),
(74, 'FX', 'France, Metropolitan'),
(75, 'GF', 'French Guiana'),
(76, 'PF', 'French Polynesia'),
(77, 'TF', 'French Southern Territories'),
(78, 'GA', 'Gabon'),
(79, 'GM', 'Gambia'),
(80, 'GE', 'Georgia'),
(81, 'DE', 'Germany'),
(82, 'GH', 'Ghana'),
(83, 'GI', 'Gibraltar'),
(84, 'GR', 'Greece'),
(85, 'GL', 'Greenland'),
(86, 'GD', 'Grenada'),
(87, 'GP', 'Guadeloupe'),
(88, 'GU', 'Guam'),
(89, 'GT', 'Guatemala'),
(90, 'GN', 'Guinea'),
(91, 'GW', 'Guinea-Bissau'),
(92, 'GY', 'Guyana'),
(93, 'HT', 'Haiti'),
(94, 'HM', 'Heard and Mc Donald Islands'),
(95, 'HN', 'Honduras'),
(96, 'HK', 'Hong Kong'),
(97, 'HU', 'Hungary'),
(98, 'IS', 'Iceland'),
(99, 'IN', 'India'),
(100, 'ID', 'Indonesia'),
(101, 'IR', 'Iran (Islamic Republic of)'),
(102, 'IQ', 'Iraq'),
(103, 'IE', 'Ireland'),
(104, 'IL', 'Israel'),
(105, 'IT', 'Italy'),
(106, 'CI', 'Ivory Coast'),
(107, 'JM', 'Jamaica'),
(108, 'JP', 'Japan'),
(109, 'JO', 'Jordan'),
(110, 'KZ', 'Kazakhstan'),
(111, 'KE', 'Kenya'),
(112, 'KI', 'Kiribati'),
(113, 'KP', 'Korea, Democratic People''s Republic of'),
(114, 'KR', 'Korea, Republic of'),
(115, 'XK', 'Kosovo'),
(116, 'KW', 'Kuwait'),
(117, 'KG', 'Kyrgyzstan'),
(118, 'LA', 'Lao People''s Democratic Republic'),
(119, 'LV', 'Latvia'),
(120, 'LB', 'Lebanon'),
(121, 'LS', 'Lesotho'),
(122, 'LR', 'Liberia'),
(123, 'LY', 'Libyan Arab Jamahiriya'),
(124, 'LI', 'Liechtenstein'),
(125, 'LT', 'Lithuania'),
(126, 'LU', 'Luxembourg'),
(127, 'MO', 'Macau'),
(128, 'MK', 'Macedonia'),
(129, 'MG', 'Madagascar'),
(130, 'MW', 'Malawi'),
(131, 'MY', 'Malaysia'),
(132, 'MV', 'Maldives'),
(133, 'ML', 'Mali'),
(134, 'MT', 'Malta'),
(135, 'MH', 'Marshall Islands'),
(136, 'MQ', 'Martinique'),
(137, 'MR', 'Mauritania'),
(138, 'MU', 'Mauritius'),
(139, 'TY', 'Mayotte'),
(140, 'MX', 'Mexico'),
(141, 'FM', 'Micronesia, Federated States of'),
(142, 'MD', 'Moldova, Republic of'),
(143, 'MC', 'Monaco'),
(144, 'MN', 'Mongolia'),
(145, 'ME', 'Montenegro'),
(146, 'MS', 'Montserrat'),
(147, 'MA', 'Morocco'),
(148, 'MZ', 'Mozambique'),
(149, 'MM', 'Myanmar'),
(150, 'NA', 'Namibia'),
(151, 'NR', 'Nauru'),
(152, 'NP', 'Nepal'),
(153, 'NL', 'Netherlands'),
(154, 'AN', 'Netherlands Antilles'),
(155, 'NC', 'New Caledonia'),
(156, 'NZ', 'New Zealand'),
(157, 'NI', 'Nicaragua'),
(158, 'NE', 'Niger'),
(159, 'NG', 'Nigeria'),
(160, 'NU', 'Niue'),
(161, 'NF', 'Norfork Island'),
(162, 'MP', 'Northern Mariana Islands'),
(163, 'NO', 'Norway'),
(164, 'OM', 'Oman'),
(165, 'PK', 'Pakistan'),
(166, 'PW', 'Palau'),
(167, 'PA', 'Panama'),
(168, 'PG', 'Papua New Guinea'),
(169, 'PY', 'Paraguay'),
(170, 'PE', 'Peru'),
(171, 'PH', 'Philippines'),
(172, 'PN', 'Pitcairn'),
(173, 'PL', 'Poland'),
(174, 'PT', 'Portugal'),
(175, 'PR', 'Puerto Rico'),
(176, 'QA', 'Qatar'),
(177, 'RE', 'Reunion'),
(178, 'RO', 'Romania'),
(179, 'RU', 'Russian Federation'),
(180, 'RW', 'Rwanda'),
(181, 'KN', 'Saint Kitts and Nevis'),
(182, 'LC', 'Saint Lucia'),
(183, 'VC', 'Saint Vincent and the Grenadines'),
(184, 'WS', 'Samoa'),
(185, 'SM', 'San Marino'),
(186, 'ST', 'Sao Tome and Principe'),
(187, 'SA', 'Saudi Arabia'),
(188, 'SN', 'Senegal'),
(189, 'RS', 'Serbia'),
(190, 'SC', 'Seychelles'),
(191, 'SL', 'Sierra Leone'),
(192, 'SG', 'Singapore'),
(193, 'SK', 'Slovakia'),
(194, 'SI', 'Slovenia'),
(195, 'SB', 'Solomon Islands'),
(196, 'SO', 'Somalia'),
(197, 'ZA', 'South Africa'),
(198, 'GS', 'South Georgia South Sandwich Islands'),
(199, 'ES', 'Spain'),
(200, 'LK', 'Sri Lanka'),
(201, 'SH', 'St. Helena'),
(202, 'PM', 'St. Pierre and Miquelon'),
(203, 'SD', 'Sudan'),
(204, 'SR', 'Suriname'),
(205, 'SJ', 'Svalbarn and Jan Mayen Islands'),
(206, 'SZ', 'Swaziland'),
(207, 'SE', 'Sweden'),
(208, 'CH', 'Switzerland'),
(209, 'SY', 'Syrian Arab Republic'),
(210, 'TW', 'Taiwan'),
(211, 'TJ', 'Tajikistan'),
(212, 'TZ', 'Tanzania, United Republic of'),
(213, 'TH', 'Thailand'),
(214, 'TG', 'Togo'),
(215, 'TK', 'Tokelau'),
(216, 'TO', 'Tonga'),
(217, 'TT', 'Trinidad and Tobago'),
(218, 'TN', 'Tunisia'),
(219, 'TR', 'Turkey'),
(220, 'TM', 'Turkmenistan'),
(221, 'TC', 'Turks and Caicos Islands'),
(222, 'TV', 'Tuvalu'),
(223, 'UG', 'Uganda'),
(224, 'UA', 'Ukraine'),
(225, 'AE', 'United Arab Emirates'),
(226, 'GB', 'United Kingdom'),
(227, 'UM', 'United States minor outlying islands'),
(228, 'UY', 'Uruguay'),
(229, 'UZ', 'Uzbekistan'),
(230, 'VU', 'Vanuatu'),
(231, 'VA', 'Vatican City State'),
(232, 'VE', 'Venezuela'),
(233, 'VN', 'Vietnam'),
(234, 'VG', 'Virgin Islands (British)'),
(235, 'VI', 'Virgin Islands (U.S.)'),
(236, 'WF', 'Wallis and Futuna Islands'),
(237, 'EH', 'Western Sahara'),
(238, 'YE', 'Yemen'),
(239, 'YU', 'Yugoslavia'),
(240, 'ZR', 'Zaire'),
(241, 'ZM', 'Zambia'),
(242, 'ZW', 'Zimbabwe');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_emailtemplates`
--

CREATE TABLE IF NOT EXISTS `tbl_emailtemplates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email_from` varchar(50) NOT NULL,
  `email_from_name` varchar(50) NOT NULL,
  `email_subject` varchar(255) NOT NULL,
  `email_content` text NOT NULL,
  `title` varchar(50) NOT NULL,
  `inserted_date` datetime NOT NULL,
  `status` enum('0','1','2') NOT NULL DEFAULT '2' COMMENT '0: logical delete , 1 : inactive ; 2 : active',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `tbl_emailtemplates`
--

INSERT INTO `tbl_emailtemplates` (`id`, `email_from`, `email_from_name`, `email_subject`, `email_content`, `title`, `inserted_date`, `status`) VALUES
(1, 'admin@stasher.com', 'Admin', 'Welcome to stasher', '<table width="760" align="center">\r\n	<tr height="200" bgcolor="#05ae54" align="center">\r\n    	<td>\r\n        	[LOGO]\r\n        </td>\r\n    </tr>\r\n    <tr>\r\n    	<td>\r\n        	<table cellpadding="5" cellspacing="5" style="font-family:Arial, Helvetica, sans-serif; font-size:14px; color:#444;">\r\n            	<tr>\r\n                	<td>\r\n                    	<strong>Hi [NAME],</strong>\r\n                    </td>\r\n                </tr>\r\n                <tr>\r\n                	<td>Thank for registration. Please check following details to access your account:\r\n                    </td>\r\n                </tr>\r\n                <tr>\r\n                	<td>\r\n                    	<strong>USERNAME: [USERNAME]</strong>\r\n                    </td>\r\n                </tr>\r\n                <tr>\r\n                	<td>\r\n                    	<strong>EMAIL: [EMAIL]</strong>\r\n                    </td>\r\n                </tr>\r\n                <tr>\r\n                	<td>\r\n                    	<strong>PASSWORD: [PASSWORD]</strong>\r\n                    </td>\r\n                </tr>\r\n            </table>\r\n        </td>\r\n    </tr>\r\n</table>\r\n', 'User Registration from front end', '2014-11-11 15:19:38', '2'),
(2, 'admin@stasher.com', 'Admin', 'Don''t remember your password?', '<table>\r\n<tr>\r\n	<td>\r\n		[LOGO]\r\n	</td>\r\n</tr>\r\n<tr>\r\n	<td>Hi [NAME]</td>\r\n</tr>\r\n<tr>\r\n	<td>\r\n		I think you forgot your password.You can access your account by new password: \r\n		<p>Passwors : [PASSWORD]</p>\r\n	</td>\r\n</tr>\r\n</table>', 'forgot password', '2014-06-25 12:52:08', '2'),
(3, 'admin@stasher.com', 'Admin', 'New password is here', '<table>\r\n<tr>\r\n	<td>\r\n		[LOGO]\r\n	</td>\r\n</tr>\r\n<tr>\r\n	<td>Hi [NAME]</td>\r\n</tr>\r\n<tr>\r\n	<td>\r\n		You can access your account by new password: \r\n		<p>Password : [PASSWORD]</p>\r\n	</td>\r\n</tr>\r\n</table>', 'New Password', '2015-04-30 00:00:00', '2');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_faq`
--

CREATE TABLE IF NOT EXISTS `tbl_faq` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(255) NOT NULL,
  `answer` varchar(255) NOT NULL,
  `inserted_date` datetime NOT NULL,
  `status` enum('0','1','2') NOT NULL DEFAULT '2' COMMENT '0: logical delete ;1: inactive ; 2:active',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `tbl_faq`
--

INSERT INTO `tbl_faq` (`id`, `question`, `answer`, `inserted_date`, `status`) VALUES
(1, 'que1', 'ans1', '2014-09-13 02:39:41', '2'),
(2, 'que2', 'ans2', '2014-09-13 02:39:43', '2');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_fund_requests`
--

CREATE TABLE IF NOT EXISTS `tbl_fund_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `childId` int(11) NOT NULL,
  `parentId` int(11) NOT NULL,
  `price` float(10,2) NOT NULL,
  `description` varchar(255) NOT NULL,
  `inserted_date` datetime NOT NULL,
  `status` enum('0','1','2') NOT NULL COMMENT '0:logical delete ;1 : rejected ; 2: accepted',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=32 ;

--
-- Dumping data for table `tbl_fund_requests`
--

INSERT INTO `tbl_fund_requests` (`id`, `childId`, `parentId`, `price`, `description`, `inserted_date`, `status`) VALUES
(31, 135, 141, 0.00, '10', '2015-06-15 22:43:10', '2'),
(30, 121, 132, 0.00, '1', '2015-03-11 02:58:37', '2'),
(29, 137, 136, 0.00, '10', '2015-03-07 23:13:25', '2'),
(28, 135, 133, 0.00, '1', '2015-03-05 15:56:42', '2'),
(27, 121, 120, 0.00, '10', '2015-03-03 16:47:16', '2');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_invites`
--

CREATE TABLE IF NOT EXISTS `tbl_invites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `missionId` int(11) NOT NULL,
  `agentId` int(11) NOT NULL,
  `invitation_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_missions`
--

CREATE TABLE IF NOT EXISTS `tbl_missions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) NOT NULL,
  `childId` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `location` varchar(100) NOT NULL,
  `incentive` varchar(100) NOT NULL,
  `isTimebase` enum('yes','no') NOT NULL DEFAULT 'yes',
  `totaltime` datetime NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `rewardtype` enum('cash','gift') NOT NULL DEFAULT 'cash',
  `rewards` varchar(255) NOT NULL,
  `alert_type` enum('1','2','3','4') NOT NULL COMMENT '1: Daily; 2:  Every Week;3: Once a month,;4:Once a year',
  `repeat_type` enum('1','2','3','4') NOT NULL COMMENT '1: None;2: At time of due date;3: 1 hour before;4: 2 days before',
  `inserted_date` datetime NOT NULL,
  `isPublic` enum('yes','no') NOT NULL DEFAULT 'no',
  `status` enum('0','1','2','3','4','5') NOT NULL DEFAULT '1' COMMENT '0: Logocal delete;1: draft ; 2: public and child accpted it ;3: closedsh;4: public but child not accepted yet;5: completed by child',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=111 ;

--
-- Dumping data for table `tbl_missions`
--

INSERT INTO `tbl_missions` (`id`, `parentId`, `childId`, `title`, `description`, `location`, `incentive`, `isTimebase`, `totaltime`, `start_time`, `end_time`, `rewardtype`, `rewards`, `alert_type`, `repeat_type`, `inserted_date`, `isPublic`, `status`) VALUES
(106, 147, 134, 'Get A''s on your final exams', 'You must get all A''s, no B''s', '', '', 'yes', '2015-05-07 18:00:00', '2015-05-03 09:09:59', '2015-05-07 18:00:00', 'gift', 'Drinks on me', '1', '1', '2015-05-03 09:09:59', 'no', '4'),
(104, 162, 170, 'Bed room cleaning', 'New mission added by Pluts Oab', '', '', 'yes', '1970-01-01 00:00:00', '2015-04-30 18:48:32', '1970-01-01 00:00:00', 'cash', '100', '1', '1', '2015-04-30 18:48:32', 'yes', '4'),
(103, 162, 172, 'Bed room cleaning', 'New mission added by Pluts Oab', '', '', 'yes', '1970-01-01 00:00:00', '2015-04-30 18:48:32', '1970-01-01 00:00:00', 'cash', '100', '1', '1', '2015-04-30 18:48:32', 'yes', '4'),
(100, 141, 135, 'Do homework', 'Do homework on time', '', '', 'yes', '2015-04-29 19:00:00', '2015-04-29 23:19:15', '2015-04-29 19:00:00', 'cash', '10', '1', '1', '2015-04-29 18:17:44', 'yes', '5'),
(98, 120, 121, 'mission_vip', 'test describe', '', '', 'yes', '2015-04-22 18:53:09', '2015-04-20 13:49:41', '2015-04-22 18:53:09', 'cash', '2.50', '1', '1', '2015-04-20 19:18:17', 'yes', '5'),
(94, 120, 121, 'mission test b1', 'mission for childtest1', '', '', 'yes', '2015-03-21 14:52:00', '2015-03-19 14:52:53', '2015-03-21 14:52:00', 'cash', '5', '1', '1', '2015-03-19 14:52:53', 'yes', '0'),
(93, 120, 121, 'Gauche', 'Fixing cocky', '', '', 'yes', '1970-01-01 00:00:00', '2015-03-16 18:43:12', '1970-01-01 00:00:00', 'cash', '100', '1', '1', '2015-03-16 18:43:12', 'yes', '0'),
(92, 120, 121, 'Mission 7pm2 min', 'This is done100', '', '', 'yes', '1970-01-01 00:00:00', '2015-03-16 18:40:38', '1970-01-01 00:00:00', 'cash', '100', '1', '1', '2015-03-16 18:40:38', 'yes', '5'),
(85, 120, 121, 'Test mission 1', '', '', '', 'yes', '2015-03-10 23:27:00', '2015-03-10 20:28:03', '2015-03-10 23:27:00', 'gift', 'gift', '1', '1', '2015-03-10 20:28:03', 'yes', '0'),
(63, 120, 121, 'mission oab3', 'Enter description (Optional)', '', '', 'yes', '0000-00-00 00:00:00', '2015-03-09 12:52:18', '0000-00-00 00:00:00', 'cash', '5', '1', '1', '2015-03-09 06:37:25', 'yes', '0'),
(64, 120, 121, 'mission oab3', 'Enter description (Optional)', '', '', 'yes', '0000-00-00 00:00:00', '2015-03-09 12:53:29', '0000-00-00 00:00:00', 'cash', '5', '1', '1', '2015-03-09 06:37:57', 'yes', '0'),
(61, 120, 121, 'mission oab3', 'Enter description (Optional)', '', '', 'yes', '0000-00-00 00:00:00', '2015-03-09 12:58:41', '0000-00-00 00:00:00', 'cash', '5', '1', '1', '2015-03-09 06:36:26', 'yes', '0'),
(60, 136, 137, 'Drink your drink', 'Get another drink, you are weak', '', '', 'yes', '2015-03-08 17:34:44', '2015-03-07 22:38:13', '2015-03-08 17:34:44', 'cash', '1.50', '1', '1', '2015-03-07 22:38:13', 'no', '2'),
(59, 136, 137, 'Drink your drink', 'Get another drink, you are weak', '', '', 'yes', '2015-03-08 17:34:44', '2015-03-07 22:38:04', '2015-03-08 17:34:44', 'cash', '1.50', '1', '1', '2015-03-07 22:38:04', 'no', '2'),
(55, 133, 135, 'Test', 'Enter description (Optional)', '', '', 'no', '0000-00-00 00:00:00', '2015-03-05 16:01:21', '1970-01-01 00:00:00', 'gift', 'love ', '1', '1', '2015-03-05 16:01:21', 'yes', '3'),
(105, 162, 171, 'Complete homework', 'Need your home work completed in 2 hrs', '', '', 'yes', '1970-01-01 00:00:00', '2015-04-30 18:49:30', '1970-01-01 00:00:00', 'cash', '10', '1', '1', '2015-04-30 18:49:30', 'yes', '4'),
(102, 162, 171, 'Bed room cleaning', 'New mission added by Pluts Oab', '', '', 'yes', '1970-01-01 00:00:00', '2015-04-30 18:48:32', '1970-01-01 00:00:00', 'cash', '100', '1', '1', '2015-04-30 18:48:32', 'yes', '4'),
(101, 162, 173, 'Bed room cleaning', 'I need your bedroom clean from your side in next 3 hrs ', '', '', 'yes', '1970-01-01 00:00:00', '2015-04-30 18:48:32', '1970-01-01 00:00:00', 'cash', '100', '1', '1', '2015-04-30 18:48:32', 'yes', '4'),
(99, 141, 135, 'Do homework math', '', '', '', 'yes', '2015-04-29 13:32:00', '2015-04-27 17:36:12', '2015-04-29 13:32:00', 'cash', '2.50', '1', '1', '2015-04-27 13:34:43', 'yes', '5'),
(97, 141, 135, 'Take out the trash', '', '', '', 'yes', '2015-04-18 12:00:28', '2015-04-16 16:41:12', '2015-04-18 12:00:28', 'cash', '1', '1', '1', '2015-04-16 12:39:51', 'yes', '5'),
(96, 141, 135, 'Limpiar el cuarto', '', '', '', 'yes', '2015-03-26 18:53:00', '2015-03-25 18:53:27', '2015-03-26 18:53:00', 'cash', '1.00', '1', '1', '2015-03-25 18:53:27', 'yes', '5'),
(95, 120, 142, 'Childtest1 mission title', 'mission description for childtest1 afsjgh asfajsfb afjj asfjaf adfaj', '', '', 'yes', '2015-04-23 15:51:02', '2015-04-20 09:24:58', '2015-04-23 15:51:02', 'cash', '10', '1', '1', '2015-04-20 14:53:34', 'yes', '4'),
(91, 120, 121, 'Missing 13 March 7 pm', 'Clean the car', '', '', 'yes', '1970-01-01 00:00:00', '2015-03-16 18:37:53', '1970-01-01 00:00:00', 'cash', '10', '1', '1', '2015-03-16 18:37:53', 'yes', '0'),
(90, 120, 121, 'Mission1arch', 'Clean the office', '', '', 'no', '0000-00-00 00:00:00', '2015-03-16 18:36:19', '1970-01-01 00:00:00', 'cash', '10', '1', '1', '2015-03-16 18:36:19', 'yes', '0'),
(89, 120, 134, 'Test', 'Test it', '', '', 'yes', '2015-04-22 10:32:03', '2015-04-20 14:34:24', '2015-04-22 10:32:03', 'gift', 'love', '1', '1', '2015-04-20 10:33:00', 'yes', '4'),
(88, 141, 135, 'Get straight As', 'You can do it', '', '', 'yes', '2015-03-22 12:00:13', '2015-03-13 12:12:23', '2015-03-22 12:00:13', 'cash', '10', '1', '1', '2015-03-13 12:12:23', 'yes', '5'),
(87, 120, 121, 'mission test on 13 march 6.45', '', '', '', 'yes', '2015-03-14 18:45:00', '2015-03-13 18:45:46', '2015-03-14 18:45:00', 'cash', '10', '1', '1', '2015-03-13 18:45:46', 'yes', '3'),
(86, 120, 121, 'Mission 7.17', '', '', '', 'yes', '2015-03-13 19:42:15', '2015-03-12 14:13:22', '2015-03-13 19:42:15', 'cash', '5', '1', '1', '2015-03-12 19:42:29', 'yes', '5'),
(62, 120, 121, 'mission oab3', 'Enter description (Optional)', '', '', 'yes', '2015-03-11 12:04:38', '2015-03-09 06:36:37', '2015-03-11 12:04:38', 'cash', '5', '1', '1', '2015-03-09 06:36:37', 'yes', '0'),
(58, 136, 137, 'Drink your drink', 'Get another drink, you are weak', '', '', 'yes', '2015-03-08 17:34:44', '2015-03-07 22:38:02', '2015-03-08 17:34:44', 'cash', '1.50', '1', '1', '2015-03-07 22:38:02', 'no', '4'),
(57, 133, 135, 'Test', 'Enter description (Optional)', '', '', 'no', '0000-00-00 00:00:00', '2015-03-05 16:01:39', '1970-01-01 00:00:00', 'gift', 'love ', '1', '1', '2015-03-05 16:01:39', 'yes', '5'),
(56, 133, 135, 'Test 1', 'Enter description (Optional)', '', '', 'no', '0000-00-00 00:00:00', '2015-03-10 03:45:30', '2015-03-13 23:44:25', 'cash', '1.00', '1', '1', '2015-03-05 16:01:22', 'yes', '5'),
(54, 133, 135, 'Test', 'Enter description (Optional)', '', '', 'no', '0000-00-00 00:00:00', '2015-03-05 16:01:20', '1970-01-01 00:00:00', 'gift', 'love ', '1', '1', '2015-03-05 16:01:20', 'yes', '5'),
(53, 133, 135, 'Test', 'Enter description (Optional)', '', '', 'no', '0000-00-00 00:00:00', '2015-03-05 16:01:18', '1970-01-01 00:00:00', 'gift', 'love ', '1', '1', '2015-03-05 16:01:18', 'yes', '5'),
(52, 133, 135, 'Test', 'Enter description (Optional)', '', '', 'no', '0000-00-00 00:00:00', '2015-03-05 16:01:16', '1970-01-01 00:00:00', 'gift', 'love ', '1', '1', '2015-03-05 16:01:16', 'yes', '5'),
(51, 120, 121, 'Mission Test2', 'Enter description (Optional)', '', '', 'yes', '0000-00-00 00:00:00', '2015-03-09 13:35:53', '0000-00-00 00:00:00', 'cash', '20', '1', '1', '2015-02-27 10:13:38', 'yes', '5'),
(50, 120, 121, 'Mission Test1', 'Enter description (Optional)', '', '', 'yes', '2015-03-01 15:32:41', '2015-03-10 06:08:16', '2015-03-01 15:32:41', 'cash', '10', '1', '1', '2015-02-27 10:04:51', 'yes', '5'),
(49, 122, 123, 'Cleaning task', 'Clean the bedrooms ', '', '', 'yes', '2015-02-28 13:18:12', '2015-02-27 07:51:09', '2015-02-28 13:18:12', 'cash', '25', '1', '1', '2015-02-27 07:51:09', 'yes', '2'),
(107, 127, 121, 'Take out trash', '', '', '', 'yes', '2015-05-08 04:11:00', '2015-05-07 16:12:09', '2015-05-08 04:11:00', 'cash', '1', '1', '1', '2015-05-07 16:12:09', 'yes', '5'),
(108, 141, 135, 'Test 0.22', '', '', '', 'yes', '2015-05-14 06:12:00', '2015-05-13 18:12:45', '2015-05-14 06:12:00', 'cash', '1', '1', '1', '2015-05-13 18:12:45', 'yes', '5'),
(109, 127, 121, 'take out the trash', 'take out the trash', '', '', 'yes', '2015-05-28 03:30:00', '2015-05-27 15:30:24', '2015-05-28 03:30:00', 'cash', '1', '1', '1', '2015-05-27 15:30:24', 'yes', '5'),
(110, 141, 135, 'Take out trash', '', '', '', 'yes', '2015-06-18 06:37:00', '2015-06-15 18:37:57', '2015-06-18 06:37:00', 'cash', '1', '1', '1', '2015-06-15 18:37:57', 'yes', '5');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_mission_tasks`
--

CREATE TABLE IF NOT EXISTS `tbl_mission_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `missionId` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `status` enum('0','1','2') NOT NULL COMMENT '0: logical delete ;1: inactive ; 2:active',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_notes`
--

CREATE TABLE IF NOT EXISTS `tbl_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) NOT NULL,
  `missionId` int(11) NOT NULL,
  `childId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `inserted_date` datetime NOT NULL,
  `status` enum('0','1','2') NOT NULL DEFAULT '2' COMMENT '0: logical delete;1: inactive; 2: active',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `tbl_notes`
--

INSERT INTO `tbl_notes` (`id`, `parentId`, `missionId`, `childId`, `message`, `inserted_date`, `status`) VALUES
(6, 120, 89, 134, 'Hurry up', '2015-05-08 14:17:36', '2');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pages`
--

CREATE TABLE IF NOT EXISTS `tbl_pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_title` varchar(255) NOT NULL,
  `page_content` text NOT NULL,
  `meta_title` varchar(255) NOT NULL,
  `meta_description` varchar(255) NOT NULL,
  `inserted_date` datetime NOT NULL,
  `status` enum('0','1','2') NOT NULL DEFAULT '2' COMMENT '0: logical delete , 1 : inactive ; 2 : active',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `tbl_pages`
--

INSERT INTO `tbl_pages` (`id`, `page_title`, `page_content`, `meta_title`, `meta_description`, `inserted_date`, `status`) VALUES
(1, 'About Us12', '<p>12 Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum condimentum magna et lectus eleifend laoreet? Nullam non elit vel libero varius consequat. Fusce viverra vel justo id aliquet? Maecenas venenatis metus mauris, in fermentum posuere.</p>\r\n', 'About Us', 'About Us', '2014-09-13 02:31:36', '2'),
(2, 'Tems Of Use', 'User Agreement\r\nDate Last Revised for Stasher: March 1, 2015\r\nGeneral Terms\r\nThis User Agreement (“Agreement)” is a contract between you and Stasher Inc. (“Stasher”) and sets forth the terms and conditions that apply to your access and use of Stasher’s services, including the Stasher App and associated website (the “Services”) as owned and operated by Stasher.\r\nAs used in this Agreement, the term "Sites" includes all pages and content provided by Stasher that are associated with the Services that Stasher operates or offers that link to this Agreement. By installing, accessing or using the Services, you agree that you have read and agree to be bound by the terms and conditions of this Agreement and the Stasher Privacy Policy, which is available at www.stasherapp.com and is incorporated in this Agreement by this reference, as they may be amended from time to time in the future (see “Modifications” below). If you do not agree to this Agreement, then you may not use the Services.\r\n1. Accepting the Terms\r\nBy using the information, tools, features, software and functionality including content, updates and new releases provided by Stasher, you agree to be bound by this Agreement, whether you are a “Visitor” (which means that you simply browse the Sites) or a “Member” (which means that you have registered with Stasher). The term “you” or “User” refers to a Visitor or Member. The term “we” refers to Stasher. If you wish to become a Member, communicate with other Members, or make use of the Services, you must read this Agreement and indicate your acceptance during the registration process.\r\nIf you accept this Agreement, you represent that you have the capacity to be bound by it or if you are acting on behalf of a company or entity that you have the authority to bind such entity.\r\n2. Privacy and your Personal Information\r\nYou agree to the applicable Stasher Privacy Policy, and any changes published by Stasher. You agree that Stasher may use and maintain your data according to the Stasher’s Privacy Policy, as part of the Services. You give Stasher permission to combine information you enter or upload for the Services with that of other users of the Services and/or other Stasher services. For example, this means that Stasher may use your and other users’ non-identifiable, aggregated data to improve the Services or to design promotions.\r\n3. Service-Specific Terms for the Stasher App\r\nThe Stasher App is a personal finance and payment service that helps Users, depending on the age of the User and type of account, with at least one of the following: a) make payments to third parties, b) accept payments from third parties, and c) track and monitor linked bank account activity. You may use the Stasher App on your mobile device. The Services may also present you information relating to third party products or services (“Stasher Offers”), as well as provide you general tips, recommendations and educational material.\r\nStasher itself is not a licensed money transmitter and we partner with a third-party payment processor, which is responsible for the handling of funds and the proper completion of transactions initiated with the Stasher App.  Stasher has no responsibility for the actions of any transfer recipient or for the subject of any transfer. We do not guarantee the identity of any Stasher App user or that a sender or a recipient can or will complete a transaction.\r\nA)	Eligibility and Account Registration\r\nCurrently, you may only use the Stasher App in the United States. To be eligible for using the Stasher App, you must create an account with a cellular/wireless telephone number that you own. You may also initiate account registration by connecting with your Facebook account, however, we still need additional information to create your account. As further detailed in our Privacy Policy, in order to register, create and use an account, Stasher may require that you submit certain Personal Information (as defined in the Privacy Policy). \r\nB) Types of Accounts\r\nWe offer three types of Personal accounts: Secret Agent, Commander and Ally. A Secret Agent account has the ability to receive funds into a linked bank account. A Secret Agent account does not have the ability to transfer funds nor does it have access to or the ability to enter financial or bank account information, unless the User of such account is at least 18 years of age. A Commander account is for Users at least 18 years of age and has the ability to transfer and receive funds. An Ally account is for Users at least 18 years of age and has the ability to transfer funds. We may allow certain third-parties to become Users and operate an Ally account as a Business account.\r\nSome features of Personal accounts may be limited based on how you wish to use the Service, how much you need to send or receive and what we know about you. We may require any User to provide more information in order to complete a transaction.\r\nC) Identity Authentication\r\nYou hereby authorize Stasher, directly or through third parties, to make any inquiries we consider necessary to validate your identity and/or authenticate your identity and account information. This may include asking you for further information and/or documentation about your account usage or identity, or requiring you to take steps to confirm ownership of your email address, wireless/cellular telephone number or financial instruments, and verifying your information against third party databases or through other sources. This process is for internal verification purposes.\r\nD) Transaction History\r\nYou may view your transaction history by logging into your Stasher App. You agree to review your transaction history through your online account instead of receiving periodic statements by mail.\r\nE) Sending Money\r\nWe may, at our discretion, impose limits on the amount of money you can send or receive through the Stasher App. We may increase your sending and/or receiving limits upon special request. These limits may change from time to time in Stasher''s sole discretion.\r\nWhen you make a payment on the Stasher App, you fund the payment with a bank account. In doing so, you are requesting that we initiate on your behalf an electronic transfer from your bank account in the amount you specify, which is completed by our third party payment processor.\r\nWhen you send money, the recipient is not required to accept it. You agree that you will not hold Stasher liable for any damages resulting from a recipient’s decision not to accept a payment made through the Services.\r\nYou may use the Stasher App without charge to send money with transactions funded by a bank account. Our fees may change from time to time in Stasher’s sole discretion. You are subject to third party fees, such as insufficient fund fees, reversal, or ACH insufficient fund fees that a bank may charge if your payment is rejected.\r\nF) Closing Your Account\r\nYou may close your account at any time. You may close your account by logging in to your account, clicking on “My Account”, clicking on “Delete Account”, and then following the instructions.\r\nYou may not close your account to evade a payment investigation. You will remain liable for all obligations related to your account even after the account is closed.\r\nG) Termination\r\nUpon termination of this Agreement for any reason, we have the right to prohibit your access to the Stasher App, including without limitation by deactivating your username and password, and to refuse future access to the Stasher App by you.\r\n4. Account Information from Third Party Sites\r\nUsers may direct Stasher to retrieve their own information maintained online by third-parties with which they have customer relationships, maintain accounts or engage in financial transactions (“Account Information”). Stasher works with one or more online service providers to access this Account Information. Stasher makes no effort to review the Account Information for any purpose, including but not limited to accuracy, legality or non-infringement. Stasher is not responsible for the products and services offered by or on third-party sites.\r\nStasher cannot always foresee or anticipate technical or other difficulties which may result in failure to obtain data or loss of data, personalization settings or other service interruptions. Stasher cannot assume responsibility for the timeliness, accuracy, deletion, non-delivery or failure to store any user data, communications or personalization settings. For example, when displayed through the Services, Account Information is only as fresh as the time shown, which reflects when the information is obtained from such sites. Such information may be more up-to-date when obtained directly from the relevant sites.\r\n5. Stasher Offers and Third-Party Links\r\nThere may be some parts of the Services that will be supported by sponsored links from advertisers and display Stasher Offers that may be custom matched to you based on information stored in the Services, queries made through the Services or other information. We will always disclose when a particular Stasher Offer is sponsored.\r\nIn connection with Stasher Offers, the Services will provide links to other web sites belonging to Stasher advertisers and other third parties. Stasher does not endorse, warrant or guarantee the products or services available through the Stasher Offers (or any other third-party products or services advertised on or linked from our site), whether or not sponsored, and Stasher is not an agent or broker or otherwise responsible for the activities or policies of those web sites. Stasher does not guarantee that the bank account or other service terms, rates or rewards offered by any particular advertiser or other third party on the Sites are actually the terms that may be offered to you if you pursue the offer or that they are the best terms or lowest rates available in the market.\r\nIf you elect to use or purchase services from third parties, you are subject to their terms and conditions and privacy policy.\r\n6. Your Registration Information\r\nIn order to allow you to use the Services, you will need to sign up for an account with Stasher. We may verify your identity. You authorize us to make any inquiries we consider necessary to validate your identity. These inquiries may include asking you for further information, requiring you to provide your full address, your social security number and/or requiring you to take steps to confirm ownership of your email address or financial instruments, or verifying information you provide against third party databases or through other sources. If you do not provide this information or Stasher cannot verify your identity, we can refuse to allow you to use the Services.\r\nYou agree and understand that you are responsible for maintaining the confidentiality of your password which, together with your username and/or e-mail address, allows you to access the Sites. That username and password, together with any mobile number or other information you provide, form your “Registration Information.” By providing us with your e-mail address, you agree to receive all required notices electronically, through the Services by displaying links to notices generally on the Site, to that e-mail address. It is your responsibility to update or change that address, as appropriate. Notices will be provided in HTML (or, if your system does not support HTML, in plain-text) in the text of the e-mail or through a link to the appropriate page on our site, accessible through any standard, commercially available internet browser.\r\nIf you become aware of any unauthorized use of your Registration or Account Information for the Services, you agree to notify Stasher immediately at the email address – bianca@stasherapp.com. \r\nIf you believe that your Registration or Account Information or device that you use to access the Services has been lost or stolen, that someone is using your account without your permission, or that an unauthorized transfer has occurred, you must notify Stasher immediately in order to minimize your possible losses.\r\nThe following is Stasher’s contact information:\r\nTelephone: 786-239-1547\r\nEmail: bianca@stasherapp.com\r\nAddress: 40 Morton Street, Apt 1A, New York, NY 10014\r\n7. Your Use of the Services\r\nYour right to access and use the Sites and the Services is personal to you and is not transferable by you to any other person or entity. You are only entitled to access and use the Sites and Services for lawful purposes. Accurate records enable Stasher to provide the Services to you. You must provide true, accurate, current and complete information about your accounts maintained at other web sites, as requested in our “Add Account” setup forms, and you may not misrepresent your Registration and Account Information. In order for the Services to function effectively, you must also keep your Registration and Account Information up to date and accurate. If you do not do this, the accuracy and effectiveness of the Services will be affected. You represent that you are a legal owner of, and that you are authorized to provide us with, all Registration and Account Information and other information necessary to facilitate your use of the Services.\r\nYour access and use of the Services may be interrupted from time to time for any of several reasons, including, without limitation, the malfunction of equipment, periodic updating, maintenance or repair of the Services or other actions that Stasher, in its sole discretion, may elect to take. In no event will Stasher be liable to any party for any loss, cost, or damage that results from any scheduled or unscheduled downtime.\r\nYour sole and exclusive remedy for any failure or non-performance of the Services, including any associated software or other materials supplied in connection with such services, shall be for Stasher to use commercially reasonable efforts to effectuate an adjustment or repair of the applicable service.\r\n8. Use With Your Mobile Device\r\nUse of these Services are made available through a compatible mobile device, Internet and/or network access and may require software. You agree that you are solely responsible for these requirements, including any applicable changes, updates and fees as well as the terms of your agreement with your mobile device and telecommunications provider. STASHER MAKES NO WARRANTIES OR REPRESENTATIONS OF ANY KIND, EXPRESS, STATUTORY OR IMPLIED AS TO: (i) THE AVAILABILITY OF TELECOMMUNICATION SERVICES FROM YOUR PROVIDER AND ACCESS TO THE SERVICES AT ANY TIME OR FROM ANY LOCATION; (ii) ANY LOSS, DAMAGE, OR OTHER SECURITY INTRUSION OF THE TELECOMMUNICATION SERVICES; AND (iii) ANY DISCLOSURE OF INFORMATION TO THIRD PARTIES OR FAILURE TO TRANSMIT ANY DATA, COMMUNICATIONS OR SETTINGS CONNECTED WITH THE SERVICES.\r\n9. Online and Mobile Alerts\r\nStasher may from time to time provide automatic alerts and voluntary account-related alerts. Automatic alerts may be sent to you following certain changes to your account or information, such as a change in your Registration Information.\r\nVoluntary account alerts may be turned on by default as part of the Services. They may then be customized, deactivated or reactivated by you. These alerts allow you to choose alert messages for your accounts. Stasher may add new alerts from time to time, or cease to provide certain alerts at any time upon its sole discretion. Each alert has different options available, and you may be asked to select from among these options upon activation of your alerts service.\r\nYou understand and agree that any alerts provided to you through the Services may be delayed or prevented by a variety of factors. Stasher may make commercially reasonable efforts to provide alerts in a timely manner with accurate information, but cannot guarantee the delivery, timeliness, or accuracy of the content of any alert. Stasher shall not be liable for any delays, failure to deliver, or misdirected delivery of any alert; for any errors in the content of an alert; or for any actions taken or not taken by you or any third party in reliance on an alert.\r\nElectronic alerts may be sent to the email address you have provided as your primary email address for the Services. If your email address or your mobile device’s email address changes, you are responsible for informing us of that change. You may also choose to have alerts sent to a mobile device that accepts text messages. Changes to your email address or mobile number will apply to all of your alerts.\r\nBecause alerts are not encrypted, we will never include your passcode. However, alerts may include your username and some information about your accounts. Depending upon which alerts you select, information such as account activity may be included. Anyone with access to your email will be able to view the content of these alerts. At any time you may disable future alerts.\r\n10. Rights You Grant to Us\r\nBy submitting information, data, passwords, usernames, PINs, other log-in information, materials and other content to Stasher through the Services, you are licensing that content to Stasher for the purpose of providing the Services. Stasher may use and store the content in accordance with this Agreement and our Privacy Policy. You represent that you are entitled to submit it to Stasher for use for this purpose, without any obligation by Stasher to pay any fees or be subject to any restrictions or limitations. By using the Services, you expressly authorize Stasher to access your Account Information maintained by identified third parties, on your behalf as your agent. When you use the “Add Accounts” feature of the Services, you will be directly connected to the website for the third party you have identified. Stasher will submit information including usernames and passwords that you provide to log into the Site. You hereby authorize and permit Stasher to use and store information submitted by you to accomplish the foregoing and to configure the Services so that it is compatible with the third party sites for which you submit your information. For purposes of this Agreement and solely to provide the Account Information to you as part of the Service, you grant Stasher a limited power of attorney, and appoint Stasher as your attorney-in-fact and agent, to access third party sites, retrieve and use your information with the full power and authority to do and perform each thing necessary in connection with such activities, as you could do in person. YOU ACKNOWLEDGE AND AGREE THAT WHEN STASHER IS ACCESSING AND RETRIEVING ACCOUNT INFORMATION FROM THIRD PARTY SITES, STASHER IS ACTING AS YOUR AGENT, AND NOT AS THE AGENT OF OR ON BEHALF OF THE THIRD PARTY THAT OPERATES THE THIRD PARTY SITE. You understand and agree that the Services are not sponsored or endorsed by any third parties accessible through the Services. Stasher is not responsible for any payment processing errors or fees or other Services-related issues, including those issues that may arise from inaccurate account information.\r\n11. Stasher’s Intellectual Property Rights\r\nThe contents of the Services, including its “look and feel” (e.g., text, graphics, images, logos and button icons), photographs, editorial content, notices, software (including html-based computer programs) and other material may be protected under both United States and other applicable copyright, trademark and other laws. The contents of the Services belong or are licensed to Stasher or its software or content suppliers. Stasher grants you the right to view and use the Services subject to these terms. You may download or print a copy of information for the Services for your personal, internal and non-commercial use only. Any distribution, reprint or electronic reproduction of any content from the Services in whole or in part for any other purpose is expressly prohibited without our prior written consent. You agree not to use, nor permit any third party to use, the Site or the Services or content in a manner that violates any applicable law, regulation or this Agreement.\r\n12. Access and Interference\r\nYou agree that you will not:\r\n•	Use any robot, spider, scraper, deep link or other similar automated data gathering or extraction tools, program, algorithm or methodology to access, acquire, copy or monitor the Services or any portion of the Services, without Stasher’s express written consent, which may be withheld in Stasher’s sole discretion.\r\n•	Use or attempt to use any engine, software, tool, agent, or other device or mechanism (including without limitation browsers, spiders, robots, avatars or intelligent agents) to navigate or search the services, other than the search engines and search agents available through the Services and other than generally available third-party web browsers (such as Microsoft Explorer);\r\n•	Post or transmit any file which contains viruses, worms, Trojan horses or any other contaminating or destructive features, or that otherwise interfere with the proper working of the Services;\r\n•	Attempt to decipher, decompile, disassemble, or reverse-engineer any of the software comprising or in any way making up a part of the Services.\r\n13. Rules for Posting\r\nAs part of the Services, Stasher may allow you to post content on bulletin boards, blogs and at various other publicly available locations on the Sites. These forums may be hosted by Stasher or by one of our third party service providers on Stasher’s behalf. You agree in posting content to follow certain rules.\r\n•	You are responsible for all content you submit, upload, post or store through the Services.\r\n•	You are responsible for all materials ("Content") uploaded, posted or stored through your use of the Services. You grant Stasher a worldwide, royalty-free, non-exclusive license to host and use any Content provided through your use of the Services. You are responsible for any lost or unrecoverable Content. You must provide all required and appropriate warnings, information and disclosures. Stasher is not responsible for the Content or data you submit through the Services. By submitting content to us, you represent that you have all necessary rights and hereby grant us a perpetual, worldwide, non-exclusive, royalty-free, sublicenseable and transferable license to use, reproduce, distribute, prepare derivative works of, modify, display, and perform all or any portion of the content in connection with Services and our business, including without limitation for promoting and redistributing part or all of the site (and derivative works thereof) in any media formats and through any media channels. You also hereby grant each User a non-exclusive license to access your posted content through the Sites, and to use, reproduce, distribute, prepare derivative works of, display and perform such content as permitted through the functionality of the Services and under this Agreement.\r\n•	You agree not to use, nor permit any third party to use, the Services to a) post or transmit any message which is libelous or defamatory, or which discloses private or personal matters concerning any person; b) post or transmit any message, data, image or program that is indecent, obscene, pornographic, harassing, threatening, abusive, hateful, racially or ethnically offensive; that encourages conduct that would be considered a criminal offense, give rise to civil liability or violate any law; or that is otherwise inappropriate; c) post or transmit any message, data, image or program that would violate the property rights of others, including unauthorized copyrighted text, images or programs, trade secrets or other confidential proprietary information, and trademarks or service marks used in an infringing fashion; or d) interfere with other Users’ use of the Service, including, without limitation, disrupting the normal flow of dialogue in an interactive area of the Sites, deleting or revising any content posted by another person or entity, or taking any action that imposes a disproportionate burden on the Service infrastructure or that negatively affects the availability of the Service to others.\r\n•	Except where expressly permitted, you may not post or transmit charity requests; petitions for signatures; franchises, distributorship, sales representative agency arrangements, or other business opportunities (including offers of employment or contracting arrangements); club memberships; chain letters; or letters relating to pyramid schemes. You may not post or transmit any advertising, promotional materials or any other solicitation of other users to use goods or services except in those areas (e.g., a classified bulletin board) that are designated for such purpose.\r\n•	You agree that any employment or other relationship you form or attempt to form with an employer, employee, or contractor whom you contact through areas of the Sites that may be designated for that purpose is between you and that employer, employee, or contractor alone, and not with us.\r\n•	You may not copy or use personal identifying or business contact information about other Users without their permission. Unsolicited e-mails, mailings, telephone calls, or other communications to individuals or companies whose contact details you obtain through the Services are prohibited.\r\n•	You agree that we may use any content, feedback, suggestions, or ideas you post in any way, including in future modifications of the Service, other products or services, advertising or marketing materials. You grant us a perpetual, worldwide, fully transferable, sublicensable, non-revocable, fully paid-up, royalty free license to use the content and feedback you provide to us in any way.\r\nThe Services may include a community forum or other social features to exchange information with other users of the Services and the public. Stasher does not support and is not responsible for the content in these community forums. Please use respect when you interact with other users. Do not reveal information that you do not want to make public. Users may post hypertext links to content of third parties for which Stasher is not responsible.\r\n14. Social media sites\r\nStasher may provide experiences on social media platforms such as Facebook®, Twitter® and Instagram® that enable online sharing and collaboration among users who have registered to use them. Any content you post, such as pictures, information, opinions, or any Personal Information that you make available to other participants on these social platforms, is subject to the Terms of Use and Privacy Policies of those platforms. Please refer to those social media platforms to better understand your rights and obligations with regard to such content.\r\n15. Disclaimer of Representations and Warranties\r\nTHE SITES, SERVICES, INFORMATION, DATA, FEATURES, AND ALL CONTENT AND ALL SERVICES AND PRODUCTS ASSOCIATED WITH THE SERVICESOR PROVIDED THROUGH THE SERVICES (WHETHER OR NOT SPONSORED) ARE PROVIDED TO YOU ON AN “AS-IS” AND “AS AVAILABLE” BASIS. STASHER, ITS AFFILIATES, AND ITS THIRD PARTY PROVIDERS, LICENSORS, DISTRIBUTORS OR SUPPLIERS (COLLECTIVELY, "SUPPLIERS") MAKE NO REPRESENTATIONS OR WARRANTIES OF ANY KIND, EXPRESS OR IMPLIED, AS TO THE CONTENT OR OPERATION OF THE SITE OR OF THE SERVICES. YOU EXPRESSLY AGREE THAT YOUR USE OF THE SERVICES IS AT YOUR SOLE RISK.\r\nNEITHER STASHER OR ITS SUPPLIERS MAKE ANY REPRESENTATIONS, WARRANTIES OR GUARANTEES, EXPRESS OR IMPLIED, REGARDING THE ACCURACY, RELIABILITY OR COMPLETENESS OF THE CONTENT ON THE SITES OR OF THE SERVICES (WHETHER OR NOT SPONSORED), AND EXPRESSLY DISCLAIMS ANY WARRANTIES OF NON-INFRINGEMENT OR FITNESS FOR A PARTICULAR PURPOSE. NEITHER STASHER NOR ITS SUPPLIERS MAKE ANY REPRESENTATION, WARRANTY OR GUARANTEE THAT THE CONTENT THAT MAY BE AVAILABLE THROUGH THE SERVICES IS FREE OF INFECTION FROM ANY VIRUSES OR OTHER CODE OR COMPUTER PROGRAMMING ROUTINES THAT CONTAIN CONTAMINATING OR DESTRUCTIVE PROPERTIES OR THAT ARE INTENDED TO DAMAGE, SURREPTITOUSLY INTERCEPT OR EXPROPRIATE ANY SYSTEM, DATA OR PERSONAL INFORMATION.\r\nSOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION OF CERTAIN WARRANTIES OR THE LIMITATION OR EXCLUSION OF LIABILITY FOR INCIDENTAL OR CONSEQUENTIAL DAMAGES. IN SUCH STATES LIABILITY IS LIMITED TO THE EXTENT PERMITTED BY LAW. ACCORDINGLY, SOME OF THE ABOVE LIMITATIONS OF SECTIONS 15 AND 17 OF THIS PROVISION MAY NOT APPLY TO YOU.\r\n16. Not a Financial Planner, Broker or Tax Advisor\r\nNEITHER STASHER NOR THE SERVICES ARE INTENDED TO PROVIDE FINANCIAL ADVICE. STASHER IS NOT A FINANCIAL PLANNER. The Service is intended only to assist you in your financial organization and decision-making and is broad in scope. Your personal financial situation is unique, and any information and advice obtained through the Service may not be appropriate for your situation. Accordingly, before making any final decisions or implementing any financial strategy, you should consider obtaining additional information and advice from your financial advisers who are fully aware of your individual circumstances.\r\n17. Limitations on Stasher’s Liability\r\nSTASHER SHALL IN NO EVENT BE RESPONSIBLE OR LIABLE TO YOU OR TO ANY THIRD PARTY, WHETHER IN CONTRACT, WARRANTY, TORT (INCLUDING NEGLIGENCE) OR OTHERWISE, FOR ANY INDIRECT, SPECIAL, INCIDENTAL, CONSEQUENTIAL, EXEMPLARY, LIQUIDATED OR PUNITIVE DAMAGES, INCLUDING BUT NOT LIMITED TO LOSS OF PROFIT, REVENUE OR BUSINESS, ARISING IN WHOLE OR IN PART FROM YOUR ACCESS TO THE SITES, YOUR USE OF THE SERVICES, THE SITES OR THIS AGREEMENT, EVEN IF STASHER HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. NOTWITHSTANDING ANYTHING TO THE CONTRARY IN THIS AGREEMENT, STASHER’S LIABILITY TO YOU FOR ANY CAUSE WHATEVER AND REGARDLESS OF THE FORM OF THE ACTION, WILL AT ALL TIMES BE LIMITED TO A MAXIMUM OF $300.00 (THREE HUNDRED UNITED STATES DOLLARS).\r\n18. Your Indemnification of Stasher\r\nYou shall defend, indemnify and hold harmless Stasher and its officers, directors, shareholders, and employees, from and against all claims, suits, proceedings, losses, liabilities, and expenses, whether in tort, contract, or otherwise, that arise out of or relate, including but not limited to attorney fees, in whole or in part arising out of or attributable to any breach of this Agreement or any activity by you in relation to the Sites or your use of the Services.\r\n19. Ending your relationship with Stasher\r\nThis Agreement will continue to apply until terminated by either you or Stasher. Stasher may at any time, terminate its legal agreement with you and access to the Services: a) if you have breached any provision of this Agreement (or have acted in a manner which clearly shows that you do not intend to, or are unable to comply with the provisions of this Agreement); b) if Stasher in its sole discretion believes it is required to do so by law (for example, where the provision of the Service to you is, or becomes, unlawful); c) for any reason and at any time with or without notice to you; or d) immediately upon notice, to the e-mail address provided by you as part of your Registration Information.\r\nYou acknowledge and agree that Stasher may immediately deactivate or delete your account and all related information and files in your account and/or prohibit any further access to all files and the Services by you. Further, you agree that Stasher shall not be liable to you or any third party for any termination of your access to the Services.\r\n20. Modifications\r\nStasher reserves the right at any time and from time to time to modify or discontinue, temporarily or permanently, the Sites or Services with or without notice. Stasher reserves the right to change the Services, including applicable fees, in our sole discretion and from time to time. In such event, if you are a paid user, Stasher will provide notice to you. If you do not agree to the changes after receiving a notice of the change to the Services, you may stop using the Services. Your use of the Services, after you are notified of any change(s) will constitute your agreement to such change(s). You agree that Stasher shall not be liable to you or to any third party for any modification, suspensions, or discontinuance of the Services.\r\nStasher may modify this Agreement from time to time. Any and all changes to this Agreement may be provided to you by electronic means (i.e., via email or by posting the information on the Sites). In addition, the Agreement will always indicate the date it was last revised. You are deemed to accept and agree to be bound by any changes to the Agreement when you use the Services after those changes are posted.\r\n21. Governing Law and Forum for Disputes\r\nNew York state law governs this Agreement without regard to its conflicts of laws provisions.\r\nANY DISPUTE OR CLAIM RELATING IN ANY WAY TO THE SERVICES OR THESE TERMS OF USE WILL BE RESOLVED BY BINDING ARBITRATION, RATHER THAN IN COURT, except that you may assert claims in small claims court if your claims qualify. The Federal Arbitration Act governs the interpretation and enforcement of this provision; the arbitrator shall apply California law to all other matters. Notwithstanding anything to the contrary, any party to the arbitration may at any time seek injunctions or other forms of equitable relief from any court of competent jurisdiction. WE EACH AGREE THAT ANY AND ALL DISPUTES MUST BE BROUGHT IN THE PARTIES'' INDIVIDUAL CAPACITY AND NOT AS A PLAINTIFF OR CLASS MEMBER IN ANY PURPORTED CLASS OR REPRESENTATIVE PROCEEDING. BY ENTERING INTO THIS AGREEMENT AND AGREEING TO ARBITRATION, YOU AGREE THAT YOU AND STASHER ARE EACH WAIVING THE RIGHT TO FILE A LAWSUIT AND THE RIGHT TO A TRIAL BY JURY. IN ADDITION, YOU AGREE TO WAIVE THE RIGHT TO PARTICIPATE IN A CLASS ACTION OR LITIGATE ON A CLASS-WIDE BASIS. YOU AGREE THAT YOU HAVE EXPRESSLY AND KNOWINGLY WAIVED THESE RIGHTS.\r\n22. Apple Requirements. You can download from the Mac App Store the Stasher iOS application, the principal app of the Stasher Service, and upon payment of any applicable fee, the Stasher app will give you full access to Stasher’s services. You are responsible for any fee you incur and are charged by a third party (i.e, Apple), which may change from time to time, in connection with your download and use of the Stasher iOS app. Stasher has no obligation to refund any payments made to such third party for your use of the Stasher app as set out in this Agreement. \r\nIf you downloaded any of the Services or product from the Mac App Store, the following terms also apply to you:\r\nA.	Acknowledgement: You acknowledge that this Agreement is between you and Stasher only, and not with Apple, and Stasher, not Apple, is solely responsible for the Software and the content thereof.\r\nB.	Scope of License: The license granted to you for the Software is a limited, non-transferable license to use the Software on Mac product that you own or control and as permitted by the Usage Rules set forth in the terms of service applicable to the Mac App Store.\r\nC.	Maintenance and Support: Stasher and not Apple is solely responsible for providing any maintenance and support services, for which additional fees may apply, with respect to the Services. You acknowledge that Apple has no obligation whatsoever to furnish any maintenance and support services with respect to the Software.\r\nD.	Warranty: Stasher is solely responsible for any product warranties, whether express or implied by law, to the extent not effectively disclaimed. In the event of any failure of the Software to conform to any applicable warranty, you may notify Apple, and Apple will refund the purchase price for the Software to you. To the maximum extent permitted by applicable law, Apple will have no other warranty obligation whatsoever with respect to the Software, and any other claims, losses, liabilities, damages, costs or expenses attributable to any failure to conform to any warranty will be Stasher’s sole responsibility.\r\nE.	Product Claims: Stasher, not Apple, is responsible for addressing any user or third party claims relating to the Software or the user’s possession and/or use of the Software, including, but not limited to: (i) product liability claims; (ii) any claim that the Software fail to conform to any applicable legal or regulatory requirement; and (iii) claims arising under consumer protection or similar legislation.\r\nF.	Intellectual Property Rights: You acknowledge that, in the event of any third party claim that the Software or your possession and use of the Software infringes that third party’s intellectual property rights, Stasher, not Apple, will be solely responsible for the investigation, defense, settlement and discharge of any such intellectual property infringement claim.\r\nG.	Legal Compliance: You represent and warrant that (i) you are not located in a country that is subject to a U.S. Government embargo, or that has been designated by the U.S. Government as a terrorist-supporting country; and (ii) you are not listed on any U.S. Government list of prohibited or restricted parties.\r\nH.	Developer Contact Info: Direct any questions, complaints or claims to: Stasher Inc., 40 Morton Street, Apt 1A, New York, NY 10014 or bianca@stasherapp.com. \r\nI.	Third Party Terms of Agreement: You must comply with any applicable third party terms of agreement when using the Software.\r\nJ.	Third Party Beneficiary: You acknowledge and agree that Apple and Apple’s subsidiaries are third party beneficiaries of this Agreement, and that, upon your acceptance of the terms and conditions of the Agreement, Apple will have the right (and will be deemed to have accepted the right) to enforce the Agreement against you as a third party beneficiary thereof.\r\n', 'Tems Of Use', 'Tems Of Use', '2014-09-13 02:36:22', '2'),
(3, 'Privacy Policy', 'Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Vestibulum ac eros lacinia sapien mollis lobortis. Morbi ultrices est blandit augue fringilla lacinia. Fusce commodo quam vitae dolor tempus, nec condimentum sapien facilisis. In volutpat.\r\n', 'Privacy Policy', 'Privacy Policy', '2014-09-13 02:36:42', '2'),
(4, 'Contact Us', 'Duis tincidunt velit quis ante aliquet, ullamcorper tincidunt dolor mattis. Aenean porta est pharetra fermentum imperdiet. Ut viverra accumsan mi, non interdum tellus dignissim vitae. Fusce neque lorem, congue non sapien at, gravida vulputate metus! Nullam porta vestibulum metus.\r\n', 'Contact Us', 'Contact Us', '2014-09-13 02:45:41', '2');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_sitesettings`
--

CREATE TABLE IF NOT EXISTS `tbl_sitesettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `var_name` varchar(50) NOT NULL,
  `var_value` text NOT NULL,
  `status` enum('0','1','2') NOT NULL DEFAULT '2' COMMENT '0: logical delete;1:inactive;2:active',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `tbl_sitesettings`
--

INSERT INTO `tbl_sitesettings` (`id`, `var_name`, `var_value`, `status`) VALUES
(1, 'SITENAME', 'Stasher', '2'),
(2, 'TITLE', 'Stasher', ''),
(3, 'FRONTTITLE', 'Welcome to stasher', ''),
(4, 'ADMINTITLE', 'Welcome to Admin Panel', ''),
(5, 'SITEURL', 'http://54.225.115.65/stasher', ''),
(6, 'COPYRIGHT', '&copy; 2015', ''),
(7, 'PARTNER_KEY', '4aa327f5ac661878d6178e2c2b44aa5a9a0708d2', '2'),
(8, 'PARTNER_PASS', '7a383e494ac323569402b9f1fe591c1735906202', '2'),
(9, 'DOCROOT', '/var/www/stasher/', '2');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_subscribers`
--

CREATE TABLE IF NOT EXISTS `tbl_subscribers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `inserted_date` datetime NOT NULL,
  `status` enum('0','1','2') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `tbl_subscribers`
--

INSERT INTO `tbl_subscribers` (`id`, `name`, `email`, `inserted_date`, `status`) VALUES
(1, 'sam dicosta', 'sam@gmail.com', '2015-04-29 07:15:33', '2'),
(2, 'Clay', 'John', '2015-04-29 07:21:04', '2'),
(3, 'Clay fox', 'clay@yahoo.com', '2015-04-29 07:21:38', '2'),
(4, 'mona', 'mona@yaahoo.com', '2015-04-29 07:26:08', '2'),
(5, '', '', '2015-04-29 09:50:28', '2'),
(6, '', '', '2015-04-29 10:02:54', '2'),
(7, '', '', '2015-04-29 10:03:51', '2'),
(8, '', '', '2015-04-29 10:06:24', '2'),
(9, '', '', '2015-04-29 10:08:37', '2'),
(10, '', '', '2015-04-29 10:15:29', '2'),
(11, 'Tanvi', 'tanvi@oabstudios.com', '2015-04-29 10:15:53', '2'),
(12, '', '', '2015-04-29 10:20:50', '2'),
(13, '', '', '2015-04-29 10:37:47', '2'),
(14, 'biacnca', 'bianca@stasherapp.com', '2015-04-29 12:11:29', '2');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_transactions`
--

CREATE TABLE IF NOT EXISTS `tbl_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_id` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(30) NOT NULL,
  `status_code` varchar(20) NOT NULL,
  `merchant` varchar(100) NOT NULL,
  `payment_amount` varchar(25) NOT NULL,
  `invoice_detail` varchar(255) NOT NULL,
  `sms_date` varchar(30) NOT NULL,
  `sms_time` varchar(30) NOT NULL,
  `credit_amount` varchar(50) NOT NULL,
  `debit_amount` varchar(50) NOT NULL,
  `error_code` varchar(50) NOT NULL,
  `parentId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=157 ;

--
-- Dumping data for table `tbl_transactions`
--

INSERT INTO `tbl_transactions` (`id`, `trans_id`, `name`, `email`, `address`, `phone`, `status_code`, `merchant`, `payment_amount`, `invoice_detail`, `sms_date`, `sms_time`, `credit_amount`, `debit_amount`, `error_code`, `parentId`) VALUES
(1, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 120),
(2, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(3, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(4, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(5, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(6, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(7, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(8, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(9, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(10, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(11, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(12, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(13, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(14, '<null>', '', '', '', '', '', '', '', '', '', '', '', '', 'payment_key length must be at least 20 characters ', 0),
(15, '<null>', '', '', '', '', '', '', '', '', '', '', '', '', 'payment_key length must be at least 20 characters ', 0),
(16, '<null>', '', '', '', '', '', '', '', '', '', '', '', '', 'payment_key length must be at least 20 characters ', 0),
(17, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(18, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(19, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(20, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(21, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(22, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(23, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(24, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(25, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(26, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(27, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(28, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(29, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(30, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(31, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(32, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(33, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(34, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(35, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(36, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(37, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(38, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(39, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(40, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(41, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(42, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(43, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(44, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(45, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(46, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(47, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(48, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0),
(49, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0),
(50, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0),
(51, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0),
(52, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0),
(53, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0),
(54, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(55, '06e762d1acfc98a41838ef1226f07a3bab73038b', '', '', '', '', '', '', '', '', '', '', '', '', 'Payment not found.', 0),
(56, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(57, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(58, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(59, 'ee810f458963cbfc9ad30da62877f25d9aa39acf', '', '', '', '', '', '', '', '', '', '', '', '', 'Payment not found.', 0),
(60, 'ee810f458963cbfc9ad30da62877f25d9aa39acf', '', '', '', '', '', '', '', '', '', '', '', '', 'Payment not found.', 0),
(61, '5e797343866011b924d04ef057e1fdc0a7e93823', '', '', '', '', '', '', '', '', '', '', '', '', 'Payment not found.', 0),
(62, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(63, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(64, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(65, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(66, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(67, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(68, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(69, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(70, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(71, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(72, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(73, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(74, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(75, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(76, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(77, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(78, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(79, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(80, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(81, '19d66b1c1c72c69e672cedc29ecadf867d157ea6', '', '', '', '', '', '', '', '', '', '', '', '', 'Payment not found.', 0),
(82, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(83, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(84, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(85, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(86, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(87, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(88, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(89, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(90, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(91, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(92, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(93, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(94, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(95, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(96, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(97, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(98, '8ab453e9e9a135a4edb25c3b242f524b3fa6f82f', '', '', '', '', '', '', '', '', '', '', '', '', 'Payment not found.', 0),
(99, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(100, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(101, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(102, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(103, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(104, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(105, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(106, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(107, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(108, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(109, '2e3010b787576192b86a8d02d1bbd71819b05aeb', 'JEREMY A WEISBERG', 'jeremy.weisberg@gmail.comï¿½ï¿½', '353 West Street', '2122052016', 'queued', 'STASHER INC.', '0.01', 'Add parent bank account', 'May 23, 2015', '12:29:06 pm', '0.01', '0.01', 'null', 0),
(110, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(111, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(112, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(113, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(114, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(115, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(116, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(117, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(118, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(119, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(120, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(121, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(122, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(123, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(124, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(125, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(126, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(127, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(128, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(129, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(130, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(131, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(132, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(133, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(134, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(135, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(136, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(137, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(138, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(139, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(140, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(141, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(142, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(143, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(144, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(145, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(146, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(147, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(148, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(149, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(150, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(151, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(152, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(153, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(154, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(155, 'f276e314954a0f1d8047130e64fc70a4d67744e5', 'BIANCA L PADILLA', 'biancalpadilla@gmail.com', '40 Morton Street', '7862391547', 'executed', 'STASHER INC.', '1', 'Tst', 'Mar 10, 2015', '3:41:35 am', '1', '1', 'null', 0),
(156, '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_transaction_history`
--

CREATE TABLE IF NOT EXISTS `tbl_transaction_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `childId` int(11) NOT NULL,
  `parentId` int(11) NOT NULL,
  `price` float(10,2) NOT NULL,
  `description` varchar(255) NOT NULL,
  `inserted_date` datetime NOT NULL,
  `status` enum('0','1','2') NOT NULL COMMENT '0:logical delete;1:pending;2:done',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_transaction_newhistory`
--

CREATE TABLE IF NOT EXISTS `tbl_transaction_newhistory` (
  `id` int(11) NOT NULL DEFAULT '0',
  `userId` int(11) NOT NULL,
  `orderId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_trophies`
--

CREATE TABLE IF NOT EXISTS `tbl_trophies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `image` varchar(100) NOT NULL,
  `inserted_date` datetime NOT NULL,
  `status` enum('0','1','2') NOT NULL COMMENT '0: logical delete;1: inactive;2:active',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE IF NOT EXISTS `tbl_users` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `saltkey` varchar(255) NOT NULL,
  `usertype` enum('1','2','3','4') NOT NULL COMMENT '1: superadmin ;2: subadmin;3: agent -child ; 4: Commander - parent',
  `devicetoken` varchar(255) NOT NULL,
  `registered_date` datetime NOT NULL,
  `status` enum('0','1','2') NOT NULL COMMENT '0: logical delete;1:inactive;2:active',
  PRIMARY KEY (`userId`),
  KEY `userId` (`userId`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=182 ;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`userId`, `username`, `email`, `password`, `saltkey`, `usertype`, `devicetoken`, `registered_date`, `status`) VALUES
(144, 'ashgobindram', 'ash@oabstudios.com', 'b76b59de916e1de88bcf592960e3b5d35b0f53183da520f516caa3605a238b82', 'VJU1l9Bg3HfEoOf0lxKa66weyq1hCZUyIPz5Xak1RzFgnVqJsaUxgqLOQM6tL12tP', '4', '', '2015-03-12 16:13:41', '2'),
(143, 'testchild', 'test@test.com', 'ae0accc71f8dce0ca80acdbb8c7e39387c3ccade14f91ad07e45059e888ada16', 'ThX0bgGVGHvp0HLDdjgiX7ntVVgMMjmGAkPMAvHgdcGnUr28KhpIoNbkIr7vLsbmN', '3', '', '2015-03-11 19:40:14', '2'),
(142, 'Fuchka', 'deba@oabstudios.com', 'cb7680f2f676c16374ce30c7ff8ccb5f9b1f748f567aa50582cf3a005223def9', 'dvLrwObjJ4h7mdq6ZVMHbJXPvTOoJ5jXz6p7UApDEGK1Ua6T7SBhBy78sVwcZQ0yV', '3', '', '2015-03-11 06:21:12', '2'),
(141, 'biancalpadilla', 'biancalpadilla@gmail.com', '21f4b7bfc2a44921c4a6f4f7d997bb53a554372751ced44dfadaf7fb27c28ff1', '1j1ht9QyeXqE8wWRYqkV1byICt3iSRzTbAbFI2dWZEA7axX0Xh6YsDG67InZAXSMx', '4', '317fbe5b959c1ecce35419fd42c346e71b2363a19bec1722b014063552eb251c', '0000-00-00 00:00:00', '2'),
(140, 'parenttestoab', 'parenttestoab@gmail.com', 'e086bf147f6f3c10d751b07be0d6d6e7e8f14ae3529c9c969023bcd735a3e2d9', 'n1pZdlN8NBhRVrTU7Y7cFLs3RN1YolUMmjLzFyHtaYk6peZwc6JSQcUIZVHohBaDV', '4', '', '2015-03-10 14:28:16', '2'),
(139, 'chandra.debashis', 'chandra.debashis@gmail.com', 'cf487ee5b96b1b51a39268c5f7c3c1f008447cfddebe7e1320f4532a963d114b', '8Y1xsNX5KucmPyxTm4qjI703xH16F9jM7jky8hCSMPeBnLvKPV4y2cBzUCFzKYmQi', '4', '', '0000-00-00 00:00:00', '2'),
(138, 'sparshme5', 'sparshme5@gmail.com', 'fc0f32796224327ab235e558223fd434083dd52531286ec530651a5626e1781d', '2iSAlQkP0oh6DMsIXVgafioXGwG8RopTHhu48OThdbmRXPzVLQ610uXP2EXS4mMKE', '4', '', '0000-00-00 00:00:00', '2'),
(137, 'biancapadilla', 'kid@test.com', '4a2198328f2ebc8747d5b34bf9c24d80020a6c1705cade629d10fbc3c168a40f', 'q2sL49CydicxRTUYDnhORX8EV3nkJks0mUVp3yYgQaOI4IHH7YvXWCBREYcojEyFz', '3', '', '2015-03-07 22:18:52', '2'),
(136, 'JWparent', 'Jeremy.weisberg@gmail.com', '3fce7e9bb89acc7b2751ccc8080c985c0d705dcbf6ef49d837f4e0c28606e261', 'XWrkiyeUVjqOHFQj5UE8iftMGj20yCUwzlQRU6LPocE7SvqWp55Hkyu1Rwaq95WIq', '4', '', '2015-03-07 22:02:21', '2'),
(135, 'EmiliaPadilla', 'emilia@test.com', '6c42063146f552937d7b36314c72d3c9476d8a413020af157bd8983582094eee', 'PUW7QHn1sRF024ZiDkJ6btyAMwoZ0VgYPc6GUsGmkmwlpwD4Qn93QHCDe2CnWTmM6', '3', '317fbe5b959c1ecce35419fd42c346e71b2363a19bec1722b014063552eb251c', '2015-03-05 15:54:26', '2'),
(134, 'biancachild', 'biancachild@test.com', 'c43b769a82d5e68d4c9a3f5812a3b8810165c6d765b3834e780dfa452dc51762', 'NJtwcy3z6rb7WncbJB7B27Vk4XNP0aAWU5t8CvGHWSOTf16YCbADhvYksMaCXKzRP', '3', '', '2015-03-05 15:44:55', '2'),
(133, 'biancaparent', 'test@Bianca.com', '4485343318d67c7c5f5a94b030fcf4a313d686071ea318f5f9a383909f9a5008', 'N2HcGdlDRRzK8EnaLE1ZBD5fXVD2gRa5SRgy5BcVsLGAq4LbIMbjpfynabpq3zuVq', '4', '', '2015-03-05 15:42:07', '2'),
(132, 'bhushan12.uparkar', 'bhushan12.uparkar@gmail.com', '3fcaf89b2f0e9b723dc78395d8478cc36295e5ed113dd39431b41763f6bbd5fc', 'bfP0RB5zFUHVGeOlbmEIJmVcSFqS7FOiUErLfwlVq4Q8hFst28cKu8XmNnfU44cYH', '4', '', '0000-00-00 00:00:00', '2'),
(131, 'parenttest7', 'parenttest7@gmail.com', '2a8dfd6e8b95fe2af03d54568031c2e39d9a63099fff45465980d6836b49862b', 'z78tM4A4O0tI2eMuts9xbw4ztazDFuzeBGHnKhryrUht04YCw8aHEdh8oRK4mjiX1', '4', '', '2015-03-02 11:31:11', '2'),
(130, 'parenttest6', 'parenttest6@gmail.com', '2289d01773c4b5b6e778a473ea8ac5ea3b11b8d833988b0e74a441980688fe32', 'Wrtf5YPdEqXbDUhY1GkxxwLnwoSCuz6q2yG6xwibXgnBaFzamUHTrthXSaAmJFNKe', '4', '', '2015-03-02 11:21:05', '2'),
(129, 'parenttest5', 'parenttest5@gmail.com', 'c2f866f07702da6de4edb2696dd2af8cea70fc7255208fc6ffab5b862c235e81', '0LmZzN3KrjLJmhAmuv9GpYEGh2OgcDYlollX0nIAHtk5LUqfqzWPxAwPCk6OX5alp', '4', '', '2015-03-02 10:26:30', '2'),
(128, 'parenttest4', 'parenttest4@gmail.com', '28d021f4dfef885332cf32812fd9d8fe737e7a090bed20eddccf70c4f8778218', '1ad3sAUOt2IKqtF4UTD86pY60hoFedlfnyhQ0cFDennEQ3ILVlS2LR8U9vAnJVC8u', '4', '', '2015-03-02 10:23:33', '2'),
(127, 'parenttest3', 'parenttest3@gmail.com', '89af040c616b623dc2ab8737940e91e80f2685fe36b3be8747f29afdd4debd49', 'GJxI9NacUuOJr4F0dyr6uITbLqN27X4NGBwOoG1jbP3DSIM6geaLW5WHvKJCHMpnn', '4', 'f6780245f11c732da776086e61b277a8086a874678f7e01111b17bc57565b6c4', '2015-03-02 09:33:50', '2'),
(126, 'childtest3', 'childtest3@gmail.com', '5fff275c9d794a8588b3ad144c918b58441941551e3ea9c3751a546353ea6b38', 'y0OtdkeT4VAp5s2U5UBxqLmVIWPInSGV3uofPC9SyIiDbjxfe0NFV0AD6qmsj3nlx', '3', '', '2015-02-27 10:33:55', '2'),
(125, 'childtest2', 'childtest2@gmail.com', 'a1e3218530084a9086c3c35172bb340a83b07322f4d64177a3b0b874e141ab74', 'YrxdqJWKKTEYTGnmCCjDhoE8NmnyyO4wfBKFkGp5A43tKpPn391jxErl2OUzDX6Sy', '3', '', '2015-02-27 10:30:56', '2'),
(124, 'parenttest2', 'parenttest2@gmail.com', 'e81a5506a41d58483dda9b054ef79387142c44512714236e9c29648de9670316', 'LKnjPjsY9ulPczc59brSQu6p9ZbjHqltaJM14fYbJk2WUd13osVfX2E61QpIgLbqu', '4', '', '2015-02-27 09:58:37', '2'),
(123, 'Jay', 'Mankar.jay@gmail.com', '2821290b83f73b34a9548dd772a694f662a59296ff5c94ffc3f601a2d8369ca2', 'yZQYdSUeI8bBlUUoQyxpS6F0NsZ3p0KX9AWmtQBcXNNiIIHygeX0jDi86h0urTsAu', '3', '', '2015-02-27 07:36:09', '2'),
(122, 'Jayant', 'jayant@oabstudios.com', '25fe24118fb69208273a72e2e6b7eba39bdafc7acfa212856e6a6ab849817880', 'ABbJzOT5Nkh2yW0WLSShOj8evmtGitfS5rCEfvJ4Q15pWdlH7dZVw803uDIM7YFbp', '4', '', '2015-02-27 07:13:20', '2'),
(121, 'childtest1', 'childtest1@gmail.com', '6260b9623e91a7968f98dfc522147c688a694212bf532dff63bf69f75cb80392', 'qUmJcfWn4dAm6Ve8dW0kIQ3Qn8SqMT6dNsWZHTnL8X9cSmk7iuq2ksSHAK8nEdArF', '3', 'f6780245f11c732da776086e61b277a8086a874678f7e01111b17bc57565b6c4', '2015-02-27 07:12:00', '2'),
(120, 'parenttest1', 'parenttest1@gmail.com', 'ca6493fd299b5ac92940346daa0620c3eab644cf21e056f2b9c097e63e479ba1', '8n3n4E1ZG5vBWUcVBNYBAcKJiOZFyCnG1q45644L9yn6tz15mZFWcqGueGaMjyskY', '4', 'f6780245f11c732da776086e61b277a8086a874678f7e01111b17bc57565b6c4', '2015-02-27 07:02:40', '2'),
(145, 'vipuloab', 'vipuloab@gmail.com', '2dc72e68aeaa87a8d8ddda97baddfbbd8b3e45d54cf3c42ca4a49e0a2b16e27f', 'QS070pGwAkp8bux2mMmbPgICvYJbrdRi72ogr6M2pb9BGGD4sZfhgXULWDXnRPGXR', '4', 'b46bdbabb6c2856d71d99315e352f791ce3c86636dada3eafa025688a716bd63', '2015-03-13 15:29:52', '2'),
(146, 'carlospadilla', 'carlos@gmail.com', '08e1ae4fffc6bb1cd289988b7619ad6d70e5a0bdbf4191c9ebbe36ede3a31470', 'JvzTTFmWmbhyoNeXbJ6ihfgj4vDDQhwAM7uFLQB93TGqHVnTFsbWIsgMXTpOaWpX3', '4', '', '2015-03-13 16:08:22', '2'),
(147, 'jeremy.weisberg', 'jeremy.weisberg@gmail.com', '3fb9decf69dda45573ea6b6322f696409066cc7c5d9698495aaa403077c49d49', 'xUXdSAu8VtxddpLOLJQXKtLo7ayRfZiMTgZMQtTMXr1bRL1CvRzfklDrvcjKbBw6R', '4', 'f6780245f11c732da776086e61b277a8086a874678f7e01111b17bc57565b6c4', '0000-00-00 00:00:00', '2'),
(148, 'barhate.vipul', 'barhate.vipul@gmail.com', '81d27e6493abe6acebeadb9856ebe304caf33a86210f4c2c097ceb3f4d7be201', 'RVuHckHHGfIh3M7YwdNptfjyei478muYiZFvknc1CUiFHpEdDsD7HXEWgI4n6xmox', '4', '', '0000-00-00 00:00:00', '2'),
(149, 'bpadi', 'biancapadilla@test.com', '1996d63a3ecf5ff95f57dea7f6e0761d99b44b179386972ea8f1ac76de92a5de', 'lfB78GMNqy5JMqmxiSPuIlEj0CelAdhWtT3BAOo1nsKaS7IbZyFITj24WgoxuGtXz', '3', '', '2015-03-18 13:09:32', '2'),
(150, 'parentoab', 'parentoab@gmail.com', '66b55a1da849f24ced2a9d14a5ef16f37d4837b553a46465b3ec6abdffeb74bd', 'cIdykBreqYa8qQE78XkelDmgh7iEUkB84PFnq8BQ6MYvCDCJAWYWzkcQrvumP7tSV', '4', 'b46bdbabb6c2856d71d99315e352f791ce3c86636dada3eafa025688a716bd63', '2015-03-18 13:54:30', '2'),
(151, 'parenttest11', 'childtest11@gmail.com', '0c9ba3e079b032836957fa4163d0c5a0b1399465d2b901a32572041b9927b4f3', 'BnFq5kqdAplUner6G4PrbMdQNlpuBaddySDDd5QNubIRq0W7dMyoyMfm8FQIQ5WoW', '4', '', '2015-03-19 15:22:14', '2'),
(152, 'shooter', 'shooter@oabstudios.com', '496cf54bd4b3acc74cb27fa25e980b5ea61fc90c55a4a074e0aaacaa42190f9e', 'A2aFSX05G1uPXB4KarjWHG4mxLcBIByiDIXwF8Bm87b6HfQRG0NoQRLnDYYlzwEde', '3', '', '2015-03-19 15:27:25', '2'),
(153, 'parenttest31', 'parenttest31@gmail.com', '418c79e0683fb62565dd17c51a340cd5d7b72604ecc4014112343f0474e21234', 'bFbZYAiZ2ZSxZwOxIO2qhattelIjoxoAcAAabSacR3KRzyphnqIFBc9QxR0WoywB0', '4', '', '2015-03-23 13:27:43', '2'),
(154, 'parenttestz1', 'parenttestz1@gmail.com', 'd97296221cf22ccb92aaecb27c9d8d1a85d1a5ad170d640def1bb73783cbd681', '7MkZWxRZhJyQ9QdzzSbL22iTbeiKLTTRFeRCLJB4saTA180zZkk2mDUyRdiC7cuMr', '4', '', '2015-03-23 13:41:26', '2'),
(155, 'nitinoab', 'nitinoab@gmail.com', 'd4f95f0a68009819c620826be626f6711ded4805df15468864c12e33656f1e4d', 'CUlinDJWc7ODXZj6GSZO8z2rwPHwYrLBm8TJKDFXKtBHtVM0NMXVlYmRO4oNvaoRh', '4', '', '2015-03-27 11:43:21', '2'),
(156, 'mangeshoab', 'mangeshoab@gmail.com', '89be397d6f21e0b25bf2664892a17aeaad0274c32d07cad873d3a772b093408b', 'qdn3yf80H1dxFQJLlOMX5mFMC3ePE455hs8PHeZpfcWU3FGotslxP2kr5yhIClNTO', '4', '', '2015-03-27 11:50:45', '2'),
(157, 'manojoab', 'manojoab@gmail.com', '8d7e0276a84a964ee73e9fa01f078971cd409ceb3a246a842b7bc4d7b8ad48d7', 'iB3Vg1GKBndwamkWkfhjB08FxUbHi3ZAD3wU3cEEASbKfvHzKYTm912FVcndfnOTq', '4', '', '2015-03-27 11:56:11', '2'),
(158, 'parentparent', 'parent@parent.com', 'b2d7dea660c107ca30acd72702609e389e75132cbefd49ab8e9b8132c680dc46', 'WeX3AGvD8I3nbb6UJrvs3ETDeUZKUBAQQyTqeo5l87IjhNe1fJtinmWCgVnbxY3nw', '4', 'c3b915fa3592fc88730cdd06fb6c631f17509531eca5e0726e7ce43faff03c1b', '2015-03-27 15:36:24', '2'),
(159, 'ramoab', 'ramoab@gmail.com', 'e3f82814541703f54f14c87f48d2a25e3e08401d5cf26b6625a3558d59e345d5', '5LJh8aprzMEC3KPiuIPvC8J5XNnvgH5ksOCAY23yOHaQsZ9XIYsl7bp4ZNzfuEAXs', '4', '', '2015-03-31 11:16:02', '2'),
(160, 'xanderoab', 'xanderoab@gmail.com', '36fb55fb886fb18d52941874c186cf49a73df9875984f2d8d978948af0aa1ca0', 'U9fK82zkofii8e7vEvMy6eWeBUpTjAleJAZQBza1OsjVHprlVeT1sQf4KEX5eiiXT', '3', '', '2015-04-01 06:49:03', '2'),
(161, 'sachinoab', 'sachinoab@gmail.com', '64700b5e010967b4141ae2f29b0b61509f9f5ceb609351f7b27b1b9c35a92613', '2YXsG2ybM66qn75zflx41mE9d8AkSieUgbmXdV9Z1dqnkvXzRuDRRhZ6ozphSEc9Q', '4', '', '2015-04-01 08:59:49', '2'),
(162, 'gaurav', 'gaurav@myplu.to', '6e3bb1c02a4980329861cb4497adc990ca34860e4ee1cb7c2bedeab0aa4b1767', 'iD6rAgthZGkYTBPz8UE70Po8sgqIXOTgrYH2fbjeRDdLf3lmX1t7PSei0F28tUnUT', '4', 'b46bdbabb6c2856d71d99315e352f791ce3c86636dada3eafa025688a716bd63', '0000-00-00 00:00:00', '2'),
(163, 'admin', 'vipul@oabstudios.com', 'ebe9dbf835f98667290461c84b5aaf6ef164471bb2fae51b40df948204a00370', 'q8OgwB3cUac0ZUD5EGWvMcNZM7UPS88jeVzLxBXrM0BL5eQJVNeI13HM9CC2JJkYF', '1', '', '0000-00-00 00:00:00', '2'),
(164, 'fhhj', 'fhh@fg.com', 'ee5fe84e6ebb4a890fec2bb275fe8c1cc740a6c607a5b9a8cde6cec63f92e569', 'VKCYTp75QxfQYJPLl8vJj1DV7sw5vqrrb4p5tv9k4oa281Nt8jcrjPmqiTvOjXfu1', '4', '', '2015-04-23 09:45:58', '2'),
(165, 'mahesh', 'mahesh@oabstudios.com', '744ad5befa14a2469f5cf121968c47830d2c282fa13c0002e6d1cae0e0bb8748', 'afrZVMAkLSJWKdmXh9SA6ZQJ8ohCdLfo2HnXuYhfQ1cBeyzvGr7MrXwzlNczzrXB0', '4', '', '2015-04-27 13:15:51', '2'),
(166, 'emilia', 'emilia@gmail.com', 'c2457d6d20872259b861395ec0d109a78c0f8fa226ad61483ea756a415310398', 'uyrFpb0JU8C7AzbcvfuVJo8HlKWq6ukz4LfsWobRvOY6o0iTpMO9bWQxGMXLgilj4', '3', '317fbe5b959c1ecce35419fd42c346e71b2363a19bec1722b014063552eb251c', '2015-04-29 17:33:56', '2'),
(167, 'momtest', 'mom@gmail.com', '33c8005724a1cc552d598a83041dda38556ebc5c45ae1ce44261d8cba2ca0498', 'kOeSOTEoZf9AUIrF8C4Zb91lMNqn6dWq3ajQ5Xe5cmE867NcIQcUZcgM1Ha7U7wWh', '4', '317fbe5b959c1ecce35419fd42c346e71b2363a19bec1722b014063552eb251c', '2015-04-29 22:09:50', '2'),
(168, 'wilhelmina', 'beyba23@gmail.com', '7740a96cc6c5837945d5b1ab78493e8596ec7b7466b9eb63d3a7551bbce056e1', 'WeR3auquy1B0WW8i1grcADahPgkGpN9l31ocvPG5QidMel5eCwqcaBtZROGhBPDEP', '4', '317fbe5b959c1ecce35419fd42c346e71b2363a19bec1722b014063552eb251c', '2015-04-29 22:34:08', '2'),
(169, 'Emma', 'emma@gmail.com', '6a21f6774b22dfd11fcd28f8cf884529d4efa8f26c085cf9ca787092ab6d6de6', 'YQ6JYNpOOg8NXzGdc0ER21sbEDj2c6CaVIUUvkIkAP8ypOMBXqtYqVa6yt8KyKVus', '3', '', '2015-04-30 12:21:13', '2'),
(170, 'Chris', 'chris@gmail.com', '3492817c2c62e2fbdc3089a254818970b6d2ace0ed3789cfd36130fad7d79b24', 'bXcr56PRlgblhdgrhoA6xO2EnYj65apf8CGbHw44Meo5sFwJ58OBVQfiOznSKM8Rp', '3', '', '2015-04-30 12:56:42', '2'),
(171, 'Tyrin', 'tyrin@gmail.com', 'd50c9bd72259131e66abb6a981bdd3923fa25f5e5e3fac63ae7d632c7cc4c269', 'WqqWE1B4fGkwoRhk8nQZRHnnMu5TshqoHRlmRXp8DKE3BWnJjdJbV7zIADB4V3sDU', '3', '', '2015-04-30 13:01:45', '2'),
(172, 'stark', 'tenley@gmail.com', '56340b343bf28a2aa0ac3d4a3eed56a49b237dc50caa6f75dbd1224c9367839d', 'x5yhQPwCJViWVlgo9UIrwJmnJsxI9klFpUWgJsStoaqjwGIEAq78asuTV3C4nYIMS', '3', '', '2015-04-30 13:07:02', '2'),
(173, 'Eddard', 'eddard@gmail.com', 'c093744cc82d6b8440fe3cd270d8a3e70187c28e222b56ed55f381c00001da85', 'flm341qPnMHtIwOFRKgQ35CtvWRmMyB3UX5XXuNkhuOZ2DFSoVJq1lUwiLS6kt8fr', '3', '', '2015-04-30 13:08:33', '2'),
(174, 'Mom', 'mom@mom.com', '8d7da0f15ada4240a7bb5b1f8f5dc4691540778f1f65113f3d883a60bf6b013e', 'lE7Mwx8lfXCpm9jEAEnoPcRtZxY5e6AAKHmgeuCuseTOndsXRQlG4d03K88ZdHAXp', '4', '317fbe5b959c1ecce35419fd42c346e71b2363a19bec1722b014063552eb251c', '2015-04-30 20:12:34', '2'),
(175, 'Daughter', 'daughter@daughter.com', 'fe33cfa6588fa82110c2aa4c8b37cb0262e6a8766ee0d4261ccc7ff278b3daf5', 'ta1UT6ZsxeL6lpYSjM1vNMe3ORoyYC3rM4mF9l9FzTLVjJOCvO9jAnlpeJXdm1F94', '3', '317fbe5b959c1ecce35419fd42c346e71b2363a19bec1722b014063552eb251c', '2015-04-30 20:15:05', '2'),
(176, 'Son', 'son@son.com', '3b840afc599c57f387926a8d264d841f640e153987d417fa3bc510a84c51a38a', 'llJim3zEcpTUl1UBXCdAE52G2J0ns7AOsk7PnGtz6ntrnn3k1fUEkWllFuJ9BjW5E', '3', '317fbe5b959c1ecce35419fd42c346e71b2363a19bec1722b014063552eb251c', '2015-04-30 20:15:41', '2'),
(177, 'Dad', 'father@father.com', '4fe1d9b45071c68ff1affb6d4293fbd75fde8eb045509bd7d71b49e9652064ca', 'q9eNhYpyon1Ut9WvBfIueROkaKksBHC2PQP7OfFdCF86O5AqjjUyaITltdO5Uq7Kh', '4', '317fbe5b959c1ecce35419fd42c346e71b2363a19bec1722b014063552eb251c', '2015-04-30 20:19:03', '2'),
(178, 'x1', 'parenttestx1@gmail.com', 'e5a3ca484aa834552b52250e753d6d1274a05fa619bc6795f4d0df95d04070d9', 'cNHOx8e4gKjhz1NdhffbR67BiRezPL63zMQ8U6abPtsougCMvRYmW5XfWcOMYUOyH', '4', '', '2015-05-07 06:30:43', '2'),
(179, 'x2', 'parentx2@gmail.com', '5a3489e62ee1a19d8ed80882384f3b79397a94eacf67bc88435701c24875724f', 'qlG2GtbN34QQhJJ93AvDX7eJFO0RFQW7bC9S7jF0nwZFfJNikjVhp015YaWE2SKcv', '4', '', '2015-05-07 06:41:15', '2'),
(180, 'childx1', 'childtestx1@gmail.com', 'd3e6a79f47ec029b21845650c0f9298712526c4781c5ca5f54e0c5c04b1b5c1c', 'Q9Isp02489yxBKAQWwNmgXBbARZqweImmqPMzQQGZoeB0Pr7lfsCd4NOVNer2XNon', '3', '', '2015-05-07 09:17:22', '2'),
(181, 'sanvidhan', 'sanvidhan@oab.com', '1683d4fef0693380c6111a783f13cd0c43225eee31afde8c3ba2acb0e0647f8f', 'LM88fsD8OaPpuJdaqtD6meNxnnfyLu7xheEwHiEwtuVXd09ECMJY1xwoUMWGh4dyi', '4', '', '2015-05-27 14:07:55', '2');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user_activities`
--

CREATE TABLE IF NOT EXISTS `tbl_user_activities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `requestfrom` int(11) NOT NULL COMMENT 'this is userid parent/child',
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `activity_type` enum('1','2','3','4','5','6','7','8','9','10','11','12','13') NOT NULL COMMENT '1: child  fund request  ;  2: fund transfered by parent; 3: misioon added by parent ;  4: mission accepted child ;  5: mission canceled by child ;  6: mission canceled by parent ;  7: mission completed by child;  8: mission completed by parent; 9: mission reminder by parent 10: add parent ; 11: add child ;  12: child request canceled by parent  13: parent request caanceled by child',
  `inserted_date` datetime NOT NULL,
  `status` enum('0','1','2') NOT NULL DEFAULT '2' COMMENT '0: logical delete;1: private ;2 :public',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=233 ;

--
-- Dumping data for table `tbl_user_activities`
--

INSERT INTO `tbl_user_activities` (`id`, `userId`, `requestfrom`, `title`, `description`, `activity_type`, `inserted_date`, `status`) VALUES
(160, 127, 126, 'Request accepted', 'Your request has been accepted by childthree test : a Secret Agent (child) is added to the list.', '13', '2015-04-02 06:45:13', '2'),
(159, 127, 126, 'Request accepted', 'Your request has been accepted by childthree test : a Secret Agent (child) is added to the list.', '13', '2015-04-02 06:39:20', '2'),
(158, 127, 126, 'Request accepted', 'Your request has been accepted by childthree test : a Secret Agent (child) is added to the list.', '13', '2015-04-02 06:39:02', '2'),
(157, 127, 126, 'Request accepted', 'Your request has been accepted by childthree test : a Secret Agent (child) is added to the list.', '13', '2015-04-02 06:38:58', '2'),
(156, 127, 126, 'Request accepted', 'Your request has been accepted by childthree test : a Secret Agent (child) is added to the list.', '13', '2015-04-02 06:38:46', '2'),
(155, 127, 126, 'Request accepted', 'Your request has been accepted by childthree test : a Secret Agent (child) is added to the list.', '13', '2015-04-02 06:38:30', '2'),
(154, 135, 158, 'commander request from Parent Parent', 'New commander request from Parent Parent', '11', '2015-04-02 02:15:12', '2'),
(153, 126, 127, 'commander request from parentthree test', 'New commander request from parentthree test', '11', '2015-04-01 13:28:36', '2'),
(161, 127, 126, 'Request accepted', 'Your request has been accepted by childthree test : a Secret Agent (child) is added to the list.', '13', '2015-04-02 09:07:04', '2'),
(162, 127, 126, 'Request accepted', 'Your request has been accepted by childthree test : a Secret Agent (child) is added to the list.', '13', '2015-04-02 10:00:15', '2'),
(163, 123, 162, 'commander request from Pluts Oab', 'New commander request from Pluts Oab', '11', '2015-04-02 10:47:29', '2'),
(164, 135, 141, 'Mission added by Bianca Padilla', 'New mission added by Bianca Padilla', '3', '2015-04-16 11:51:01', '2'),
(165, 121, 120, 'Mission added by Parent Test', 'New mission added by Parent Test', '3', '2015-04-20 15:00:05', '2'),
(166, 121, 120, 'Mission Edited', 'Mission is edited by Parent Test', '2', '2015-04-20 18:46:43', '2'),
(167, 122, 123, 'Mission Accpeted', 'Mission is accepted by Child Test : Cleaning task', '3', '2015-04-20 13:19:58', '2'),
(168, 121, 120, 'Mission Edited', 'Mission is edited by Parent Test', '2', '2015-04-20 18:52:52', '2'),
(169, 121, 120, 'Mission Edited', 'Mission is edited by Parent Test', '2', '2015-04-20 18:53:24', '2'),
(170, 121, 120, 'Mission Edited', 'Mission is edited by Parent Test', '2', '2015-04-20 19:18:17', '2'),
(171, 134, 120, 'Mission Edited', 'Mission is edited by Parent Test', '2', '2015-04-20 10:33:00', '2'),
(172, 135, 141, 'Mission added by Bianca Padilla', 'New mission added by Bianca Padilla', '3', '2015-04-27 13:33:19', '2'),
(173, 135, 141, 'Mission Edited', 'Mission is edited by Bianca Padilla', '2', '2015-04-27 13:34:43', '2'),
(174, 141, 166, 'commander request from Emilia Padilla', 'Emilia Padilla has requested to add you as a Parent. Accept now!', '10', '2015-04-29 17:35:56', '2'),
(175, 166, 167, 'parent request from Mercy Padilla', 'New parent request from Mercy Padilla', '11', '2015-04-29 22:12:26', '2'),
(176, 167, 166, '', 'Your request has been accepted by Emilia Padilla : a child is added to the list.', '13', '2015-04-29 22:15:41', '2'),
(177, 167, 166, '', 'Your request has been accepted by Emilia Padilla : a child is added to the list.', '13', '2015-04-29 22:15:56', '2'),
(178, 166, 141, '', 'Your request has been accepted by Bianca Padilla : a child is added to the list.', '13', '2015-04-29 22:19:01', '2'),
(179, 135, 141, 'Mission added by Bianca Padilla', 'New mission added by Bianca Padilla', '3', '2015-04-29 17:39:51', '2'),
(180, 135, 141, 'Mission edited', 'Mission is edited by Bianca Padilla', '2', '2015-04-29 18:17:44', '2'),
(181, 173, 162, 'Mission added by Pluts Oab', 'New mission added by Pluts Oab', '3', '2015-04-30 18:48:32', '2'),
(182, 171, 162, 'Mission added by Pluts Oab', 'New mission added by Pluts Oab', '3', '2015-04-30 18:48:32', '2'),
(183, 172, 162, 'Mission added by Pluts Oab', 'New mission added by Pluts Oab', '3', '2015-04-30 18:48:32', '2'),
(184, 170, 162, 'Mission added by Pluts Oab', 'New mission added by Pluts Oab', '3', '2015-04-30 18:48:32', '2'),
(185, 171, 162, 'Mission added by Pluts Oab', 'New mission added by Pluts Oab', '3', '2015-04-30 18:49:30', '2'),
(186, 175, 177, 'parent request from Dad ', 'New parent request from Dad ', '11', '2015-04-30 20:19:15', '2'),
(187, 176, 177, 'parent request from Dad ', 'New parent request from Dad ', '11', '2015-04-30 20:19:26', '2'),
(188, 174, 176, 'commander request from Son ', 'Son  has requested to add you as a Parent. Accept now!', '10', '2015-04-30 20:26:24', '2'),
(189, 137, 147, 'parent request from Jeremy Weisberg', 'New parent request from Jeremy Weisberg', '11', '2015-05-03 13:05:07', '2'),
(190, 134, 147, 'Mission added by Jeremy Weisberg', 'New mission added by Jeremy Weisberg', '3', '2015-05-03 09:09:59', '2'),
(191, 121, 127, 'Mission added by parentthree test', 'New mission added by parentthree test', '3', '2015-05-07 16:12:09', '2'),
(192, 134, 0, 'Parent Test', ' Donâ€™t forget! You have Mission Test from Parent Test waiting to be tackled!', '9', '2015-05-08 14:17:36', '2'),
(193, 135, 141, 'Mission added by Bianca Padilla', 'New mission added by Bianca Padilla', '3', '2015-05-13 18:12:45', '2'),
(194, 121, 127, 'Mission added by parentthree test', 'New mission added by parentthree test', '3', '2015-05-27 15:30:24', '2'),
(195, 121, 181, 'parent request from sanvidhan sonone', 'New parent request from sanvidhan sonone', '11', '2015-05-27 14:08:29', '0'),
(196, 181, 121, '', 'Your request has been accepted by Child Test : a child is added to the list.', '13', '2015-06-01 06:56:13', '2'),
(197, 181, 121, '', 'Your request has been accepted by Child Test : a child is added to the list.', '13', '2015-06-01 08:36:24', '2'),
(198, 181, 121, '', 'Your request has been accepted by Child Test : a child is added to the list.', '13', '2015-06-01 08:40:22', '2'),
(199, 181, 121, '', 'Your request has been accepted by Child Test : a child is added to the list.', '13', '2015-06-01 09:23:47', '2'),
(200, 181, 121, '', 'Your request has been accepted by Child Test : a child is added to the list.', '13', '2015-06-01 11:30:46', '2'),
(201, 181, 121, '', 'Your request has been accepted by Child Test : a child is added to the list.', '13', '2015-06-01 11:30:52', '2'),
(202, 181, 121, '', 'Your request has been accepted by Child Test : a child is added to the list.', '13', '2015-06-01 11:31:22', '2'),
(203, 127, 121, 'Mision accepted', 'Mission is accepted by Child Test : take out the trash', '3', '2015-06-01 11:31:50', '2'),
(204, 127, 121, 'Mision accepted', 'Mission is accepted by Child Test : take out the trash', '3', '2015-06-01 11:31:58', '2'),
(205, 181, 121, '', 'Your request has been accepted by Child Test : a child is added to the list.', '13', '2015-06-01 11:36:23', '2'),
(206, 181, 121, '', 'Your request has been rejected by Child Test : a child is added to the list.', '13', '2015-06-01 11:38:32', '2'),
(207, 181, 121, '', 'Your request has been rejected by Child Test : a child is added to the list.', '13', '2015-06-01 13:18:36', '2'),
(208, 181, 121, '', 'Your request has been rejected by Child Test : a child is added to the list.', '13', '2015-06-01 13:18:43', '2'),
(209, 181, 121, '', 'Your request has been rejected by Child Test : a child is added to the list.', '13', '2015-06-01 13:19:02', '2'),
(210, 181, 121, '', 'Your request has been rejected by Child Test : a child is added to the list.', '13', '2015-06-01 13:30:10', '2'),
(211, 181, 121, '', 'Your request has been rejected by Child Test : a child is added to the list.', '13', '2015-06-01 13:30:29', '2'),
(212, 181, 121, '', 'Your request has been rejected by Child Test : a child is added to the list.', '13', '2015-06-01 13:31:46', '2'),
(213, 120, 121, 'Mission completed by Child Test', 'Congrats, Child Test completed their Mission! Approve now to send reward!Child Test', '7', '0000-00-00 00:00:00', '2'),
(214, 120, 121, 'Mission completed by Child Test', 'Congrats, Child Test completed their Mission! Approve now to send reward!Child Test', '7', '0000-00-00 00:00:00', '2'),
(215, 175, 174, 'parent request from Mom ', 'New parent request from Mom ', '11', '2015-06-04 15:38:45', '2'),
(216, 135, 141, 'Mission added by Bianca Padilla', 'New mission added by Bianca Padilla', '3', '2015-06-15 18:37:57', '2'),
(217, 133, 135, 'Mission completed by Emilia Padilla', 'Congrats, Emilia Padilla completed their Mission! Approve now to send reward!Emilia Padilla', '7', '0000-00-00 00:00:00', '2'),
(218, 133, 135, 'Mission completed by Emilia Padilla', 'Congrats, Emilia Padilla completed their Mission! Approve now to send reward!Emilia Padilla', '7', '0000-00-00 00:00:00', '2'),
(219, 141, 135, 'Mision accepted', 'Mission is accepted by Emilia Padilla : Take out trash', '3', '2015-06-15 22:41:38', '2'),
(220, 141, 135, 'Mision accepted', 'Mission is accepted by Emilia Padilla : Take out trash', '3', '2015-06-15 22:41:39', '2'),
(221, 141, 135, 'Mision accepted', 'Mission is accepted by Emilia Padilla : Take out trash', '3', '2015-06-15 22:41:44', '2'),
(222, 141, 135, 'Mision accepted', 'Mission is accepted by Emilia Padilla : Take out trash', '3', '2015-06-15 22:42:03', '2'),
(223, 141, 135, 'Mision accepted', 'Mission is accepted by Emilia Padilla : Take out trash', '3', '2015-06-15 22:42:05', '2'),
(224, 141, 135, 'Mision accepted', 'Mission is accepted by Emilia Padilla : Take out trash', '3', '2015-06-15 22:42:14', '2'),
(225, 141, 135, 'Payment request from Emilia Padilla', 'Child Emilia Padilla has requested a payment. Swipe to view.', '1', '2015-06-15 22:43:10', '2'),
(226, 141, 135, 'Mission completed by Emilia Padilla', 'Congrats, Emilia Padilla completed their Mission! Approve now to send reward!Emilia Padilla', '7', '0000-00-00 00:00:00', '2'),
(227, 141, 135, 'Mission completed by Emilia Padilla', 'Congrats, Emilia Padilla completed their Mission! Approve now to send reward!Emilia Padilla', '7', '0000-00-00 00:00:00', '2'),
(228, 141, 135, 'Mission completed by Emilia Padilla', 'Congrats, Emilia Padilla completed their Mission! Approve now to send reward!Emilia Padilla', '7', '0000-00-00 00:00:00', '2'),
(229, 141, 135, 'Mission completed by Emilia Padilla', 'Congrats, Emilia Padilla completed their Mission! Approve now to send reward!Emilia Padilla', '7', '0000-00-00 00:00:00', '2'),
(230, 141, 135, 'Mission completed by Emilia Padilla', 'Congrats, Emilia Padilla completed their Mission! Approve now to send reward!Emilia Padilla', '7', '0000-00-00 00:00:00', '2'),
(231, 120, 121, 'Mission completed by Child Test', 'Congrats, Child Test completed their Mission! Approve now to send reward!Child Test', '7', '0000-00-00 00:00:00', '2'),
(232, 120, 121, 'Mission completed by Child Test', 'Congrats, Child Test completed their Mission! Approve now to send reward!Child Test', '7', '0000-00-00 00:00:00', '2');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user_badges`
--

CREATE TABLE IF NOT EXISTS `tbl_user_badges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `badgeId` int(11) NOT NULL,
  `childId` int(11) NOT NULL,
  `parentId` int(11) NOT NULL,
  `inserted_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=32 ;

--
-- Dumping data for table `tbl_user_badges`
--

INSERT INTO `tbl_user_badges` (`id`, `badgeId`, `childId`, `parentId`, `inserted_date`) VALUES
(18, 1, 143, 1, '2015-03-11 19:40:15'),
(17, 1, 142, 1, '2015-03-11 06:21:12'),
(16, 1, 137, 1, '2015-03-07 22:18:53'),
(15, 1, 135, 1, '2015-03-05 15:54:27'),
(14, 1, 134, 1, '2015-03-05 15:44:55'),
(13, 1, 126, 1, '2015-02-27 10:33:56'),
(12, 1, 125, 1, '2015-02-27 10:30:56'),
(11, 1, 123, 1, '2015-02-27 07:36:09'),
(10, 1, 121, 1, '2015-02-27 07:12:00'),
(19, 1, 149, 1, '2015-03-18 13:09:32'),
(20, 1, 152, 1, '2015-03-19 15:27:25'),
(21, 2, 143, 0, '2015-03-26 00:00:00'),
(22, 1, 160, 0, '2015-04-01 06:49:04'),
(23, 1, 166, 0, '2015-04-29 17:33:56'),
(24, 1, 169, 0, '2015-04-30 12:21:13'),
(25, 1, 170, 0, '2015-04-30 12:56:42'),
(26, 1, 171, 0, '2015-04-30 13:01:46'),
(27, 1, 172, 0, '2015-04-30 13:07:02'),
(28, 1, 173, 0, '2015-04-30 13:08:34'),
(29, 1, 175, 0, '2015-04-30 20:15:06'),
(30, 1, 176, 0, '2015-04-30 20:15:42'),
(31, 1, 180, 0, '2015-05-07 09:17:23');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user_information`
--

CREATE TABLE IF NOT EXISTS `tbl_user_information` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `fname` varchar(50) NOT NULL,
  `lname` varchar(50) NOT NULL,
  `gender` enum('m','f') NOT NULL DEFAULT 'm' COMMENT 'm: male;f:female',
  `country` int(11) NOT NULL,
  `dob` date NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `tutorialshow` enum('y','n') NOT NULL DEFAULT 'n',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=175 ;

--
-- Dumping data for table `tbl_user_information`
--

INSERT INTO `tbl_user_information` (`id`, `userId`, `fname`, `lname`, `gender`, `country`, `dob`, `avatar`, `tutorialshow`) VALUES
(148, 154, 'parentzone', 'test', 'm', 80, '1987-03-23', '', 'n'),
(147, 153, 'parentthreeone', 'test', 'm', 103, '1984-03-23', '', 'n'),
(146, 152, 'shooter', 'oab', 'm', 5, '1994-03-19', '', 'n'),
(145, 151, 'parentoneone', 'test', 'm', 5, '1991-03-19', '', 'n'),
(144, 150, 'Parent', 'Oab', 'm', 10, '1987-03-18', '1426686870_550983968be9c_150.jpg', 'n'),
(143, 149, 'Bianca', 'Padilla', 'm', 3, '2015-03-18', '', 'n'),
(142, 148, 'Vipul', 'Barhate', 'm', 0, '0000-00-00', '1426497729_5506a0c106eb6_148.jpg', 'n'),
(141, 147, 'Jeremy', 'Weisberg', 'm', 0, '0000-00-00', '1426335586_55042762ae66d_147.jpg', 'n'),
(140, 146, 'Carlos', 'Padilla', 'm', 1, '1965-07-06', '', 'n'),
(139, 145, 'Vipul', 'Oab', 'm', 5, '1987-03-13', '1429872390_553a1f0692dcb_145.jpg', 'n'),
(138, 144, 'ash', 'Gobindram', 'm', 1, '1985-05-18', '1426176821_5501bb350b1c1_144.jpg', 'n'),
(137, 143, 'B', 'H', 'm', 6, '2015-03-11', '', 'n'),
(136, 142, 'Fuchka', 'woof', 'm', 99, '2014-11-21', '1426054901_54ffdef5b4867_142.jpg', 'n'),
(135, 141, 'Bianca', 'Padilla', 'm', 0, '1993-01-27', '1426001822_54ff0f9e9b762_141.jpg', 'n'),
(134, 140, 'Oab', 'Test', 'm', 140, '1984-03-10', '', 'n'),
(133, 139, 'Debashis', 'Chandra', 'm', 0, '0000-00-00', '1425972914_54fe9eb2c63d5_139.jpg', 'n'),
(132, 138, 'Gaurav', 'Taywade', 'm', 0, '1984-02-23', '1425901803_54fd88ebba5b4_138.jpg', 'n'),
(131, 137, 'Bianca', 'Padilla', 'm', 5, '2009-11-02', '1425767790_54fb7d6e36780_137.jpg', 'n'),
(130, 136, 'Jeremy', 'Weisberg', 'm', 1, '1985-09-03', '1425765951_54fb763f7d92e_136.jpg', 'n'),
(129, 135, 'Emilia', 'Padilla', 'm', 6, '2015-03-05', '1426211109_550241258a3d9_135.jpg', 'n'),
(128, 134, 'Bianca', 'child', 'm', 7, '2015-03-05', '', 'n'),
(127, 133, 'Mom', 'Padilla', 'm', 1, '1958-03-05', '1425571197_54f87d7de8a26_133.jpg', 'n'),
(126, 132, 'Bhushan', 'Uparkar', 'm', 0, '1987-06-12', '1425565590_54f86796b4201_132.jpg', 'n'),
(125, 131, 'parentseven', 'test', 'm', 39, '1968-03-02', '', 'n'),
(124, 130, 'parentsix', 'test', 'm', 2, '1982-03-02', '', 'n'),
(123, 129, 'parentfive', 'test', 'm', 25, '1980-03-02', '', 'n'),
(122, 128, 'parentfour', 'test', 'm', 16, '1977-03-02', '', 'n'),
(121, 127, 'parentthree', 'test', 'm', 4, '1977-03-02', '', 'n'),
(120, 126, 'childthree', 'test', 'm', 143, '1989-02-27', '', 'n'),
(119, 125, 'childtwo', 'test', 'm', 56, '1994-02-27', '', 'n'),
(118, 124, 'parenttwo', 'test', 'm', 81, '1981-02-27', '', 'n'),
(117, 123, 'Jay', 'Mankar', 'm', 99, '2003-02-27', '', 'n'),
(116, 122, 'Jayant', 'Mankar', 'm', 99, '1988-10-18', '1427116644_5510126414e3b_122.jpg', 'n'),
(115, 121, 'Child', 'Test', 'm', 99, '1987-06-03', '1429523162_5534cada0836f_121.jpg', 'n'),
(114, 120, 'Parent', 'Test', 'm', 99, '1988-06-12', '1425040971_54f0664b37c6c_120.jpg', 'n'),
(149, 155, 'nitin', 'zagz', 'm', 54, '1991-03-27', '', 'n'),
(150, 156, 'mangesh', 'oab', 'm', 18, '1989-03-27', '', 'n'),
(151, 157, 'manoj', 'oab', 'm', 5, '1992-03-27', '', 'n'),
(152, 158, 'Parent', 'Parent', 'm', 6, '1964-03-27', '', 'n'),
(153, 159, 'ram', 'oab', 'm', 0, '1991-03-31', '', 'n'),
(154, 160, 'xander', '', 'm', 0, '2000-04-01', '', 'n'),
(155, 161, 'sachin', 'oab', 'm', 0, '1990-04-01', '', 'n'),
(156, 162, 'Pluts', 'Oab', 'm', 0, '0000-00-00', '1427971526_551d1dc69d191_162.jpg', 'n'),
(157, 164, 'Fgh', '', 'm', 0, '2015-04-23', '', 'n'),
(158, 165, 'm', 'm', 'm', 6, '2015-04-27', '', 'n'),
(159, 166, 'Emilia', 'Padilla', 'm', 0, '2014-05-03', '', 'n'),
(160, 167, 'Mercy', 'Padilla', 'm', 0, '2015-04-29', '', 'n'),
(161, 168, 'Wilhelmina', 'Pantaleon', 'm', 0, '1983-07-17', '', 'n'),
(162, 169, 'Emma', 'Watson', 'm', 0, '2015-04-30', '', 'n'),
(163, 170, 'Chris', 'Gayle', 'm', 0, '2004-04-30', '1430398602_5542268a6da87_170.jpg', 'n'),
(164, 171, 'Tyrin', 'Lanister', 'm', 0, '2008-04-30', '1430398906_554227ba01c0b_171.jpg', 'n'),
(165, 172, 'Tenley', 'Stark', 'm', 0, '2008-04-30', '1430399222_554228f6837db_172.jpg', 'n'),
(166, 173, 'Eddard', 'Stark', 'm', 0, '2007-04-30', '1430399313_55422951beee5_173.jpg', 'n'),
(167, 174, 'Mom', '', 'm', 0, '2015-04-30', '1430424754_55428cb2162e2_174.jpg', 'n'),
(168, 175, 'Daughter', '', 'm', 0, '1999-04-30', '', 'n'),
(169, 176, 'Son', '', 'm', 0, '2004-04-30', '', 'n'),
(170, 177, 'Dad', '', 'm', 0, '1960-04-30', '1430425143_55428e373c5ad_177.jpg', 'n'),
(171, 178, 'parent', 'x', 'm', 0, '1976-05-07', '', 'n'),
(172, 179, 'parentx', 'testxtwo', 'm', 0, '1979-05-07', '', 'n'),
(173, 180, 'child', 'testxone', 'm', 0, '1997-05-07', '', 'n'),
(174, 181, 'sanvidhan', 'sonone', 'm', 0, '1992-05-27', '1433151616_556c288027b1f_181.jpg', 'n');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user_relation`
--

CREATE TABLE IF NOT EXISTS `tbl_user_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `childId` int(11) NOT NULL,
  `parentId` int(11) NOT NULL,
  `requestfrom` int(11) NOT NULL,
  `requestto` int(11) NOT NULL,
  `parent_type` enum('1','2','3') NOT NULL DEFAULT '1' COMMENT '1: parent; 2: family;3:friend',
  `relation_name` varchar(30) NOT NULL,
  `inserted_date` datetime NOT NULL,
  `seenstatus` enum('y','n') NOT NULL DEFAULT 'n',
  `status` enum('0','1','2') NOT NULL DEFAULT '2',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=116 ;

--
-- Dumping data for table `tbl_user_relation`
--

INSERT INTO `tbl_user_relation` (`id`, `childId`, `parentId`, `requestfrom`, `requestto`, `parent_type`, `relation_name`, `inserted_date`, `seenstatus`, `status`) VALUES
(86, 143, 120, 0, 0, '1', 'Parent', '2015-03-19 06:18:02', 'n', '2'),
(85, 134, 147, 0, 0, '3', 'Friend', '2015-03-14 12:21:58', 'n', '2'),
(84, 142, 145, 0, 0, '3', 'Friend', '2015-03-13 15:34:42', 'n', '2'),
(83, 142, 120, 0, 0, '1', 'Parent', '2015-03-13 14:17:09', 'n', '2'),
(82, 142, 139, 0, 0, '1', 'Parent', '2015-03-11 06:22:16', 'n', '2'),
(81, 134, 120, 0, 0, '1', 'Parent', '2015-03-11 02:23:07', 'n', '2'),
(80, 135, 141, 0, 0, '1', 'Parent', '2015-03-10 15:38:15', 'n', '2'),
(79, 134, 136, 0, 0, '1', 'Parent', '2015-03-07 22:35:10', 'n', '2'),
(78, 137, 136, 0, 0, '1', 'Parent', '2015-03-07 22:21:18', 'n', '2'),
(77, 135, 133, 0, 0, '1', 'Parent', '2015-03-05 15:54:58', 'n', '2'),
(76, 121, 132, 0, 0, '1', 'Parent', '2015-03-05 14:32:39', 'n', '2'),
(75, 121, 122, 0, 0, '1', 'Parent', '2015-03-03 15:45:16', 'n', '2'),
(74, 123, 122, 0, 0, '1', 'Parent', '2015-02-27 07:36:43', 'n', '2'),
(73, 121, 120, 0, 0, '1', 'Parent', '2015-02-27 07:32:20', 'n', '2'),
(87, 121, 150, 121, 150, '1', 'Parent', '2015-03-25 14:27:37', 'n', '2'),
(88, 121, 127, 121, 127, '1', 'Parent', '2015-03-26 07:00:43', 'n', '2'),
(89, 126, 120, 120, 126, '1', 'Parent', '2015-03-26 09:32:59', 'n', '1'),
(97, 125, 124, 124, 125, '1', 'Parent', '2015-03-27 12:36:01', 'n', '1'),
(91, 123, 120, 120, 123, '1', 'Parent', '2015-03-26 09:48:11', 'n', '1'),
(92, 126, 155, 155, 126, '1', 'Parent', '2015-03-27 11:44:00', 'n', '1'),
(93, 126, 156, 156, 126, '1', 'Parent', '2015-03-27 11:51:17', 'n', '1'),
(98, 125, 159, 159, 125, '1', 'Parent', '2015-03-31 11:16:56', 'n', '1'),
(96, 125, 156, 125, 156, '1', 'Parent', '2015-03-27 12:34:50', 'n', '1'),
(99, 160, 124, 124, 160, '1', 'Parent', '2015-04-01 06:49:41', 'n', '1'),
(100, 126, 124, 124, 126, '1', 'Parent', '2015-04-01 10:57:52', 'n', '1'),
(101, 126, 127, 127, 126, '1', 'Parent', '2015-04-01 13:28:36', 'n', ''),
(102, 135, 158, 158, 135, '1', 'Parent', '2015-04-02 02:15:12', 'n', '1'),
(103, 123, 162, 162, 123, '1', 'Parent', '2015-04-02 10:47:29', 'n', '1'),
(104, 166, 141, 166, 141, '1', 'Parent', '2015-04-29 17:35:56', 'n', '1'),
(105, 166, 167, 167, 166, '1', 'Parent', '2015-04-29 22:12:26', 'n', ''),
(106, 173, 162, 162, 173, '1', 'parent', '0000-00-00 00:00:00', 'n', '2'),
(107, 171, 162, 162, 171, '1', 'parent', '0000-00-00 00:00:00', 'n', '2'),
(108, 172, 162, 162, 172, '1', 'parent', '0000-00-00 00:00:00', 'n', '2'),
(109, 170, 162, 162, 170, '1', 'parent', '0000-00-00 00:00:00', 'n', '2'),
(110, 175, 177, 177, 175, '1', 'Parent', '2015-04-30 20:19:15', 'n', '2'),
(111, 176, 177, 177, 176, '1', 'Parent', '2015-04-30 20:19:26', 'n', '2'),
(112, 176, 174, 176, 174, '1', 'Parent', '2015-04-30 20:26:24', 'n', '1'),
(113, 137, 147, 147, 137, '3', 'Friend', '2015-05-03 13:05:07', 'n', '1'),
(114, 121, 181, 181, 121, '1', 'Parent', '2015-05-27 14:08:29', 'n', '0'),
(115, 175, 174, 174, 175, '1', 'Parent', '2015-06-04 15:38:45', 'n', '2');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
