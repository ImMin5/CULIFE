package com.team.culife.controller;

import java.nio.charset.Charset;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
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
	public ModelAndView authorWrite(HttpSession session,ExhibitionVO vo) {
		ModelAndView mav = new ModelAndView();
		Integer memberNo = (Integer)session.getAttribute("logNo");
		MemberVO mvo = memberService.memberSelectByNo(memberNo);
		mav.addObject("mvo", mvo);
		
		System.out.println(mvo.getNickname());
		System.out.println(mvo.getNo());
		 
		mav.setViewName("exhibition/authorWrite");
		return mav;
	}
	// 작가등록
	@PostMapping("authorWriteOk")
	public ResponseEntity<String> authorWriteOk(ExhibitionVO vo, HttpServletRequest request, HttpSession session){
		vo.setMember_no((Integer)request.getSession().getAttribute("logNo"));
		Integer memberNo = (Integer)session.getAttribute("logNo");
		
		String path = session.getServletContext().getRealPath("/upload/"+memberNo+"/thumbnail");
		System.out.println("path --> " +path);
		ResponseEntity<String> entity = null;
		
		System.out.println("author " + vo.getAuthor());
		System.out.println("no " + vo.getMember_no());
		System.out.println("sns_link  " + vo.getSns_link());
		System.out.println("author_thumbnail " + vo.getAuthor_thumbnail());
		System.out.println("debut_year " + vo.getDebut_year());
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("text", "html",Charset.forName("UTF-8")));
		
        try {
        	authorService.authorWrite(vo);
        	String msg = "<script>alert('작가 신청되었습니다.');location.href='/exhibition/authorWrite';</script>";
			entity = new ResponseEntity<String>(msg, headers, HttpStatus.OK);
        } catch (Exception e) {
        	e.printStackTrace();
        	String msg = "<script>alert('작가등록 실패');history.back();</script>";
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
	
	@GetMapping("authorView")
	public ModelAndView authorView(HttpSession session, ExhibitionVO vo, String author) {
		ModelAndView mav = new ModelAndView();

		mav.addObject("vo", authorService.authorSelect(author));
		mav.setViewName("exhibition/authorView");
		return mav;
	}
	
	@GetMapping("exhibitionWrite")
	public ModelAndView exhibitionApply(HttpSession session, ExhibitionVO vo) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("exhibition/exhibitionWrite");
		return mav;
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
