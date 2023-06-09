<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   
   <%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	%>
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
        	width:220px;
        	height:20px;
        	float:right;
        	font-size:5px;
        	border-radius: 10px 10px;
        	background-color:#2d99d6;
        	color:#FFFFFF;
        }
    </style>
</head>
<body class="bar">
	<div style=" width:280px; height:55px; float:left; padding:5px 0 0 10px;">
		<div style="float:left"><img style="width:50px; height: 50px;" src="<%=basePath%>/avatar/<c:if test = "${user.id == null}">default.png</c:if>${user.avatar}"> </div>
			<div style="float:right; width:230px; height:50px;">
				<p style="color:yellow; font-size:25px; padding-left:20px; margin: 0; text-shadow: 0.1em 0.1em #333">
					<c:if test = "${user.id == null}">
							 未知用户
						</c:if>
						  ${user.nickname}
						
				</p>
				
				<div id="asset">
					<span style="padding-left:10px; font-size:13px;">经验：<c:if test = "${user.id == null}">0</c:if>${user.experience}</span>
					<span style="color:yellow; font-size:13px;">金币: <c:if test = "${user.id == null}">0</c:if><fmt:formatNumber value="${user.money}" pattern="###" /> </span>
					<span style="color:pink; font-size:13px;">积分：<c:if test = "${user.id == null}">0</c:if>${user.points}</span> 
				</div>
			</div>
	</div> 

	<div style="float:right;" width="50%">
		<a href="game/index" target="workspace"><img class="menu shadow" src="images/plant.ico" width="50px"></a>
		<a href="user/loginPage" target="workspace"><img class="menu shadow" src="images/farmer.png" width="50px"></a>
		<a href="store/index" target="workspace"><img class="menu shadow" src="images/shop.png" width="50px"></a>
		<a href="user/grid" target="workspace"><img class="menu shadow" src="images/a.png" width="50px"></a>
		<a href="seed/grid" target="workspace"><img class="menu shadow" src="images/seedManager.png" width="50px"></a>
	<div>
</body>
</html>