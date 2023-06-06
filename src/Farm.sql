-- Create TABLE T_SeedType
CREATE TABLE [dbo].[T_SeedType] (
  [id] bigint  IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [typeId] int  NOT NULL,
  [typeName] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL
)

INSERT INTO [dbo].[T_SeedType] ([typeId], [typeName]) 
VALUES 	(1, '普通'),
		(2, '高级'),
		(3, '梦幻')

-- Create Table T_Soil
CREATE TABLE [dbo].[T_Soil] (
	[id] bigint  IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[soilId] int  NOT NULL,
	[soilName] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL
)

INSERT INTO [dbo].[T_Soil] ([soilId], [soilName]) 
VALUES	(1, '黄土地'),
		(2, '黑土地'),
		(3, '红土地'),
		(4, '金土地')

-- Create Table T_CropStatus
CREATE TABLE [dbo].[T_CropStatus] (
	[id] bigint  IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[statusId] int  NOT NULL,
	[statusName] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL
)

INSERT INTO [dbo].[T_CropStatus] ([statusId], [statusName])
VALUES	(1, '种子阶段'),
		(2, '生长阶段'),
		(3, '成熟阶段'),
		(4, '枯草期')
	
-- Create table T_Seed
CREATE TABLE [dbo].[T_Seed] (
  [id] bigint  IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [seedId] int  NOT NULL,
  [seedName] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL,
  [season] int  NOT NULL,
  [seedLevel] int  NOT NULL,
  [seedType] int  NOT NULL,
  [experience] int  NOT NULL,
  [matureTime] int  NOT NULL,
  [harvest] int  NOT NULL,
  [purchasePrice] int  NOT NULL,
  [salePrice] int  NOT NULL,
  [soil] int  NOT NULL,
  [points] int  NOT NULL,
  [prompt] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL
)

-- Insert data for table T_Seed
INSERT INTO [dbo].[T_Seed] ([seedId], [seedName], [season], [seedLevel], [seedType], [experience], [matureTime], [harvest], [purchasePrice], [salePrice], [soil], [points], [prompt])
VALUES
  (1, '草莓', 2, 0, 1, 12, 80, 8, 10, 18, 1, 180,'草莓（英文：strawberry）是一种常见的水果，甜美可口，富含维生素C。草莓不宜与柠檬一同食用，以免引起胃不适。'),
  (6, '茄子', 2, 1, 2, 16, 110, 10, 12, 20, 3, 200, '小贴士：茄子(英文：eggplant)是一种紫色的蔬菜，富含纤维素。'),
  (7, '西红柿', 4, 1, 2, 18, 100, 12, 15, 22, 2, 220, '小贴士：西红柿(英文：tomato)是一种常见的红色蔬果，富含维生素C和抗氧化物质。西红柿可以生食或烹饪食用，是许多菜肴的重要成分。'),
  (8, '豆荚', 4, 1, 1, 26, 240, 60, 35, 45, 2, 300, '豆荚（英文：pea pod）是一种蔬菜，内含嫩豌豆，口感爽脆。豆荚不宜与山楂同时食用，以免引起胃部不适。'),
  (9, '辣椒', 2, 3, 1, 16, 140, 40, 35, 35, 2, 340, '辣椒（英文：chili pepper）是一种常见的调味品，具有辛辣的味道和独特的风味。辣椒不宜与牛奶同时食用。'),
  (13, '葡萄', 1, 0, 1, 14, 90, 8, 10, 18, 3, 180, '葡萄（英文：grape）是一种多汁的水果，味道酸甜可口，富含抗氧化物。葡萄不宜与大蒜同时食用，以免产生不良反应。'),
  (14, '西瓜', 1, 1, 1, 24, 210, 50, 30, 40, 1, 280, '西瓜（英文：watermelon）是一种夏季常见的水果，具有清凉解暑的特点。西瓜不宜与蟹肉同时食用，以免引起消化不良。'),
  (32, '水晶果', 1, 4, 3, 12, 420, 20, 15, 25, 1, 930, '水晶果（英文：Crystal Fruit）是一种珍稀的观赏植物，研磨后可入药，味苦，性凉，食用后可抗衰老。常生长于地底深处。'),
  (30, '星星花', 2, 4, 1, 16, 140, 40, 65, 15, 3, 190, '星星花（英文：Starflower）是一种罕见的地外作物，有着很高的观赏价值，常在夜间开花。来自地球之外。'),
  (418, '玉米', 3, 0, 1, 22, 180, 40, 25, 35, 4, 260, '小贴士：玉米(英文：corn)是一种常见的粮食作物，味道香甜可口，含有丰富的营养成分，是人们日常饮食中重要的一部分。'),
  (933, '白萝卜', 1, 0, 1, 16, 100, 10, 12, 20, 1, 200, '小贴士：白萝卜(英文：radish)是一种非常常见的蔬菜，生食熟食均可，其味略带辛辣味。白萝卜不能与人参、西洋参一起吃。'),
  (940, '土豆', 3, 1, 2, 20, 120, 15, 18, 25, 2, 250, '小贴士：土豆(英文：potato)是一种主食类蔬菜，含有丰富的淀粉和维生素。土豆可以烹饪成各种美食，如炖汤、炸薯条等。')
  
