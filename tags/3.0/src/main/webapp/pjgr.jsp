<%@page import="org.svnadmin.util.EncryptUtil"%>
<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@include file="inc.jsp"%>
<span style="color:green;font-weight:bold;"><a href="pj">项目管理(<%=request.getParameter("pj")%>)</a> --> 用户组管理</span><br><br>
<%
String PJ_MANAGER = org.svnadmin.Constants.getManagerGroup(request.getParameter("pj"));

%>

<%
org.svnadmin.entity.PjGr entity = (org.svnadmin.entity.PjGr)request.getAttribute("entity");
if(entity==null)entity=new org.svnadmin.entity.PjGr();
%>
<script>
function checkForm(f){
	if(f.elements["pj"].value==""){
		alert("项目不可以为空");
		f.elements["pj"].focus();
		return false;
	}
	if(f.elements["gr"].value==""){
		alert("组号不可以为空");
		f.elements["gr"].focus();
		return false;
	}
	if("<%=PJ_MANAGER%>" == f.elements["gr"].value){
		alert("管理员组是默认组，不可以修改");
		f.elements["gr"].focus();
		return false;
	}
	return true;
}
</script>
<form name="pjgr" action="<%=ctx%>/pjgr" method="post" onsubmit="return checkForm(this);">
	<input type="hidden" name="act" value="save">
	<table>
		<tr>
			<td>项目</td>
			<td><input type="hidden" name="pj" value="<%=request.getParameter("pj")%>"><%=request.getParameter("pj")%></td>
			<td>组号</td>
			<td><input type="text" name="gr" value="<%=entity.getGr()==null?"":entity.getGr()%>"  onkeyup="value=value.replace(/[^_\-A-Za-z0-9]/g,'')"><span style="color:red;">*</span></td>
			<td>描述</td>
			<td><input type="text" name="des" value="<%=entity.getDes()==null?"":entity.getDes()%>"></td>
			<td>
				<input type="submit" value="提交">
			</td>
		</tr>
	</table>
</form>

<table class="sortable">

	<thead>
		<td>NO.</td>
		<td>项目</td>
		<td>组号</td>
		<td>描述</td>
		<td>设置用户</td>
		<td>删除</td>
	</thead>
	<%
	java.util.List<org.svnadmin.entity.PjGr> list = (java.util.List)request.getAttribute("list");

	if(list!=null){
	  for(int i = 0;i<list.size();i++){
		  org.svnadmin.entity.PjGr pjGr = list.get(i);
		%>
		<tr>
		<td><%=(i+1) %></td>
		<td>
			<%=pjGr.getPj() %>
		</td>
		
		<td>
			<%if(PJ_MANAGER.equals(pjGr.getGr())){%><%=pjGr.getGr() %><%}else{%>
			<a href="<%=ctx%>/pjgr?act=get&pj=<%=pjGr.getPj()%>&gr=<%=pjGr.getGr()%>"><%=pjGr.getGr() %></a>
			<%}%>
		</td>
		<td><%=pjGr.getDes() %></td>
		<td><a href="<%=ctx%>/pjgrusr?pj=<%=pjGr.getPj()%>&gr=<%=pjGr.getGr()%>">设置用户</a></td>
		<td>
			<%if(PJ_MANAGER.equals(pjGr.getGr())){%>&nbsp;<%}else{%>
			<a href="javascript:if(confirm('确认删除?')){del('<%=ctx%>/pjgr?&pj=<%=pjGr.getPj()%>&gr=<%=pjGr.getGr()%>')}">删除</a>
			<%}%>
		</td>
	</tr>
		<%	
	}}
	%>
</table>