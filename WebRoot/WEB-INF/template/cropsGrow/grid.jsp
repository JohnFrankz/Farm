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
		cursor: pointer;
	}
        
</style>
<body>
	<div id="containeer">
	    <div id="land"></div>
	    	<div id="seedBagContaineer">
		    	<div id="left" class="arrow">
		    		<img src="../images/left.png">
		    	</div>
		    	<div id="seedBagImg" style=""></div>
		    	<div id="right" class="arrow">
		    		<img src="../images/left.png" style="transform: rotate(180deg);">
		    	</div>
    		</div>
	</div>
</body>

<script>
	window.onload = function() {
		var frameset = parent.document.getElementsByTagName('frameset')[0];
	    frameset.rows = '60,*,50';
	    parent.document.querySelector('#bottom').src = '<%=basePath%>/tools.jsp';
	    $("body").css("height",$(window).height());
	};
	
	class Land {
	    i;//前端土地标识
	    j;//前端土地标识

	    cropId;
	    cropStatus
	    currentStateHasGrownTime;
	    isCrop;
	    isInsect;
	    isMature;
	    isWithered;
	    landIndex;
	    landType;
	    output;
	    stateEndTime;
	    username;
	}
	
	
	var landIndex;
	var landMap = new Map()
	
	var landWidth = 120;
	var landHeight = 60;
	
	var paddingX = 15;
	var paddingY = 55;
	
	$(function () {
		
		initWebSocket();
		
		var num = 0;
		var $land = $('#land');
		
		
		var url = '<%=basePath%>/game/landStatus';
		 request({}, 'post', url, false, function (result) {
			 console.log(result);
			 for (var i = 0; i<4; i++){
				 for (var j = 0; j<6; j++, num++){
					 var currLand = result[num];
					 $land.append(landButton(i,j,currLand));
					 $land.append(addLandImg(i,j,currLand));
					 addSeedData(i,j, currLand);
					 /* if (currLand.isCrop == 0) {
						 continue;
					 }  */
					 
					 <%-- var url2 = '<%=basePath%>/growth/gridData?seedId=' + currLand.seedId;
					 request({}, 'post', url2, false, function (result2) {
						 console.log(result2);
						 
					 }); --%>
					 
					 
					 if(currLand.isCrop == 1){
						 $land.append(initCropImg(i,j,currLand));
					 }
					 
					 
					
					 
				 }
			 }
		 })
		 
		 
		 
		 $(document).on('click', '.clickBox', function () {
			 /* console.log(landMap); */
			 console.log(this.getAttribute('data-landIndex'))
		     var land = landMap.get(parseInt(this.getAttribute('data-landIndex')));
			 	console.log(land);
		        console.log(land.landIndex)
		        //土地没有作物
		        if (land.isCrop == 0) {
		            plantCrop(land);
		        } else {
		            //作物生虫
		            if (land.isInsect == 1) {
		                killWorm(land.landId);
		            } else {
		                if (land.isMature == 1) {
		                    //作物成熟
		                    harvest(land.landId);
		                } else if (land.isWithered == 1) {
		                    //作物枯萎
		                    cleanGrass(land.landId);
		                }
		            }
		        }
		    });
		 
		$(document).on('click','.seedImg', function(){
			
			var seedBagLandIndex =parseInt(landIndex);
			console.log(seedBagLandIndex)
			var seedId = this.getAttribute('data-cropId');
			console.log(seedId)
			var url = '<%=basePath%>/game/plant?landIndex=' + seedBagLandIndex + '&seedId=' + seedId;
			request({},'post',url,true,function(result){
				if(result.code == 0){
					console.log(result);
					console.log(seedBagLandIndex);
					
					
					messageBox('消息',result.msg);
					
	                $('#seedBagContaineer').dialog('close');

				}
				else{
					messageBox('消息',result.msg);
				}
				
			})
		}) 
		
		initTip();
	})
	
	function initWebSocket(){
		let socket = new WebSocket("ws://127.0.0.1:8080/farm/action");

		socket.onopen = function(e) {
		  console.log("[open] Connection established");
		  console.log("Sending to server");
		  socket.send("My name is John");
		};

		socket.onmessage = function(event) {
			/* console.log(`[message] Data received from server: ${event.data}`); */
			/* console.log(event); */
			console.log(event)
			/* var data = event.data; */

			var data = JSON.parse(event.data);
			/* console.log("jjjj"+data); */
		/* 	console.log("hahahah   " + data); */
/* 			console.log("afdsaf" + data.landIndex)
 */			updateData(data);	
		};

		socket.onclose = function(event) {
		  if (event.wasClean) {
			  console.log(`[close] Connection closed cleanly, code=${event.code} reason=${event.reason}`);
		  } else {
		    // 例如服务器进程被杀死或网络中断
		    // 在这种情况下，event.code 通常为 1006
		    console.log('[close] Connection died');
		  }
		};

		socket.onerror = function(error) {
			console.log("[error]", error.message);
		};
	}
	
	
	
	
	function addLandImg(i,j,currLand){
		var landImgUrl = '../images/land/' + currLand.landType + '.png'
	   	var $landImg = $('<img data-landType="' + currLand.landType + '" class="land" id="land_' + currLand.landIndex + '" src="' + landImgUrl + '" alt="土地">');
   		$landImg.css({
	        width: landWidth + 'px',
	        height: landHeight + 'px',
	        left: adjustX(i, j) + 'px',
	        top: adjustY(i, j) + 'px',
	        zIndex: 5
	    });
		return $landImg;
	}
	
	function landButton(i, j, currLand) {
	    var $landButton = $('<div data-landType="' + currLand.landType + '" data-landIndex="' + currLand.landIndex + '" class="clickBox" id="clickBox_' + currLand.landIndex + '">');
	    $landButton.css({
	        width: landWidth + 'px',
	        height: landHeight + 'px',
	        left: adjustX(i, j) + 'px',
	        top: adjustY(i, j) + 'px',
	        zIndex: 30
	    });

	    return $landButton;
	}
	
	function addSeedData(i, j, result) {
	    let land = new Land();
	    land.i = i;
	    land.j = j;

	    land.landIndex = result.landIndex;
	    /* console.log(land.landIndex); */
	    

	    land.stateEndTime = result.stateEndTime;
	    land.isInsect = result.isInsect;
	    land.output = result.output;
	    land.isMature = result.isMature;
	    
	    land.cropStatus = result.cropStatus;
	    land.isCrop = result.isCrop;
	    land.isWithered = result.isWithered;
	   
	    land.currentStateHasGrownTime = result.currentStateHasGrownTime;

	    land.cropId = result.cropId;
	    land.landType = result.landType;
		land.username = result.username;
		
		/* console.log(land); */

	    landMap.set(land.landIndex, land);
	    /* console.log(landMap); */
	}
	
	
	function adjustX(i, j) {
	    return (j * (landWidth + paddingX));
	}

	function adjustY(i, j) {
	    return (i * (landHeight + paddingY));
	}
	
	
	function initCropImg(i,j,currLand){
		if (currLand.cropStatus == 6 || currLand.cropStatus == 0) {
	        //枯草期或者种子阶段
	        url = '../images/crops/basic/' + currLand.cropStatus + '.png';
	    } else {
	        //正常生长阶段
	        url = '../images/crops/' + currLand.cropId + '/' + currLand.cropStatus + '.png';
	    }
		
		var $crop = $('<img data-cropId="' + currLand.cropId + '" data-nowCropGrowStage="' + currLand.cropStatus+ '" class="crop" id="crop_' + currLand.landIndex+ '" src="' + url + '" >');
	
	    /* if (cropGrow != null) {
	        picOffsetX = cropGrow['picOffsetX'];
	        picOffsetY = cropGrow['picOffsetY'];
	        picWidth = cropGrow['picWidth'];
	        picHeight = cropGrow['picHeight'];
	    } */

	    $crop.css({
	        width: 80 + 'px',
	        height: 80 + 'px',
	        left: adjustX(i, j) + 20  + 'px', 
	        top: adjustY(i, j) + -15+ 'px', 
	        zIndex: 10
	    });
	    
	    return $crop;
	}
	
	$('#seedBagContaineer').dialog({
        title: '种子收纳袋',
        width: '930',
        height: 260,
        closed: 'true',
        modal: true,
    });
	
	function plantCrop(land) {
		
		
		landIndex = land.landIndex;
		var landType = land.landType;
		console.log("landtypd = " + landType) 
	    /*
	    soundPlantCrop.play(); */
	   
	    let $seedBagWindow = $('#seedBagContaineer');
	    $seedBagWindow.dialog('open');
	    
	    var seedBagBox = $('#seedBagContaineer');
	    var $left = $('#left');
	    var $right = $('#right');
	    var $seedBagImg = $('#seedBagImg');
	    var itemWidth = 200;
	    var itemMargin = 10;
	    var visibleItems = 4;
		var userName = '${user.username}';
		
		var url = '<%=basePath%>/game/getSeeds?landType=' + landType;
		console.log(url)
		
		document.getElementById('seedBagImg').innerHTML = '';
		
	    request({}, 'post',url, true, function (result) {
	    	/* console.log(url)
	    	console.log(result);
			console.log(result.length); */
	            for (var i = 0; i < result.length; i++) {
	            	/* console.log(result) */
	                var seedId = result[i]['seedId'];
	                /* var seedLandType = result[i]['landType'];
	                console.log("seedLandtype = " + seedLandType) */
	               /*  console.log(seedId) */
	                var imgUrl ='../images/crops/' + seedId + '/5.png';
	                var $seedNum = $('<div class="seedNum" style="">' + result[i]['seedNum'] + '</div>');
	                var $img = $('<img style="display:block; margin-left: auto;margin-right: auto;width:160px; height:170px;" class="seedImg" data-cropId="' + seedId + '" src="' + imgUrl + '" >');
	                var $seedImgBox = $('<div class="seedImgBox"></div>');
	                
	                $seedImgBox.append($seedNum);
	                $seedImgBox.append($img);
	                $seedBagImg.append($seedImgBox);
	                
	            }	        
	    })
		
	    seedBagImg.style.width = (itemWidth + itemMargin) * visibleItems - itemMargin + 'px';
		
	    $left.click(function () {
	        if ($seedBagImg[0].scrollWidth > $seedBagImg[0].clientWidth || $seedBagImg[0].offsetWidth > $seedBagImg[0].clientWidth) {
	            var width = $('.seedImg').outerWidth();
	            $seedBagImg.animate({scrollLeft: '-=' + width});
	        }

	    });	
	    $right.click(function () {
	        if ($seedBagImg[0].scrollWidth > $seedBagImg[0].clientWidth || $seedBagImg[0].offsetWidth > $seedBagImg[0].clientWidth) {
	            var width = $('.seedImg').outerWidth();
	            $seedBagImg.animate({scrollLeft: '+=' + width});
	        }
	    });
	}
	
	
	function updateData(data){
		console.log("vava"+data)
		console.log("gaga" + data.cropId)
		updateCropImg(data);
		/* var land = landMap.get(landIndex);
		console.log(land); */
	}
	
	function updateCropImg(data){
		let $crop = $('#crop_' + data.landIndex);
		console.log("dsaf" + data.landIndex)
	    if (data.isCrop == 0) {
	        if ($crop[0]) {
	            $crop.remove();
	        }
	    } else {
	        let url;
	        //更新作物图片
	        if (data.nowCropGrowStage == 6 || land.nowCropGrowStage == 0) {
	            //枯草期或者种子阶段
	            url = basePath + '/ext/images/crops/basic/' + land.nowCropGrowStage + '.png';
	        } else {
	            //正常生长阶段
	            url = basePath + '/ext/images/crops/' + land.cropId + '/' + land.nowCropGrowStage + '.png';
	        }
	    }
	}
	
	function getSeedName(seedId) {
	    var seedName = null;
	    $.ajax({
	        url: '<%=basePath%>/seed/getSeedData?seedId=' + seedId,
	        async: false,
	        success: function(response) {
	            seedName = response.seedName;
	        }
	    });
	    return seedName;
	}
	
	function getCropState(cropStatus){
		var cropState = null;
			$.ajax({
	 		    url: '<%=basePath%>/growth/getCropStatus?statusId=' + cropStatus,
	 		    async : false,
	 		   	success: function(response) {
		            cropState = response.statusName;
	 		   		}
			  	});
			console.log(cropState);
			return cropState; 
		}
	
	
	function initTip() {
	    $('.clickBox').tooltip({
	        trackMouse: true,
	        position: 'right',
	        showDelay: 1000,
	        onShow: function () {
	            
	            var land = landMap.get(parseInt(this.getAttribute('data-landIndex')));
	            console.log('seedName' + land.cropId);
	            if (land.isCrop == 1){
	            
		            var seedName = getSeedName(land.cropId);
		            var cropState = getCropState(land.cropStatus)
		            console.log(seedName);
		            console.log(cropState);
	
		            var output = land.output;
		            var stateEndTime = land.stateEndTime;
		            var $tip = $('<div style="color: black;"></div>')
		            
		            $tip.append('名称：' + seedName + '<br>');
		            $tip.append('状态：' + cropState + '<br>');
		            $tip.append('产量：' + output + '<br>');
		            $tip.append('时间：' + formatDate(stateEndTime) + '<br>');
	
		            $(this).tooltip({
		                content: $tip
		            });
		            $(this).tooltip('tip').css({
		                backgroundColor: 'white',
		                borderColor: 'black',
		            });
		        }
	        }
	    });
	}
	
	function formatDate(time) {
	    let date = new Date(time);
	    let YY = date.getFullYear();
	    let MM = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
	    let DD = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
	    let hh = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
	    let mm = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
	    let ss = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
	    // 这里修改返回时间的格式
	    return YY + "-" + MM + "-" + DD + " " + hh + ":" + mm + ":" + ss;
	}

	function plant() {
		$(document).on('click','.seedImg', function(){
			
			var seedBagLandIndex =parseInt(landIndex);
			console.log(seedBagLandIndex)
			var seedId = this.getAttribute('data-cropId');
			console.log(seedId)
			var url = '<%=basePath%>/game/plant?landIndex=' + seedBagLandIndex + '&seedId=' + seedId;
			request({},'post',url,true,function(result){
				if(result.code == 0){
					console.log(result);
					console.log(seedBagLandIndex);
					console.log("vava"+data)
					updateData(data);
					messageBox('消息',result.msg);
					
	                $('#seedBagContaineer').dialog('close');

				}
				else{
					messageBox('消息',result.msg);
				}
				
			})
		})
	}
</script>
</html>