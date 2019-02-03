<%-- 
    Document   : teacherInfo
    Created on : 2015-10-10, 13:35:12
    Author     : OovEver
--%>

<%@page import="com.Discuz.Bean.User"%>
<%@page import="com.Discuz.DAO.UserManagerDao"%>
<%@page import="java.util.List"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>
	学生信息管理平台
</title><link href="../Style/StudentStyle.css" rel="stylesheet" type="text/css" /><link href="../Script/jBox/Skins/Blue/jbox.css" rel="stylesheet" type="text/css" /><link href="../Style/ks.css" rel="stylesheet" type="text/css" />
    <script src="../Script/jBox/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="../Script/jBox/jquery.jBox-2.3.min.js" type="text/javascript"></script>
    <script src="../Script/jBox/i18n/jquery.jBox-zh-CN.js" type="text/javascript"></script>
    <script src="../Script/Common.js" type="text/javascript"></script>
    <script src="../Script/Data.js" type="text/javascript"></script>
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
        function submitMail() {
            var mtitle = "联系方式有修改";
            var html = "<div style='padding:10px;'><div style='width:65px; height:120px; float:left;'>修改的地方：</div><div style='width:250px; height:120px; float:left;'><textarea id='objeCont' name='objeCont' style='width:250px; height:105px;'></textarea></div></div>";

            var submit = function (v, h, f) {
                if (f.objeCont == '' || f.objeCont.length > 80) {
                    $.jBox.tip("请您输入有修改的地方，且不超过80个字！", 'error', { focusId: "objeCont" }); // 关闭设置 objeCont 为焦点
                    return false;
                }

                StudentCompain.insertCompain('', mtitle, 5, f.objeCont, function (data) {
                    var obj = $.parseJSON(data);
                    var resultObj = false;
                    if (obj.ok) {
                        $.jBox.tip("成功提交联系方式的修改邮件！");
                    }
                });
            };

            $.jBox(html, { title: "联系方式修改的邮件", submit: submit });
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
                
<h2 class="mbx">我的信息 &gt; 个人资料 &nbsp;&nbsp;&nbsp;</h2>       

<div class="cztable">
    <table width="100%" cellpadding="0" cellspacing="0">
         <%     // String userName=request.getParameter("name");                                  
             String userName=username;
             List<User> list = UserManagerDao.getInstance().selectPersonInfo(userName);
                            if (list == null || list.size() < 1) {
                                out.println("没有数据");
                            } else {
                                for (User pu : list) {
                               

                        %>
        <tr>
            <td align="right" width="80">账号：</td>
            <td><%=pu.getUserName()%></td>
            <td align="right" width="90">昵称：</td>
            <td><%=pu.getNickName()%></td>
            
          
        </tr>
        <tr>
            <td align="right">积分：</td>
            <td>
                <%
                    out.print(pu.getCredit());                
                
                %>
            </td>
            <td align="right">级别：</td>
            <td>
                 <%
            if(pu.getVip()==5)
            {
                out.print("普通用户");
            }
            if(pu.getVip()==4)
            {
                out.print("大版主");
            }
            else if(pu.getVip()==3)
            {
                out.print("小版主");
            }
              else if(pu.getVip()==2)
            {
                out.print("论坛管理员");
            }
                else if(pu.getVip()==1)
            {
                out.print("系统管理员");
            }
           
            %>  
                     
                
            </td>
        </tr>
      
      
      
     
          <%
                                }
                            }
                        %>
    </table>
</div>

            </div>
        </div>
        <div class="footer">
            <p>
               &copy;copyright 2015内蒙古大学计算机学院 版权所有</p>
        </div>
    </div>
</body>
</html>

