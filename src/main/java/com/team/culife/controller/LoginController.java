package com.team.culife.controller;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.team.culife.service.LoginService;
import com.team.culife.service.MemberService;
import com.team.culife.vo.MemberBanVO;
import com.team.culife.vo.MemberVO;

@RestController
public class LoginController {
	@Value("${open-api.REST_API_KEY}")
    private String REST_API_KEY;
	
	@Inject
	LoginService loginService;
	@Inject
	MemberService memberService;
	
	//로그인 뷰 페이지
	@GetMapping("/login")
	public ModelAndView loginView(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Integer memberNo = (Integer)session.getAttribute("logNo");
		String nickname = (String)session.getAttribute("logNickname");
		try {
			if(memberNo == null) {
				mav.setViewName("login/login");
				System.out.println("[INFO] nickname : " + nickname + " " + memberNo +" 로그인");
			}
			else
				mav.setViewName("redirect:/");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	//code가 redirect되는 주소
	@GetMapping("/login/oauth")
	public void loginOauth(@RequestParam(value = "code", required = false) String code) {
		ModelAndView mav = new ModelAndView();
		loginService.getKakaoToken(code);
		mav.setViewName("redirect:/");
	}
	
	//카카오 로그인 진행
	@PostMapping("/login/kakao")
	public ResponseEntity<HashMap<String,String>> getUserInfo(@RequestParam(value = "token", required = false)String token, HttpSession session) {
		JSONObject jsonObj = loginService.getUserInfo(token);
		MemberVO mvo = null;
		ResponseEntity<HashMap<String,String>> entity = null;
		HashMap<String,String> result = new HashMap<String, String>();
		try {
			result.put("status", "200");
			if(jsonObj == null) {
				System.out.println("잘못된 접근입니다.");
			}
			//이메일이 없을 경우 or is_email_valid가 false일 경우 
			if(!jsonObj.getJSONObject("kakao_account").getBoolean("has_email")) {
				result.put("redirect", "/");
				System.out.println("이메일을 입력 받아야 합니다.");
				
			}
			mvo = memberService.memberSelectByEmail(jsonObj.getJSONObject("kakao_account").getString("email"));
			if(mvo == null) {
				//회원이 아닐 경우
				mvo = new MemberVO();
				mvo.setKakao_id(jsonObj.getLong("id"));
				mvo.setNickname(jsonObj.getJSONObject("kakao_account").getJSONObject("profile").getString("nickname"));
				mvo.setEmail(jsonObj.getJSONObject("kakao_account").getString("email"));
				mvo.setGrade(0);
				
				memberService.memberInsert(mvo);
				session.setAttribute("logNo", mvo.getNo());
				session.setAttribute("logNickname", mvo.getNickname());
				session.setAttribute("Token", token);
				session.setAttribute("grade",mvo.getGrade());
				
				result.put("msg","회원가입 성공");
				result.put("redirect", "/");
				System.out.println("회원가입");
			}
			else {
				
				//정지된 회원인기 판별
				if(mvo.getStatus() == 0) {
					//로그인
					session.setAttribute("logNo", mvo.getNo());
					session.setAttribute("logNickname", mvo.getNickname());
					session.setAttribute("Token", token);
					session.setAttribute("grade",mvo.getGrade());
					
					result.put("msg","로그인 성공");
					result.put("status", "200");
					//관리자 로그인
					if(mvo.getGrade() == 2) 
						result.put("redirect", "/admin/memberList");
					//일반 로그인
					else
						result.put("redirect", "/");
					
				}else {
					//정지된 아이디
					MemberBanVO mbvo = memberService.memberBanSelectByMemberNo(mvo.getNo());
					result.put("msg", "[정지된 아이디]\n기간 : "+mbvo.getStart_date().split(" ")[0] + " ~ " + mbvo.getEnd_date().split(" ")[0]);
					result.put("status", "201");
					result.put("redirect", "/login");
				}
				
				System.out.println("로그인 성공");
			}    
			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
		}catch(Exception e) {
			result.put("msg", "로그인 에러 관리자에게 연락주세요.");
			result.put("status", "400");
			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return entity;
	}
	
	//로그아웃 버튼 주소 
	//https://kauth.kakao.com/oauth/logout?client_id=f20eb18d7d37d79e45a5dff8cb9e3b9e&logout_redirect_uri=http://localhost:8080/logout/kakao
	//로그아웃 
	@GetMapping("/logout")
	public ModelAndView logout(HttpSession session){
		ModelAndView mav = new ModelAndView();
		Integer memberNo = (Integer)session.getAttribute("logNo");
		String Token = (String)session.getAttribute("Token");
		String logNickname = (String)session.getAttribute("logNickname");
		Integer grade = (Integer)session.getAttribute("grade");
		
		try {
			if(memberNo != null ) {
				MemberVO mvo = memberService.memberSelectByNo(memberNo);
				System.out.println(mvo.getNickname());
				if(mvo != null) {
					loginService.logout(mvo.getKakao_id(),Token);
				}
			}
			session.invalidate();
			mav.setViewName("redirect:/");
			
		}catch(Exception e) {
			e.printStackTrace();
			session.invalidate();
			mav.setViewName("redirect:/");
		}
		
		return mav;
	}
	
	//카카오 로그아웃 redirect 주소
	@GetMapping("/logout/kakao")
	public ModelAndView logoutKakao(HttpSession session, @RequestParam(value = "state", required = false)String state) {
		System.out.println("state : " + state);
		return logout(session);
	}
	
	//로그인
	@PostMapping("/login")
	public ResponseEntity<HashMap<String,String>> adminSignup(MemberVO mvo , HttpSession session){
		ResponseEntity<HashMap<String,String>> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		
		try {
			result.put("status", "200");
			MemberVO Orimvo = memberService.memberSelectByEmail(mvo.getEmail());
			if(Orimvo == null) {
				result.put("msg", "존재하지 않는 아이디 입니다.");
				
			}
			else if(Orimvo.getEmail().equals(mvo.getEmail())){
				
				session.setAttribute("logNo", Orimvo.getNo());
				session.setAttribute("logNickname", Orimvo.getNickname());
				session.setAttribute("grade",Orimvo.getGrade());
				result.put("msg", "로그인 성공");
				System.out.println("로그인 성공 ---> "+ Orimvo.getNickname());				
			}
			entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			result.put("status", "400");
			result.put("msg", "로그인 에러...관리자에게 문의해 주세요.");
			entity = new ResponseEntity<HashMap<String,String>>(result,HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
