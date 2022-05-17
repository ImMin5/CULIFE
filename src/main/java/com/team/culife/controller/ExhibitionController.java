package com.team.culife.controller;

import java.io.File;
import java.nio.charset.Charset;
import java.security.Provider.Service;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.team.culife.service.AuthorService;
import com.team.culife.service.ExhibitionService;
import com.team.culife.service.MemberService;
import com.team.culife.vo.AuthorVO;
import com.team.culife.vo.ExhibitionVO;
import com.team.culife.vo.MemberVO;

@RestController
public class ExhibitionController {
	@Inject
	MemberService memberService;
	@Inject
	ExhibitionService exhibitionService;
	@Inject
	AuthorService authorService;
	
	@GetMapping("mypage/authorWrite")
	public ModelAndView authorWrite(HttpSession session, HttpServletRequest request, AuthorVO vo, String author) {
		ModelAndView mav = new ModelAndView();
		vo.setMember_no((Integer)request.getSession().getAttribute("logNo"));
		Integer memberNo = (Integer)session.getAttribute("logNo");
		MemberVO mvo = memberService.memberSelectByNo(memberNo);
		AuthorVO avo = authorService.authorSelectByName(author);
		mav.addObject("mvo", mvo);
		mav.addObject("avo", avo);
		
		System.out.println(mvo.getNickname());
		System.out.println(mvo.getNo());
		 
		mav.setViewName("exhibition/authorWrite");
		return mav;
	}
	// 작가등록
	@PostMapping("/authorWriteOk")
	@ResponseBody
	public ResponseEntity<String> authorWriteOk(AuthorVO vo, HttpServletRequest request, HttpSession session){
		vo.setMember_no((Integer)request.getSession().getAttribute("logNo"));
		Integer memberNo = (Integer)session.getAttribute("logNo");
		
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("text", "html",Charset.forName("UTF-8")));
		
		String path = session.getServletContext().getRealPath("/upload/"+memberNo+"/author");
		System.out.println("path --> " +path);
		
		try {
			/* MultipartHttpServletRequest mr = (MultipartHttpServletRequest) request; */
			
			System.out.println("author => " + vo.getAuthor());
			authorService.authorWrite(vo);
			System.out.println("service 확인");
			String msg = "작가 신청되었습니다.";
			entity = new ResponseEntity<String>(msg, headers, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			String msg = "작가등록 실패";
			entity = new ResponseEntity<String>(msg, headers, HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@PostMapping("authorNameCheck")
	@ResponseBody
	public String authorCheck(String author) {
		String cnt = authorService.authorCheck(author);
		return cnt;
	}

	/*
	@GetMapping("exhibitionWrite")
	public ModelAndView exhibitionApply(HttpSession session, HttpServletRequest request, ExhibitionVO vo) {
		vo.setAuthor_no((Integer)request.getSession().getAttribute("authorNo"));
		Integer memberNo = (Integer)session.getAttribute("logNo");
		System.out.println("author_no " + vo.getAuthor_no());
		System.out.println("member_no " + memberNo);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("exhibition/exhibitionWrite");
		return mav;
	}
	*/
	@PostMapping("exhibitionWriteOk")
	public ResponseEntity<String> exhibitionWriteOk(ExhibitionVO evo, String author, HttpServletRequest request, HttpSession session){
		ModelAndView mav = new ModelAndView();
		
		Integer memberNo = (Integer)session.getAttribute("logNo");
		AuthorVO avo = authorService.authorNoSelect(memberNo);
		mav.addObject("avo", avo);
		evo.setAuthor_no(avo.getNo());
		ResponseEntity<String> entity = null;
		try {
			exhibitionService.exhibitionWrite(evo);
			String msg = "<script>alert('전시 등록 완료.'); "
					+ "location.href='/online_exhibition/onlineList'</script>";
			entity = new ResponseEntity<String>(msg, HttpStatus.OK);
		} catch (Exception e) {
			
		}
		
		
		return entity;
	}
	
	@GetMapping("workCreate")
	public ModelAndView workCreate(HttpSession session, ExhibitionVO vo) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("exhibition/workCreate");
		return mav;
	}
	
	@GetMapping("workEdit")
	public ModelAndView workEdit(HttpSession session, ExhibitionVO vo) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("exhibition/workEdit");
		return mav;
	}
}