-- Create seed growth stage TABLE
CREATE TABLE [dbo].[T_SeedGrowthStage] (
  [id] bigint  IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [seedId] int  NOT NULL,
  [growthStage] int  NOT NULL,
  [growthName] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL,
  [growthTime] int  NOT NULL,
  [pestProbability] float(53)  NOT NULL,
  [width] int  NOT NULL,
  [height] int  NOT NULL,
  [x] int  NOT NULL,
  [y] int  NOT NULL,
  [state] int  NOT NULL
)


-- Insert data to table T_SeedGrowthStage
INSERT INTO [dbo].[T_SeedGrowthStage] ([pestProbability], [growthName], [growthStage], [growthTime], [height], [x], [y], [seedId], [state], [width])
VALUES
	(1, '种子', 0, 5, 101, 54, 215, 1, 1, 97),
	(1, '发芽', 1, 6, 107, 50, 186, 1, 2, 91),
	(1, '小叶子', 2, 7, 152, 48, 160, 1, 2, 107),
	(1, '大叶子', 3, 8, 200, 31, 115, 1, 2, 141),
	(1, '开花', 4, 9, 200, 25, 103, 1, 2, 141),
	(0, '成熟', 5, 10, 234, 4, 75, 1, 3, 194),
	(0, '枯草', 6, 0, 332, 10, 149, 1, 4, 188),
	(1, '种子', 0, 5, 92, 59, 221, 2, 1, 90),
	(0.9, '发芽', 1, 6, 89, 65, 194, 2, 2, 81),
	(0.8, '小叶子', 2, 7, 159, 38, 110, 2, 2, 122),
	(0.7, '大叶子', 3, 8, 200, 43, 102, 2, 2, 141),
	(0.5, '开花', 4, 9, 223, 16, 108, 2, 2, 156),
	(0, '成熟', 5, 10, 239, 12, 98, 2, 3, 165),
	(0, '枯草', 6, 0, 244, 37, 172, 2, 4, 142),
	(1, '种子', 0, 11, 58, 69, 223, 3, 1, 70),
	(0.1, '发芽', 1, 30, 73, 65, 194, 3, 2, 62),
	(0, '小叶子', 2, 40, 136, 57, 168, 3, 2, 97),
	(0.2, '大叶子', 3, 60, 200, 26, 97, 3, 2, 141),
	(0, '开花', 4, 70, 200, 23, 125, 3, 2, 141),
	(0, '成熟', 5, 80, 200, 25, 96, 3, 3, 142),
	(0, '枯草', 6, 0, 200, 31, 182, 3, 4, 142),
	(1, '种子', 0, 5, 92, 53, 217, 4, 1, 92),
	(0.9, '发芽', 1, 6, 105, 65, 194, 4, 2, 80),
	(0.8, '小叶子', 2, 7, 159, 43, 147, 4, 2, 116),
	(0.7, '大叶子', 3, 8, 221, 18, 145, 4, 2, 167),
	(0.6, '开花', 4, 9, 225, 20, 145, 4, 2, 156),
	(0, '成熟', 5, 10, 280, -9, 113, 4, 3, 205),
	(0, '枯草', 6, 0, 247, 26, 176, 4, 4, 161),
	(1, '种子', 0, 10, 53, 72, 226, 5, 1, 59),
	(0.1, '发芽', 1, 30, 73, 65, 194, 5, 2, 62),
	(0.1, '发芽', 1, 30, 73, 65, 194, 5, 2, 62),
	(0, '小叶子', 2, 40, 136, 59, 165, 5, 2, 97),
	(0.2, '大叶子', 3, 60, 200, 26, 97, 5, 2, 141),
	(0.2, '开花', 4, 70, 200, 23, 93, 5, 2, 141),
	(0, '成熟', 5, 80, 200, 25, 96, 5, 3, 142),
	(0, '枯草', 6, 0, 200, 31, 182, 5, 4, 142),
	(1, '种子', 0, 10, 53, 72, 226, 5, 1, 59),
	(1, '种子', 0, 5, 92, 62, 218, 6, 1, 85),
	(0.8, '发芽', 1, 6, 99, 62, 165, 6, 2, 83),
	(0.5, '小叶子', 2, 7, 163, 47, 171, 6, 2, 111),
	(0.3, '大叶子', 3, 8, 200, 26, 126, 6, 2, 141),
	(0.1, '开花', 4, 9, 200, 28, 131, 6, 2, 141),
	(0, '成熟', 5, 10, 228, 13, 118, 6, 3, 167),
	(0, '枯草', 6, 0, 253, 25, 171, 6, 4, 157),
	(1, '种子', 0, 10, 53, 72, 226, 7, 1, 59),
	(0.1, '发芽', 1, 30, 73, 65, 194, 7, 2, 62),
	(0, '小叶子', 2, 40, 196, 32, 65, 7, 2, 166),
	(0.2, '大叶子', 3, 60, 200, 26, 97, 7, 2, 141),
	(0.2, '开花', 4, 70, 200, 23, 93, 7, 2, 141),
	(0, '成熟', 5, 80, 301, 5, 46, 7, 3, 225),
	(0, '枯草', 6, 0, 200, 31, 182, 7, 4, 142),
	(1, '种子', 0, 10, 53, 71, 221, 8, 1, 59),
	(0.1, '发芽', 1, 30, 73, 65, 194, 8, 2, 62),
	(0.2, '小叶子', 2, 40, 136, 53, 151, 8, 2, 97),
	(0.2, '大叶子', 3, 60, 200, 26, 97, 8, 2, 141),
	(0.2, '开花', 4, 70, 200, 23, 93, 8, 2, 141),
	(0, '成熟', 5, 80, 200, 47, 114, 8, 3, 142),
	(0, '枯草', 6, 0, 200, 31, 182, 8, 4, 142),
	(1, '种子', 0, 10, 53, 72, 226, 9, 1, 59),
	(0.1, '发芽', 1, 30, 73, 65, 194, 9, 2, 62),
	(0.2, '小叶子', 2, 40, 136, 53, 151, 9, 2, 97),
	(0.2, '大叶子', 3, 60, 200, 26, 97, 9, 2, 141),
	(0.2, '开花', 4, 70, 200, 23, 93, 9, 2, 141),
	(0, '成熟', 5, 80, 200, 25, 96, 9, 3, 142),
	(0, '枯草', 6, 0, 200, 31, 182, 9, 4, 142),
	(1, '种子', 0, 10, 53, 72, 226, 10, 1, 59),
	(0.1, '发芽', 1, 30, 73, 65, 194, 10, 2, 62),
	(0.2, '小叶子', 2, 40, 136, 53, 151, 10, 2, 97),
	(0.2, '大叶子', 3, 60, 200, 26, 97, 10, 2, 141),
	(0.2, '开花', 4, 70, 200, 23, 93, 10, 2, 141),
	(0, '成熟', 5, 80, 200, 25, 96, 10, 3, 142),
	(0, '枯草', 6, 0, 200, 31, 182, 10, 4, 142),
	(1, '种子', 0, 10, 53, 72, 226, 418, 1, 59),
	(0.1, '发芽', 1, 30, 73, 65, 194, 418, 2, 62),
	(0, '小叶子', 2, 40, 136, 56, 132, 418, 2, 97),
	(0.2, '大叶子', 3, 60, 200, 26, 97, 418, 2, 141),
	(0, '开花', 4, 70, 200, 43, 60, 418, 2, 141),
	(0, '成熟', 5, 80, 200, 44, 61, 418, 3, 142),
	(0, '枯草', 6, 0, 200, 31, 182, 418, 4, 142),
	(0.1, '发芽', 1, 30, 73, 65, 194, 940, 2, 62),
	(0.2, '小叶子', 2, 40, 136, 53, 151, 940, 2, 97),
	(0.2, '大叶子', 3, 60, 200, 26, 97, 940, 2, 141),
	(0.2, '开花', 4, 70, 200, 23, 93, 940, 2, 141),
	(0, '成熟', 5, 80, 200, 25, 96, 940, 3, 142),
	(0, '枯草', 6, 0, 200, 31, 182, 940, 4, 142)

