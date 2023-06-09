﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

        #land {
            position: absolute;
            width:100%;
            height:100%;
            left:270px;
            top:140px;
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
	
	.spade{
		position:absolute;
		width:55px;
		height:55px;
		top:460px;
		left:180px;
		background:url(../images/clean.png);
		border:thick double green;
		-webkit-border-radius: 50%;
		-moz-border-radius: 50%;
		border-radius: 50%;
	}
	
	.custom-cursor {
		  cursor: url(../cursor/clean.cur), default;
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
    	<div id="spade" class="spade"> </div>
	</div>
	
	<audio id="worm2" src="../sounds/isInsect2.mp3"></audio>
	<audio id="harvest" src="../sounds/harvest2.mp3"></audio>
	<audio id="hasPlanted" src="../sounds/hasPlanted.mp3"></audio>
	<audio id="killworm" src="../sounds/killworm.mp3"></audio>
	<audio id="plant" src="../sounds/plant2.mp3"></audio>
	<audio id="cleanLand" src="../sounds/cleanLand.mp3"></audio>
	<audio id="mistake" src="../sounds/mistake.mp3"></audio>
	<audio id="bgm" src="../sounds/bgm.mp3"></audio>
	
</body>

<script>
	window.onload = function() {
		var bgm = $('#bgm')[0];
		//bgm.play();
		var frameset = parent.document.getElementsByTagName('frameset')[0];
	    frameset.rows = '60,*,50';
	    parent.document.querySelector('#bottom').src = '<%=basePath%>/tools.jsp';
	    $("body").css("height",$(window).height());
	};
	
	class Land {
	    cropId;
	    cropStatus
	    currentStateHasGrownTime;
	    currentStage;
	    currentSeason;
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
	
	
	var mistake = $('#mistake')[0];
	 var $spade = $('#spade');
	 
	$(function () {
		initWebSocket();
		var num = 0;
		var $land = $('#land');
		var url = '<%=basePath%>/game/landStatus';
		 request({}, 'post', url, false, function (result) {
			 for (var i = 0; i<4; i++){
				 for (var j = 0; j<6; j++, num++){
					 var currLand = result[num];
					 $land.append(landButton(i,j,currLand));
					 $land.append(addLandImg(i,j,currLand));
					 addSeedData(i,j, currLand); 
					 if(currLand.isCrop == 1){
						 $land.append(initCropImg(i,j,currLand));
						 if(currLand.isInsect == 1){
							 $land.append(initInsect(i,j,currLand));
						 }
					 }
				 }
			 }
		 })
		 
		 
		$('#spade').on('click', function () {
		  var currentCursor = $('body').css("cursor");
		  var targetCursor = "url(\"http://127.0.0.1:8080/farm//cursor/clean.cur\"), default";
		  console.log("currentCursor: ", currentCursor)
		  if (currentCursor !== targetCursor) {
		    // 如果当前光标不是目标样式，则修改为目标样式
		    $('body').css("cursor", targetCursor);
		  } else {
		    // 如果当前光标是目标样式，则恢复默认样式
		    $('body').css("cursor", "default");
		  }
		  isSpade = !isSpade;
		  if (isSpade) {
			  $('.clickBox').css("cursor", targetCursor);
		  }
		});
 
		 $(document).on('click', '.clickBox', function () {
		     var land = landMap.get(parseInt(this.getAttribute('data-landIndex')));
				if (isSpade) {
					if (land.isCrop == 0) 
						return;
					if (!(land.currentStage == 6 && land.isWithered == 1)) {
						$.messager.confirm (' 提示:',' 作物还未收获，你确认要铲除吗？',function (event){ 
							if (event) { 
								removeCrop(land.landIndex);
								return;
							}
						}); 
					} else { 
						removeCrop(land.landIndex); 
					}
					return;
			 	}
				
		        if (land.isCrop == 0) {
		            plantCrop(land);
		        } else if (land.currentStage == 6 && land.isWithered == 1 ) {
		        	cleanDeadLeaves(land.landIndex);
		        } else if (land.isInsect == 1) {
		            killBug(land.landIndex);
		        } else if (land.currentStage == 5  && land.isMature == 1) {
		        	harvest(land.landIndex);
		        }
		    });
		 
		$(document).on('click','.seedImg', function(){
			var hasPlanted = $('#hasPlanted')[0];	
			var seedBagLandIndex =parseInt(landIndex);
			var seedId = this.getAttribute('data-cropId');
			var url = '<%=basePath%>/game/plant?landIndex=' + seedBagLandIndex + '&seedId=' + seedId;
			request({},'post',url,true,function(result){
				if(result.code == 0){
					hasPlanted.play();
					messageBox('消息',result.msg);
	                $('#seedBagContaineer').dialog('close');
				}
				else{
					mistake.play();
					messageBox('消息',result.msg);
				}
			})
		}) 
		landTip();
		var isSpade = 0;
		$(document).on('mouseenter', '.clickBox', function () {
			if (isSpade == 1) {
				return;
			}
			 var land = landMap.get(parseInt(this.getAttribute('data-landIndex')));	   
			 var currentCursorStyle = $('#spade').css('cursor');
			 if (currentCursorStyle.indexOf('custom-cursor') === -1) {
		        if (land.isCrop == 0) {
		        	 $('.clickBox').css("cursor", "url(../cursor/plant3.cur),default");
		        } else if (land.currentStage == 6 && land.isWithered == 1 ) {
		        	 $('.clickBox').css("cursor", "url(../cursor/clean.cur),default");
		        } else if (land.isInsect == 1) {
		        	 $('.clickBox').css("cursor", "url(../cursor/killBug.cur),default");
		        } else if(land.currentStage != 5 && land.currentStage != 5){
		        	 $('.clickBox').css("cursor", "url(../cursor/wait.cur), default");
		        } else if (land.currentStage == 5  && land.isMature == 1) {
		        	 $('.clickBox').css("cursor", "url(../cursor/glove.cur),default");
		        }
			 }
	        
	    });

	    
	})
	
	function initWebSocket(){
		let socket = new WebSocket("ws://127.0.0.1:8080/farm/action");
		socket.onopen = function(e) {
		  console.log("[open] Connection established");
		  console.log("Sending to server");
		  socket.send("My name is John");
		};
		socket.onmessage = function(event) {
			var data = JSON.parse(event.data);
			updateData(data);	
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
	   	var $landImg = $('<img data-landType="' + currLand.landType + '" class="land" style="position:absolute;" id="land_' + currLand.landIndex + '" src="' + landImgUrl + '">');
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
	    var $landButton = $('<div data-landType="' + currLand.landType + '" data-landIndex="' + currLand.landIndex + '" class="clickBox" style="position:absolute;" id="clickBox_' + currLand.landIndex + '">');
	    $landButton.css({
	        width: landWidth + 'px',
	        height: landHeight + 'px',
	        left: adjustX(i, j) + 'px',
	        top: adjustY(i, j) + 'px',
	        zIndex: 30
	    });
	    return $landButton;
	}
	
	function initInsect(i,j,currLand){
		var $insect = $('<img class="insect" style="position:absolute;" id="insect_' + currLand.landIndex + '" src="../images/insect.png">');
		$insect.css({
	        width: 60 + 'px',
	        height: 60 + 'px',
	        left: adjustX(i, j) -10  + 'px', 
	        top: adjustY(i, j) -10 + 'px',
	        zIndex: 20
	    });
	    return $insect;
	}
	
	function addSeedData(i, j, result) {
	    let land = new Land();
	    land.landIndex = result.landIndex;
	    
		land.currentStage = result.currentStage;
		land.currentSeason = result.currentSeason;
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
		

	    landMap.set(land.landIndex, land);
	}
	
	
	function adjustX(i, j) {
	    return (j * (landWidth + paddingX));
	}

	function adjustY(i, j) {
	    return (i * (landHeight + paddingY));
	}
	
	
	function initCropImg(i,j,currLand){
	
		var url;
		var growthStage = $.ajax({
 		    url: '<%=basePath%>/growth/getStage?seedId=' + currLand.cropId + '&growthStage=' + currLand.currentStage,
 		    async : false,
		  	}).responseJSON;
		
		
		if (currLand.currentStage == 6 || currLand.currentStage == 0) {
	        url = '../images/crops/basic/' + currLand.currentStage + '.png';
	    } else {
	        url = '../images/crops/' + currLand.cropId + '/' + currLand.currentStage + '.png';
	    }
		
		var $crop = $('<img data-cropId="' + currLand.cropId + '" data-nowCropGrowStage="' + currLand.currentStage+ '" class="crop" style="position:absolute;" id="crop_' + currLand.landIndex+ '" src="' + url + '" >');

	    $crop.css({
	        width: growthStage.width + 'px',
	        height: growthStage.height + 'px',
	        left: adjustX(i, j) + (growthStage.x - 52) * 3 / 5 + 'px', 
	        top: adjustY(i, j) - (255 - growthStage.y)  + 'px', 
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
	   	var plant = $('#plant')[0];
	    plant.play(); 
	    var $seedBagWindow = $('#seedBagContaineer');
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
		document.getElementById('seedBagImg').innerHTML = '';
	    request({}, 'post',url, true, function (result) {
	            for (var i = 0; i < result.length; i++) {
	                var seedId = result[i]['seedId'];
	                var imgUrl ='../images/crops/' + seedId + '/5.png';
	                var $seedNum = $('<div class="seedNum" style="">' + result[i]['seedNum'] + '</div>');
	                var $img = $('<img id="cropImg_'+ seedId + '" style="display:block; margin-left: auto;margin-right: auto;width:160px; height:170px;" class="seedImg" data-cropId="' + seedId + '" src="' + imgUrl + '" >');
	                var $seedImgBox = $('<div class="seedImgBox"></div>');
	                
	                $seedImgBox.append($seedNum);
	                $seedImgBox.append($img);
	                $seedBagImg.append($seedImgBox);
	                
	        	    var seedId = $img.attr('data-cropId');
	                
	                var seedData = $.ajax({
	         		    url: '<%=basePath%>/seed/getSeedData?seedId=' +seedId,
	         		    async : false,
	        		  	}).responseJSON;
	                
	                var content = $('<div style="color: black;">')
	                    .append('名称：' + seedData.seedName).append('<br>')
	                    .append('单季产量：' + seedData.harvest + "个果实").append('<br>')
	                    .append('果实单价：' + seedData.purchasePrice + "金币" ).append('<br>')
	                    .append('季数：' + seedData.season + "季作物").append('<br>');
	                var soilCode = seedData.soil;
	                var tudi = soilCode == 1 ? "红" : soilCode == 2 ? "黑" :
	                	soilCode == 3 ? "金" : "紫";
	                content.append('土地要求：' + tudi + "土地" ).append('<br>')
		               
	                    $('#cropImg_' + seedId).tooltip({
	                        trackMouse: true,
	                        position: 'right',
	                        content: content,
	                        onShow: function () {
	                            $(this).tooltip('tip').css({
	                                backgroundColor: 'white',
	                                borderColor: 'gray',
	                            });
	                        }
	                    });
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
		var land = landMap.get(data.landIndex);
		updateCropImg(data);
		updateInsect(data);
		land.landIndex = data.landIndex;
		land.isInsect = data.isInsect;
		land.cropStatus = data.cropStatus;
		land.currentSeason = data.currentSeason;
		land.currentStage = data.currentStage;
		land.stateEndTime = data.stateEndTime;
		land.cropId = data.cropId;
		land.isWithered = data.isWithered;
		land.isCrop = data.isCrop;
		land.isMature = data.isMature;
		land.output = data.output;
		land.landType = data.landType;
		land.currentStateHasGrownTime = data.currentStateHasGrownTime
		landMap.set(land.landIndex,land);
	}
	
	function updateCropImg(data){
		var growthStage = $.ajax({
 		    url: '<%=basePath%>/growth/getStage?seedId=' + data.cropId + '&growthStage=' + data.currentStage,
 		    async : false,
		  	}).responseJSON;
		var $crop = $('#crop_' + data.landIndex);
	    if (data.isCrop == 0) {
	        if ($crop[0]) {
	            $crop.remove();
	        }
	    } else {
	    	var i = Math.floor((data.landIndex) / 6) ;
	    	var j = (data.landIndex ) % 6;
	        var url;
	        if (data.currentStage == 6 || data.currentStage == 0) {
	            url = '../images/crops/basic/' + data.currentStage + '.png';
	        } else {
	            url = '../images/crops/' + data.cropId + '/' + data.currentStage + '.png';
	        }
			 if (!$crop[0]) {
				 $crop = $('<img data-cropId="' + data.cropId + '" data-currentStage="' + data.currentStage + '" class="crop" style="position:absolute;" id="crop_' + data.landIndex + '" src="' + url + '">');
				 $crop.css({
				        width: growthStage.width + 'px',
				        height: growthStage.height + 'px',
				        left: adjustX(i, j) + (growthStage.x - 52) * 3 / 5 + 'px', 
				        top: adjustY(i, j) - (255 - growthStage.y)  + 'px',  
				        zIndex: 10
				    });
				 $('#land').append($crop);
			 }else{
				 
				 $crop.css({
				        width: growthStage.width + 'px',
				        height: growthStage.height + 'px',
				        left: adjustX(i, j) + (growthStage.x - 52) * 3 / 5 + 'px', 
				        top: adjustY(i, j) - (255 - growthStage.y)  + 'px',  
				        zIndex: 10
				    });
				 $crop[0].src = url;
			 }
	    }
	}
	
	function updateInsect(data){
		var worm2 = $('#worm2')[0];
		var i = Math.floor((data.landIndex) / 6) ;
    	var j = (data.landIndex ) % 6;
		var $insect = $('#insect_' + data.landIndex);
	    if (!data.isCrop || data.isInsect == 0) {
	        if ( $insect[0]) {
	        	
	            $insect.remove();
	        }
	    } else {
	        if (!$insect[0]) {
	            $insect = $('<img class="insect" style="position:absolute;" id="insect_' + data.landIndex + '" src="../images/insect.png">');
	            $insect.css({
	                width: 60 + 'px',
	                height: 60 + 'px',
	                left: adjustX(i, j) - 10 + 'px',
	                top: adjustY(i, j) - 10 + 'px',
	                zIndex: 20
	            });
	            worm2.play();
	            $('#land').append($insect);
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
			return cropState; 
		}
	
	
	function landTip() {
	    $('.clickBox').tooltip({
	        trackMouse: false,
	        position: 'left',
	        showDelay: 1500,
	        onShow: function () {
	            var land = landMap.get(parseInt(this.getAttribute('data-landIndex')));
	            if (land.isCrop == 1){
		            var seedName = getSeedName(land.cropId);
		            var cropState = getCropState(land.cropStatus)
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
	    return YY + "-" + MM + "-" + DD + " " + hh + ":" + mm + ":" + ss;
	}

 	function harvest(landIndex) {
 		var harvest = $('#harvest')[0];
 		var url = '<%=basePath%>/game/harvest?landIndex=' + landIndex;
 		request({}, 'post', url, false, function (result) { 
 			if (result.code == 0 ) {      
 				messageBox('消息', result.msg);         
 				harvest.play();
 			} else {
	 				mistake.play();     
	 				messageBox('消息', '收获失败');    
	 			}   
 			});
 		  parent.document.querySelector('#menu').src = '<%=basePath%>/menu.jsp';
 		}
 	
 	function cleanDeadLeaves(landIndex) {
 		var cleanLand = $('#cleanLand')[0];
 		var url = '<%=basePath%>/game/cleanDeadLeaves?landIndex=' + landIndex;
 	    request({}, 'post', url, false, function (result) {
 	        if (result.code == 0) {
 	            messageBox('消息', result.msg);
 	            cleanLand.play();
 	        } else {
 	            mistake.play(); 
 	            messageBox('消息', '除草失败');
 	        }
 	    });
 	   parent.document.querySelector('#menu').src = '<%=basePath%>/menu.jsp';
 	}
 	
 	function killBug(landIndex){
 		var killBug = $('#killworm')[0];
 		var url = '<%=basePath%>/game/killBug?landIndex=' + landIndex;
 		request({},'post',url,false,function(result){
 			if(result.code == 0){
 				messageBox ('消息',result.msg);
 				killBug.play();
 			} else {
 				mistake.play();
 				messageBox('消息',result.msg);
 			}
 		})
 		  parent.document.querySelector('#menu').src = '<%=basePath%>/menu.jsp';
 	}
 	
 	function removeCrop(landIndex) {
 		var cleanLand = $('#cleanLand')[0];
 		var url = '<%=basePath%>/game/removeCrop?landIndex=' + landIndex;
 		request({},'post',url,false,function(result){
 			if(result.code == 0){
 				messageBox ('消息',result.msg);
 				cleanLand.play();
 			} else {
 				mistake.play();
 				messageBox('消息',result.msg);
 			}
 		})
 	}
 	
 	bgm.addEventListener("ended", function() {
	 		bgm.currentTime = 0;
	 		bgm.play();
 		});

</script>
</html>