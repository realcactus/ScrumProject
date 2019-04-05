<%-- 
    Document   : showSchool
    Created on : 2015-12-2, 17:46:26
    Author     : OovEver
--%>

<%@page import="com.Discuz.Bean.School"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="com.Discuz.DAO.SchoolManagerDao"%>
<%@page import="com.Discuz.DAO.SchoolManagerDao"%>
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
                     String typeString=request.getParameter("type");
                     session.setAttribute("type", typeString);
                     String username = (String) session.getAttribute("username");                                      
                     if(username==null){    
                     if(typeString.equals("submit"))
                    {
                        response.sendRedirect("/Discuz/User/StudentInfor/index.jsp?error=yes2");
                    }
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
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        
         <%     // String userName=request.getParameter("name");                                  
          
            int schoolNum=0;         
            int i=0;         
            int j=0;
            int rowNumI;
            schoolNum=SchoolManagerDao.getInstance().selecSchoolNum();   
            if(schoolNum!=0)
            {
                rowNumI=schoolNum/3+1;
            }
            int []idI=new int[schoolNum];
             String []schoolNameString=new String[schoolNum];
               String []url=new String[schoolNum];
             List<School> list = SchoolManagerDao.getInstance().selectEditSchoolInfo();
                            if (list == null || list.size() < 1) {
                                out.println("没有数据");
                            } else {
                                for (School pu : list) {
                             schoolNameString[i]=pu.getSchool();
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
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><img src="../../schoolPicture/<%=url[j]%>" width=117 height="141"></td>
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><img src="../../schoolPicture/<%=url[j+1]%>" width=117 height="141"></td>           
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><img src="../../schoolPicture/<%=url[j+2]%>" width=117 height="141"></td>
        </tr>
      <tr style="height: 28px" class="tdbg" align="center">
          
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><a href="/Discuz/User/StudentInfor/showAcademy.jsp?school=<%=schoolNameString[j]%>"><%=schoolNameString[j]%></a></td>
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><a href="/Discuz/User/StudentInfor/showAcademy.jsp?school=<%=schoolNameString[j+1]%>"><%=schoolNameString[j+1]%></a></td>           
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><a href="/Discuz/User/StudentInfor/showAcademy.jsp?school=<%=schoolNameString[j+2]%>"><%=schoolNameString[j+2]%></a></td>
        </tr>
        <%
                            }
                            }
                            else{
                                  for(j=0;j<schoolNum-3;j+=3)                            
                            {
        %>
         <tr style="height: 28px" class="tdbg" align="center">
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><img src="../../schoolPicture/<%=url[j]%>" width=117 height="141"></td>
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><img src="../../schoolPicture/<%=url[j+1]%>" width=117 height="141"></td>           
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><img src="../../schoolPicture/<%=url[j+2]%>" width=117 height="141"></td>
        </tr>
        <tr style="height: 28px" class="tdbg" align="center">
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><a href="/Discuz/User/StudentInfor/showAcademy.jsp?school=<%=schoolNameString[j]%>"><%=schoolNameString[j]%></a></td>
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><a href="/Discuz/User/StudentInfor/showAcademy.jsp?school=<%=schoolNameString[j+1]%>"><%=schoolNameString[j+1]%></a></td>           
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><a href="/Discuz/User/StudentInfor/showAcademy.jsp?school=<%=schoolNameString[j+2]%>"><%=schoolNameString[j+2]%></a></td>
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
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><img src="../../schoolPicture/<%=url[schoolNum-1]%>" width=117 height="141"></td>
           
        </tr>
                    <tr style="height: 28px" class="tdbg" align="center">
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><a href="/Discuz/User/StudentInfor/showAcademy.jsp?school=<%=schoolNameString[schoolNum-1]%>"><%=schoolNameString[schoolNum-1]%></a></td>
                    </tr>
                   <%
                            }
                            else if(schoolNum%3==2){
                   %>
                                    <tr style="height: 28px" class="tdbg" align="center">
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><img src="../../schoolPicture/<%=url[schoolNum-2]%>" width=117 height="141"></td>
             <td width="33%" align="center" style="color: Red; font-weight:bold;"><img src="../../schoolPicture/<%=url[schoolNum-1]%>" width=117 height="141"></td>
        </tr>
                      <tr style="height: 28px" class="tdbg" align="center">
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><a href="/Discuz/User/StudentInfor/showAcademy.jsp?school=<%=schoolNameString[schoolNum-2]%>"><%=schoolNameString[schoolNum-2]%></a></td>
            <td width="33%" align="center" style="color: Red; font-weight:bold;"><a href="/Discuz/User/StudentInfor/showAcademy.jsp?school=<%=schoolNameString[schoolNum-1]%>"><%=schoolNameString[schoolNum-1]%></a></td>
                    </tr>
                   
                   <%
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
