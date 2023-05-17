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
	<div>
		<div class="easyui-panel" title="用户选择" style="width:400px;">
			<div style="padding:10px 20px 20px 20px; text-align:center;">
			    <form id="selectUser" method="post">
			    	<div style="width:320px; border-bottom:2px solid #FFFFFF; padding:10px 20px 20px 20px;">
					    
					    <input label="当前用户：" class="easyui-combobox" name="" data-options="
					    					width:300,
											url: '',
											method: 'post',
											valueField: 'value',
											textField: 'text',
											panelWidth: 350,
											panelHeight: 'auto',
											formatter: formatItem,
											data: [
						                 {value: '1', text: '种子阶段'},
						                 {value: '2', text: '生长阶段'},
						                 {value: '3', text: '成熟阶段'},
						                 {value: '4', text: '枯草期'}
						               ]
										">
										
						</div>
						
						<p>请在下拉框中选择用户昵称，并点击“确认”按钮设定当前用户信息。</p>		
								
			    </form>
			    <div style="text-align:right;padding:5px">
			    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">确认</a>
			    </div>
		 	</div>
		 </div>
	</div>
</body>

<script>



	$("body").css("height",$(window).height());
	var params ={
			id:'',
			mode:'insert'
	}; 
	
	function submitForm(){
		$('#selectUser').form('submit');
	}
	
	function formatItem(row){
			var s = '<span style="font-weight:bold">' + row.text + '</span><br/>' +
					'<span style="color:#888">' + row.desc + '</span>';
			return s;
		}
</script>
</html>