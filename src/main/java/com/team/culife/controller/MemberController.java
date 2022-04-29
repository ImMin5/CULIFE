package com.team.culife.controller;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RestController;

import com.team.culife.service.LoginService;
import com.team.culife.service.MemberService;
import com.team.culife.vo.MemberVO;

@RestController
public class MemberController {
	@Inject
	LoginService loginService;
	
	@Inject
	MemberService memberService;
	
	//회원 탈퇴
	@DeleteMapping("/member")
	public ResponseEntity<HashMap<String,String>> memberDelete(HttpSession session){
		ResponseEntity<HashMap<String,String>> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		Integer memberNo = (Integer)session.getAttribute("logNo");
		String Token = (String)session.getAttribute("Token");
		
		try {
			if(memberNo != null) {
				
				MemberVO mvo = memberService.memberSelectByNo(memberNo);
				if(mvo != null) {
					JSONObject jsonObj = loginService.unlinkKaKao(mvo.getKakao_id(), Token);
					memberService.memberDelete(jsonObj.getLong("id"));
				}
				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return entity;
	}
}
