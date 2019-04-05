<%-- 
    Document   : groupEditDetail
    Created on : 2015-10-7, 17:38:15
    Author     : OovEver
--%>

<%@page import="java.util.List"%>
<%@page import="com.StudentMS.bean.User"%>
<%@page import="com.StudentMS.bean.User"%>
<%@page import="com.StudentMS.DAO.UserManagerDao"%>
<%@page import="com.StudentMS.DAO.UserManagerDao"%>
<%@page import="com.StudentMS.DAO.UserManagerDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>
	学生信息管理平台
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
      
        var studentID=$("#groupID").val();
       
        if (studentID == "") {
            $.jBox.tip("组号不能为空！", 'error');
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
                <div id="logo">
                    <a href="../../Index.aspx.html">
                        <img src="../../Images/Student/logo.gif" alt="" width="165" height="48" />
                    </a>
                </div>
                <div class="topxx">
                    <select onchange="changeCateory($(this))" style="font-size: 11px; background: #4991cf;
                        color: #fff;">
                        
                        <option 
                            value="4">
                            远程</option>
                        
                        <option selected='selected'
                            value="1">
                            自考</option>
                        
                    </select>
                    910513201419学员：邹智，欢迎您！ <a href="../../MyInfo/Index.aspx.html">我的信息</a> <a href="../StudentInfor/systemMsge.aspx.html">
                        通知</a> <a href="ChangePasswd.aspx.html">密码修改</a> <a onclick="loginOut()"
                            href="javascript:">安全退出</a>
                </div>
                <div class="blog_nav">
                    <ul>
                        <li><a href="../../Index.aspx.html">我的信息</a></li>
                        <li><a href="../../EducationCenter/Score.aspx.html">教务中心</a></li>
                        <li><a href="../../MyAccount/wdcw.aspx.html">我的学费</a></li>
                        <li><a href="../../OnlineTeaching/StudentMaterial.aspx.html">资料中心</a></li>
                    </ul>
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
                            <a href="../../MyInfo/Index.aspx.html">我的信息</a></div>
                        <div>
                            <a href="../../MyInfo/ClassInfo.aspx.html">班级信息 </a>
                        </div>
                        <div>
                            <a href="../StudentInfor/Letter.aspx.html">短信息</a></div>
                        <div>
                            <a href="../StudentInfor/systemMsge.aspx.html">学院通知</a></div>
                        <div>
                            <a href="../../MyInfo/Objection.aspx.html">我的异议</a></div>
                    </div>
                    <div class="ta1">
                        <strong>教务中心</strong>
                        <div class="leftbgbt2">
                        </div>
                    </div>
                    <div class="cdlist">
                        <div>
                            <a href="../../EducationCenter/Application.aspx.html">我的报考</a></div>
                        <div>
                            <a href="../../EducationCenter/Score.aspx.html">我的成绩</a></div>
                        <div>
                            <a href="../../EducationCenter/Book.aspx.html">我的书籍</a></div>
                    </div>
                    <div class="ta1">
                        <strong>学习中心</strong><div class="leftbgbt2">
                        </div>
                    </div>
                    <div class="cdlist">
                        <div>
                            <a href="../../OnlineTeaching/StudentMaterial.aspx.html">资料下载</a></div>
                        <div>
                            <a href="../../OnlineTeaching/StudentStudyRecordList.aspx.html">学习历程</a></div>
                    </div>
                   
                    <div class="ta1">
                        <strong>财务中心</strong><div class="leftbgbt2">
                        </div>
                    </div>
                    <div class="cdlist">
                        <div>
                            <a href="../../MyAccount/wdcw.aspx.html">我的财务</a></div>
                    </div>
<div class="ta1">
                        <a href="http://www.csgb.net/login.aspx?userLoginName=2014&userName=邹智&professionId=F40C998A-D9AC-421F-99C9-C024C1DC53AD&flag=sm" target="_blank"><strong>教学系统</strong></a>
                        <div class="leftbgbt2">
                        </div>
                    </div>
                </div>
            </div>
            <div class="rightbox">
                
<h2 class="mbx">我的信息 &gt; 密码修改</h2>
<div class="cztable">
    
<table border="0" cellspacing="0" cellpadding="0" width="500px" style="margin:30px auto 0px auto;">
    <form action="../../groupAddServlet" method="post">
     <tr align="center">
        <th style="width:20%; text-align:left;">组号：</th>
        <td style="width:70%; text-align:left;"><input id="groupID" name="groupID" value="" type="text" class="input_2 txtinput1" /></td>
    </tr>   
        
         <tr align="center">
        <th style="width:20%; text-align:left;">组长名：</th>
        <td style="width:20%; text-align:left;">
           
           <select name="select" size="1">
                  <%     // String userName=request.getParameter("name");                                  
            
            int i=0;
             List<User> list = UserManagerDao.getInstance().selectGroupLeaderInfo();
                            if (list == null || list.size() < 1) {
                                out.println("没有数据");
                            } else {
                                for (User pu : list) {
                                    
                              
                                i++;
                               

                        %>
				    <option value="<%=pu.getName()%>"><%=pu.getName()%></option>
				  <%
                                }
                            }
                        %>    			   
			      </select>           
           
        </td>
  
    </tr>
     
    <tr>
    <td colspan="2" style="text-align:center;"><input type="submit" id="btnSubmit" value="添加新组" onclick="return changePassword()" class="input2" /></td>
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
   alert("小组已存在错误");
  }

</script>
</html>

