package com.team.culife.controller;

import java.io.File;
import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.team.culife.service.LoginService;
import com.team.culife.service.MemberService;
import com.team.culife.vo.MemberVO;

@RestController
public class MemberController {
	@Inject
	LoginService loginService;
	
	@Inject
	MemberService memberService;
	
	//마이페이지 내정보 뷰
	@GetMapping("/mypage/member")
	public ModelAndView mypage(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Integer memberNo = (Integer)session.getAttribute("logNo");
		
		try {
			
			if(memberNo != null ) {
				MemberVO mvo = memberService.memberSelectByNo(memberNo);
				mav.addObject("mvo", mvo);
				mav.setViewName("member/mypage");
			}
			else {
				mav.setViewName("redirect:/");
			}
			//나중에 바꿔야됨 test용
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return mav; 
	}
	
	//회원 정보 수정
	@PutMapping("/mypage/member")
	public ResponseEntity<HashMap<String,String>> memberEdit(String thumbnail, HttpServletRequest request ,HttpSession session){
		ResponseEntity<HashMap<String,String>> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		Integer memberNo = (Integer)session.getAttribute("logNo");
		
		try {

		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return entity;
	}
	
	//회원 썸네일 업로드
	@PostMapping("/mypage/member/thumbnail")
	public ResponseEntity<HashMap<String,String>> memberThumbnailEdit(MemberVO mvo, HttpServletRequest request ,HttpSession session){
		ResponseEntity<HashMap<String,String>> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		Integer memberNo = (Integer)session.getAttribute("logNo");
		String path = session.getServletContext().getRealPath("/upload/"+memberNo+"/thumbnail");
		System.out.println("path --> " +path);
		
		try {
			System.out.println("th "+ mvo.getThumbnail());
			
			MultipartHttpServletRequest mr = (MultipartHttpServletRequest)request;
			MultipartFile newFile = (MultipartFile) mr.getFile("file");
			
			if(newFile != null) { //새로업로드된 파일이 있으면
				String newUploadFilename = newFile.getOriginalFilename();	
					if(newUploadFilename!=null && !newUploadFilename.equals("")) {
						File f = new File(path, newUploadFilename);
						//폴더가 존재하지 않을 경우 폴더 생성
						if(!f.exists()) {
							try {
								System.out.println(f.mkdirs());
							}catch(Exception e) {e.printStackTrace();}
						}

						// 업로드
						try {
							//기존에 있던 썸네일 파일 삭제
							
							mvo = memberService.memberSelectByNo(memberNo);
							if(mvo.getThumbnail() != null) {
								File deleteFile = new File(path,mvo.getThumbnail());
								deleteFile.delete();
							}
							mvo.setThumbnail(newUploadFilename);
							System.out.println("업로드 결과 ---> "+ memberService.memberUpdate(mvo));
							newFile.transferTo(f);
						} catch(Exception ee) {ee.printStackTrace();}
							
					}
			} // if
			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			result.put("msg", "회원정보 업데이트 에러...");
			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	//회원 탈퇴
	@DeleteMapping("/mypage/member")
	public ResponseEntity<HashMap<String,String>> memberDelete(HttpSession session){
		ResponseEntity<HashMap<String,String>> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		Integer memberNo = (Integer)session.getAttribute("logNo");
		String Token = (String)session.getAttribute("Token");
		String rootPath = session.getServletContext().getRealPath("/upload/"+memberNo);
		try {
			result.put("status","200");
			if(memberNo != null) {
				
				MemberVO mvo = memberService.memberSelectByNo(memberNo);
				//카카오 서비스 끊기 -> 회원 탈퇴
				if(mvo != null) {
					JSONObject jsonObj = loginService.unlinkKaKao(mvo.getKakao_id(), Token);
					memberService.memberDelete(jsonObj.getLong("id"));
					memberService.deleteFileAll(new File(rootPath));
					session.invalidate();
					result.put("msg","회원탈퇴 성공");
					result.put("redirect","/");
					entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
				}
				
			}
			
		}catch(Exception e) {
			result.put("status","400");
			result.put("msg","회원 탈퇴 에러... 관리자에게 문의하세요.");
			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return entity;
	}
}