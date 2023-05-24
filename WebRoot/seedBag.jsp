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
	<div class="easyui-dialog" style="width:800px;" title="种子仓库" data-options="iconCls:'my-custom-icon'">
		<table id="tt" style="width:100%;height:400px"
			title="" singleSelect="true" fitColumns="flase" remoteSort="false"
			url="datagrid8_getdata.php" pagination="true" sortOrder="desc" sortName="itemid">
		<thead>
			<tr>
				<th field="itemid" width="25%" sortable="true">种子名称</th>
				<th field="listprice" width="25%" sortable="true">种子等级</th>
				<th field="unitcost" width="25%" sortable="true">种子类型</th>
				<th field="attr1" width="25%" sortable="true">土地需求</th>
			</tr>
		</thead>
	</table>	
	</div>
</body>

<script>

	$("body").css("height",$(window).height()); 
	
	$('#tt').datagrid({
		view: cardview,
		
		pagination:true,
        pagePosition:'bottom',
        pageSize:4,
        pageList:[4,6,8],
	});
	
	var cardview = $.extend({}, $.fn.datagrid.defaults.view, {
		
		renderRow: function(target, fields, frozen, rowIndex, rowData){
			var cc = [];
			cc.push('<td style="padding:10px 5px;border:0;">');
			if (!frozen){
				var aa = rowData.itemid.split('-');
				var img = 'shirt' + aa[1] + '.gif';
				cc.push('<img src="images/' + img + '" style="width:150px;float:left">');
				cc.push('<div style="float:left;margin-left:20px;">');
				for(var i=0; i<fields.length; i++){
					var copts = $(target).datagrid('getColumnOption', fields[i]);
					cc.push('<p><span class="c-label">' + copts.title + ':</span> ' + rowData[fields[i]] + '</p>');
				}
				cc.push('</div>');
			}
			cc.push('</td>');
			return cc.join('');
		}
	});
	
</script>
</html>