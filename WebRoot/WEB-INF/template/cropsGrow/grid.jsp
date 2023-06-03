<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>ext/easyui/themes/green/easyui.css?t564">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>ext/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>ext/easyui/themes/color.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>ext/farm/farm.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>ext/farm/imgPosition.css?t=0901">
    
    <script type="text/javascript" src="<%=basePath%>ext/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>ext/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>ext/easyui/plugins/jquery.edatagrid.js"></script>
    <script type="text/javascript" src="<%=basePath%>ext/easyui/plugins/jquery.draggable.js"></script>
    <script type="text/javascript" src="<%=basePath%>ext/easyui/locale/easyui-lang-zh_CN.js"></script>
    
    <script type="text/javascript" src="<%=basePath%>ext/farm/helper.js"></script>
    <script type="text/javascript" src="<%=basePath%>ext/farm/imgPosition.js"></script>
</head>

<style>
	body{
		background:url(../images/plant.webp);
		background-size:100% 100%;
    	background-repeat:no-repeat;
	}
	#containeer {
            position: relative;
            left: 0;
            right: 0;
            bottom: 0;
            top: 0;
            display: flex;
            flex-direction: column;
          
            background-size: cover;
        }

        /*土地样式*/
        #land {
            position: absolute;
            width:100%;
            height:100%;
            left:270px;
            top:140px;
        }

        .land {
            position: absolute;
        }

        .insect {
            position: absolute;
        }

        .crop {
            position: absolute;
        }

        .clickBox {
            position: absolute;
            clip-path: polygon(50% 0, 100% 50%, 50% 100%, 0 50%);
        }
</style>
<body>
	<div id="containeer">
	    <div id="land"></div>
	    <div id="seedBag"></div>
	</div>
</body>

<script>
	window.onload = function() {
		var frameset = parent.document.getElementsByTagName('frameset')[0];
	    frameset.rows = '60,*,50';
	    parent.document.querySelector('#bottom').src = '<%=basePath%>/tools.jsp';
	    $("body").css("height",$(window).height());
	}
	
	var landWidth = 120;
	var landHeight = 60;
	
	var paddingX = 15;
	var paddingY = 55;
	
	$(function () {
		$('#seedBag').dialog({
	        title: '种子收纳袋',
	        width: '900',
	        height: 240,
	        inline: true,
	        modal: true,
	        closed: 'true',
	    });
		
		var num = 0;
		var $land = $('#land');
		
		var url = '<%=basePath%>/game/landStatus';
		 request({}, 'post', url, false, function (result) {
			 console.log(result);
			 for (var i = 0; i<4; i++){
				 for (var j = 0; j<6; j++, num++){
					 
					 
					 console.log(result[num].landType)
					 $land.append(landButton(i,j,result));
					 $land.append(addLandImg(i,j,result,num));
					 
				 }
			 }
		 })
	})
	
	
	
	
	function addLandImg(i,j,result,num){
		/* let url = basePath + '/images/land/' + result.landType + '.png' */
		var url = '../images/land.png'

	    //根据land的landTypeCode生成相应的土地类型
	    var $landImg = $('<img  class="land" id="land_' + result[num].landType + '" src="' + url + '" alt="土地">');
		$landImg.css({
	        width: landWidth + 'px',
	        height: landHeight + 'px',
	        left: adjustX(i, j) + 'px',
	        top: adjustY(i, j) + 'px',
	        zIndex: 5
	    });
		return $landImg;
	}
	
	function landButton(i, j, result) {
	    var $landButton = $('<div class="clickBox" id="clickBox_' + result.landId + '">');
	    $landButton.css({
	        width: landWidth + 'px',
	        height: landHeight + 'px',
	        left: adjustX(i, j) + 'px',
	        top: adjustY(i, j) + 'px',
	        zIndex: 30
	    });

	    return $landButton;
	}
	
	function adjustX(i, j) {
	    return (j * (landWidth + paddingX));
	}

	function adjustY(i, j) {
	    return (i * (landHeight + paddingY));
	}
	
</script>
</html>