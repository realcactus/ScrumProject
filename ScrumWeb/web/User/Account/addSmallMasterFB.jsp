<%-- 
    Document   : addSmallMasterFB
    Created on : 2015-12-7, 18:09:51
    Author     : OovEver
--%>

<%@page import="com.Discuz.Bean.User"%>
<%@page import="com.Discuz.DAO.UserManagerDao"%>
<%@page import="com.Discuz.DAO.UserManagerDao"%>
<%@page import="com.Discuz.Bean.smallMaster"%>
<%@page import="com.Discuz.DAO.smallMasterMgDao"%>
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
    
<script type="text/javascript" language="javascript">
    function changePassword() {
        var oldPwd = $("#txtOldPwd").val();
        var newPwd = $("#txtNewPwd").val();
        var confirmNewPwd = $("#txtConfirmNewPwd").val();
        var studentName=$("#studentName").val();
        var studentID=$("#studentID").val();
        var grade=$("#grade").val();
       
        if (studentID == "") {
            $.jBox.tip("卡号不能为空！", 'error');
            return false;
        }
        if (studentName == "") {
            $.jBox.tip("积分不能为空！", 'error');
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
     
                 <%
    String academy=request.getParameter("school");
      if(academy==null)
      {
          academy=(String)session.getAttribute("academy");
      }
      else{
       session.setAttribute("academy", academy);
      }
  String school=(String)session.getAttribute("school");
 
    %>
<h2 class="mbx">个人中心&gt; 添加小版主</h2>
<div class="cztable">
    
<table border="0" cellspacing="0" cellpadding="0" width="500px" style="margin:30px auto 0px auto;">
   
    <form action="../../smallmasterAddServletFB?school=<%=school%>" method="post">
        <tr align="center">
             <th style="width:20%; text-align:left;">学校名称：</th>
          <td style="width:70%; text-align:center;"><%=school%></td>
        </tr>
        <tr align="center">
             <th style="width:20%; text-align:left;">学院名称：</th>
          <td style="width:70%; text-align:center;"><%=academy%></td>
        </tr>
     <tr align="center">
         
        <th style="width:20%; text-align:left;">版主名称：</th>
        <td style="width:70%; text-align:center;">
            <select name="select" size="1">
                <%
                 int i=0;
            int sumI=0;
            List<smallMaster> list2=smallMasterMgDao.getInstance().selectMasterInfo();
             boolean flag=false;
                List<User> list=UserManagerDao.getInstance().selectSmallMasterInfo();
                 if (list == null || list.size() < 1) {
                                out.println("没有数据");
                            } else {
                      if(list2.size()>0){                 
                                for (User pu : list) {
                                     sumI=0;
                                     for(smallMaster pu2:list2){
                                         if(pu.getUserName().equals(pu2.getUserName())){
                                              sumI++;
                                i++;
                                break;
                                 }
                               }
                                       if(sumI<1){
                                     
                              
                %>          
            <option value="<%=pu.getUserName()%>"><%=pu.getUserName()%></option>
             <%
                                }
                            }
                      } else
                             {
                                  for (User pu : list) {
                                   
                                       
                                  
                              
                                i++;
             
                        %>   
                            <option value="<%=pu.getUserName()%>"><%=pu.getUserName()%></option>
                            	  <%
                                        
                                
                                }
                             }
                        }
                   
                        %>   
                          </select>    
        </td>
    </tr>
   
        
   
    <tr>
    <td colspan="2" style="text-align:center;"><input type="submit" id="btnSubmit" value="添加小版主" class="input2" /></td>
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
   alert("学院已存在错误");
  }

</script>
</html>



