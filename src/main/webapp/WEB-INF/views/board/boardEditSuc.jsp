<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${cnt>0}">
	<c:if test="${vo.category=='free'}">
		<script>
			alert('π’ κΈμ΄ μμ λμμ΅λλ€.');
			location.href="/board/freeBoardView?no="+${vo.no}+"";
		</script>
	</c:if>
	<c:if test="${vo.category=='help'}">
		<script>
			alert('π’ κΈμ΄ μμ λμμ΅λλ€.');
			location.href="/board/help/helpBoardView?no="+${vo.no}+"";
		</script>
	</c:if>
</c:if>
<c:if test="${cnt==null || cnt==0}">
	<script>
		alert("π« κΈ μμ μ μ€ν¨νμ΅λλ€.");
		history.go(-1);
	</script>
</c:if>
