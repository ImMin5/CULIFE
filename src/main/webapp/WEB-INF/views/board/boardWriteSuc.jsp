<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${cnt>0}">
	<c:if test="${vo.category=='free'}">
		<script>
			alert('🟢 글이 등록되었습니다.');
			location.href='/board/freeBoardList?category=free';
		</script>
	</c:if>
	<c:if test="${vo.category=='help'}">
		<script>
			alert('🟢 글이 등록되었습니다.');
			location.href='/board/help/helpBoardList?category=help';
		</script>
	</c:if>
</c:if>
<c:if test="${cnt==null || cnt==0}">
	<script>
		alert("🚫 글 등록에 실패했습니다.");
		history.go(-1);
	</script>
</c:if>
