package com.team.culife.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        
        int grade;
        if(session.getAttribute("grade") != null) {
        	grade = (Integer)session.getAttribute("grade");
        }else {
        	grade = 3;
        }
        

		if(grade != 3) { //로그인 상태
			return true;
		}else { // 로그아웃상태
			response.sendRedirect(request.getContextPath()+"/");
			return false;
		}
    }
}
