<%-- 
    Document   : courseFSEditDetail
    Created on : 2015-12-7, 14:16:19
    Author     : OovEver
--%>

<%@page import="com.Discuz.Bean.Course"%>
<%@page import="com.Discuz.DAO.CourseManagerDao"%>
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
        if (newPwd == "") {
            $.jBox.tip("密码或确认密码不能为空！", 'error');
            return false;
        }       
        if (newPwd.length < 6 || newPwd.length > 16) {
            $.jBox.tip("密码为6~16个字符，区分大小写！", 'error');
            return false;
        }
      
         if (grade == "") {
            $.jBox.tip("班级不能为空！", 'error');
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
                    
                                            
                                            out.print("欢迎您");
                                            out.print(username);
                                            %>
                                       
                   <a href="/StudentManageSystem/MyInfo/rootInfo.jsp">我的信息</a>  <a href="/StudentManageSystem/User/Account/ChangePasswd.jsp">密码修改</a> <a
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
                                <a href="/Discuz/User/StudentInfor/showSchoolFS.jsp?type=course">课程管理</a></div>  
                         <div>
              <a href="/Discuz/User/StudentInfor/showSchoolFS.jsp?type=add">添加课程</a></div>   
                        <div>
              <a href="/Discuz/User/StudentInfor/showSchoolFS.jsp?type=question">问答管理</a></div>   
                        <div>
                     <a href="/Discuz/User/StudentInfor/showSchoolFS.jsp?type=file">资源管理</a></div>   
                    </div>    
                    
                </div>
            </div>
            <div class="rightbox">
                
<h2 class="mbx">个人中心 &gt; 编辑课程</h2>
<div class="cztable">
    

     <%     // String userName=request.getParameter("name");                                  
            int id;
            String idString=request.getParameter("id");
               session.setAttribute("id",idString);
            id=Integer.parseInt(idString);            
             List<Course> list = CourseManagerDao.getInstance().selectEditCourseInfo(id);
                            if (list == null || list.size() < 1) {
                                out.println("没有数据");
                            } else {
                                for (Course pu : list) {
                              

                        %>
               <form action="../../updateCoursePictureFS" method="post" enctype="multipart/form-data">
	<table border="0" cellspacing="0" cellpadding="0" width="500px" style="margin:30px auto 0px auto;">
	<tr>
	<td width="171">
	<h1 class="title" align="center">修改课程信息</h1>
	</td>
	
	
 	 </tr>
 	 <tr>
 	 <td height="114" align="center"> 	  
 	 <p class="blue">&nbsp;</p> 图片<%  
                                    String url;
                                     url=(String) session.getAttribute("url3");     
                                     if(url==null){
                                    url= pu.getImg();
                                     }      		
                         session.setAttribute("url3", url);
            %><%=url%> <img src="../../coursePicture/<%=url%>" width=117 height="141">	
	 </td>
	 <tr>
	 <td width="171" align="center">   
      <div class="file-box" align="center"> 
          <input type="file" name="file">       
        <input type="submit" value="提交" name="submit" size="20" class="button1"> 
      </div>
	  </td>
	 </tr>
	</tr>
	</table>
	</form>    
                        <table border="0" cellspacing="0" cellpadding="0" width="500px" style="margin:30px auto 0px auto;">                    
    <form action="../../courseFSEditServlet?id=<%=idString%>" method="post" >
     <tr align="center">
        <th style="width:20%; text-align:left;">学院名：</th>
        <td style="width:70%; text-align:left;"><input id="studentID" name="schoolName" value="<%=pu.getSchool()%>" type="text" class="input_2 txtinput1" readonly="true" /></td>
    </tr>
      <tr align="center">
        <th style="width:20%; text-align:left;">课程名：</th>
        <td style="width:70%; text-align:left;"><input id="studentID" name="courseName" value="<%=pu.getCourese()%>" type="text" class="input_2 txtinput1" /></td>
    </tr>
   
    <tr>
    <td colspan="2" style="text-align:center;"><input type="submit" id="btnSubmit" value="更改课程信息" onclick="return changePassword()" class="input2" /></td>
    </tr>
     </form>
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
       <script> 
//取出传回来的参数error并与yes比较
  var errori ='<%=request.getParameter("error")%>';
  if(errori=='yes'){
   alert("课程已存在错误");
  }
  
</script>
</html>