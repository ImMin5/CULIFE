package com.team.culife.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class AuthorInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        
        int grade = (int)session.getAttribute("grade");
		System.out.println(grade);

		if(grade != 0 && grade == 1) { //로그인 상태
			return true;
		} else { // 로그아웃상태
			response.sendRedirect(request.getContextPath()+"/");
			return false;
		}
    }
}
