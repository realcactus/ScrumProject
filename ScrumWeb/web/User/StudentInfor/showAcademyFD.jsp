<%-- 
    Document   : showAcademyFD
    Created on : 2015-12-4, 21:11:23
    Author     : OovEver
--%>

<%@page import="com.Discuz.DAO.academyManagerDao"%>
<%@page import="com.Discuz.Bean.Academy"%>
<%@page import="com.Discuz.DAO.CourseManagerDao"%>
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
                        <strong>教务中心</strong>
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
                

<div class="morebt">
    



</div>
<div class="cztable">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      
         <%     // String userName=request.getParameter("name");                                  
           String schoolName=request.getParameter("school");
           session.setAttribute("school", schoolName);
            int schoolNum=0;         
            int i=0;         
            int j=0;
            int rowNumI;
            schoolNum=CourseManagerDao.getInstance().selecSchoolNum(schoolName);   
            if(schoolNum!=0){
            if(schoolNum!=0)
            {
                rowNumI=schoolNum/3+1;
            }
            int []idI=new int[schoolNum];
             String []schoolNameString=new String[schoolNum];
              String []url=new String[schoolNum];
             List<Academy> list = academyManagerDao.getInstance().selectEditAcademyInfo(schoolName);
                            if (list == null || list.size() < 1) {
                                out.println("没有数据");
                            } else {
                                for (Academy pu : list) {
                             schoolNameString[i]=pu.getAcademy();
                             idI[i]=pu.getId();
                                url[i]=pu.getImg();
                             i++;
                              
                                }
                            
                            }
                        %>
                        <%
                            if(schoolNum>=3){
                            if(schoolNum%3==0)
                            {
                            for(j=0;j<schoolNum;j+=3)                            
                            {
                                
                         
                        %>
                        <tr style="height: 28px" class="tdbg" align="center">
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><img src="../../academyPicture/<%=url[j]%>" width=117 height="141"></td>
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><img src="../../academyPicture/<%=url[j+1]%>" width=117 height="141"></td>           
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><img src="../../academyPicture/<%=url[j+2]%>" width=117 height="141"></td>
        </tr>
      <tr style="height: 28px" class="tdbg" align="center">
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><a href="/Discuz/User/StudentInfor/showCourseFD.jsp?school=<%=schoolNameString[j]%>"><%=schoolNameString[j]%></a></td>
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><a href="/Discuz/User/StudentInfor/showCourseFD.jsp?school=<%=schoolNameString[j+1]%>"><%=schoolNameString[j+1]%></a></td>           
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><a href="/Discuz/User/StudentInfor/showCourseFD.jsp?school=<%=schoolNameString[j+2]%>"><%=schoolNameString[j+2]%></a></td>
        </tr>
        <%
                            }
                            }
                            else{
                                  for(j=0;j<schoolNum-3;j+=3)                            
                            {
        %>
         <tr style="height: 28px" class="tdbg" align="center">
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><img src="../../academyPicture/<%=url[j]%>" width=117 height="141"></td>
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><img src="../../academyPicture/<%=url[j+1]%>" width=117 height="141"></td>           
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><img src="../../academyPicture/<%=url[j+2]%>" width=117 height="141"></td>
        </tr>
        <tr style="height: 28px" class="tdbg" align="center">
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><a href="/Discuz/User/StudentInfor/showCourseFD.jsp?school=<%=schoolNameString[j]%>"><%=schoolNameString[j]%></a></td>
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><a href="/Discuz/User/StudentInfor/showCourseFD.jsp?school=<%=schoolNameString[j+1]%>"><%=schoolNameString[j+1]%></a></td>           
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><a href="/Discuz/User/StudentInfor/showCourseFD.jsp?school=<%=schoolNameString[j+2]%>"><%=schoolNameString[j+2]%></a></td>
        </tr>
        <%
                                   
                            }
                            }
                    }%>
                   <%
                            if(schoolNum%3==1)
                            {
                                
                            
                   %>
                     <tr style="height: 28px" class="tdbg" align="center">
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><img src="../../academyPicture/<%=url[schoolNum-1]%>" width=117 height="141"></td>
           
        </tr>
                    <tr style="height: 28px" class="tdbg" align="center">
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><a href="/Discuz/User/StudentInfor/showCourseFD.jsp?school=<%=schoolNameString[schoolNum-1]%>"><%=schoolNameString[schoolNum-1]%></a></td>
                    </tr>
                   <%
                            }
                            else if(schoolNum%3==2){
                   %>
                    <tr style="height: 28px" class="tdbg" align="center">
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><img src="../../academyPicture/<%=url[schoolNum-2]%>" width=117 height="141"></td>
             <td width="33%" align="center" style="color: Red; font-weight:bold;"><img src="../../academyPicture/<%=url[schoolNum-1]%>" width=117 height="141"></td>
        </tr>
                      <tr style="height: 28px" class="tdbg" align="center">
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><a href="/Discuz/User/StudentInfor/showCourseFD.jsp?school=<%=schoolNameString[schoolNum-2]%>"><%=schoolNameString[schoolNum-2]%></a></td>
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><a href="/Discuz/User/StudentInfor/showCourseFD.jsp?school=<%=schoolNameString[schoolNum-1]%>"><%=schoolNameString[schoolNum-1]%></a></td>
                    </tr>
                   
                   <%
                            }
            }
            else
            {
               out.print("没有学院");
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

