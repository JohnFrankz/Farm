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
	
	.my-custom-icon {
	  background-image: url(../images/用户.png);
	  /* 设置图标的宽度、高度和其他样式属性 */
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
	 parent.document.querySelector('#bottom').src = '<%=basePath%>/seed.jsp';
	
<%-- 	var landTypeList = {};
    var seedTypeList = {};
	
	getRemoteData('<%=basePath%>/seed/getAllSoil', false, function (data) {
        for (var i = 0; i < data.length; i++) {
            landTypeList[data[i]['soil']] = data[i]['soilName'];
        }
    });
    getRemoteData('<%=basePath%>/seed/getAllSeedType', false, function (data) {
        for (var i = 0; i < data.length; i++) {
            seedTypeList[data[i]['seed']] = data[i]['typeName'];
        }
    });
     --%>
    
	var cardview = $.extend({}, $.fn.datagrid.defaults.view, {
		renderRow: function(target, fields, frozen, rowIndex, rowData){
			let imgUrl = '<%=basePath%>/images/crops/' + rowData["seedId"] + '/5.png';
            let divStr = 
            	'<div id="mainBox_' + rowData['seedId'] + '" style="width:22%; padding: 10px;border: 0;display: inline-block; float:left;">' +
	                '<div style="width: 100%;height: 350px;border: gold 1px solid;border-collapse:collapse;">' +
	                    '<div style=" width:100%;">' +
	                            '<p style="padding:10px; height: 80px;">"' + rowData['prompt'] + '</p>' +
	                    '</div>' +
	                    '<div id="mainBoxImg_' + rowData['seedId'] + '" style="">' + 
	                            '<img style="width: 100%;height: 180px;" src="' + imgUrl + '" alt="种子图片">' + 
	                    '</div>' +
                        '<div style="padding: 10px;text-align: center;">' +
                            '<input type="button" value="我要购买" class="greenColorButton" onclick="purchaseSeed(' + rowData['seedId'] + ",\'" + rowData['seedName'] + '\')">' + 
                        '</div>'+ 
	                '</div>' + 
	            '</div>';
            return $(divStr).prop('outerHTML');
		}
	});
	
	var seedShopGrid;
	$(document).ready(function() {
		$('#seedShopContaineer').dialog({
            title: '种子仓库',
            iconCls: 'icon-seedPurchase',
            width: '80%',
            height: '90%',
        });
		
	seedShopGrid = $('#seedShopGrid').datagrid({
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
        
        columns: [
        	[{field: 'id', title: 'ID', width: 0,	sortable: true,	align: 'center', halign: 'center'}, 
        	 
        	 {field: 'seedName',title: '种子名称', width: '25%',	sortable: true,	align: 'center', halign: 'center',}, 
        	 {field: 'seedLevel', title: '种子等级', width: '25%', sortable: true, align: 'center', halign: 'center',}, 
        	 {field: 'seedType', title: '种子类型', width: '25%', sortable: true,	align: 'center', halign: 'center' ,
        		 options: {
                     required: true,
                     valueField: 'typeId',
                     textField: 'typeName',
                     panelHeight: 'auto',
                     url:'<%=basePath%>/seed/getAllSeedType'
                 },
              
	             formatter: function(value, row) {
	     	 		return $.ajax({
	         		    url: '<%=basePath%>/seed/getSeedType?typeId=' + value,
	         		    async : false,
	     		  	}).responseJSON.typeName;
	     		}
        	 }, 
        	 {field: 'soil', title: '土地类型', width: '25%', sortable: true, align: 'center', halign: 'center',
        		 options: {
                	 url:'<%=basePath%>/seed/getAllSoil' ,
                     required: true,
                     valueField: 'soilId',
                     textField: 'soilName',
                     panelHeight: 'auto'
             
                 },
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

	
</script>
</html>