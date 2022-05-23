package com.team.culife.config;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.team.culife.intercepter.AdminInterceptor;
import com.team.culife.intercepter.AuthorInterceptor;
import com.team.culife.intercepter.LoginInterceptor;




@Configuration
public class WebConfig implements WebMvcConfigurer{
	@Value("${upload-path}")
	private String uploadPath;
	
	@Value("${resource-path}")
	private String resourcePath;
	
	//로그인해야만 접속가능한 매퍼주소.
	private static final List<String> LOGIN_URL = Arrays.asList(
			"/예시1/**");
	
	//작가등급만 접속가능한 매퍼주소.
	private static final List<String> AUTHOR_URL = Arrays.asList(
			"/예시/**", "/예시2/**");
		
	//관리자만 접속가능한 매퍼주소.
	private static final List<String> ADMIN_URL = Arrays.asList(
			"/admin/**");
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		//(참고: https://kitty-geno.tistory.com/83
		//registry.addInterceptor(new LoginInterceptor()).addPathPatterns("/예시/**");
		//registry.addInterceptor(new LoginInterceptor()).excludePathPatterns("/예시/**");
		
		//인터셉터 적용
		//registry.addInterceptor(new LoginInterceptor()).addPathPatterns(LOGIN_URL);
		//registry.addInterceptor(new AuthorInterceptor()).addPathPatterns(AUTHOR_URL);
		registry.addInterceptor(new AdminInterceptor()).addPathPatterns(ADMIN_URL);

	}
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler(uploadPath).addResourceLocations(resourcePath);
	}
}
