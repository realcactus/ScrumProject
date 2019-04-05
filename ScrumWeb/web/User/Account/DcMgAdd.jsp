<%-- 
    Document   : DcMgAdd
    Created on : 2015-11-24, 11:06:21
    Author     : OovEver
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>
	高校资源共享论坛
</title><link href="../../Style/studentStyle.css" rel="stylesheet" type="text/css" /><link href="../../Script/jBox/Skins/Blue/jbox.css" rel="stylesheet" type="text/css" /><link href="../../Style/ks.css" rel="stylesheet" type="text/css" />
    <script src="../../Script/jBox/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="../../Script/jBox/jquery.jBox-2.3.min.js" type="text/javascript"></script>
    <script src="../../Script/jBox/i18n/jquery.jBox-zh-CN.js" type="text/javascript"></script>
    <script src="../../Script/Common.js" type="text/javascript"></script>
    <script src="../../Script/Data.js" type="text/javascript"></script>
    <script type="text/javascript">
        $().ready(function () {
            setStudMsgHeadTabCheck();
            showUnreadSysMsgCount();
        });

        //我的信息头部选项卡
        function setStudMsgHeadTabCheck() {
            var currentUrl = window.location.href;
            currentUrl = currentUrl.toLowerCase();
            var asmhm = "";
            $("#ulStudMsgHeadTab li").each(function () {
                asmhm = $(this).find('a').attr("href").toLowerCase();
                if (currentUrl.indexOf(asmhm) > 0) {
                    $(this).find('a').attr("class", "tab1");
                    return;
                }
            });
        }

        //显示未读系统信息
        function showUnreadSysMsgCount() {
            var unreadSysMsgCount = "0";
            if (Number(unreadSysMsgCount) > 0) {
                $("#unreadSysMsgCount").html("(" + unreadSysMsgCount + ")");
            }
        }

        //退出
        function loginOut() {
            if (confirm("确定退出吗？")) {
                StudentLogin.loginOut(function (data) {
                    if (data == "true") {
                        window.location = "/Login.aspx";
                    }
                    else {
                        jBox.alert("退出失败！", "提示", new { buttons: { "确定": true} });
                    }
                });
            }
        }
        //更改报考类别
        function changeCateory(thisObj, id) {
            var oldCateoryId = $("#cateoryId").val();
            var cateoryId = "";
            if (id != null) {
                cateoryId = id;
            }
            else {
                cateoryId = thisObj.val();
            }
            var studentId = $("#studentId").val();
            if (cateoryId.length <= 0) {
                jBox.tip("报考类别不能为空！");
                if (id == null) {
                    thisObj.val(oldCateoryId);
                }
            }
            else {
                studentInfo.changeStudentCateory(cateoryId, function (data) {
                    var result = $.parseJSON(data);
                    if ((String(result.ok) == "true")) {
                        window.location.href = "/Index.aspx";
                    }
                    else {
                        jBox.tip(result.message);
                    }
                });
            }
        }
    </script>
    
<script type="text/javascript" language="javascript">
    function changePassword() {
        var oldPwd = $("#txtOldPwd").val();
        var newPwd = $("#txtNewPwd").val();
        var confirmNewPwd = $("#txtConfirmNewPwd").val();
        var studentName=$("#studentName").val();
        var studentID=$("#studentID").val();
        var grade=$("#grade").val();
       var phone=$("#phone").val();
        if (studentID == "") {
            $.jBox.tip("账号不能为空！", 'error');
            return false;
        }
        if (studentName == "") {
            $.jBox.tip("姓名不能为空！", 'error');
            return false;
        }
        if (newPwd == "" || confirmNewPwd=="") {
            $.jBox.tip("密码或确认密码不能为空！", 'error');
            return false;
        }       
        if (newPwd.length < 6 || newPwd.length > 16) {
            $.jBox.tip("密码为6~16个字符，区分大小写！", 'error');
            return false;
        }
        if (newPwd != confirmNewPwd) {
            $.jBox.tip("密码两次输入不一致！", 'error');
            return false;
        }
         if (phone == "") {
            $.jBox.tip("电话不能为空！", 'error');
            return false;
        }
        
         

        studentAccount.changePassword(studentName,oldPwd, newPwd, function (data) {
            var obj = $.parseJSON(data);
            if (obj.ok) {
                jBox.alert(obj.message, "提示");
                setTimeout(function () {
                    window.location.reload();
                }, 1500);
            }
            else {
                jBox.tip(obj.message, 'error');
            }
        });
    }
      function t(obj)
{
if(obj.value=="2")
{
document.getElementById("grade").style.display = ""
 if (grade == "") {
            $.jBox.tip("班级不能为空！", 'error');
            return false;
        }
}
else
document.getElementById("grade").style.display = "none"
}
</script>
<style type="text/css">
    .txtinput1{width:180px;}
</style>
</head>
<body>

    <div class="banner">
        <div class="bgh">
            <div class="page">
              
                   <div class="topxx">
                             <%
                     String username = (String) session.getAttribute("username");                                      
                                    if(username==null){        
%>     
<a href="/Discuz/User/Account/Login.jsp">登录</a>
<a href="/Discuz/User/Account/Register.jsp">注册</a>        
<%
                                    }
                                    else
                                    {                                        
                                        out.print("欢迎您 ");
                                    
%>
<a href="/Discuz/MyInfo/userInfo.jsp"><%=username%></a>
<a href="/Discuz/User/Account/ChangePasswd.jsp">修改密码</a>
<a href="/Discuz/logOut">注销</a>
<%
                                    }
