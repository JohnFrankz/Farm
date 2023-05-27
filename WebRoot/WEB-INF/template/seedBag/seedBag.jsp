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
	}
	
	.icon-seedBag {
	  background-image: url(../images/icon-seedBag.png);
	  /* 设置图标的宽度、高度和其他样式属性 */
	}
	
	.buyButton {
	    color: #FFFFFF;
	    background-color: #55cb86;
	    border-radius: 3px;
	    border: 2px solid #53d785 ;
	    outline: none;
	    font-size: 17px;
	    text-align: center;
	    cursor: pointer;
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
    <script type="text/javascript" src="<%=basePath%>ext/farm/helper.js?346t"></script>    
</head>
<body>
    <div id="seedShopContaineer">
        <table id="seedShopGrid"></table>
    </div>
</body>

<script>

	$("body").css("height",$(window).height()); 
	 var frameset = parent.document.getElementsByTagName('frameset')[0];
     frameset.rows = '60,*,200';
	 parent.document.querySelector('#bottom').src = '<%=basePath%>/seed.jsp';
	 
	 
	 var allSoil=["","黄土地","黑土地","红土地","金土地"];
	 var allSeedType = ["","普通","高级","梦幻"];
    
	var cardview = $.extend({}, $.fn.datagrid.defaults.view, {
		renderRow: function(target, fields, frozen, rowIndex, rowData){
			var imgUrl = '<%=basePath%>/images/crops/' + rowData["seedId"] + '/5.png';
			var main =	'<div id="mainBox_' + rowData['seedId'] + '" style="width:23%; padding: 5px;margin: 0 auto;display: inline-block; float:left; ">' +
			                '<div style="width:100%; height: 250px; border: 0.2rem outset yellow;  border-radius: 12px;border-collapse:collapse;">' +
			                    '<div style=" width:100%; ">' +
			                            '<p style="padding:5px; height: 60px; margin:0;">"' + rowData['prompt'] + '</p>' +
			                    '</div>' +
			                    '<div id="mainBoxImg_' + rowData['seedId'] + '" style="text-align:center;">' + 
			                            '<img style="width: 150px;height: 170px; margin-top:20px; " src="' + imgUrl + '" >' + 
			                    '</div>' +
			                '</div>' + 
		                        '<div style="padding: 10px;text-align: center;">' +
		                            '<input type="button" value="我要购买" class="buyButton" onclick="purchaseSeed(' + rowData['seedId'] + ",\'" + rowData['seedName'] + '\')">' + 
		                        '</div>'+ 
			            '</div>';
		 return $(main).prop('outerHTML');
		}
	});
	
	var seedShopGrid;
	$(document).ready(function() {
		$('#seedShopContaineer').dialog({
            title: '种子仓库',
            iconCls: 'icon-seedBag',
            width: '60%',
            height: 430,
        });
		
	seedShopGrid = $('#seedShopGrid').edatagrid({
		view: cardview,
        singleSelect: 'true',
        url: '<%=basePath%>/seed/data',
        idField: 'id',
        nowrap: true,
        remoteSort: false,
        fit: true,
        fitColumns: true,
        pagination:true,
        pagePosition:'bottom',
        pageSize:4,
        pageList:[1,2,3,4],
        onLoadSuccess: createTipTool,
        columns: [
        	[{field: 'id', title: 'ID', width: 0,	sortable: true,	align: 'center', halign: 'center'}, 
        	 {field: 'seedName',title: '种子名称', width: '25%',	sortable: true,	align: 'center', halign: 'center',}, 
        	 {field: 'seedLevel', title: '种子等级', width: '25%', sortable: true, align: 'center', halign: 'center',}, 
        	 {field: 'seedType', title: '种子类型', width: '25%', sortable: true,	align: 'center', halign: 'center' ,
	             formatter: function(value, row) {
	     	 		return $.ajax({
	         		    url: '<%=basePath%>/seed/getSeedType?typeId=' + value,
	         		    async : false,
	     		  	}).responseJSON.typeName;
	     		}
        	 }, 
        	 {field: 'soil', title: '土地类型', width: '25%', sortable: true, align: 'center', halign: 'center',
        		 
                formatter: function(value, row) {
                	 		return $.ajax({
                    		    url: '<%=basePath%>/seed/getSoilType?soilId=' + value,
                    		    async : false,
                		  	}).responseJSON.soilName;
                		}
        	 }, 
        	 {field: 'seedId',	title: '种子ID', width: $(this).width() * 0.1,	sortable: true,	align: 'center', halign: 'center',}, 
			 {field: 'season', title: '可收获季', width: 30,	sortable: true,	align: 'center', halign: 'center',}, 
        	 {field: 'salePrice', title: '单个果实可获金币', width: 30,	sortable: true,	align: 'center', halign: 'center',}, 
        	 {field: 'experience', title: '经验收获', width: 30,	sortable: true,	align: 'center', halign: 'center',}, 
        	 {field: 'matureTime',	title: '成熟时间', width: 30,	sortable: true,	align: 'center', halign: 'center',}, 
        	 {field: 'harvest', title: '单季收获', width: 30,	sortable: true,	align: 'center', halign: 'center',}, 
        	 {field: 'purchasePrice', title: '价格', width: 30,	sortable: true,	align: 'center', halign: 'center',}, 
        	 {field: 'points', title: '积分收获', 	width: 30,	sortable: true,	align: 'center', halign: 'center',}, 
        	 {field: 'prompt',	title: '提示信息', width: 30,	sortable: true,	align: 'center', halign: 'center'}, 
        	]]
	});
	})
	
	
	function createTipTool(o) {
        if (o != null) {
            onLoadSuccessObj = o;
        }
        var obj;
        obj = onLoadSuccessObj;
        var data = obj['rows'];
        for (let i = 0; i < data.length; i++) {
            let content = $('<div style="color: black;">')
                .append('名称：' + data[i]['seedName']).append('<br>')
                .append('级别：' + data[i]['seedLevel']).append('<br>')
                .append('价格：' + data[i]['purchasePrice']).append('<br>')
                .append('类别：' + allSeedType[data[i]['seedType']]).append('<br>')
                .append('土地：' + allSoil[data[i]['soil']]).append('<br>')
                .append('可收获季：' + data[i]['season']).append('<br>')
                .append('成熟时间：' + data[i]['matureTime']).append('<br>')
                .append('单季收获：' + data[i]['harvest']).append('<br>')
                .append('经验收获：' + data[i]['experience']).append('<br>')
                .append('单个果实可获金币：' + data[i]['salePrice']).append('<br>')
                .append('积分收获：' + data[i]['points']).append('<br>')
                .append('</div>');

            $('#mainBoxImg_' + data[i]['seedId']).tooltip({
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

        
    }
	
	function purchaseSeed(seedId, seedName) {
		console.log(seedId);
		console.log(seedName)
		var currUserName = '${user.username}';
        let message = '请输入您要购买的' + '<span style="color:gold;">' + seedName + '</span>' + '的数量';
        $.messager.prompt('提示信息', message, function (number) {
        	var url = '<%=basePath%>/store/buy?seedId=' + seedId + '&num=' + number + '&userName=' + currUserName;
            if (/^[1-9]\d*/.test(number)) {
                request({fuck: "fuckyou"}, 'post', url, false, function (result) {
                    if (result.code == 0) {
                        parent.document.querySelector('#bottom').src = '<%=basePath%>/seed.jsp';
                        parent.document.querySelector('#menu').src = '<%=basePath%>/menu.jsp';
                        messageBox('消息', '种子购买成功'); 
                    } else {
                        messageBox('消息', '金钱不足');
                    }
                });
            } else {
                messageBox('消息', '请输入有效数字');
            }
        });
    }

	
</script>
</html>