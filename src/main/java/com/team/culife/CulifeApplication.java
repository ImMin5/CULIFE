package com.team.culife;

import java.util.Date;

import javax.inject.Inject;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import com.team.culife.service.AdminService;

@SpringBootApplication
@EnableScheduling
public class CulifeApplication {
	@Inject
	AdminService service;
	
	public static void main(String[] args) {
		SpringApplication.run(CulifeApplication.class, args);	
	}
	
	//choi0501-회원관리페이지 스케줄러: 정지회원 풀어주는 기능
	//@Scheduled(cron = "초 분 시 일 월 주")
	//매일 0시 0분 5초마다 실행
	//@Scheduled(cron = "5 0 0 * * *")	
	//발표용 3분마다 실행
	/*@Scheduled(cron = "0 0/3 * * * *") public void run() {
	System.out.println("현재시간은 "+ new Date()); 
	System.out.println("스케줄러를 실행합니다.");
	service.scheduleUpdate(); service.scheduleDelete();
	}*/
}