%>
                </div>
            
            </div>
        </div>
    </div>
    <div class="page">
        <div class="box mtop">
            <div class="leftbox">
                 <div class="l_nav2">
                    <div class="ta1">
                        <strong>个人中心</strong>
                        <div class="leftbgbt">
                        </div>
                    </div>
                     <div class="cdlist">
                        <div>
                              <a href="/Discuz/MyInfo/DcMgInfo.jsp">我的信息</a></div>                           
                    </div>
                    <div class="ta1">
                        <strong>论坛中心</strong>
                        <div class="leftbgbt2">
                        </div>
                    </div>
                    <div class="cdlist">
                        <div>
                            <a href="/Discuz/MyInfo/DcManagerEdit.jsp">人员管理</a></div>
                        <div>
                            <a href="/Discuz/User/Account/DcMgAdd.jsp">添加人员</a></div>
                        <div>
                            <a href="/Discuz/MyInfo/cardEdit.jsp">充值卡管理</a></div>
                        <div>
                            <a href="/Discuz/User/Account/creditAdd.jsp">添加充值卡</a></div>                         
                         <div>
                            <a href="/Discuz/MyInfo/schoolEdit.jsp">学校管理</a></div>
                         <div>
                            <a href="/Discuz/User/Account/schoolAdd.jsp">添加学校</a></div>
                         <div>
                            <a href="/Discuz/MyInfo/academyEdit.jsp">学院管理</a></div>
                    <div>
                            <a href="/Discuz/User/StudentInfor/showSchoolFA.jsp">添加学院</a></div>
                     <div>
                            <a href="/Discuz/MyInfo/courseEdit.jsp">课程管理</a></div>
                   <div>
                            <a href="/Discuz/User/StudentInfor/showSchoolFAC.jsp">添加课程</a></div>
                             <div>
                            <a href="/Discuz/User/StudentInfor/showSchoolFD.jsp?choose=comment">问答管理</a></div>
                            <div>
                            <a href="/Discuz/User/StudentInfor/showSchoolFD.jsp?choose=resource">资源管理</a></div>
                            <div>
                            <a href="/Discuz/User/StudentInfor/assignSchool.jsp?method=manage">大版主管理</a></div>
                              <div>
                            <a href="/Discuz/User/StudentInfor/assignSchool.jsp?method=add">添加大版主</a></div>
                              <div>
                            <a href="/Discuz/User/StudentInfor/assignAccademy.jsp?method=manage">小版主管理</a></div>
                              <div>
                            <a href="/Discuz/User/StudentInfor/assignAccademy.jsp?method=add">添加小版主</a></div>
                    </div>    
                    
                   
                   
                   
                  

                </div>
            </div>
            <div class="rightbox">
                
<h2 class="mbx">论坛中心 &gt; 添加人员</h2>
<div class="cztable">
    
<table border="0" cellspacing="0" cellpadding="0" width="500px" style="margin:30px auto 0px auto;">
    <form action="../../DcMgAddServlet" method="post">
     <tr align="center">
        <th style="width:20%; text-align:left;">账号：</th>
        <td style="width:70%; text-align:left;"><input id="studentID" name="studentID" value="" type="text" class="input_2 txtinput1" /></td>
    </tr>
    <tr align="center">
        <th style="width:20%; text-align:left;">昵称：</th>
        <td style="width:70%; text-align:left;"><input id="studentName" name="studentName"value="" type="text" class="input_2 txtinput1" /></td>
    </tr>
    <tr align="center">
        <th style="width:20%; text-align:left;">密码：</th>
        <td style="width:70%; text-align:left;"><input id="txtNewPwd" name="txtNewPwd" value="" type="password" class="input_2 txtinput1" />&nbsp;&nbsp;6~16个字符，区分大小写</td>
    </tr>
    <tr align="center" >
        <th style="width:20%; text-align:left;">确认密码：</th>
        <td style="width:70%; text-align:left;"><input id="txtConfirmNewPwd" value="" type="password" class="input_2 txtinput1" /></td>
    </tr>
         <tr align="center">
        <th style="width:20%; text-align:left;">级别：</th>
        <td style="width:20%; text-align:left;">
           <select name="select" size="1" onchange="t(this)">
				    <option value="3">大版主</option>
				    <option value="4">小版主</option>		
                                      <option value="5">普通用户</option>		
			      </select>  
            
            
        </td>
  
    </tr>
   
    <tr>
    <td colspan="2" style="text-align:center;"><input type="submit" id="btnSubmit" value="添加人员" onclick="return changePassword()" class="input2" /></td>
    </tr>
     </form>
</table>
   
   
</div>

            </div>
        </div>
        <%--<div class="footer">--%>
            <%--<p>--%>
                  <%--&copy;copyright 2015内蒙古大学计算机学院 版权所有</p>--%>
        <%--</div>--%>
    </div>
</body>
    
       <script> 
//取出传回来的参数error并与yes比较
  var errori ='<%=request.getParameter("error")%>';
  if(errori=='yes'){
   alert("用户已存在错误");
  }

</script>
</html>
