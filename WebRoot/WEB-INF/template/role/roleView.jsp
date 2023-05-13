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
<div id="controlBox">
		<!-- iconCls：单纯图标 -->
		<div style="margin-bottom:20px">
            <input class="easyui-textbox" label="用户名:" labelPosition="left" style="width:100%;">
        </div>
			<div>
            <a href="#" class="easyui-linkbutton" iconCls="icon-ok" style="width:100%;height:32px">Register</a>
        </div>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" >查询</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addStu()">添加</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" >取消</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" >删除</a>
        </div>
    	<table id="grid"></table>
    	<!-- easyui-dialog : 产生对话框的div -->
        <div id="formRoleContainer" class="easyui-dialog" style="width:280px;height:300px;padding:10px 10px" closed="true" buttons="#formStudentButtons">
           <!--  novalidate 属性是一个布尔属性。
                 novalidate 属性规定当提交表单时不对表单数据（输入）进行验证。 -->
            <form id="formStudent" method="POST" novalidate>
                <table class='tbledit'>
                    <tr>
                        <td>ID</td>
                        <td><input name="id" required="true" class="w200" value="0" readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td>姓名：</td>
                        <td><input name="name" required="true" class="easyui-validatebox w50"></td>
                    </tr>
                    <tr>
                        <td>性别：</td>
                        <td><input name="gender" required="true" class="easyui-combobox" panelHeight="auto"
                                data-options="editable:false,  valueField:'value',  textField:'label', data: [{label: '男', value: 1}, {label: '女', value: 0}]">
                        </td>
                    </tr>
                    <tr>
                        <td>生日：</td>
                        <td><input name="birth" required="true" class="easyui-datebox"></td>
                    </tr>
                    <tr>
                        <td>身高：</td>
                        <td><input name="height" required="true" class="easyui-numberbox " data-options="precision: 2">米</td>
                    </tr>
                </table>
            </form>
        </div>
        <div id="formStudentButtons"> <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok"
                onclick="saveForm()">保存</a> <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
                onclick="javascript:$('#formStudentContainer').dialog('close')">取消</a></div>
</body>
</html>