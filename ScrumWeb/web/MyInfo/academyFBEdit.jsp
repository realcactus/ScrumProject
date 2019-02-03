<%-- 
    Document   : academyFBEdit
    Created on : 2015-12-7, 17:28:53
    Author     : OovEver
--%>

<%@page import="com.Discuz.DAO.academyManagerDao"%>
<%@page import="com.Discuz.Bean.Academy"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>
	 高校资源共享论坛
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
                                    if(username==null){        
%>     
<a href="/Discuz/User/Account/Login.jsp">登录</a>
<a href="/Discuz/User/Account/Register.jsp">注册</a>        
<%
                                    }
                                    else
                                    {                                        
                                        out.print("欢饮您 ");
                                    
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
                                <a href="/Discuz/User/StudentInfor/showSchoolFB.jsp?type=course">课程管理</a></div>  
                         <div>
              <a href="/Discuz/User/StudentInfor/showSchoolFB.jsp?type=add">添加课程</a></div>   
                         <div>
                                <a href="/Discuz/User/StudentInfor/showSchoolFB.jsp?type=academy">学院管理</a></div>  
                              <div>
                                <a href="/Discuz/User/StudentInfor/showSchoolFB.jsp?type=addacademy">添加学院</a></div>  
                         <div>
                                <a href="/Discuz/User/StudentInfor/showSchoolFB.jsp?type=mastermg">小版主管理</a></div>  
                           <div>
                                <a href="/Discuz/User/StudentInfor/showSchoolFB.jsp?type=masteradd">添加小版主</a></div>  
                        <div>
              <a href="/Discuz/User/StudentInfor/showSchoolFB.jsp?type=question">问答管理</a></div>   
                        <div>
                     <a href="/Discuz/User/StudentInfor/showSchoolFB.jsp?type=file">资源管理</a></div>   
            
                    </div>   
                    
                      
                            
                </div>
            </div>
            <div class="rightbox">
                
<h2 class="mbx">论坛中心 &gt; 学院管理;</h2>       
<div class="cztable">
    <table width="100%" cellpadding="0" cellspacing="0">
         <%     // String userName=request.getParameter("name");                                  
             int GroupNum=0;
             String School=request.getParameter("school");
             if(School==null)
             {
                 School=(String)session.getAttribute("school");
             }else
             {
                 session.setAttribute("school", School);
             }
             List<Academy> list =academyManagerDao.getInstance().selectEditAcademyInfo(School);
                            if (list == null || list.size() < 1) {
                                out.println("没有数据");
                            } else {
                                for (Academy pu : list) {
                               

                        %>
        <tr>
            <td align="center">校名：</td>
            <td><%=pu.getSchool()%></td>          
            <td align="center">学院名</td>
            <td><%=pu.getAcademy()%></td>
        </tr>          
        <tr>
            <td colspan="2" align="center">
                <a href="../User/Account/academyFBEditDetail.jsp?id=<%=pu.getId()%>">编辑</a>
            
            </td>
              <td colspan="2" align="center">
                  <a href="../academyFBDeleteServlet?id=<%=pu.getId()%>">删除</a>
            
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
