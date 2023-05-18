<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>菜单</title>
<style>
        body {
            margin: 0px;           
        }
        
        .bar{
        	
        	background-image:url(images/topbar.png);        	
            background-size:25% 60px;
            background-repeat:repeat-x;            
        }
        
        .shadow{
        	-moz-box-shadow:2px 2px 5px #333333;
        	-webkit-box-shadow:2px 2px 5px #333333;
        	box-shadow:2px 2px 5px #333333;
        }
        
        .menu{
           margin: 3px 5px 5px 5px;
        }
        
        #asset{
        	position:absolute;
        	width:120px;
        	height:30px;
        	top:30px;
        	right:0;
        	
        	border-radius: 10px 10px;
        	background-color:blue;
        }
    </style>
</head>
<body class="bar">
	<div style="position:relative; width:200px; height:60px; float:left; padding:5px 0 0 10px;">
		<img src="avatar/zhangfei.jpg" style="width:50px; height:50px;">
		<p style="float:right; color:white; line-height:20px; text-align:center; margin: 0;">zhugelaing </p>
		
		<div id="asset"></div>
	</div> 

	<div style="float:right;" width="50%">
		<a href="seed/grid" target="workspace"><img class="menu shadow" src="images/seedManager.png" width="50px"></a>
		<a href="user/loginPage" target="workspace"><img class="menu shadow" src="images/farmer.png" width="50px"></a>
		<a href="seed/grid" target="workspace"><img class="menu shadow" src="images/shop.png" width="50px"></a>
		<a href="seed/grid" target="workspace"><img class="menu shadow" src="images/a.png" width="50px"></a>
		<a href="seed/grid" target="workspace"><img class="menu shadow" src="images/seedManager.png" width="50px"></a>
		
	<div>
</body>
</html>