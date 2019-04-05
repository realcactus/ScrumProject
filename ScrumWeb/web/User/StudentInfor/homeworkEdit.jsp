<%-- 
    Document   : homeworkEdit
    Created on : 2015-10-7, 10:04:25
    Author     : OovEver
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="com.StudentMS.DAO.HomeworkDao"%>
<%@page import="com.StudentMS.DAO.HomeworkDao"%>
<%@page import="com.StudentMS.bean.Homework"%>
<%@page import="com.StudentMS.bean.Homework"%>
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
    
<script type="text/javascript">
    function showMsg(msg, obj) {
        jBox.tip(msg);
        $("#" + obj).focus();
    }

    function modifySystemMsgeStatus(smid, smtype) {
        var result = false;
        studentInfo.modifySystemMesgeStatus(smid, smtype, function (data) {
            var result = $.parseJSON(data);
            if ((String(result.ok) == "true")) {
                jBox.alert("成功标记为已读！", "提示");
                setTimeout(function () {
                    window.location.reload();
                }, 1500);
            }
            else {
                $.jBox.error(result.message, '提示');
            }
        });
        return result;
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
                      if(username==null)
                      {
                         response.sendRedirect("/StudentManageSystem/User/StudentInfor/index.jsp");
                      }
                                            
                                            out.print("欢迎您");
                                            out.print(username);
                                            %>
                                       
                   <a href="/StudentManageSystem/MyInfo/teacherInfo.jsp">我的信息</a>  <a href="/StudentManageSystem/User/Account/ChangePasswd.jsp">密码修改</a> <a
                            href="/StudentManageSystem/loginOut">安全退出</a>
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
                            <a href="/StudentManageSystem/MyInfo/teacherInfo.jsp">我的信息</a></div>                       
                    </div>
                    <div class="ta1">
                        <strong>教务中心</strong>
                        <div class="leftbgbt2">
                        </div>
                    </div>
                    <div class="cdlist">
                        <div>
                            <a href="/StudentManageSystem/User/StudentInfor/addHomework.jsp">发布作业</a></div>
                        <div>
                            <a href="/StudentManageSystem/User/StudentInfor/homeworkEdit.jsp">作业管理</a></div>
                        <div>
                            <a href="/StudentManageSystem/User/StudentInfor/downloadHomework.jsp">下载作业</a></div>
                        <div>
                            <a href="/StudentManageSystem/User/Account/groupAdd.jsp">添加分组</a></div>
                          <div>
                            <a href="/StudentManageSystem/MyInfo/groupEdit.jsp">分组管理</a></div>
                         <div>
                            <a href="/StudentManageSystem/User/Account/teacherAdd.jsp">添加人员</a></div>
                         <div>
                            <a href="/StudentManageSystem/MyInfo/teacherEdit.jsp">人员管理</a></div>
                    </div>        
                </div>
            </div>
            <div class="rightbox">
                
<h2 class="mbx">教务中心&gt;作业管理</h2>

<div class="cztable">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          
           
            <th width="40%">标题</th>
            
            <th style="text-align:center;" width="20%">添加时间</th>  
             <th>编辑</th>
              <th>删除</th>
        </tr>
         <%     // String userName=request.getParameter("name");                                  
           
            String url="/StudentManageSystem/User/StudentInfor/homeworkEdit.jsp";
             List<Homework> list = HomeworkDao.getInstance().selectHomeworkInfo();
                            if (list == null || list.size() < 1) {
                                out.println("没有数据");
                            } else {
                                for (Homework pu : list) {
                              

                        %>
        <tr style="height: 28px" class="tdbg" align="center">
            <td width="40%" align="center" style="color: Red; font-weight:bold;"><a href="/StudentManageSystem/User/StudentInfor/showHomeworkDetail.jsp?id=<%=pu.getId()%>&url=<%=url%>"><%=pu.getTitle()%></a></td>
            <td  width="20%" align="center" style="color: Red; font-weight:bold;"><%=pu.getAddDate()%></td>
            <td><a href="/StudentManageSystem/User/StudentInfor/homeworkEditDetail.jsp?id=<%=pu.getId()%>">编辑</a></td>
          <td><a href="../../deleteHomeworkServlet?id=<%=pu.getId()%>">删除</a></td>
        </tr>
        <%
                                }
                            
                            }
        %>
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
</html>

