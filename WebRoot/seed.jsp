<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style>
	body{
		margin:0 auto;
		width:100%;
		height:100%;
		border:0;
		border-top: 3px solid green
	}
	
	.icon-seedBag {
	  background-image: url(../images/icon-seedBag.png);
	  /* 设置图标的宽度、高度和其他样式属性 */
	}
	
	#seedBagContaineer{
		width: max-content;
		height:100%;
		margin-left: auto;
		margin-right: auto; 
		display:flex; 
		
	}
	
	#seedBagImg{
		display:flex;
		overflow-x: hidden;
        overflow-y: hidden;
		/* width:1010px;
		margin-left: auto;
		margin-right: auto; */
	}
	
	.seedNum{
		width:30px;
		color:#FFFFFF;
		background-color:red;
		border-radius:250px;
		text-align:center;
		margin-left: auto;
		margin-right: auto;
		margin-bottom:10px;
		margin-top:10px;
	}
	
	.seedImgBox{
		flex: 0 0 200px;
		height:100%;
		margin-right: 10px;
		/* padding:0 20px; 
		float:left;
		flex-direction:column;
		justify-content:center; */
	}
	
	.arrow{
		display:flex; 
		width:40px;
		height:100%;
		justify-content: center;
		align-items: center;
	}
	

</style>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>ext/easyui/themes/green/easyui.css?t=34355">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>ext/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>ext/easyui/themes/color.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>ext/farm/farm.css">
    <script type="text/javascript" src="<%=basePath%>ext/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>ext/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>ext/easyui/plugins/jquery.edatagrid.js"></script>
    <script type="text/javascript" src="<%=basePath%>ext/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=basePath%>ext/farm/helper.js"></script>    
</head>
<body>
    <div id="seedBagContaineer">
    	<div id="left" class="arrow">
    		<img src="../images/left.png">
    	</div>
    	<div id="seedBagImg" style=""></div>
    	<div id="right" class="arrow">
    		<img src="../images/left.png" style="transform: rotate(180deg);">
    	</div>
      
    </div>
</body>

<script>

	$("body").css("height",$(window).height()); 
	
	$(document).ready(function() {
		
		 	var seedBagBox = $('#seedBagContaineer');
		    var $left = $('#left');
		    var $right = $('#right');
		    var $seedBagImg = $('#seedBagImg');
		    var itemWidth = 200;
		    var itemMargin = 10;
		    var visibleItems = 4;
			var userName = '${user.username}';
			
			var url = '<%=basePath%>/store/userBag?userName=' + userName;
			console.log(url)
		    //初始化数据
		    request({}, 'post',url, true, function (result) {
		    	console.log(url)
		    	console.log(result);
/* 		        if (result.code == 0) {
 */		            /* var data = result.data;
						console.log(data); */
						console.log(result.length);
		            for (let i = 0; i < result.length; i++) {
		                let seedId = result[i]['seedId'];
		                console.log(seedId)
		                var imgUrl ='../images/crops/' + seedId + '/5.png';
		                var $seedNum = $('<div class="seedNum" style="">' + result[i]['seedNum'] + '</div>');
		                var $img = $('<img style="display:block; margin-left: auto;margin-right: auto;width:160px; height:170px;" class="cropImg" data-cropId="' + seedId + '" src="' + imgUrl + '" >');
		                var $seedImgBox = $('<div class="seedImgBox"></div>');
		                $seedImgBox.append($seedNum);
		                $seedImgBox.append($img);
		                $seedBagImg.append($seedImgBox);
		                
		            }
/* 		          }
 */		        
		    })
			
		    seedBagImg.style.width = (itemWidth + itemMargin) * visibleItems - itemMargin + 'px';
			
		    $left.click(function () {
		        //判断是否存在滚动条
		        if ($seedBagImg[0].scrollWidth > $seedBagImg[0].clientWidth || $seedBagImg[0].offsetWidth > $seedBagImg[0].clientWidth) {
		            //滚动条左移
		            let width = $('.cropImg').outerWidth() * visibleItems;
		            $seedBagImg.animate({scrollLeft: '-=' + width});
		        }

		    });
		    $right.click(function () {
		        // 判断是否存在滚动条
		        if ($seedBagImg[0].scrollWidth > $seedBagImg[0].clientWidth || $seedBagImg[0].offsetWidth > $seedBagImg[0].clientWidth) {
		            //滚动条右移
		            let width = $('.cropImg').outerWidth() * visibleItems;
		            $seedBagImg.animate({scrollLeft: '+=' + width});
		        }
		    });
			
			
	})
	


	
</script>
</html>