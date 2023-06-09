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
    <title>用户登录</title>
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

<!-- <div id="p" class="easyui-panel"  style="width:100%;height:800px;padding:20px;"> -->
<div id="controlBox">
		<!-- iconCls：单纯图标 -->
			<span style="color:white">用户名:</span>
            <input id="seatex" class="easyui-textbox" style="width:20%;"><!-- iconCls:'icon-search' -->
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search '" style="background:" onclick="searchRole()">查询</a>
            <a href="#" class="easyui-linkbutton c2" data-options="iconCls:'icon-add '"    style="background:" onclick="addRole()">添加</a>
            <a href="#" class="easyui-linkbutton c4" data-options="iconCls:'icon-remove'" style="background:" onclick="cancelRole()">取消</a>
            <a href="#" class="easyui-linkbutton c5" data-options="iconCls:'icon-cancel'" style="background:" onclick="deleteRole()">删除</a>
        </div>
    	<table id="grid"></table>
    	</div>
        <div id="formFileContainer" class="easyui-dialog" data-options="noheader:true,closed:true" 
             style="width:400px;height:100px;padding:3px 10px" buttons="#formFileButtons">
                     
             <form id="formUploadFile" method="post" action="" enctype="multipart/form-data">         
    	        <span style="color:white">头像文件:</span> 
    	     	<input id="file" class="easyui-filebox" name = "file"  data-options="prompt:'选择文件'  ,buttonText:'选择文件'" style="width:80%">    
         	</form>
        </div>
        <div id="formFileButtons"> 
        	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok"     onclick="submitUploadForm()">开始上传</a>
         	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#formFileContainer').dialog('close')">关闭窗口</a>
       </div>
                
        <script>
        window.onload = function() {
			var frameset = parent.document.getElementsByTagName('frameset')[0];
		     frameset.rows = '60,*,50';
		    parent.document.querySelector('#bottom').src = '<%=basePath%>/tools.jsp';
		    $("body").css("height",$(window).height());
		}
	
        
        var rowData = {};
        var isInsertNewRow = false;
        var grid;
        var params = {
                id: '',
                row: '',
                index: '',
            };
        $(document).ready(function () {
            grid = $('#grid').edatagrid({
                title: '用户清单',
                width: '100%',
                height: 600,
                method: 'post',
                url: '<%=basePath%>user/getUser',
                saveUrl: '<%=basePath%>user/save',
                updateUrl: '<%=basePath%>user/save',
                destroyUrl: '<%=basePath%>user/delete',
                border: false,
                rownumbers: true,
                remoteSort: true,
                nowrap: true,
                singleSelect: true,
                fitColumns: true,
                pagination: true,
                pagePosition:'bottom',
                pageSize:3,
                pageList:[3,6,9],
                striped: true,
                idField: "id",
                autoSave: false,
                autoRowHeight:true,
                rowStyler: function(index,row){
                    return 'height:80px';
                    },
                columns:
                    [[{
                        field: 'id',
                        title: 'ID',
                        align: 'center',
                        halign: 'center',
                        width: 50,
                        sortable: true,
                    }, {
                        field: 'avatar',
                        title: '头像',
                        width: 100,
                        align: 'center',
                        halign: 'center',
                        sortable: true,
                        editor:{
                        	type:'validatebox',
                        	options:{
                        		
                        		}
                        },
                        formatter: function(value,row) {
                            if (value == null || value == "")
                                value = "default.png";
                            return '<div style="height:80px;">' + 
                            		'<img src="<%=basePath%>/avatar/' + value + 
                            		'"style="height:60px;margin-top:10px;width:100%"></div>';
                        },
                    }, {
                        field: 'username',
                        title: '用户名',
                        width: 100,
                        align: 'center',
                        halign: 'center',
                        sortable: true,
/*                         formatter: function (value,
                            row) {
                            if (value == "1") {
                                return '男';
                            } else {
                                return '女';
                            }
                        } */
                        editor:{
                        	type:'validatebox',
                        	options:{
                        		required:true
                        		}
                        }
                    }, {
                        field: 'nickname',
                        title: '昵称',
                        width: 200,
                        sortable: true,
                        align: 'center',
                        halign: 'center',
                        editor:{
                        	type:'validatebox',
                        	options:{
                        		required:true
                        		}
                        }
                    }, {
                        field: 'experience',
                        title: '经验值',
                        width: 200,
                        align: 'center',
                        halign: 'center',
                        sortable: true,
                        formatter: function (value) {
                        	return '<div style="display:inline-block; text-align:center;"><img src="../images/userImages/jy.png" style="height:15px">' + value + '</div>';       
                        },
                        editor:{
                        	type:'validatebox',
                        	options:{
                        		required:true
                        		}
                        }
                    }, {
                    	field: 'points',
                    	title: '积分',
                    	width: 200,
                    	sortable: true,
                    	align: 'center',
                        halign: 'center',
                    	width:200,
                    	formatter: function (value) {
                    		return '<div style="display:inline-block; text-align:center;"><img src="../images/userImages/jf.png" style="height:15px">' + value + '</div>';  
                    	},
                    	editor:{
                        	type:'validatebox',
                        	options:{
                        		required:true
                        		}
                        }
                    }, {
                    	field: 'money',
                		title: '金币',
                		sortable: true,
                    	align: 'center',
                        halign: 'center',
                		width: 200,
                		formatter: function (value) {
                            return '<div style="display:inline-block; text-align:center;"><img src="../images/userImages/jb.png" style="height:15px">' + value + '</div>';
                        },
                		editor:{
                        	type:'validatebox',
                        	options:{
                        		required:true
                        		}
                        }
             		}, {
                        field: 'operate',
                        title: '操作',
                        width: '35%',
                        align: 'center',
                        halign: 'center',
                        formatter: function (value, row) {
                        	 return `<a href="#" class="easyui-linkbutton c3" onclick="upload()" style ="">上传头像</a>` +  '&nbsp&nbsp' +
                        	 		`<a href="javascript:void(0)" class="easyui-linkbutton c4" onclick="savedata()">保存数据</a>`;
                        }
                    }]
                ],
                onLoadSuccess: function(){
                    // $.parser.parse(); 全部解析 
                    $.parser.parse($('.c3').parent()); //解析指定节点，传入指定节点的父节点
                }, 
                onSuccess: function(){
                	$.parser.parse($('.c3').parent());
                },
                onDestroy: function(index, row){
                    grid.edatagrid('reload')
                },
                onClickRow: function(index, field, value) {
                     params.index = index;
                     params.row = field;
                },
                onAfterEdit: function(){
                	$.parser.parse($('.c3').parent());
                },
                onCancelEdit: function(){
                	$.parser.parse($('.c3').parent());
                },
                onAdd:function(){
                	$.parser.parse($('.c3').parent());
                },
                onEdit:function(){
                	$.parser.parse($('.c3').parent());
                },
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
            });
/*             grid.edatagrid("getPager").pagination({
                pageSize: 5,
                pageList: [5, 10, 15, 20],
            	beforePageText: '第',
            	afterPageText: '页    共 {pages} 页',
            	displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
            }); */

        });
     
        function searchRole() {
        	$("#grid").datagrid("load", {
                userName: $('#seatex').val()
            });
        }
        
        function addRole(){
        	var length = $('#grid').edatagrid('getRows').length + 1;
        	$("#grid").edatagrid("addRow");
        }
        
        function cancelRole(){
        	$("#grid").edatagrid("cancelRow");
        }
        
        function deleteRole(){
        	$("#grid").edatagrid("destroyRow");
        }
        
        function upload(){
        	isInsertNewRow = false;
        	var selectRow = $('#grid').edatagrid('getSelected');
        	if (selectRow != null && selectRow.isNewRecord) {
        		isInsertNewRow = true;
        		var allRow = $('#grid').edatagrid('getRows');
        		var newRowIndex = allRow.length - 1;
				var editors = $('#grid').edatagrid('getEditors', newRowIndex);
				for (var i = 0; i < editors.length; i++) {
				  	var field = editors[i].field;
				  	var value = editors[i].target.val();
				  	rowData[field] = value;
				}
        	}
        	$("#formFileContainer").dialog('open');
        }
        
        function savedata()
        {
        	var rows = $('#grid').edatagrid('getRows'); // 获取所有行数据
        	for (var i = 0; i < rows.length; i++) {
        	    $('#grid').edatagrid('endEdit', i); // 结束编辑状态，确保新增的行也会被保存
        	}
        	if (isInsertNewRow) {
        		var rowIndex = $('#grid').edatagrid('getRowIndex', rows[rows.length - 1]); // 获取最后一行（新增行）的索引
        	  	$('#grid').edatagrid('saveRow', rowIndex); 
        	  	$.ajax({
        	  	    url: '<%=basePath%>user/save',
        	  	    type: 'POST',
        	  	    data: rowData,
        	  	    success: function(response) {
        	  	      // 处理保存成功的逻辑
        	  	    },
        	  	    error: function() {
        	  	      // 处理保存失败的逻辑
        	  	    }
        	  	  });
        	} else {
        		$('#grid').edatagrid('saveRow');
        	}
        }
        
        function submitUploadForm() {
             var fileName = "";
             fileName = $('#file').textbox('getText');
            
            $('#formUploadFile').form('submit', {
            url: '<%=basePath%>file/avatarUpload',
			type: 'post',  
			onSubmit: function (param) {
	            return $(this).form('validate');
	        },
            success: function(data) {
            	var result = eval('(' + data + ')'); //变成js对象
                var row = $('#grid').edatagrid('getSelected');
              	if(result.code==0){           		
              		if (isInsertNewRow) {
              			row = rowData;
              			for (var i = 0; i < row.length; i++) {
              			    $('#grid').datagrid('endEdit', i); // 结束编辑以确保数据同步
              			    var index = $('#grid').datagrid('getRowIndex', row[i]);
              			    $('#grid').datagrid('beginEdit', index); // 开始编辑以标记为已修改
              			 }
              		}
              		row.avatar = fileName;
              		$("#grid").edatagrid("updateRow",{//更新字段
  						index:params.index, //行索引
  						row: row
	  				}); 		
		             $.messager.show({
		                  title: "消息",
		                  msg: "上传成功"
		              });
		             $.ajax({
	            			url: "<%=basePath%>user/updateAvatar",
	            			type: "post",
	            			async: false,
	            			data: {id:params.row.id,avatar:fileName}
	            		});
              		$("#grid").datagrid("beginEdit",params.index);
              		$.parser.parse($('.c3').parent());
              		$('#formFileContainer').dialog('close');
              }
              	else{
              		$.messager.show({
                          title: "消息",
                          msg: "上传失败"
                      });
          }
          }
      });
          }
        </script>
</body>
</html>