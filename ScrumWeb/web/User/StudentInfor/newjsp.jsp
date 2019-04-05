<%-- 
    Document   : showHomeworkTest
    Created on : 2015-10-8, 14:50:04
    Author     : OovEver
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.StudentMS.DAO.DBcon"%>
<%@page import="java.util.List"%>
<%@page import="com.StudentMS.bean.Homework"%>
<%@page import="com.StudentMS.bean.Homework"%>
<%@page import="com.StudentMS.DAO.HomeworkDao"%>
<%@page import="com.StudentMS.DAO.HomeworkDao"%>
<%@page import="com.StudentMS.DAO.HomeworkDao"%>
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
        
            <div class="page">
                <div id="logo">
                   
                </div>
                 <div class="topxx">
                     <%
                     String username = (String) session.getAttribute("username");                                      
                                            
%>     
<a href="/StudentManageSystem/User/Account/Login.jsp">登录</a>
<a href="/StudentManageSystem/User/Account/Register.jsp">注册</a>          
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
                
<h2 class="mbx">作业信息 &gt;作业</h2>
<div class="morebt">
    


</div>
<div class="cztable">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          
           
            <th width="40%">标题</th>
            
            <th style="text-align:center;" width="20%">添加时间</th>            
        </tr>
         <%!     // String userName=request.getParameter("name");                                  
           public static final int PAGESIZE = 10;  
           int pageCount;  
           int curPage = 1;  
    %>
    <%      
       String url="http://localhost:8080/StudentManageSystem/User/StudentInfor/index.jsp";
       Connection conn = DBcon.getConn();
        int id=0;
         String title="";
         String date="";
       String sql="select * from  db_StudentMS.dbo.\"homework\"";
        PreparedStatement stat = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY); 
            ResultSet rs = stat.executeQuery();
            List<Homework> empList = new ArrayList<Homework>();  
            if(!rs.next())
            {
                out.print("没有数据");
            }
            else
            {
         rs.last();
        int size = rs.getRow();  
        
        pageCount = (size%PAGESIZE==0)?(size/PAGESIZE):(size/PAGESIZE+1); 
      
         String tmp = request.getParameter("curPage");  
        if(tmp==null){  
            tmp="1";  
        }  
        curPage = Integer.parseInt(tmp);  
        if(curPage>=pageCount) curPage = pageCount;  
       boolean flag = rs.absolute((curPage-1)*PAGESIZE+1);  
        
        int count = 0;  
         do{  
         
            if(count>=PAGESIZE)break;  
            id=rs.getInt("id");
            title=rs.getString("title");
            date=rs.getString("addDate");
            count++;  
            
            %>
        <tr style="height: 28px" class="tdbg" align="center">
            <td width="40%" align="center" style="color: Red; font-weight:bold;"><a href="/StudentManageSystem/User/StudentInfor/showHomeworkDetail.jsp?id=<%=id%>&url=<%=url%>"><%=title%></a></td>
            <td  width="20%" align="center" style="color: Red; font-weight:bold;"><%=date%></td>
        </tr>
         <%  
        }while(rs.next()); 
        conn.close();  
            }
         
   
%>  
    </table>    
    <a href = "/StudentManageSystem/User/StudentInfor/index.jsp?curPage=1" >首页</a>  
<a href = "/StudentManageSystem/User/StudentInfor/index.jsp?curPage=<%=(((curPage-1)>0)? (curPage-1) : 1)%>" >上一页</a>  
<a href = "/StudentManageSystem/User/StudentInfor/index.jsp?curPage=<%=curPage+1%>" >下一页</a>  
<a href = "/StudentManageSystem/User/StudentInfor/index.jsp?curPage=<%=pageCount%>" >尾页</a> 
<%
if(curPage<0)
{
    curPage=1;
}
%>
第<%=curPage%>页/共<%=pageCount%>页  
  
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