-- Create TABLE T_User 
CREATE TABLE [dbo].[T_User] (
  [id] bigint IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [username] varchar(255) COLLATE Chinese_PRC_CI_AS NULL,
  [nickname] varchar(255) COLLATE Chinese_PRC_CI_AS NULL,
  [experience] int NOT NULL,
  [points] int NOT NULL,
  [money] int NOT NULL,
  [avatar] varchar(255) NULL
);

INSERT INTO [dbo].[T_User] ([username], [nickname], [experience], [points], [money], [avatar])
VALUES
('zhaoyun', '赵云', 889, 62989, 7860, 'zhaoyun.jpg'),
('guanyu', '关羽', 750, 54236, 6320, 'guanyu.jpg'),
('liubei', '刘备', 920, 71459, 8960, 'liubei.jpg'),
('sunquan', '孙权', 620, 41975, 5480, 'sunquan.jpg'),
('diaochan', '貂蝉', 480, 32541, 4320, 'diaochan.jpg');


-- CREATE TABLE User_bag 
CREATE TABLE [dbo].[T_UserBag] (
  [id] bigint  IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [userName] varchar(255) COLLATE Chinese_PRC_CI_AS  NULL,
  [seedId] int  NOT NULL,
  [seedNum] int  NOT NULL,
)

