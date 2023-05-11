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
		<a href="#" class="easyui-linkbutton c3" iconCls="icon-save" onclick="javascript:grid.edatagrid('saveRow')">编辑</a>
		<a href="#" class="easyui-linkbutton c4" iconCls="icon-remove" onclick="javascript:grid.edatagrid('cancelRow')">取消</a>
		<a href="#" class="easyui-linkbutton c5" iconCls="icon-cancel" onclick="javascript:grid.edatagrid('destroyRow')">删除</a>
		
	</div>
	<table id="seedManage"></table>
	
	<div id="formSeedContainer" class="easyui-dialog" style="width:680px; height:400px; padding:10px 10px" closed="true" buttons="#formSeedButtons">
		<form id="formSeedManage" method="POST" novalidate>
			<table >
				<tr>
					<td>ID</td>
					<td><input name="" required="true" class="w200" value="0"></td>
				</tr>
				
				<tr>
					<td>种子ID</td>
					<td><input name="" required="true" class="w200"></td>
				</tr>
				
				<tr>
					<td>种子名称</td>
					<td><input name="" required="true" class="easyui-validatebox w50"></td>
				</tr>
				
				<tr>
					<td>X季作物</td>
					<td><input name="" required="true" class="easyui-numberbox w50"></td>
				</tr>
				
				<tr>
					<td>种子等级</td>
					<td><input name="" required="true" class="easyui-numberbox w50"  ></td>
				</tr>
				
				<tr>
					<td>种子类型</td>
					<td><input name="" required="true" class="easyui-combobox w50"></td>
				</tr>
				
				<tr>
					<td>可获经验：</td>
					<td><input name="" required="true" class="easyui-numberbox w50"></td>
				</tr>
				
				<tr>
					<td>每季成熟所需时间：</td>
					<td><input name="" required="true" class="easyui-numberbox">秒</td>
				</tr>
				
				<tr>
					<td>每季成熟可获收成：</td>
					<td><input name="" required="true" class="easyui-numberbox">个果实</td>
				</tr>
				
				<tr>
					<td>种子采购价：</td>
					<td><input name="" required="true" class="easyui-numberbox">个金币</td>
				</tr>
				
				<tr>
					<td>每个收获的果实单价</td>
					<td><input name="" required="true" class="easyui-numberbox">个金币</td>
				</tr>
				
				<tr>
					<td>土地需求：</td>
					<td><input name="" required="true" class="easyui-combobox"></td>
				</tr>
				
				<tr>
					<td>每季成熟可获积分：</td>
					<td><input name="" required="true" class="easyui-numberbox"></td>
				</tr>
				
				<tr>
					<td>提示信息：</td>
					<td><input name="" required="true" class="easyui-validatebox"></td>
				</tr>
				
			</table>
		</form>
	</div>
	
	<div id="formSeedButtons">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick ="saveForm()">保存</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick ="javascript:$('#formSeedContainer').dialog('close')">取消</a>
    </div>
    
	<script>
		var seedManageGrid;
		$(document).ready(function() {
			seedManageGrid = $('#seedManage').edatagrid({
				title: '种子清单',
				width:100%;
				height:100%;
				method:'post',
				url:'<%=basePath%>/',
				saveUrl: '',
				updateUrl: '',
				destroyUrl: '',
				border: false,
                rownumbers: true,
                remoteSort: true,
                nowrap: false,
                singleSelect: true,
                fitColumns: true,
                striped: true,
                autoSave: true,
                idField: "id",
                //分页
                pagination:true,
                pagePosition:'bottom',
                pageSize:5,
                pageList:[5,10,15],
                
                columns: [
                	[{field: 'id',		title: 'ID', 				width: 30px,	sortable: true,	align: 'center',	halign: 'center'}, 
                	 {field: 'seedId',	title: '种子ID',				width: 30px,	sortable: true,	align: 'center',	halign: 'center'}, 
                	 {field: 'seedName',title: '种子名称', 			width: 30px,	sortable: true,	align: 'center',	halign: 'center'}, 
                	 {field: 'season',	title: 'x季作物',			width: 30px,	sortable: true,	align: 'center',	halign: 'center',	
                		 				formatter: seedGridAddSuffix(value, "季作物")
                	 }, 
                	 {field: 'leve',	title: '种子等级', 			width: 30px,	sortable: true,	align: 'center',	halign: 'center',
                		 				formatter: seedGridAddSuffix(value, "级作物")
                	 }, 
                	 {field: 'seedId',	title: '种子类型',			width: 30px,	sortable: true,	align: 'center',	halign: 'center'}, 
                	 {field: 'id',		title: '可获经验', 			width: 30px,	sortable: true,	align: 'center',	halign: 'center'}, 
                	 {field: 'seedId',	title: '每季成熟所需时间',	width: 30px,	sortable: true,	align: 'center',	halign: 'center',
                		 				formatter: seedGridAddSuffix(value, "秒")	 
                	 }, 
                	 {field: 'id',		title: '每季成熟可获收成', 	width: 30px,	sortable: true,	align: 'center',	halign: 'center'}, 
                	 {field: 'seedId',	title: '种子采购价',			width: 30px,	sortable: true,	align: 'center',	halign: 'center',
                		 				formatter: seedGridAddSuffix(value, "金币")	 
                	 }, 
                	 {field: 'id',		title: '每个收获的果实单价', 	width: 30px,	sortable: true,	align: 'center',	halign: 'center',
                		 				formatter: seedGridAddSuffix(value, "金币")	 
                	 }, 
                	 {field: 'seedId',	title: '土地需求',			width: 30px,	sortable: true,	align: 'center',	halign: 'center'}, 
                	 {field: 'id',		title: '每季成熟可获积分', 	width: 30px,	sortable: true,	align: 'center',	halign: 'center',
                		 				formatter: seedGridAddSuffix(value, "分")	 
                	 }, 
                	 {field: 'seedId',	title: '提示信息',			width: 30px,	sortable: true,	align: 'center',	halign: 'center'}, 
                	 {field: 'id',		title: '操作', 				width: 30px,	sortable: true,	align: 'center',	halign: 'center',
                		 				formatter: founction(){ }	 
                	 }
                	]
                ]
			})
		})
		
		function seedGridAddSuffix(value, suffix) {
			return Number(value) + suffix;
		}
	</script>
</body>
</html>