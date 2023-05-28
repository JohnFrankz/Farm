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
	<div id="seedManageCon">
		<span style="color:#ffffff;">种子：</span>
		<input id="seedSearch"  class="easyui-textbox" panelHeight="auto">
		<a href="#" class="easyui-linkbutton c1" iconCls="icon-search" onclick="doSeedSearch()">查询</a>
		<a href="#" class="easyui-linkbutton c2" iconCls="icon-add" onclick="addSeed()">添加</a>
		<a href="#" class="easyui-linkbutton c3" iconCls="icon-edit" onclick="editRow()">编辑</a>
		<a href="#" class="easyui-linkbutton c4" iconCls="icon-remove" onclick="cancel()">取消</a>
		<a href="#" class="easyui-linkbutton c5" iconCls="icon-cancel" onclick="javascript:seedManageGrid.edatagrid('destroyRow')">删除</a>
		
	</div>

	<table id="seedManage"></table>

	<div id="formSeedContainer" class="easyui-dialog" style="width:880px; height:400px; padding:10px 10px" closed="true" buttons="#formSeedButtons">
		<form id="formSeedManage" method="POST" novalidate>
			<table style="width:100%">
				<tr>
					<td  style="width:25%">ID：</td>
					<td  style="width:25%"><input name="id" required="true" class="w150" value="0" readonly="readonly" ></td>
				</tr>
				
				<tr>
					<td style="width:25%">种子ID：</td>
					<td style="width:25%"><input name="seedId" required="true" class="easyui-numberbox w150"></td>
				</tr>
				
				<tr>
					<td>种子名称：</td>
					<td><input name="seedName" required="true" class="easyui-textbox w50"></td>
				</tr>
				
				<tr>
					<td>X季作物：</td>
					<td><input name="season" required="true" class="easyui-numberbox w50"></td>
				</tr>
				
				<tr>
					<td>种子等级：</td>
					<td><input name="seedLevel" required="true" class="easyui-numberbox w50"  ></td>
				</tr>
				
				<tr>
					<td>种子类型：</td>
					<td><input name="seedType" required="true" class="easyui-combobox w50" data-options="valueField: 'typeId',textField: 'typeName', panelHeight: 'auto',
				               url:'<%=basePath%>/seed/getAllSeedType', "></td>
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
					<td>每个收获的果实单价：</td>
					<td><input name="salePrice" required="true" class="easyui-numberbox">个金币</td>
				</tr>
				
				<tr>
					<td>土地需求：</td>
					<td><input id="soil" name="soil" required="true" class="easyui-combobox" data-options="valueField: 'soilId',textField: 'soilName', panelHeight: 'auto',
				                url:'<%=basePath%>/seed/getAllSoil', ">

                </td>
				</tr>
				
				<tr>
					<td>每季成熟可获积分：</td>
					<td><input name="points" required="true" class="easyui-numberbox">分</td>
				</tr>
				
				<tr>
					<td>提示信息：</td>
					<td><input name="prompt" required="true" class="easyui-textbox"></td>
				</tr>
				
			</table>
		</form>
	</div>
	
	<div id="formSeedButtons">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick ="saveForm()">保存</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick ="javascript:$('#formSeedContainer').dialog('close')">取消</a>
    </div>
    
    <div id="growthStageButton" class="easyui-dialog" style="width:1200px; height:550px;" closed="true">
    	<div style="padding:5px 0 0 10px;">
	    	<a href="#" class="easyui-linkbutton c2" iconCls="icon-add" onclick="addGrowthStage()">添加</a>
			<a href="#" class="easyui-linkbutton c3" iconCls="icon-edit" onclick="editGrowthStage()">编辑</a>
			<a href="#" class="easyui-linkbutton c4" iconCls="icon-remove" onclick="javascript:$('#growthStage').edatagrid('cancelRow')">取消</a>
			<a href="#" class="easyui-linkbutton c5" iconCls="icon-cancel" onclick="javascript:$('#growthStage').edatagrid('destroyRow')">删除</a>
		 </div>
    	<table id="growthStage" style="width:100%; "></table>
   
	    <div id="formGrowthContainer" class="easyui-dialog" style="width:880px; height:400px; padding:10px 10px" closed="true" buttons="#formGrowthButtons">
	    	<form id="formGrowthStage" method="POST" novalidate>
	    		<table>
	    			<tr>
						<td  style="width:25%">ID：</td>
						<td  style="width:25%"><input name="id" required="true" class="w150" value="0" readonly="readonly" ></td>
					</tr>
					
					<tr>
						<td style="width:25%">种子ID：</td>
						<td style="width:25%"><input id="seedId" name="seedId" required="true" readonly="readonly"  class=" w150" ></td>
					</tr>
					
					<tr>
						<td>生长阶段:</td>
						<td><input id="growthStage2" name="growthStage" required="true" class="easyui-numberbox w50"></td>
					</tr>
					
					<tr>
						<td>生长阶段标题：</td>
						<td><input name="growthName" required="true" class="easyui-textbox w50"></td>
					</tr>
					
					<tr>
						<td>阶段生长时间：</td>
						<td><input name="growthTime" required="true" class="easyui-numberbox w50">秒</td>
					</tr>
					
					<tr>
						<td>生虫概率：</td>
						<td><input name="pestProbability" required="true" class="easyui-numberbox w50"></td>
					</tr>
					
					<tr>
						<td>图片宽度：</td>
						<td><input id="pWidth" name="width" required="true" class="easyui-numberbox w50">px</td>
					</tr>
					
					<tr>
						<td>图片高度：</td>
						<td><input id="pHeight" name="height" required="true" class="easyui-numberbox w50">px</td>
					</tr>
					
					<tr>
						<td>图片offsetX：</td>
						<td><input id="pX" name="x" required="true" class="easyui-numberbox w50" >px</td>
					</tr>
					
					<tr>
						<td>图片offsetY：</td>
						<td><input id="pY" name="y" required="true" class="easyui-numberbox w150">px</td>
					</tr>
					
					<tr>
						<td>作物状态：</td>
						<td><input name="state" required="true" class="easyui-combobox w50" data-options="valueField: 'statusId',textField: 'statusName', panelHeight: 'auto',
				               url:'<%=basePath%>/growth/getAllCropStatus',
				               ">
				        </td>
					</tr>
					
					<tr>
						<td></td>
						<td><a href="#" class="easyui-linkbutton c1" onclick="moveImg()">编辑图片位置</a></td>
					</tr>
	    		</table>
	    	</form>
	    </div>
	    
    	<div id="formGrowthButtons">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick ="saveFormGrowth()">保存</a> 
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick ="javascript:$('#formGrowthContainer').dialog('close')">取消</a>
	    </div>
	    
	    <div id="positionDialog" class="easyui-dialog" style="position:relative; width:260px;height:440px;padding:10px 10px; background: url(../images/positioning.png) no-repeat center;" closed="true" buttons="#positionDialogButtons">
		    <div id="tools-imagePositioner-display" class="tools-imagePositioner-display">
		        <img class="easyui-draggable easyui-resizable" style="position:resolute; width:70px; height:70px; border:1px solid red;" data - options="onDrag:imagePositioneronDrag" src="">
		    </div>
		</div>
		<div id="positionDialogButtons">
		    <a href="javascript:void(0)" class="easyui-linkbutton" icon Cls="icon-ok" onclick="gainPostion()">确定 </a>
		    <a href="javascript:void(0)" class="easyui-linkbutton" icon Cls="icon-cancel" onclick="javascript:$('#positionDialog').dialog('close')">取消</a>
		</div>
     </div>
    
	<script>
	

	window.onload = function() {
		var frameset = parent.document.getElementsByTagName('frameset')[0];
	     frameset.rows = '60,*,50';
	    parent.document.querySelector('#bottom').src = '<%=basePath%>/tools.jsp';
	    $("body").css("height",$(window).height());
	}
	
		var params ={
				id:'',
				mode:'insert'
		}; 
	
		var seedManageGrid;
		$(document).ready(function() {
			seedManageGrid = $('#seedManage').edatagrid({
				title: '种子清单',
				width:'100%',
				height:560,
				method:'post',
				url:'<%=basePath%>/seed/data',
				saveUrl: '<%=basePath%>/seed/save',
				updateUrl: '<%=basePath%>/seed/save',
				destroyUrl: '<%=basePath%>/seed/delete',
				editable: true,
				border: false,
                rownumbers: true,
                remoteSort: true,
                nowrap: false,
                singleSelect: true,
                fitColumns: true,
                striped: true,
                idField: "id",
                //分页
                pagination:true,
                pagePosition:'bottom',
                pageSize:3,
                pageList:[3,6,9],
                columns: [
                	[{field: 'id',		title: 'ID', width: 10,	sortable: true,	align: 'center', halign: 'center'}, 
                	 {field: 'seedId',	title: '种子ID', width: 20,	sortable: true,	align: 'center', halign: 'center',
                		editor: {
                            type: 'numberbox',
                            options: {
                                required: true
                            }
                        }	
                	 }, 
                	 {field: 'seedName',title: '种子名称', width: 30,	sortable: true,	align: 'center', halign: 'center',
                		 editor: {
                             type: 'textbox',
                             options: {
                                 required: true
                             }
                         }
                	 }, 
                	 {field: 'season', title: 'x季作物', width: 30,	sortable: true,	align: 'center', halign: 'center',
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
                	 {field: 'seedLevel', title: '种子等级', width: 30, sortable: true, align: 'center', halign: 'center',
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
                	 {field: 'seedType', title: '种子类型', width: 30, sortable: true,	align: 'center', halign: 'center' ,
                		 editor: {
                             type: 'combobox',
                             options: {
                                 required: true,
                                 valueField: 'typeId',
                                 textField: 'typeName',
                                 panelHeight: 'auto',
	                             url:'<%=basePath%>/seed/getAllSeedType'
                             },
                         },	 
                         formatter: function(value, row) {
                 	 		return $.ajax({
                     		    url: '<%=basePath%>/seed/getSeedType?typeId=' + value,
                     		    async : false,
                 		  	}).responseJSON.typeName;
                 		}
                	 }, 
                	 {field: 'experience', title: '可获经验', width: 30,	sortable: true,	align: 'center', halign: 'center',
                		 editor: {
                             type: 'numberbox',
                             options: {
                                 required: true
                             }
                         },	 
                	 }, 
                	 {field: 'matureTime',	title: '每季成熟所需时间', width: 30,	sortable: true,	align: 'center', halign: 'center',
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
                	 {field: 'harvest', title: '每季成熟可获收成', width: 30,	sortable: true,	align: 'center', halign: 'center',
                		 editor: {
                             type: 'numberbox',
                             options: {
                                 required: true
                             }
                         },	 
                	 }, 
                	 {field: 'purchasePrice', title: '种子采购价', width: 30,	sortable: true,	align: 'center', halign: 'center',
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
                	 {field: 'salePrice', title: '每个收获的果实单价', width: 30,	sortable: true,	align: 'center', halign: 'center',
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
                	 {field: 'soil', title: '土地需求', width: 30, sortable: true, align: 'center', halign: 'center',
                		 editor: {
                             type: 'combobox',
                             options: {
                            	 url:'<%=basePath%>/seed/getAllSoil' ,
                                 required: true,
                                 valueField: 'soilId',
                                 textField: 'soilName',
                                 panelHeight: 'auto'
                         
                             },
	                        },
	                        
	                        formatter: function(value, row) {
	                        	 		return $.ajax({
		                        		    url: '<%=basePath%>/seed/getSoilType?soilId=' + value,
		                        		    async : false,
	                        		  	}).responseJSON.soilName;
	                        		}
                	 }, 
                	 {field: 'points', title: '每季成熟可获积分', 	width: 30,	sortable: true,	align: 'center', halign: 'center',
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
                	 {field: 'prompt',	title: '提示信息', width: 40,	sortable: true,	align: 'center', halign: 'center',
                		 editor: {
                             type: 'textbox',
                             options: {
                                 required: true
                             }
                         },}, 
                	 {field: 'operation', title: '操作', width: 30,	sortable: true,	align: 'center', halign: 'center',
                		 				formatter: function(value, row){
                		 					var growthStage = '<a href="#" class="easyui-linkbutton c4" onclick="growthStage('+ row.seedId +')">成长阶段</a>';
                		 					return growthStage;
                		 				}
                	 }
                	]
                ],
                
                onLoadSuccess: function(){
                	$.parser.parse($('.c4').parent());
                },

                /* onBeforeEdit: function (index, row) {  
                    row.editing = true;  
                    updateActions(index);
                },
                onAfterEdit: function (index, row) {  
                    row.editing = false;  
                    updateActions(index);
                },
                onCancelEdit: function (index,row,changes) {
                    alert(changes);
                    row.editing = false;  
                    updateActions(index);
                }, */

           	 destroyMsg: {
                    norecord: {
                        title: '警告',
                        msg: '首先需要选中记录，然后在点击删除按钮!'
                    },
                    confirm: {
                        title: '确认',
                        msg: '是否删除选中记录?'
                    }
                },
                onSuccess: function(index, result) {
                    console.log(result);
                    $("#msgBox").text(result.msg);
                    
                    $.messager.show({
                        title: "消息",
                        msg: result.msg
                    });
                },
                onDestroy: function(index, result) {
                    console.log(result);
                    $("#msgBox").text(result.msg);
                }
			});
		});
	
 
		
		var gorwthStageGrid;
		function growthStage(seedId){
			$('#growthStageButton').dialog('open').dialog('setTitle','编辑成长阶段');
			growthStageGrid = $('#growthStage').edatagrid({
				title:'成长阶段定义',
				width:'100%',
				height:300, 
				method:'post',
				url:'<%=basePath%>/growth/gridData?seedId=' + seedId,
				saveUrl: '<%=basePath%>/growth/save',
				updateUrl: '<%=basePath%>/growth/save',
				destroyUrl: '<%=basePath%>/growth/delete',
				editable: true,
				border: false,
                rownumbers: true,
                remoteSort: true,
                nowrap: false,
                singleSelect: true,
                fitColumns: true,
                striped: true,
                idField: "id",
                columns: [
                	[{field: 'id', title: 'ID', width: 10,	sortable: true,	align: 'center', halign: 'center'},
                		{field: 'seedId', title: '种子ID', width: 10,	sortable: true,	align: 'center', halign: 'center'},
                		{field: 'growthStage', title: '生长阶段', width: 10,	sortable: true,	align: 'center', halign: 'center',
	                			editor:{
	                				type: 'numberbox',
	                				 options: {
	                                     required: true,
	                                     }
	                			},
                		},
                		{field: 'growthName', title: '生长阶段标题', width: 10,	sortable: true,	align: 'center', halign: 'center',
                				editor:{
                    				type: 'textbox',
                    				options: {
	                                     required: true,
	                                     }
                    			},
                    	},
                		{field: 'growthTime', title: '阶段生长时间', width: 10,	sortable: true,	align: 'center', halign: 'center',
                    			editor:{
                    				type: 'numberbox',
                    				options: {
	                                     required: true,
	                                     }
                    			},		
                		},
                		{field: 'pestProbability', title: '生虫概率', width: 10,	sortable: true,	align: 'center', halign: 'center',
	                			editor:{
	                				type: 'numberbox',
	                				options: {
	                                     required: true,
	                                     }
	                			},	
                		},
                		{field: 'width', title: '宽度', width: 10,	sortable: true,	align: 'center', halign: 'center',
	                			editor:{
	                				type: 'numberbox',
	                				options: {
	                                     required: true,
	                                     }
	                			},	
                		},
                		{field: 'height', title: '高度', width: 10,	sortable: true,	align: 'center', halign: 'center',
	                			editor:{
	                				type: 'numberbox',
	                				options: {
	                                     required: true,
	                                     }
	                			},	
                		},
                		{field: 'x', title: 'offsetX', width: 10,	sortable: true,	align: 'center', halign: 'center',
	                			editor:{
	                				type: 'numberbox',
	                				options: {
	                                     required: true,
	                                     }
	                			},
                		},
                		{field: 'y', title: 'offsetY', width: 10,	sortable: true,	align: 'center', halign: 'center',
	                			editor:{
	                				type: 'numberbox',
	                				options: {
	                                     required: true,
	                                     }
	                			},	
                		},
                		{field: 'state', title: '作物状态', width: 10,	sortable: true,	align: 'center', halign: 'center',
                			editor: {
                                type: 'combobox',
                                options: {
                                    required: true,
                                    valueField: 'statusId',
                                    textField: 'statusName',
                                    panelHeight: 'auto',
   	                             	url:'<%=basePath%>/growth/getAllCropStatus'
                                },
   	                        },
   	                        
	   	                     formatter: function(value, row) {
	                 	 		return $.ajax({
	                     		    url: '<%=basePath%>/growth/getCropStatus?statusId=' + value,
	                     		    async : false,
	                 		  	}).responseJSON.statusName;
	                 		}	
                		},
                		]
                	],
				
				destroyMsg: {
                    norecord: {
                        title: '警告',
                        msg: '首先需要选中记录，然后在点击删除按钮!'
                    },
                    confirm: {
                        title: '确认',
                        msg: '是否删除选中记录?'
                    }
                },
                onSuccess: function(index, result) {
                    console.log(result);
                    $("#msgBox").text(result.msg);
                    
                    $.messager.show({
                        title: "消息",
                        msg: result.msg
                    });
                },
                onDestroy: function(index, result) {
                    console.log(result);
                    $("#msgBox").text(result.msg);
                }
			})
				
		}

		/* function updateActions(index){
			$('#seedManage').datagrid('updateRow',{
				index: index,
				row:{}
			});
		} */
	
		function doSeedSearch() {
	        seedManageGrid.datagrid("load", {
	            seedName: $('#seedSearch').val()
	        });
	    }
		
		function addSeed() {
		    $('#formSeedContainer').dialog('open')
		        .dialog('center')
		        .dialog('setTitle', '添加数据');
		    $('#formSeedManage').form('clear');
		    $('#formSeedManage').find("input[name='id']").val(0);
		}
	
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
		
		function cancel(){
			seedManageGrid.edatagrid('cancelRow');
			seedManageGrid.datagrid('reload');
		}

		function saveForm() {
            $('#formSeedManage').form('submit', {
                url: '<%=basePath%>/seed/save',
                onSubmit: function(param) {
                    //param.id = params.id;
                    //param.mode = params.mode; 
                    return $(this).form('validate');
                },
                success: function(result) {
                    var result = eval('(' + result + ')');
                    if (result.code == 0) {
                        $('#formSeedContainer').dialog('close');
                        seedManageGrid.datagrid('reload');
                    }
                    $.messager.show({
                        title: "消息",
                        msg: result.msg
                    });
                }}
            )}
		
		function addGrowthStage() {
			var row = $('#seedManage').datagrid('getSelected');
		    $('#formGrowthContainer').dialog('open')
		        .dialog('center')
		        .dialog('setTitle', '添加数据');
		    $('#formGrowthStage').form('clear');
		    $('#formGrowthStage').find("input[name='id']").val(0);
		    $('#formGrowthStage').find("input[name='seedId']").val(row.seedId);
		}
		
		function editGrowthStage(){
			var row = $('#growthStage').datagrid('getSelected');
            if (row) {
                params.id = row.id;
                params.mode = 'edit';
                $('#formGrowthContainer').dialog('open').dialog('setTitle', '编辑数据');
                $('#formGrowthStage').form('load', row);
            } else {
                alert("请先选择一行数据，然后再尝试点击操作按钮！");
            }
		}

		function saveFormGrowth() {
            $('#formGrowthStage').form('submit', {
                url: '<%=basePath%>/growth/save', 
                onSubmit: function(param) {
                    //param.id = params.id;
                    //param.mode = params.mode; 
                  	return $(this).form('validate');
                },
                success: function(result) {
                    var result = eval('(' + result + ')');
                    if (result.code == 0) {
                        $('#formGrowthContainer').dialog('close');
                        $('#growthStage').datagrid('reload');
                    }
                    $.messager.show({
                        title: "消息",
                        msg: result.msg
                    });
                }}
            )}

		function moveImg(){
			$('#positionDialog').dialog("open").dialog('setTitle', '编辑图片位置');
			
			var imgUrl;
			if ($('#growthStage2').val() == 0){
				imgUrl = "../images/crops/basic/0.png";
			}else if($('#growthStage2').val() == 6){
				imgUrl="../images/crops/basic/9.png";
			}else{
				imgUrl="../images/crops/" + $("#seedId").val() + "/"+ $('#growthStage2').val() +".png";
			}
			$("#positionDialog img").css({"width":$("#pWidth").val()+"px","height":$("#pHeight").val()+"px","top":$("#pY").val()+"px","left":$("#pX").val()+"px",})
			$("#positionDialog img").attr("src", imgUrl);
		}
		
		function gainPostion(){
	    	var img=$("#positionDialog img");
	    	
	    	var width=img.css("width");
	    	width=width.replace("px","");
	    	var widthNumber=parseInt(width);
	    	
	    	var height=img.css("height");
	    	height=height.replace("px","");
	    	var heightNumber=parseInt(height);
	    	
	    	var top=img.css("top");
	    	top=top.replace("px","");
	    	var topNumber=parseInt(top);
	    	
	    	var left=img.css("left");
	    	left=left.replace("px","");
	    	var leftNumber=parseInt(left);
	    	$("#pWidth").numberbox('setValue',widthNumber);
	    	$("#pHeight").numberbox('setValue',heightNumber);
	    	$("#pX").numberbox('setValue',leftNumber);
	    	$("#pY").numberbox('setValue',topNumber);
	    	
	    	$("#positionDialog").dialog("close");
	    }

	</script>
</body>
</html>
