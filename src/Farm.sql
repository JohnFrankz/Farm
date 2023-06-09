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
VALUES	(1, '红土地'),
		(2, '黑土地'),
		(3, '金土地'),
		(4, '紫土地')

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
  (32, '水晶果', 1, 4, 3, 12, 420, 20, 15, 25, 4, 930, '水晶果（英文：Crystal Fruit）是一种珍稀的观赏植物，研磨后可入药，味苦，性凉，食用后可抗衰老。常生长于地底深处。'),
  (30, '星星花', 2, 4, 1, 16, 140, 40, 65, 15, 4, 190, '星星花（英文：Starflower）是一种罕见的地外作物，有着很高的观赏价值，常在夜间开花。来自地球之外。'),
  (418, '玉米', 3, 0, 1, 22, 180, 40, 25, 35, 1, 260, '小贴士：玉米(英文：corn)是一种常见的粮食作物，味道香甜可口，含有丰富的营养成分，是人们日常饮食中重要的一部分。'),
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


INSERT INTO [T_SeedGrowthStage]([seedId], [growthStage], [growthName], [growthTime], [pestProbability], [width], [height], [x], [y], [state])
VALUES (1, 0, '种子', 5, 0.100000001490116, 66, 71, 93, 257, 1),
       (1, 1, '发芽', 6, 0.2, 63, 79, 98, 230, 2),
       (1, 2, '小叶子', 7, 0.2, 78, 124, 94, 219, 2),
       (1, 3, '大叶子', 8, 0.3, 94, 140, 94, 194, 2),
       (1, 4, '开花', 9, 0.100000001490116, 111, 140, 70, 190, 2),
       (1, 5, '成熟', 10, 0.5, 119, 127, 67, 186, 3),
       (1, 6, '枯草', 0, 0, 140, 258, 64, 203, 4),
       (933, 0, '种子', 5, 0.100000001490116, 64, 68, 97, 261, 1),
       (933, 1, '发芽', 6, 0.1, 80, 88, 72, 226, 2),
       (933, 2, '小叶子', 7, 0.2, 121, 158, 59, 175, 2),
       (933, 3, '大叶子', 8, 0.2, 140, 199, 48, 123, 2),
       (933, 4, '开花', 9, 0.3, 155, 222, 38, 91, 2),
       (933, 5, '成熟', 10, 0.200000002980232, 143, 211, 67, 83, 3),
       (933, 6, '枯草', 0, 0, 141, 243, 60, 209, 4),
       (13, 0, '种子', 11, 0.100000001490116, 69, 57, 94, 271, 1),
       (13, 1, '发芽', 30, 0.200000002980232, 61, 72, 89, 240, 2),
       (13, 2, '小叶子', 40, 0.2, 96, 135, 68, 158, 2),
       (13, 3, '大叶子', 60, 0.3, 140, 199, 58, 132, 2),
       (13, 4, '开花', 70, 0.4, 140, 199, 51, 152, 2),
       (13, 5, '成熟', 80, 0.5, 141, 199, 50, 148, 3),
       (13, 6, '枯草', 0, 0, 141, 199, 62, 225, 4),
       (14, 0, '种子', 5, 0.1, 73, 75, 87, 256, 1),
       (14, 1, '发芽', 6, 0.2, 79, 104, 81, 221, 2),
       (14, 2, '小叶子', 7, 0.200000002980232, 115, 158, 72, 182, 2),
       (14, 3, '大叶子', 8, 0.2, 166, 220, 42, 166, 2),
       (14, 4, '开花', 9, 0.4, 155, 224, 41, 168, 2),
       (14, 5, '成熟', 10, 0.4, 139, 202, 41, 191, 3),
       (14, 6, '枯草', 0, 0, 137, 232, 59, 211, 4),
       (30, 0, '种子', 10, 0.1, 57, 51, 93, 260, 1),
       (30, 1, '发芽', 30, 0.2, 61, 72, 96, 250, 2),
       (30, 2, '小叶子', 40, 0.2, 96, 135, 78, 200, 2),
       (30, 3, '大叶子', 60, 0.2, 140, 199, 57, 127, 2),
       (30, 4, '开花', 70, 0.4, 140, 199, 58, 128, 2),
       (30, 5, '成熟', 80, 0.5, 141, 199, 56, 127, 3),
       (30, 6, '枯草', 0, 0, 141, 199, 63, 217, 4),
       (940, 0, '种子', 10, 0.1, 62, 66, 93, 258, 1),
       (32, 0, '种子', 5, 0.1, 67, 77, 91, 254, 1),
       (32, 1, '发芽', 6, 0.1, 81, 97, 84, 229, 2),
       (32, 2, '小叶子', 7, 0.2, 110, 162, 65, 193, 2),
       (32, 3, '大叶子', 8, 0.3, 140, 199, 45, 175, 2),
       (32, 4, '开花', 9, 0.3, 140, 199, 43, 163, 2),
       (32, 5, '成熟', 10, 0.4, 166, 227, 34, 132, 3),
       (32, 6, '枯草', 0, 0, 129, 237, 59, 212, 4),
       (7, 0, '种子', 10, 0.1, 58, 52, 93, 253, 1),
       (7, 1, '发芽', 30, 0.1, 61, 72, 100, 249, 2),
       (7, 2, '小叶子', 40, 0.2, 124, 153, 68, 154, 2),
       (7, 3, '大叶子', 60, 0.2, 140, 199, 55, 131, 2),
       (7, 4, '开花', 70, 0.3, 140, 199, 54, 152, 2),
       (7, 5, '成熟', 80, 0.1, 184, 224, 37, 141, 3),
       (7, 6, '枯草', 0, 0, 141, 199, 61, 232, 4),
       (8, 0, '种子', 10, 0.1, 58, 52, 93, 259, 1),
       (8, 1, '发芽', 30, 0.1, 61, 72, 85, 202, 2),
       (8, 2, '小叶子', 40, 0.1, 96, 135, 76, 158, 2),
       (8, 3, '大叶子', 60, 0.2, 140, 199, 63, 140, 2),
       (8, 4, '开花', 70, 0.2, 140, 199, 67, 147, 2),
       (8, 5, '成熟', 80, 0.4, 141, 199, 63, 148, 3),
       (8, 6, '枯草', 0, 0, 141, 199, 60, 223, 4),
       (9, 0, '种子', 10, 0.1, 58, 52, 98, 262, 1),
       (9, 1, '发芽', 30, 0.2, 61, 72, 90, 239, 2),
       (9, 2, '小叶子', 40, 0.3, 96, 135, 70, 202, 2),
       (9, 3, '大叶子', 60, 0.2, 140, 199, 54, 140, 2),
       (9, 4, '开花', 70, 0.2, 140, 199, 51, 167, 2),
       (9, 5, '成熟', 80, 0.5, 141, 199, 50, 165, 3),
       (9, 6, '枯草', 0, 0, 141, 199, 58, 218, 4),
       (6, 0, '种子', 10, 0.1, 58, 52, 96, 264, 1),
       (6, 1, '发芽', 30, 0.2, 61, 72, 88, 210, 2),
       (6, 2, '小叶子', 40, 0.2, 96, 135, 73, 207, 2),
       (6, 3, '大叶子', 60, 0.3, 140, 199, 48, 154, 2),
       (6, 4, '开花', 70, 0.4, 140, 199, 52, 144, 2),
       (6, 5, '成熟', 80, 0.5, 141, 199, 46, 158, 3),
       (6, 6, '枯草', 0, 0, 141, 199, 60, 226, 4),
       (418, 0, '种子', 10, 0.2, 58, 52, 98, 264, 1),
       (418, 1, '发芽', 30, 0.2, 61, 72, 115, 223, 2),
       (418, 2, '小叶子', 40, 0.1, 84, 133, 82, 169, 2),
       (418, 3, '大叶子', 60, 0.5, 105, 176, 67, 148, 2),
       (418, 4, '开花', 70, 0.5, 128, 192, 68, 100, 2),
       (418, 5, '成熟', 80, 0.4, 141, 199, 65, 96, 3),
       (418, 6, '枯草', 0, 0, 141, 199, 58, 220, 4),
       (940, 1, '发芽', 30, 0.2, 64, 78, 96, 273, 2),
       (940, 2, '小叶子', 40, 0.1, 96, 135, 81, 242, 2),
       (940, 3, '大叶子', 60, 0.3, 140, 199, 64, 173, 2),
       (940, 4, '开花', 70, 0.1, 140, 199, 58, 143, 2),
       (940, 5, '成熟', 80, 0.4, 141, 199, 56, 101, 3),
       (940, 6, '枯草', 0, 0, 114, 177, 73, 220, 4)

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
