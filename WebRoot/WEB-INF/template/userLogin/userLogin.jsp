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
	<div style="width:400px; height:230px; position:absolute;  left:50%;  top:50%; margin:-115px 0 0 -200px;">
		<div class="easyui-panel" title="用户选择" style="width:400px;" data-options="iconCls:'my-custom-icon'">
			<div style="padding:10px 20px 20px 20px; text-align:center;">
			    <form id="selectUser" method="post">
			    	<div style="width:320px; border-bottom:2px solid #FFFFFF; padding:10px 20px 20px 20px;">
					    
					    <input label="当前用户："  id="selectUserCombobox" class="easyui-combobox" name="" data-options="
					    					width:300,
											url: '<%=basePath%>/user/list',
											method: 'post',
											valueField: 'id',
											textField: 'nickname',
											panelWidth: 330,
											panelHeight: 'auto',
											formatter: formatItem,
											
										">
										
						</div>
						
						<p>请在下拉框中选择用户昵称，并点击“确认”按钮设定当前用户信息。</p>		
								
			    </form>
			    <div style="text-align:right;padding:5px">
			    	<a href="<%=basePath%>/menu.jsp" class="easyui-linkbutton" target="menu" onclick="submitForm()">确认</a>
			    </div>
		 	</div>
		 </div>
	</div>
</body>

<script>

		window.onload = function() {
			var frameset = parent.document.getElementsByTagName('frameset')[0];
		     frameset.rows = '60,*,50';
		    parent.document.querySelector('#bottom').src = '<%=basePath%>/tools.jsp';
		    $("body").css("height",$(window).height());
		}
	
	function submitForm(){
    	var id=$("#selectUserCombobox").combobox("getValue");
    	var result=$.ajax({
			url : '<%=basePath%>user/login?id=' + id,
			type : "post",
			async : false,
			data : {id:id}
		});
    	console.log(result);
		$.messager.show({
            title: "结果",
            msg: result.responseJSON.msg
        });
    }
	
	function formatItem(row){
			var s ="<img style='width:20px; height: 20px;' src=../avatar/"+ row.avatar+">" 
					+ "   " + '<span style="font-weight:bold">' + row.nickname + '</span>' + ' | 经验：' + row.experience + ' | 金币：' 
					+ row.money +' | 积分：' + row.points ;
			return s;
		}
</script>
</html>