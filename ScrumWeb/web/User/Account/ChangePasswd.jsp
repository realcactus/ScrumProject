<%-- 
    Document   : ChangePasswd
    Created on : 2015-10-5, 16:18:02
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

        if (oldPwd == "" || newPwd == "" || confirmNewPwd=="") {
            $.jBox.tip("旧密码或新密码或确认新密码不能为空！", 'error');
            return false;
        }
        if (oldPwd.length < 6 || oldPwd.length > 16) {
            $.jBox.tip("旧密码为6~16个字符，区分大小写！", 'error');
            return false;
        }
        if (newPwd.length < 6 || newPwd.length > 16) {
            $.jBox.tip("新密码为6~16个字符，区分大小写！", 'error');
            return false;
        }
        if (newPwd != confirmNewPwd) {
            $.jBox.tip("新密码两次输入不一致！", 'error');
            return false;
        }

        studentAccount.changePassword(oldPwd, newPwd, function (data) {
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
</script>
<style type="text/css">
    .txtinput1{width:180px;}
</style>
</head>
<body>

    <div class="banner">
        <div class="bgh">
            <div class="page">
                <div id="logo">
                   
                </div>
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
<a href="../../logOut">注销</a>
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
                   
             

                </div>
            </div>
            <div class="rightbox">
                
<h2 class="mbx">我的信息 &gt; 密码修改</h2>
<div class="cztable">
<table border="0" cellspacing="0" cellpadding="0" width="500px" style="margin:30px auto 0px auto;">
    <form action="../../changePasswdServlet?username=<%=username%>" method="post">
    <tr align="center">
        <th style="width:20%; text-align:left;">旧密码：</th>
        <td style="width:70%; text-align:left;"><input id="txtOldPwd" name="txtOldPwd" value="" type="password" class="input_2 txtinput1" /></td>
    </tr>
    <tr align="center">
        <th style="width:20%; text-align:left;">新密码：</th>
        <td style="width:70%; text-align:left;"><input id="txtNewPwd"  name="txtNewPwd" value="" type="password" class="input_2 txtinput1" />&nbsp;&nbsp;6~16个字符，区分大小写</td>
    </tr>
    <tr align="center">
        <th style="width:20%; text-align:left;">确认新密码：</th>
        <td style="width:70%; text-align:left;"><input id="txtConfirmNewPwd"   name="txtConfirmNewPwd" value="" type="password" class="input_2 txtinput1" /></td>
    </tr>
    <tr>
    <td colspan="2" style="text-align:center;"><input type="submit" id="btnSubmit" value="确认修改" onclick="return changePassword()" class="input2" /></td>
    </tr>
    </form>
</table>
</div>

            </div>
        </div>
        <%--<div class="footer">--%>
            <%--<p>--%>
                <%--&copy;copyright 2012 广博教育 csgb.net 版权所有 站长统计</p>--%>
        <%--</div>--%>
    </div>
</body>
        <script> 
//取出传回来的参数error并与yes比较
  var errori ='<%=request.getParameter("error")%>';
  if(errori=='yes'){
   alert("原密码错误");
  }
  
</script>
</html>
