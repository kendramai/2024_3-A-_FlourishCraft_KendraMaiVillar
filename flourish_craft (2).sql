-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 01, 2024 at 03:06 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `flourish_craft`
--

-- --------------------------------------------------------

--
-- Table structure for table `cost_raw_materials`
--

CREATE TABLE `cost_raw_materials` (
  `cost_raw_materials_ID` int(11) NOT NULL,
  `raw_materials` varchar(255) DEFAULT NULL,
  `cost` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cost_raw_materials`
--

INSERT INTO `cost_raw_materials` (`cost_raw_materials_ID`, `raw_materials`, `cost`) VALUES
(1, 'Rose', '30'),
(2, 'Wrap', '15'),
(3, 'Cloud Nine', '10'),
(4, 'Goya Take It', '15'),
(5, 'Choco Mucho', '10'),
(6, 'Toblerone', '150'),
(7, 'Dairy Milk 100g', '35'),
(8, 'Kisses', '60'),
(9, 'Goya', '25'),
(10, 'Mini Choco Mucho', '3'),
(11, 'Fairy Lights', '50');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `Customer_ID` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Age` varchar(255) DEFAULT NULL,
  `Gender` varchar(255) DEFAULT NULL,
  `Phone_Number` varchar(255) DEFAULT NULL,
  `House_Number` varchar(255) DEFAULT NULL,
  `Zone` varchar(255) DEFAULT NULL,
  `Barangay` varchar(255) DEFAULT NULL,
  `City` varchar(255) DEFAULT NULL,
  `Province` varchar(255) DEFAULT NULL,
  `Region` varchar(255) DEFAULT NULL,
  `Zip_Code` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Username` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `user_status` char(1) NOT NULL DEFAULT 'A',
  `user_type` char(1) NOT NULL DEFAULT 'C'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`Customer_ID`, `Name`, `Age`, `Gender`, `Phone_Number`, `House_Number`, `Zone`, `Barangay`, `City`, `Province`, `Region`, `Zip_Code`, `Email`, `Username`, `Password`, `user_status`, `user_type`) VALUES
(1, 'Kendra Villar', '21', 'Female', '09052816697', '124', '3', 'Salvacion', 'Polangui', 'Albay', 'V', '4506', 'kendramaivillar21@gmail.com', 'kendra', '0000', 'A', 'A'),
(2, 'Kendra Villar', '21', 'Female', '09052816697', '124', '3', 'Salvacion', 'Polangui', 'Albay', 'V', '4506', 'kendramaivillar21@gmail.com', 'kendra', '0000', 'A', 'C'),
(3, 'Alliah', '20', 'Female', '905 281 6697', '124', '3', 'Salvacion', 'Polangui', 'Albay', 'V', '4506', 'alliah@gmail', 'alliah', '2004', 'A', 'C'),
(4, 'Alliah', '20', 'Female', '905 281 6697', '124', '3', 'Salvacion', 'Polangui', 'Albay', 'V', '4506', 'alliah@gmail', 'alliah', '2004', 'A', 'C'),
(5, 'Andrei Bongalon', '19', 'M', '091111111', '12', '9', 'Ponso', 'Polangui', 'Albay', '5', '4506', 'drei@yahoo.com', 'andrei', '123456', 'A', 'C'),
(6, 'Jap', '19', 'M', '0912121211', '121', '8', 'Alnay', 'Polangui', 'Albay', '5', '4506', 'aaaa@gmail.com', 'Anese', 'Japanese', 'A', 'C'),
(11, 'Paul', '19', 'M', '00291833181', '11', '4', 'Napo', 'Polangui', 'Albay', '5', '4506', 'Powl@gmail.com', 'Powl', '321', 'A', 'C'),
(12, 'Paulygon', '12', 'Female', '0987654321', '44', '3', 'Ponso', 'Polangui', 'Albay', '7', '1212', 'paulygon@gmail.com', 'wow', '1234', 'A', 'C'),
(13, 'Ken', '43', 'M', '091234533', '09', '3', 'Basud', 'Polangui', 'Albay', '5', '4506', 'ken@gg.com', 'kenken', '345', 'A', 'A'),
(14, 'Jonas', '20', 'M', '095431345', '8', '6', 'Anopol', 'Polangui', 'Albay', '5', '4506', 'son@gg.com', 'jonas', 'jonas', 'A', 'C'),
(15, 'John', '20', 'M', '095168865555', '101', '5', 'Mendez', 'Polangui', 'Albay', '5', '4506', 'john@gg.com', 'Jdoe', '3333', 'A', 'C'),
(16, 'Joana Rose Mendoza', '20', 'F', '09155101670', '#0074', 'Zone 3', 'Salvacion', 'Polangui', 'Albay', 'V', '4506', 'joanarosemendoza17@gmail.com', 'joanarose', '12345', 'A', 'C'),
(17, 'Rhea Mai', '22', 'F', '05555554', '58', '7', 'ponso', 'polangui', 'a', 'v', '515', 'mama@gmail.com', 'rhea', '121212', 'A', 'C');

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `Order_ID` int(11) NOT NULL,
  `Customer_ID` int(11) DEFAULT NULL,
  `Set_Name` varchar(255) DEFAULT NULL,
  `Variation` varchar(255) DEFAULT NULL,
  `Quantity` varchar(255) DEFAULT NULL,
  `Price` varchar(255) DEFAULT NULL,
  `Delivery_Date` timestamp NULL DEFAULT current_timestamp(),
  `mode_of_payment` varchar(255) NOT NULL,
  `mode_of_delivery` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`Order_ID`, `Customer_ID`, `Set_Name`, `Variation`, `Quantity`, `Price`, `Delivery_Date`, `mode_of_payment`, `mode_of_delivery`) VALUES
(5, 16, 'SET B', 'pink', '3', '885', '2024-05-30 17:00:00', '', ''),
(6, 16, 'SET F', 'red', '1', '180', '2024-05-30 17:00:00', '', ''),
(7, 16, 'SET A', 'yellow', '1', '810', '2024-05-31 17:00:00', '', ''),
(8, 14, 'SET D', 'red', '3', '162', '2024-05-30 17:00:00', '', ''),
(9, 14, 'SET B', NULL, '1', '295', '2024-05-30 17:00:00', 'COD', 'pick_up'),
(10, 14, 'SET E', NULL, '1', '45', '2024-05-30 17:00:00', 'COD', 'pick up'),
(11, 14, 'SET B', NULL, '1', '295', '2024-05-30 17:00:00', 'COD', 'pick up'),
(12, 14, 'SET B', NULL, '1', '295', '2024-05-30 17:00:00', 'COD', 'pick up'),
(13, 14, 'SET B', NULL, '1', '295', '2024-05-30 17:00:00', 'COD', 'pickup'),
(14, 16, 'SET B', 'violet', '1', '295', '2024-05-30 17:00:00', '', ''),
(15, 16, 'SET B', 'red', '1', '295', '2024-05-30 17:00:00', 'cod', ''),
(16, 16, 'SET A', 'blue', '1', '810', '2024-05-30 17:00:00', 'bank_transfer', 'delivery'),
(17, 12, 'SET E', 'pink', '2', '90', '2024-05-30 17:00:00', 'gcash', 'delivery');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `Payment_ID` int(11) NOT NULL,
  `Order_ID` int(11) DEFAULT NULL,
  `Mode_of_Payment` varchar(255) DEFAULT NULL,
  `Price_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `price`
--

CREATE TABLE `price` (
  `Price_ID` int(11) NOT NULL,
  `Price` varchar(255) DEFAULT NULL,
  `Start_Date` varchar(255) DEFAULT NULL,
  `End_Date` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `price`
--

INSERT INTO `price` (`Price_ID`, `Price`, `Start_Date`, `End_Date`) VALUES
(1, '1100', NULL, NULL),
(2, '500', NULL, NULL),
(3, '450', NULL, NULL),
(4, '80', NULL, NULL),
(5, '70', NULL, NULL),
(6, '250', NULL, NULL),
(7, '199', NULL, NULL),
(8, '800', NULL, NULL),
(9, '550', NULL, NULL),
(10, '380', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `report` (
  `Report_ID` int(11) NOT NULL,
  `Set_ID` int(11) DEFAULT NULL,
  `Order_ID` int(11) DEFAULT NULL,
  `Payment_ID` int(11) DEFAULT NULL,
  `Shipping_ID` int(11) DEFAULT NULL,
  `Review_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `Review_ID` int(11) NOT NULL,
  `Customer_Review` varchar(255) DEFAULT NULL,
  `Customer_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `set`
--

CREATE TABLE `set` (
  `Set_ID` int(11) NOT NULL,
  `Set_Name` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Variation` varchar(255) DEFAULT NULL,
  `Cost` varchar(255) DEFAULT NULL,
  `Price_ID` int(11) DEFAULT NULL,
  `set_img` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `set`
--

INSERT INTO `set` (`Set_ID`, `Set_Name`, `Description`, `Variation`, `Cost`, `Price_ID`, `set_img`) VALUES
(1, 'SET A', 'ABCD', 'COLOR', '810', 0, 'SetA.png'),
(2, 'SET B', 'ABCD', NULL, '295', 0, 'SetB.png'),
(3, 'SET C', 'ABCD', NULL, '275', 0, 'SetC.png'),
(4, 'SET D', 'ABCD', NULL, '54', 0, 'SetD.png'),
(5, 'SET E', 'ABCD', NULL, '45', 0, 'SetE.png'),
(6, 'SET F', 'ABCD', NULL, '180', 0, 'SetF.png'),
(7, 'SET G', 'ABCD', NULL, '120', 0, 'SetG.png'),
(8, 'SET H', 'ABCD', NULL, '541', 0, 'SetH.png'),
(9, 'SET I', 'ABCD', NULL, '345', 0, 'SetI.png'),
(10, 'SET J', 'ABCD', NULL, '225', 0, 'SetJ.png');

-- --------------------------------------------------------

--
-- Table structure for table `sets_raw_materials`
--

CREATE TABLE `sets_raw_materials` (
  `sets_raw_materials_ID` int(11) NOT NULL,
  `cost_raw_materials_ID` int(11) DEFAULT NULL,
  `Qty` varchar(255) DEFAULT NULL,
  `Set_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sets_raw_materials`
--

INSERT INTO `sets_raw_materials` (`sets_raw_materials_ID`, `cost_raw_materials_ID`, `Qty`, `Set_ID`) VALUES
(1, 1, '5', 1),
(2, 7, '5', 1),
(3, 8, '2', 1),
(4, 6, '2', 1),
(5, 2, '2', 1),
(6, 9, '5', 2),
(7, 3, '5', 2),
(8, 1, '3', 2),
(9, 2, '2', 2),
(10, 9, '2', 3),
(11, 7, '3', 3),
(12, 1, '3', 3),
(13, 2, '2', 3),
(14, 10, '3', 4),
(15, 1, '1', 4),
(16, 2, '1', 4),
(17, 1, '1', 5),
(18, 2, '1', 5),
(19, 3, '3', 6),
(20, 5, '3', 6),
(21, 1, '3', 6),
(22, 2, '2', 6),
(23, 1, '3', 7),
(24, 2, '2', 7),
(25, 4, '6', 8),
(26, 9, '8', 8),
(27, 1, '5', 8),
(28, 2, '3', 8),
(29, 11, '1', 8),
(30, 1, '10', 9),
(31, 2, '3', 9),
(32, 2, '2', 10),
(33, 1, '3', 10),
(34, 7, '3', 10);

-- --------------------------------------------------------

--
-- Table structure for table `shipping`
--

CREATE TABLE `shipping` (
  `Shipping_ID` int(11) NOT NULL,
  `Tracking Number` varchar(255) DEFAULT NULL,
  `Order_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `User_ID` int(11) NOT NULL,
  `Full_name` varchar(255) DEFAULT NULL,
  `Age` varchar(255) DEFAULT NULL,
  `Gender` varchar(255) DEFAULT NULL,
  `Phone_Number` varchar(255) DEFAULT NULL,
  `House_Number` varchar(255) DEFAULT NULL,
  `Zone` varchar(255) DEFAULT NULL,
  `Barangay` varchar(255) DEFAULT NULL,
  `City` varchar(255) DEFAULT NULL,
  `Province` varchar(255) DEFAULT NULL,
  `Region` varchar(255) DEFAULT NULL,
  `Zip_Code` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Username` int(50) DEFAULT NULL,
  `Password` int(50) DEFAULT NULL,
  `user_status` char(1) NOT NULL DEFAULT 'A',
  `user_type` char(1) NOT NULL DEFAULT 'C'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`User_ID`, `Full_name`, `Age`, `Gender`, `Phone_Number`, `House_Number`, `Zone`, `Barangay`, `City`, `Province`, `Region`, `Zip_Code`, `Email`, `Username`, `Password`, `user_status`, `user_type`) VALUES
(1, 'Drei', '12', 'M', '0911111111', '12', '9', 'Ponso', 'Polangui', 'Albay', '5', '4506', 'drei@gmail.com', 0, 1234, 'A', 'C');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cost_raw_materials`
--
ALTER TABLE `cost_raw_materials`
  ADD PRIMARY KEY (`cost_raw_materials_ID`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`Customer_ID`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`Order_ID`),
  ADD KEY `Customer_ID` (`Customer_ID`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`Payment_ID`),
  ADD KEY `Order_ID` (`Order_ID`),
  ADD KEY `Price_ID` (`Price_ID`);

--
-- Indexes for table `price`
--
ALTER TABLE `price`
  ADD PRIMARY KEY (`Price_ID`);

--
-- Indexes for table `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`Report_ID`),
  ADD KEY `Set_ID1` (`Set_ID`),
  ADD KEY `Order_ID1` (`Order_ID`),
  ADD KEY `Payment_ID1` (`Payment_ID`),
  ADD KEY `Shipping_ID1` (`Shipping_ID`),
  ADD KEY `Review_ID1` (`Review_ID`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`Review_ID`),
  ADD KEY `Customer_ID2` (`Customer_ID`);

--
-- Indexes for table `set`
--
ALTER TABLE `set`
  ADD PRIMARY KEY (`Set_ID`);

--
-- Indexes for table `sets_raw_materials`
--
ALTER TABLE `sets_raw_materials`
  ADD PRIMARY KEY (`sets_raw_materials_ID`),
  ADD KEY `Set_ID2` (`Set_ID`),
  ADD KEY `cost_raw_materials_ID` (`cost_raw_materials_ID`);

--
-- Indexes for table `shipping`
--
ALTER TABLE `shipping`
  ADD PRIMARY KEY (`Shipping_ID`),
  ADD KEY `Order_ID3` (`Order_ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`User_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cost_raw_materials`
--
ALTER TABLE `cost_raw_materials`
  MODIFY `cost_raw_materials_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `Customer_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `Order_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `Payment_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `price`
--
ALTER TABLE `price`
  MODIFY `Price_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `report`
--
ALTER TABLE `report`
  MODIFY `Report_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `Review_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `set`
--
ALTER TABLE `set`
  MODIFY `Set_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `sets_raw_materials`
--
ALTER TABLE `sets_raw_materials`
  MODIFY `sets_raw_materials_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `shipping`
--
ALTER TABLE `shipping`
  MODIFY `Shipping_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `User_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `Customer_ID` FOREIGN KEY (`Customer_ID`) REFERENCES `customers` (`Customer_ID`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `Order_ID` FOREIGN KEY (`Order_ID`) REFERENCES `order` (`Order_ID`),
  ADD CONSTRAINT `Price_ID` FOREIGN KEY (`Price_ID`) REFERENCES `price` (`Price_ID`);

--
-- Constraints for table `report`
--
ALTER TABLE `report`
  ADD CONSTRAINT `Order_ID1` FOREIGN KEY (`Order_ID`) REFERENCES `order` (`Order_ID`),
  ADD CONSTRAINT `Payment_ID1` FOREIGN KEY (`Payment_ID`) REFERENCES `payment` (`Payment_ID`),
  ADD CONSTRAINT `Review_ID1` FOREIGN KEY (`Review_ID`) REFERENCES `review` (`Review_ID`),
  ADD CONSTRAINT `Set_ID1` FOREIGN KEY (`Set_ID`) REFERENCES `set` (`Set_ID`),
  ADD CONSTRAINT `Shipping_ID1` FOREIGN KEY (`Shipping_ID`) REFERENCES `shipping` (`Shipping_ID`);

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `Customer_ID2` FOREIGN KEY (`Customer_ID`) REFERENCES `customers` (`Customer_ID`);

--
-- Constraints for table `sets_raw_materials`
--
ALTER TABLE `sets_raw_materials`
  ADD CONSTRAINT `Set_ID2` FOREIGN KEY (`Set_ID`) REFERENCES `set` (`Set_ID`),
  ADD CONSTRAINT `cost_raw_materials_ID` FOREIGN KEY (`cost_raw_materials_ID`) REFERENCES `cost_raw_materials` (`cost_raw_materials_ID`);

--
-- Constraints for table `shipping`
--
ALTER TABLE `shipping`
  ADD CONSTRAINT `Order_ID3` FOREIGN KEY (`Order_ID`) REFERENCES `order` (`Order_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