INSERT INTO [dbo].[T_UserBag] ([userName], [seedId], [seedNum])
VALUES
('zhaoyun', 1, 5),
('guanyu', 2, 3),
('liubei', 3, 8),
('sunquan', 4, 2),
('diaochan', 5, 4),
('zhaoyun', 6, 10),
('guanyu', 7, 7),
('liubei', 8, 4),
('sunquan', 9, 6),
('diaochan', 1, 3),
('zhaoyun', 4, 2),
('guanyu', 8, 9),
('liubei', 5, 5),
('sunquan', 6, 8),
('diaochan', 6, 7),
('zhaoyun', 3, 3),
('guanyu', 3, 6),
('liubei', 4, 4),
('sunquan', 2, 5),
('diaochan', 9, 2);


CREATE TABLE [dbo].[T_FarmLandStatus] (
  [id] int  IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [username] nvarchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [landIndex] int  NOT NULL,
  [landType] int  NOT NULL,
  [isCrop] int DEFAULT 0 NOT NULL,
  [cropId] int  NULL,
  [cropStatus] int  NULL,
  [currentStage] int,
  [currentStateHasGrownTime] int NULL,
  [stateEndTime] datetime  NULL,
  [currentSeason] int,
  [isInsect] int DEFAULT 0 NOT NULL,
  [isWithered] int DEFAULT 0 NOT NULL,
  [isMature] int  NULL,
  [output] int  NULL,
)

INSERT INTO [dbo].[T_FarmLandStatus] ([username], [landIndex], [landType], [isCrop], [cropId], [cropStatus], [currentStage], [currentStateHasGrownTime], [stateEndTime], [currentSeason], [isInsect], [isWithered], [isMature], [output])
VALUES
('zhaoyun', 1, 1, 1, 1, 1, 0, 0, '2023-05-28 08:00:00', 1, 0, 0, 1, 50),
('zhaoyun', 2, 2, 1, 2, 2, 0, 0, '2023-05-29 10:00:00', 1, 1, 0, 0, 23),
('zhaoyun', 3, 1, 1, 3, 1, 0, 0, '2023-05-30 12:00:00', 1, 0, 1, 1, 60),
('zhaoyun', 4, 2, 0, 4, 3, 0, 0, '2023-05-30 12:00:00', 1, 0, 0, 1, 10),
('zhaoyun', 5, 1, 0, 5, 2, 0, 0, '2023-05-30 12:00:00', 1, 0, 0, 1, 10),
('zhaoyun', 6, 2, 1, 4, 2, 0, 0, '2023-06-01 14:00:00', 1, 1, 1, 0, 10),
('zhaoyun', 7, 1, 1, 5, 1, 0, 0, '2023-06-02 16:00:00', 1, 0, 0, 1, 70),
('zhaoyun', 8, 2, 0, 7, 1, 0, 0, '2023-05-30 12:00:00', 1, 0, 0, 1, 10),
('zhaoyun', 9, 1, 1, 6, 2, 0, 0, '2023-06-03 18:00:00', 1, 1, 0, 0, 10),
('zhaoyun', 10, 2, 1, 1, 1, 0, 0, '2023-06-04 20:00:00', 1, 0, 0, 1, 80);
