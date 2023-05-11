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
	<div id="seedManageCon">
		<span>种子：</span>
		<input id="seedSearch" class="easyui-combobox" panelHeight="auto">
		<a href="#" class="easyui-linkbutton c1" iconCls="icon-search" onclick="doSeedSearch()">查询</a>
		<a href="#" class="easyui-linkbutton c2" iconCls="icon-add" onclick="javascript:grid.edatagrid('addRow')">添加</a>
		<a href="#" class="easyui-linkbutton c3" iconCls="icon-save" onclick="javascript:grid.edatagrid('saveRow')">保存</a>
		<a href="#" class="easyui-linkbutton c4" iconCls="icon-remove" onclick="javascript:grid.edatagrid('cancelRow')">取消</a>
		<a href="#" class="easyui-linkbutton c5" iconCls="icon-cancel" onclick="javascript:grid.edatagrid('destroyRow')">删除</a>
		
	</div>
	
	<script>
		var grid;
		$(document).ready(function() {
			grid = $('#grid').edatagrid({
				title: '种子清单',
				width:100%;
				height:100%;
				method:'post',
				url:'',
				saveUrl: '',
				updateUrl: '',
				destroyUrl: '',
				
				border: false,
                rownumbers: true,
                remoteSort: true,
                nowrap: false,
                singleSelect: true,
                fitColumns: true,
                pagination: true,
                striped: true,
                autoSave: true,
                idField: "id",
                columns: [
                	[{field: 'id',		title: 'ID', 				width: 30px,	sortable: true,	align: 'center',	halign: 'center'}, 
                	 {field: 'seedId',	title: '种子ID',				width: 30px,	sortable: true,	align: 'center',	halign: 'center'}, 
                	 {field: 'seedName',title: '种子名称', 			width: 30px,	sortable: true,	align: 'center',	halign: 'center'}, 
                	 {field: 'season',	title: 'x季作物',			width: 30px,	sortable: true,	align: 'center',	halign: 'center'	formatter: function(value, row) {return Number(value) + '季作物'}}, 
                	 {field: 'leve',	title: '种子等级', 			width: 30px,	sortable: true,	align: 'center',	halign: 'center'}, 
                	 {field: 'seedId',	title: '种子类型',			width: 30px,	sortable: true,	align: 'center',	halign: 'center'}, 
                	 {field: 'id',		title: '可获经验', 			width: 30px,	sortable: true,	align: 'center',	halign: 'center'}, 
                	 {field: 'seedId',	title: '每季成熟所需时间',	width: 30px,	sortable: true,	align: 'center',	halign: 'center'}, 
                	 {field: 'id',		title: '每季成熟可获收成', 	width: 30px,	sortable: true,	align: 'center',	halign: 'center'}, 
                	 {field: 'seedId',	title: '种子采购价',			width: 30px,	sortable: true,	align: 'center',	halign: 'center'}, 
                	 {field: 'id',		title: '每个收获的果实', 	width: 30px,	sortable: true,	align: 'center',	halign: 'center'}, 
                	 {field: 'seedId',	title: '土地需求',			width: 30px,	sortable: true,	align: 'center',	halign: 'center'}, 
                	 {field: 'id',		title: '每季成熟可获积分', 	width: 30px,	sortable: true,	align: 'center',	halign: 'center'}, 
                	 {field: 'seedId',	title: '提示信息',			width: 30px,	sortable: true,	align: 'center',	halign: 'center'}, 
                	 {field: 'id',		title: '操作', 				width: 30px,	sortable: true,	align: 'center',	halign: 'center'}, 
                	 {
                		field: 'seedName',
                		title: 'ID',
                		width: 30px,
                		sortable: true,
                		align: 'center',
                		halign: 'center'
                	},{
                		field: 'id',
                		title: 'ID',
                		width: 30px,
                		sortable: true,
                		align: 'center',
                		halign: 'center'	
                	}, {
                		field: 'id',
                		title: 'ID',
                		width: 30px,
                		sortable: true,
                		align: 'center',
                		halign: 'center'
                	}, {
                		
                	}, {
                		field: 'id',
                		title: 'ID',
                		width: 30px,
                		sortable: true,
                		align: 'center',
                		halign: 'center'
                	}, {
                		field: 'id',
                		title: 'ID',
                		width: 30px,
                		sortable: true,
                		align: 'center',
                		halign: 'center'
                	}, {
                		field: 'id',
                		title: 'ID',
                		width: 30px,
                		sortable: true,
                		align: 'center',
                		halign: 'center'
                	}, {
                		field: 'id',
                		title: 'ID',
                		width: 30px,
                		sortable: true,
                		align: 'center',
                		halign: 'center'
                	}, {
                		field: 'id',
                		title: 'ID',
                		width: 30px,
                		sortable: true,
                		align: 'center',
                		halign: 'center'
                	}, {
                		field: 'id',
                		title: 'ID',
                		width: 30px,
                		sortable: true,
                		align: 'center',
                		halign: 'center'
                	}, {
                		field: 'id',
                		title: 'ID',
                		width: 30px,
                		sortable: true,
                		align: 'center',
                		halign: 'center'
                	}, {
                		field: 'id',
                		title: 'ID',
                		width: 30px,
                		sortable: true,
                		align: 'center',
                		halign: 'center'
                	}, {
                		field: 'id',
                		title: 'ID',
                		width: 30px,
                		sortable: true,
                		align: 'center',
                		halign: 'center'
                	}, {
                		field: 'id',
                		title: 'ID',
                		width: 30px,
                		sortable: true,
                		align: 'center',
                		halign: 'center'
                	}, {
                		field: 'id',
                		title: 'ID',
                		width: 30px,
                		sortable: true,
                		align: 'center',
                		halign: 'center'
                	}, {
                		field: 'id',
                		title: 'ID',
                		width: 30px,
                		sortable: true,
                		align: 'center',
                		halign: 'center'
                	}]
                ]
			})
		})
	</script>
</body>
</html>