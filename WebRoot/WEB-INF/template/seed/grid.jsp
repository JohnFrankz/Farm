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
		<span style="color:#ffffff;">种子：</span>
		<input id="seedSearch" class="easyui-validatebox" panelHeight="auto">
		<a href="#" class="easyui-linkbutton c1" iconCls="icon-search" onclick="doSeedSearch()">查询</a>
		<a href="#" class="easyui-linkbutton c2" iconCls="icon-add" onclick="javascript:seedManageGrid.edatagrid('addRow')">添加</a>
		<a href="#" class="easyui-linkbutton c3" iconCls="icon-edit" onclick="editRow()">编辑</a>
		<a href="#" class="easyui-linkbutton c4" iconCls="icon-remove" onclick="javascript:seedManageGrid.edatagrid('cancelRow')">取消</a>
		<a href="#" class="easyui-linkbutton c5" iconCls="icon-cancel" onclick="javascript:seedManageGrid.edatagrid('destroyRow')">删除</a>
		
	</div>
	<div id="seedTableContainer" >
		<table id="seedManage" style="width:100%; "></table>
	</div>
	<div id="msgBox"></div>
	
	<div id="formSeedContainer" class="easyui-dialog" style="width:680px; height:400px; padding:10px 10px" closed="true" buttons="#formSeedButtons">
		<form id="formSeedManage" method="POST" novalidate>
			<table >
				<tr>
					<td>ID</td>
					<td><input name="id" required="true" class="w200" value="0" readonly="readonly"></td>
				</tr>
				
				<tr>
					<td>种子ID</td>
					<td><input name="seedId" required="true" class="w200"></td>
				</tr>
				
				<tr>
					<td>种子名称</td>
					<td><input name="seedName" required="true" class="easyui-validatebox w50"></td>
				</tr>
				
				<tr>
					<td>X季作物</td>
					<td><input name="season" required="true" class="easyui-numberbox w50"></td>
				</tr>
				
				<tr>
					<td>种子等级</td>
					<td><input name="seedLevel" required="true" class="easyui-numberbox w50"  ></td>
				</tr>
				
				<tr>
					<td>种子类型</td>
					<td><input name="seedType" required="true" class="easyui-combobox w50"></td>
				</tr>
				
				<tr>
					<td>可获经验：</td>
					<td><input name="experience" required="true" class="easyui-numberbox w50"></td>
				</tr>
				
				<tr>
					<td>每季成熟所需时间：</td>
					<td><input name="matureTime" required="true" class="easyui-numberbox">秒</td>
				</tr>
				
				<tr>
					<td>每季成熟可获收成：</td>
					<td><input name="harvest" required="true" class="easyui-numberbox">个果实</td>
				</tr>
				
				<tr>
					<td>种子采购价：</td>
					<td><input name="purchasePrice" required="true" class="easyui-numberbox">个金币</td>
				</tr>
				
				<tr>
					<td>每个收获的果实单价</td>
					<td><input name="salePrice" required="true" class="easyui-numberbox">个金币</td>
				</tr>
				
				<tr>
					<td>土地需求：</td>
					<td><input name="soil" required="true" class="easyui-combobox"></td>
				</tr>
				
				<tr>
					<td>每季成熟可获积分：</td>
					<td><input name="points" required="true" class="easyui-numberbox">分</td>
				</tr>
				
				<tr>
					<td>提示信息：</td>
					<td><input name="prompt" required="true" class="easyui-validatebox"></td>
				</tr>
				
			</table>
		</form>
	</div>
	
	<div id="formSeedButtons">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick ="saveForm()">保存</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick ="javascript:$('#formSeedContainer').dialog('close')">取消</a>
    </div>
    
	<script>
		var params ={
				id:'',
				mode:'insert'
		};
	
		var seedManageGrid;
		$(document).ready(function() {
			seedManageGrid = $('#seedManage').edatagrid({
				title: '种子清单',
				width:'100%',
				/* height:'100%', */
				method:'post',
				url:'<%=basePath%>/seed/data',
				saveUrl: '',
				updateUrl: '',
				destroyUrl: '',
				
				editable: true,
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
                pageSize:2,
                pageList:[2,4,6],
                
                columns: [
                	[{field: 'id',		title: 'ID', width: 10,	sortable: true,	align: 'center', halign: 'center'}, 
                	 {field: 'seedId',	title: '种子ID', width: 20,	sortable: true,	align: 'center', halign: 'center'}, 
                	 {field: 'seedName',title: '种子名称', width: 30,	sortable: true,	align: 'center', halign: 'center',
                		 editor: {
                             type: 'validatebox',
                             options: {
                                 required: true
                             }
                         }
                	 }, 
                	 {field: 'season',	title: 'x季作物', width: 30,	sortable: true,	align: 'center', halign: 'center',
                		 editor: {
                             type: 'numberbox',
                             options: {
                                 required: true
                             }
                         },
   		 				formatter: function(value){
   		 					return Number(value) + '季作物';
   		 				}
                	 }, 
                	 {field: 'seedLevel',	title: '种子等级', width: 30,	sortable: true,	align: 'center', halign: 'center',
                		 editor: {
                             type: 'numberbox',
                             options: {
                                 required: true
                             }
                         },
                		 formatter: function(value){
 		 					return Number(value) + '级作物';
 		 				}
                	 }, 
                	 {field: 'seedType',	title: '种子类型', width: 30,	sortable: true,	align: 'center',	halign: 'center' ,
                		 editor: {
                             type: 'combobox',
                             options: {
                                 required: true
                             }
                         },	 
                	 }, 
                	 {field: 'experience',		title: '可获经验', 			width: 30,	sortable: true,	align: 'center',	halign: 'center',
                		 editor: {
                             type: 'numberbox',
                             options: {
                                 required: true
                             }
                         },	 
                	 }, 
                	 {field: 'matureTime',	title: '每季成熟所需时间',	width: 30,	sortable: true,	align: 'center',	halign: 'center',
                		 editor: {
                             type: 'numberbox',
                             options: {
                                 required: true
                             }
                         },
				                		 formatter: function(value){
				 		 					return Number(value) + '秒';
				 		 				}	 
                	 }, 
                	 {field: 'harvest',		title: '每季成熟可获收成', 	width: 30,	sortable: true,	align: 'center',	halign: 'center',
                		 editor: {
                             type: 'numberbox',
                             options: {
                                 required: true
                             }
                         },	 
                	 }, 
                	 {field: 'purchasePrice',	title: '种子采购价',			width: 30,	sortable: true,	align: 'center',	halign: 'center',
                		 editor: {
                             type: 'numberbox',
                             options: {
                                 required: true
                             }
                         },
					                		 formatter: function(value){
					 		 					return Number(value) + '金币';
					 		 				} 
                	 }, 
                	 {field: 'salePrice',		title: '每个收获的果实单价', 	width: 30,	sortable: true,	align: 'center',	halign: 'center',
                		 editor: {
                             type: 'numberbox',
                             options: {
                                 required: true
                             }
                         },
                		 formatter: function(value){
	 		 					return Number(value) + '金币';
	 		 				}  
                	 }, 
                	 {field: 'soil',	title: '土地需求',			width: 30,	sortable: true,	align: 'center',	halign: 'center',
                		 editor: {
                             type: 'combobox',
                             options: {
                                 required: true
                             }
                         },	 
                	 }, 
                	 {field: 'points',		title: '每季成熟可获积分', 	width: 30,	sortable: true,	align: 'center',	halign: 'center',
                		 editor: {
                             type: 'numberbox',
                             options: {
                                 required: true
                             }
                         },
                		 formatter: function(value){
	 		 					return Number(value) + '分';
	 		 				} 	 
                	 }, 
                	 {field: 'prompt',	title: '提示信息',			width: 30,	sortable: true,	align: 'center',	halign: 'center',
                		 editor: {
                             type: 'validatebox',
                             options: {
                                 required: true
                             }
                         },}, 
                	 {field: 'operation',		title: '操作', 		width: 30,	sortable: true,	align: 'center',	halign: 'center',
                		 				/* formatter: founction(){ }	 */ 
                	 }
                	]
                ],

           	 destroyMsg: {
                    norecord: {
                        title: '警告',
                        msg: '首先需要选中记录，然后在点击删除按钮'
                    },
                    confirm: {
                        title: '确认',
                        msg: '是否删除选中记录?'
                    }
                },
                onSuccess: function(index, result) {
                    console.log(result);
                    $("#msgBox").text(result.msg);
                },
                onDestroy: function(index, result) {
                    console.log(result);
                    $("#msgBox").text(result.msg);
                }
			})
		})
		
		
		function editRow() {
            var row = seedManageGrid.datagrid('getSelected');
            if (row) {
                params.id = row.id;
                params.mode = 'edit';
                $('#formSeedContainer').dialog('open').dialog('setTitle', '编辑数据');
                $('#formSeedManage').form('load', row);
            } else {
                alert("请先选择一行数据，然后再尝试点击操作按钮！");
            }
        }
		
	</script>
</body>
</html>
