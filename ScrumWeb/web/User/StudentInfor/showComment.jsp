<%-- 
    Document   : showComment
    Created on : 2015-12-4, 14:30:20
    Author     : OovEver
--%>

<%@page import="com.Discuz.DAO.CommentManagerDao"%>
<%@page import="com.Discuz.Bean.Comment"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
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
    
<script type="text/javascript">
    function returnIndex() {
        window.location = "/Index.aspx";
    }
    function showMsg(msg, obj) {
        jBox.tip(msg);
        $("#" + obj).focus();
    }
    function saveClick(studentId) {
        var Ctitle = $("#Ctitle").val();   //消息标题
        if (Ctitle == "" || Ctitle.length>20) {
            showMsg("请您输入消息标题,且不超过20个字！", "Ctitle");
            return false;
        }
        var Ctype = $("#Ctype").val();  //消息类型
        if (Ctype == ("Unselected")) {
            showMsg("请您选择投诉类型！", "Ctype");
            return false;
        }
        var Ccontent = $("#Ccontent").val(); //消息内容
        if (Ccontent == "" || Ccontent.length>80) {
            showMsg("请您输入消息内容，且不超过80个字！", "Ccontent");
            return false;
        }
        StudentCompain.insertCompain(studentId, Ctitle, Ctype, Ccontent, function (data) {
            var obj = $.parseJSON(data);
            if (obj.ok == true) {
                jBox.alert(obj.message, "提示");
                setTimeout(function () {
                    window.location.reload();
                }, 1500);
            }
            else {
                jBox.tip(obj.message);
            }
        });
    }
</script>
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
                    
                </div>
            </div>
            <div class="rightbox">
                




<div class="cztable">

<form action="../../addCommentServlet" method="post">
    <table width="100%" cellpadding="0" cellspacing="0">
         <% 
                                     String school=(String)session.getAttribute("school");
                                    String academy=(String)session.getAttribute("academy");
                                    String course=(String)session.getAttribute("Course");
                                    List<Comment> list=CommentManagerDao.getInstance().selectCommentInfo(school, academy, course);
                                     if (list == null || list.size() < 1) {
                                out.println("没有数据");
                            } else {
                                for (Comment pu : list) {
                                    
                 %>
          <tr>
            <td><div align="right"><%=pu.getAddPerson()%></div></td>
            <td ><%=pu.getComment()%></td>
        </tr>
                 
                 <%
                                }
                            }
                 %>
               
         
   
    </table>
</form>
</div>

            </div>
        </div>
        <%--<div class="footer">--%>
            <%--<p>--%>
                  <%--&copy;copyright 2015内蒙古大学计算机学院 版权所有</p>--%>
        <%--</div>--%>
    </div>
</body>
</html>
