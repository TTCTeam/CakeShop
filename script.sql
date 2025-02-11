USE [master]
GO
/****** Object:  Database [CakeShop]    Script Date: 03/01/2021 7:36:06 PM ******/
CREATE DATABASE [CakeShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CakeShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\CakeShop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CakeShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\CakeShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CakeShop] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CakeShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CakeShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CakeShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CakeShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CakeShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CakeShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [CakeShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CakeShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CakeShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CakeShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CakeShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CakeShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CakeShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CakeShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CakeShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CakeShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CakeShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CakeShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CakeShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CakeShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CakeShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CakeShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CakeShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CakeShop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CakeShop] SET  MULTI_USER 
GO
ALTER DATABASE [CakeShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CakeShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CakeShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CakeShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CakeShop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CakeShop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [CakeShop] SET QUERY_STORE = OFF
GO
USE [CakeShop]
GO
/****** Object:  Table [dbo].[Cake]    Script Date: 03/01/2021 7:36:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cake](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Thumbnail] [nvarchar](200) NULL,
	[Description] [nvarchar](1000) NULL,
	[Type] [int] NULL,
	[Ingredients] [nvarchar](500) NULL,
	[Price] [int] NULL,
 CONSTRAINT [PK_Cake] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 03/01/2021 7:36:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Tel] [nvarchar](10) NULL,
	[Address] [nvarchar](200) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 03/01/2021 7:36:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[OrderDate] [date] NULL,
	[PaymentMethod] [int] NULL,
	[IsPaied] [bit] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 03/01/2021 7:36:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[CakeID] [int] NULL,
	[Price] [int] NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentMethodDescription]    Script Date: 03/01/2021 7:36:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentMethodDescription](
	[PaymentMethod] [int] NOT NULL,
	[Description] [nvarchar](50) NULL,
 CONSTRAINT [PK_PaymentMethodDescription] PRIMARY KEY CLUSTERED 
(
	[PaymentMethod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TypeDescription]    Script Date: 03/01/2021 7:36:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypeDescription](
	[Type] [int] NOT NULL,
	[Description] [nvarchar](50) NULL,
 CONSTRAINT [PK_TypeDescription] PRIMARY KEY CLUSTERED 
(
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Cake] ON 

INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (1, N'Bánh kem Kỳ Lân', N'Images/Cake/BanhKemKyLan.jpg', N'Lớp kem sử dụng bên ngoài là kem phô mai nhập khẩu cao cấp của Elle & Vire, một thương hiệu cực kỳ nổi tiếng và cao cấp về các dòng kem của Pháp, với vị chua nhẹ, ngậy ngậy, ít béo, ít ngọt, đảm bảo quý khách sẽ có một bữa tiệc sinh nhật hoàn toàn mới lạ!', 1, N'Bột mì, Trứng, Sữa, Đường', 750000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (2, N'Bánh kem Cà Rốt', N'Images/Cake/BanhKemCaRot.jpg', N'Hương vị đặc trưng đó đến từ thành phần chính – cà rốt tươi ngon, được tuyển chọn kỹ lưỡng từ vùng nông sản Đà Lạt, nơi cà rốt được trồng tự nhiên, có chứa nhiều Beta Carotene rất tốt cho đôi mắt. Từng sợi cà rốt bào mịn hòa quyện cùng mùi hương của bột quế và hạt óc chó mang đến mùi vị thơm bùi và cảm giác giòn sần sật thú vị khi ăn, chinh phục mọi tâm hồn yêu bánh kể cả vị giác non nớt của các bé nhỏ.', 1, N'Bơ, Đường, Giấm, Trứng, Bột, Dầu ăn', 590000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (3, N'Bánh Red Velvet', N'Images/Cake/BanhRedVelvet.jpg', N'Red Velvet thường có nhiều lớp, lớp nhung đỏ thẫm kiêu sa kết hợp cùng lớp kem trắng mịn phủ bên ngoài nổi bật thu hút mọi ánh nhìn. Một chiếc bánh Red Velvet ngon đúng điệu không chỉ mang màu sắc lộng lẫy mà cốt bánh phải đủ ẩm, mềm mượt như nhung, hơi chua dịu và thoang thoảng hương chocolate. Lớp kem phô mai mát lạnh, được đánh vừa độ để bông mềm mà vẫn giữ được độ ngậy béo. Tất cả những điều đó hòa quyện, tạo nên dấu ấn đặc trưng cho Red Velvet.', 1, N'Bơ, Đường, Giấm, Trứng, Bột, Dầu ăn', 550000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (4, N'Bánh kem Whiskey', N'Images/Cake/BanhKemWhiskey.jpg', N'Bánh Whisky Dundee là một món bánh truyền thống tới từ xứ sở Scotland, và là món bánh thường được làm vài mỗi dịp Giáng sinh. Món bánh này cách làm không quá khó mà hương vị lại cực hấp dẫn đấy bạn nhé. Cùng chúng mình vào bếp học cách làm bánh whisky dundee thơm ngon ngay tại nhà để chào đón Giáng sinh nào bạn nhé.', 1, N'Bơ, Đường, Giấm, Trứng, Bột, Dầu ăn, Rượu Whiskey', 1850000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (5, N'Bánh kem Frozen', N'Images/Cake/BanhKemFrozen.jpg', N'Tiêu chí của mẹ, La Vita dễ dàng đáp ứng với cốt bánh mềm mại ít đường và kem cheese Elle & Vire thơm ngon hảo hạng. Nhưng điểm khó là kem cheese không thể tạo hình bắt mắt, trong khi chúng mình lại ngại sử dụng fondant (hỗn hợp bột đường) vì nó siêu siêu ngọt', 1, N'Bơ, Đường, Giấm, Sữa, Trứng, Bột màu', 730000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (6, N'Bánh kem Star', N'Images/Cake/BanhKemStar.jpg', N'Lớp kem sử dụng bên ngoài là kem phô mai nhập khẩu cao cấp của Elle & Vire, một thương hiệu cực kỳ nổi tiếng và cao cấp về các dòng kem của Pháp, với vị chua nhẹ, ngậy ngậy, ít béo, ít ngọt, đảm bảo quý khách sẽ có một bữa tiệc sinh nhật hoàn toàn mới lạ!', 1, N'Bơ, Đường, Giấm, Sữa, Trứng, Bột màu', 710000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (7, N'Bánh kem Tarzan', N'Images/Cake/BanhKemTarzan.jpg', N'Cốt bánh kem của chúng tôi là cốt bánh đặc, ít ngọt, theo xu hướng healthy kiểu Châu Âu, khác hẳn với cốt bánh mềm thường thấy của bánh bông lan.', 1, N'Bơ, Đường, Giấm, Sữa, Trứng, Bột màu', 710000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (8, N'Bánh mì nguyên cám', N'Images/Cake/BanhMiNguyenCam.jpg', N'Dòng bánh ăn kiêng mới nhất từ La Vita, bao gồm bột nguyên cám, bột mì lúa mạch đen, các loại hạt óc chó, hạnh nhân, nho khô,… cho một hương vị ngon miệng nhưng vẫn giúp hỗ trợ ăn kiêng, giảm cân hiệu quả.', 2, N'bột nguyên cám, bột mì lúa mạch đen, các loại hạt óc chó, hạnh nhân, nho khô', 89000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (9, N'Bánh mì đen', N'Images/Cake/BanhMiDen.jpg', N'Được làm từ bột mì đen kết hợp với gia vị thảo dược caraway với nhiều lợi ích dinh dưỡng, bánh mì đen Đan Mạch vốn là một trong những dòng bánh ăn kiêng, hỗ trợ giảm cân tuyệt vời của La Vita Bakery.', 2, N'Bột mì đen, Gia vị thảo dược Caraway', 60000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (10, N'Bánh mì men chua', N'Images/Cake/BanhMiMenChua.jpg', N'Bánh Mì Chua Nguyên Cám La Vita được làm từ bột mì nguyên cám ủ chua, chất bánh dai ngon, hương thơm chua dịu nhẹ của mùi men ủ kỹ rất dễ chịu và đặc biệt có lợi cho hệ tiêu hoá.', 2, N'Bột mì, Gia vị', 55000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (11, N'Bagels ngũ cốc', N'Images/Cake/BagelsNguCoc.jpg', N'Chất bánh mềm, thơm mùi ngũ cốc, dinh dưỡng từ các loại hạt như: Hạt Lanh, yến mạch, hạt dưa, hạt bí…', 3, N'Bột mì, gia vị, các loại hạt', 81000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (12, N'Bánh cà rốt phô mai', N'Images/Cake/BanhCaRotPhoMai.jpg', N'Hương vị đặc trưng đó đến từ thành phần chính – cà rốt tươi ngon, được tuyển chọn kỹ lưỡng từ vùng nông sản Đà Lạt, nơi cà rốt được trồng tự nhiên, có chứa nhiều Beta Carotene rất tốt cho đôi mắt. Từng sợi cà rốt bào mịn hòa quyện cùng mùi hương của bột quế và hạt óc chó mang đến mùi vị thơm bùi và cảm giác giòn sần sật thú vị khi ăn, chinh phục mọi tâm hồn yêu bánh kể cả vị giác non nớt của các bé nhỏ.', 4, N'cà rốt, óc chó, phô mai, trứng, sữa, bột mì', 160000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (13, N'Bánh mì hoa cúc', N'Images/Cake/BanhMiHoaCuc.jpg', N'Điểm đặc biệt của Bánh Mì Hoa Cúc tại La Vita là ruột bánh mềm, ẩm nhưng rất xốp, nhẹ và thớ bánh dai mịn khác hẳn các loại bánh Brioche công nghiệp đóng gói siêu thị.', 4, N'Bột bánh mì, Bơ, Phô mai, Hoa cúc', 95000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (14, N'Bánh chuối', N'Images/Cake/BanhChuoi.jpg', N'Được làm từ những nguyên liệu tốt nhất, bánh chuối với hạt óc chó còn đặc biệt ở mùi vị không thể lẫn của hạt óc chó nướng cùng vị chuối chín cây được tuyển lựa kết hợp trong một công thức chắt lọc. Vị ngọt tự nhiên từ chuối chín thanh dịu và đầy dư vị, hương thơm ấm đượm nổi bật của hạt óc chó vốn là một trong những hương vị bản sắc của Châu Âu – cái nôi của rất nhiều loại bánh ngũ cốc tuyệt hảo. Banana Walnut ở La Vita Bakery là một dòng bánh mà quý khách hàng xưa và nay luôn trao gửi trọn vẹn niềm tin cùng sự yêu mến.', 4, N'Bột bánh mì, chuối, phômai, hạt óc chó', 185000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (15, N'CupCakeRose', N'Images/Cake/CupCakeRose.jpg', N'Thay cho lời muốn nói, hãy gửi tặng những bông hoa hồng ngọt ngào nhất đến những người phụ nữ quan trọng của mình bạn nhé!!', 5, N'Bơ, Đường, Giấm, Trứng, Bột, Dầu ăn', 200000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (16, N'Bánh Pancake', N'Images/Cake/BanhPancake.jpg', N'Có thể thấy Pancake ngọt là loại bánh rất ngon, dễ kết hợp với nhiều nguyên liệu khác nhau để tạo nên một đĩa bánh tuyệt vời … Còn đối với Pancake mặn cũng ất dễ kết hợp với khá nhiều nguyên liệu phong phú. Có thể ăn với thịt lợn xông khói, thịt lợn muối hoặc xúc xích, cá hồi, phô mai cùng các loại nước sốt khác nhau tùy vào sở thích mỗi người', 6, N'bột mì, trứng và sữa, bột nở, men', 250000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (17, N'Bánh Mouse', N'Images/Cake/BanhMouse.jpg', N'Bánh Mousse thơm ngon, ngọt ngào là một món bánh đã chinh phục được rất nhiều khẩu vị, dù là khó tính nhất. Chính vì vậy, đây sẽ là món bánh lý tưởng để bạn chiêu đãi cả nhà hoặc thêm vào menu tiệm bánh để kinh doanh thu lợi nhuận.', 6, N'Galetin, kem tươi', 350000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (18, N'Bánh Flan', N'Images/Cake/BanhFlan.jpg', N'Bánh flan có thể ăn kèm cùng hoa quả để tăng độ hấp dẫn của bánh. Nguyên liệu đã đơn giản nhưng cách làm lại càng đơn giản hơn. Chỉ cần hấp cách thủy bằng nồi cơm điện, bếp ga hoặc lò vi sóng là bạn đã có ngay món bánh flan caramen siêu ngon rồi', 8, N'Trứng gà, Sữa, Nước sốt Caramen', 20000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (19, N'Bánh Mochi', N'Images/Cake/BanhMochi.jpg', N'Mochi là một loại bánh truyền thống của Nhật Bản với lớp vỏ bằng bột gạo dẻo thuần khiết làm từ gạo Mochi. Từ ngàn xưa Mochi đã là món bánh của sự gắn kết gia đình và bè bạn. Sự tuyệt hảo của Mochi có thể cảm nhận ngay ở miếng đầu tiên.Mochi ăn dẻo mềm với bột nếp kết hợp cùng với các nguyên liệu khác nhau tạo nên những loại bánh mochi đa hương vị ', 6, N'Bột, Nước, Trà xanh, Đậu đỏ', 50000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (20, N'Bánh Muffin', N'Images/Cake/BanhMuffin.jpg', N'Muffin là loại bánh có cách làm và nguyên liệu gần giống bánh cupcake nhưng hương vị khá khác nhau. Muffin ngoài các nguyên liệu cơ bản như bột, trứng, đường thì còn có thể thêm các loại hoa quả vào trộn cùng bột hay có thêm các loại hoa quả khô hoặc chocolate chip,… Cũng vì vậy mà bánh muffin được biến tấu thành rất nhiều loại.', 5, N'Bột, Nước, Trứng, Sữa, Bơ, Phomai', 120000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (21, N'Bánh Tiramisu', N'Images/Cake/BanhTiramisu.jpg', N'Bánh Tiramisu là một món tráng miệng nổi tiếng ở Ý bởi độ thơm ngon và béo mịn của nó. Vị đắng đắng quyến rũ của cafe, vị thơm nồng của rượu, vị bánh mềm ẩm do được thấm đẫm cafe và rượu, vị thơm lừng của cacao, quên lại tất cả các lại hương vị với bởi một lớp kem trứng phomai ngon tuyệt.', 6, N'Bột, Nước, Trứng, Sữa, Bơ, Phomai, Socola, Cà phê', 350000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (22, N'Bánh Donut', N'Images/Cake/BanhDonut.jpg', N'Bánh donut là một loại bánh ngọt có thể rán hoặc nướng có thể dùng làm món tráng miệng hay làm đồ ăn vặt tùy sở thích. đây là một loại bánh khá phổ biến ở các nước phương Tây, có thể mua ở nhiều cửa hàng hoặc tự làm ở nhà. Với món bánh này công thức cực kì đơn giản, để làm ở nhà thì thường người ta sẽ làm bánh donut rán vì nó rất dễ làm k ần phải cầu kì kiểm tra nhiệt độ bánh. Khi làm xong phần vỏ bánh đã được chiên giòn đều, phân còn lại là phủ các loại kem, socola cùng với các hạt đường trang trí. Với cách làm đơn giản như vậy các bạn hãy nên thử làm và chiêu đãi gia đình mình một bữa bánh ngọt thôi nào !', 6, N'Bột mì, sữa tươi, đường cát trắng, sữa bột, men, muối, trứng gà', 65000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (23, N'Bánh Crepe', N'Images/Cake/BanhCrepe.jpg', N'Bánh crepe có nguồn gốc từ Bregetna ở vùng Tây Bắc của Pháp, sau đó lan rộng ra toàn nước Pháp và trở thành món ăn truyền thống của Pháp, Bỉ, Thụy Sĩ, Canada, Brasil. Nó là một loại bánh đi kèm với các đồ uống như cafe, trà, sữa, rượu táo và cũng có thể là 1 bữa ăn sáng nhanh gọn. Người ta có nhiều cách khác nhau để biến tấu ra bánh crepe ngọt hay mặn tùy theo khẩu vị của gia đình và dành cho các dịp khác nhau. Thường thì đa số người ta sửa dụng bánh crepe ngọt là nhiều vì nó được rất nhiều trẻ nhỏ yêu thích, lại có thể ăn kèm cùng hoa quả tươi mát. Vừa dễ làm, vừa ngon, mát khi ăn kèm hoa quả, bổ dưỡng, nói chung khá là ” healthy “…Vậy chúng ta hãy nhanh tay vào bếp học làm bánh này ngay thôi, còn chờ đợi thêm gì nữa nhỉ ^^', 6, N'Bột mì, trứng, sữa và bơ', 120000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (24, N'Bánh bông lan', N'Images/Cake/BanhBongLan.jpg', N'Sponge Cake là một trong những loại bánh cơ bản và đơn giản nhất, bánh được làm bằng cách đánh bông trứng, không sử dụng bơ hoặc rất ít bơ, và cũng không cần bột nở vì bánh nở chủ yếu dựa vào bọt khí trong trứng đánh bông.

', 7, N'Trứng, đường, bột', 230000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (25, N'Bánh Gato Socola', N'Images/Cake/BanhGatoSocola.jpg', N'Sôcôla và bạc hà chắc chắn sẽ là một sự kết hợp tuyệt vời để làm nên một chiếc bánh kem ngon theo một cách rất riêng.', 7, N'Trứng, đường, bột, Socola', 240000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (26, N'Bánh bông lan xốp', N'Images/Cake/BanhBongLanXop.jpg', N'Chiffon nằm trong nhóm Foam Cake – nhóm gồm các loại bánh nở dựa vào bọt khí có trong trứng hoặc lòng trắng trứng đánh bông, khác  với nhóm High Fat Cake, gồm các loại bánh có thành phần chất béo (dầu, bơ…) cao, và chủ yếu dựa vào bột nở để nở.', 7, N'Trứng, đường, bột, bột nổi', 150000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (27, N'Bánh Black Forest', N'Images/Cake/BanhBlackForest.jpg', N'Bánh chocolate tròn phủ sirô anh đào, thêm rượu anh đào chua và xếp lớp với kem tươi và anh đào tươi', 1, N'Bơ, Đường, Giấm, Trứng, Bột, Dầu ăn, Socola,  Dâu, Nho đen', 1500000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (28, N'Dan Tats', N'Images/Cake/DanTats.jpg', N'Dan tats ngon nhất lúc mới lấy ra từ lò nướng, khi nhân trứng ấm gặp lớp vỏ giòn hoàn hảo.', 8, N'Bột, bơ, trứng, sữa, đường, nước', 350000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (29, N'Bánh quy bơ dâu', N'Images/Cake/BanhQuyBoDau.jpg', N'Tiết trời đã bắt đầu se lạnh, còn gì tuyệt vời hơn việc làm một mẻ bánh quy giòn rụm, thoang thoảng mùi vani và tươi mát với mứt dâu để đón những cuối năm tràn đầy hứng khởi? Không mất quá nhiều thời gian lại vô cùng đơn giản, bánh quy bơ mứt dâu đích thị là món bánh hoàn hảo dành cho những ngày cuối năm.', 9, N'Bột mì, bột gạo, bơ lạt, đường xay, trứng gà, muối', 50000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (30, N'Bánh quy cam', N'Images/Cake/BanhQuyCam.jpg', N'Còn gì thú vị hơn bằng tự tay làm ra những chiếc bánh quy xinh xinh với nguyên liệu ngay quanh ta. Công thức cho bánh quy cam với nguyên liệu dễ tìm, cách làm đơn giản, nhưng thành phẩm rất thơm ngon và giòn tan', 9, N'Bột mì, bơ lạt, đường bột, bơ, sữa, trứng gà', 35000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (31, N'Bánh quy socola', N'Images/Cake/BanhQuySocola.jpg', N'Bánh quy chocolate chip có lẽ là loại bánh quy được ưa thích nhất trên thế giới. Bánh quy ra lò giòn xốp, thơm ngậy mùi bơ với chocolate chip, khi ăn thi thoảng bắt gặp những miếng hạnh nhân đập nhỏ rất bùi và ngon miệng. Sau khi nướng xong, bạn có thể xếp bánh vào túi bóng kính, thắt nơ để có món quà xinh xắn tặng bạn bè hay đơn giản là cất dành để nhâm nhi cùng tách trà ấm nóng ngày xuân', 9, N'Hạnh nhân, bơ, đường bột, đường nâu, trứng', 120000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (32, N'Bánh Phomai', N'Images/Cake/BanhPhoMai.jpg', N'Đây là loại bánh ngọt được làm chủ yếu từ phô mai, tạo vị béo ngậy. Phía trên người ta có thể phủ thêm mứt. Chiếc bánh pho mát kem được làm từ những năm 1800 và trở thành một trong những món bánh quen thuộc của người dân New York', 6, N'Bột, Nước, Trứng, Sữa, Bơ, Phomai, Dâu', 500000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (33, N'Victoria Sponge', N'Images/Cake/VictoriaSponge.jpg', N'Đây là loại bánh được đặt theo tên của nữ hoàng Anh Victoria. Một chiếc Victoria Sponge truyền thống gồm mứt và lượng kem nhiều gấp đôi. Bánh thường được dùng trong tiệc trà chiều của người Anh', 7, N'Bột bánh, bột nở, trứng, sữa, dâu', 230000)
INSERT [dbo].[Cake] ([ID], [Name], [Thumbnail], [Description], [Type], [Ingredients], [Price]) VALUES (34, N'Bánh công chúa', N'Images/Cake/BanhCongChua.jpg', N'Bánh công chúa của Thụy Điển là món bánh ngọt truyền thống, nhiều người yêu thích. Ban đầu, bánh được làm để phục vụ hoàng gia, được làm từ mứt, trứng, sữa, kem và cốt bánh bông lan, bao phủ phía trên là lớp bánh hạnh nhân (thường có màu xanh). Vete-Katten, Thụy Điển là nơi tuyệt nhất để thưởng thức món bánh mang tên đài các này.', 7, N'Trứng, đường, bột, bột nổi, mứt, kem', 350000)
SET IDENTITY_INSERT [dbo].[Cake] OFF
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([ID], [Name], [Tel], [Address]) VALUES (1, N'Hà Minh Cường', N'0967968362', N'Tiền Giang')
INSERT [dbo].[Customer] ([ID], [Name], [Tel], [Address]) VALUES (2, N'Cường', N'0233666554', N'Tiền Giang')
INSERT [dbo].[Customer] ([ID], [Name], [Tel], [Address]) VALUES (3, N'Hehehe', N'0111111111', N'Tiền Giang')
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([ID], [CustomerID], [OrderDate], [PaymentMethod], [IsPaied]) VALUES (1, 1, NULL, 0, 0)
INSERT [dbo].[Order] ([ID], [CustomerID], [OrderDate], [PaymentMethod], [IsPaied]) VALUES (2, 2, CAST(N'2020-02-05' AS Date), 0, 0)
INSERT [dbo].[Order] ([ID], [CustomerID], [OrderDate], [PaymentMethod], [IsPaied]) VALUES (3, 3, CAST(N'2020-08-04' AS Date), 0, 0)
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([ID], [OrderID], [CakeID], [Price], [Quantity]) VALUES (1, 1, 1, 750000, 1)
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [CakeID], [Price], [Quantity]) VALUES (2, 2, 3, 550000, 3)
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [CakeID], [Price], [Quantity]) VALUES (3, 2, 3, 550000, 1)
INSERT [dbo].[OrderDetail] ([ID], [OrderID], [CakeID], [Price], [Quantity]) VALUES (4, 3, 3, 550000, 3)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
GO
INSERT [dbo].[PaymentMethodDescription] ([PaymentMethod], [Description]) VALUES (0, N'Thanh toán bằng tiền mặt')
INSERT [dbo].[PaymentMethodDescription] ([PaymentMethod], [Description]) VALUES (1, N'Chuyển khoản')
GO
INSERT [dbo].[TypeDescription] ([Type], [Description]) VALUES (1, N'Bánh kem')
INSERT [dbo].[TypeDescription] ([Type], [Description]) VALUES (2, N'Bánh mì')
INSERT [dbo].[TypeDescription] ([Type], [Description]) VALUES (3, N'Bánh mì vòng')
INSERT [dbo].[TypeDescription] ([Type], [Description]) VALUES (4, N'Bánh ổ dài')
INSERT [dbo].[TypeDescription] ([Type], [Description]) VALUES (5, N'Bánh nướng nhỏ')
INSERT [dbo].[TypeDescription] ([Type], [Description]) VALUES (6, N'Bánh ngọt')
INSERT [dbo].[TypeDescription] ([Type], [Description]) VALUES (7, N'Bánh bông lan')
INSERT [dbo].[TypeDescription] ([Type], [Description]) VALUES (8, N'Bánh trứng')
INSERT [dbo].[TypeDescription] ([Type], [Description]) VALUES (9, N'Bánh quy | Cookie')
GO
ALTER TABLE [dbo].[Cake]  WITH CHECK ADD  CONSTRAINT [FK_Cake_TypeDescription] FOREIGN KEY([Type])
REFERENCES [dbo].[TypeDescription] ([Type])
GO
ALTER TABLE [dbo].[Cake] CHECK CONSTRAINT [FK_Cake_TypeDescription]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([ID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Customer]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_PaymentMethodDescription] FOREIGN KEY([PaymentMethod])
REFERENCES [dbo].[PaymentMethodDescription] ([PaymentMethod])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_PaymentMethodDescription]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Cake] FOREIGN KEY([CakeID])
REFERENCES [dbo].[Cake] ([ID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Cake]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([ID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
USE [master]
GO
ALTER DATABASE [CakeShop] SET  READ_WRITE 
GO
