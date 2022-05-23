package com.team.culife.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.team.culife.service.BoardService;
import com.team.culife.service.MemberService;
import com.team.culife.vo.BoardVO;
import com.team.culife.vo.PagingVO;

@RestController
@RequestMapping("/board/")
public class BoardController {
	@Inject
	BoardService service;
	@Inject
	MemberService memberService;

	// 자유게시판
	@GetMapping("freeBoardList")
	public ModelAndView freeboardList(PagingVO pVO, BoardVO vo, HttpSession session) {
		ModelAndView mav = new ModelAndView();

		mav.addObject("list", service.freeselectList(pVO));
		vo.setNickname((String)session.getAttribute("nickName"));

		// 자유게시판 목록 페이징
		int total = service.boardTotalRecord(pVO);

		pVO.setTotalRecord(total);
		mav.addObject("pVO", pVO);

		mav.setViewName("/board/freeBoardList");
		return mav;
	}

	// 자유게시판 게시글 등록 폼
	@GetMapping("freeBoardWrite")
	public ModelAndView freeBoardWrite(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		Integer logNo=(Integer) session.getAttribute("logNo");
		if(logNo==null) {
			mav.addObject("msg","로그인 해야 이용할 수 있어요");
			mav.setViewName("board/help/message");
			return mav;
		}
		
		mav.setViewName("board/freeBoardWrite");
		return mav;
	}

	// 자유게시판 상세페이지 뷰
	@GetMapping("freeBoardView")
	public ModelAndView freeView(int no, String userid, HttpSession session) {
		ModelAndView mav = new ModelAndView();

		// 조회수 증가
		service.updateViews(no);

		// 상세페이지 보이기(뷰 보이기)
		mav.addObject("viewVo", service.selectView(no));
		mav.setViewName("/board/freeBoardView");

		return mav;
	}

	// 자유게시판 글등록 DB연결
	@PostMapping("freeBoardWriteOk")
	public ModelAndView freeWriteOk(BoardVO vo, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		try {
			// 현재 session에 있는 ID와 카테고리

			vo.setMember_no((Integer) session.getAttribute("logNo"));
			vo.setNickname((String) session.getAttribute("logNickname"));
			vo.setCategory("free");

			mav.addObject("cnt", service.boardInsert(vo));

			mav.addObject("vo", vo);
			mav.setViewName("board/boardWriteSuc");
		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName("redirect:/");
		}
		return mav;
	}

	// 자유게시판 글 수정 폼
	@GetMapping("freeBoardEdit")
	public ModelAndView freeEdit(int no) {
		ModelAndView mav = new ModelAndView();
		BoardVO bvo = service.selectEditView(no);

		mav.addObject("bvo", bvo);
		mav.setViewName("board/freeBoardEdit");
		return mav;
	}

	// 자유게시판 글 수정DB
	@PostMapping("freeBoardEditOk")
	public ModelAndView freeBoardEditOk(BoardVO vo, HttpSession session) {
		ModelAndView mav = new ModelAndView();

		vo.setMember_no((Integer) session.getAttribute("logNo"));
		vo.setCategory("free");

		int cnt = service.updateEditView(vo);

		mav.addObject("cnt", cnt);
		mav.addObject("vo", vo);
		mav.setViewName("board/boardEditSuc");

		return mav;
	}

	// 자유게시판 글 삭제하기
	@GetMapping("freeBoardDel")
	public ResponseEntity<String> freeBoardDel(int no, HttpSession session) {

		int member_no = (Integer) session.getAttribute("logNo");
		ResponseEntity<String> entity = null;

		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=utf-8");

		// 삭제
		int result = service.deleteView(no, member_no);
		if (result > 0) {
			String msg = "<script>alert('글이 삭제되었습니다.');";
			msg += "location.href='/board/freeBoardList';</script>";
			entity = new ResponseEntity<String>(msg, headers, HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>(failMsg(), headers, HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	// 문의사항게시판
	@GetMapping("/help/helpBoardList")
	public ModelAndView helpboardList(PagingVO pVO, BoardVO vo, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Integer logNo=(Integer) session.getAttribute("logNo");
		if(logNo==null) {
			mav.addObject("msg","로그인 해야 이용할 수 있어요");
			mav.setViewName("board/help/message");
			return mav;
		}
		vo.setMember_no(logNo);
		List<BoardVO> list = service.helpselectList(pVO);
		
		// 문의사항 목록 페이징
		int total = service.boardTotalRecord(pVO);

		pVO.setTotalRecord(total);
		mav.addObject("pVO", pVO);
		mav.addObject("list", list);
		
		mav.setViewName("board/help/helpBoardList");
		return mav;
	}

	// 문의사항 게시글 등록 폼
	@GetMapping("/help/helpBoardWrite")
	public ModelAndView helpBoardWrite() {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("board/help/helpBoardWrite");
		return mav;
	}

	// 문의사항 상세페이지 뷰
	@GetMapping("/help/helpBoardView")
	public ModelAndView helpView(int no, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Integer member_no = (Integer) session.getAttribute("logNo");
		if(member_no==null) {
			mav.addObject("msg","로그인 해야 이용할 수 있어요");
			mav.setViewName("board/help/message");
			return mav;
		}
		
		int grade = (Integer) session.getAttribute("grade");
		BoardVO vo = service.selectView(no);	
		
		if(vo.getMember_no() == member_no || grade == 2) {
			// 상세페이지 보이기(뷰 보이기)
			mav.addObject("viewVo", vo);
			// 조회수 증가
			service.updateViews(no);
		}
		else {
			String msg ="guest";
			mav.addObject("msg",msg);
		}
		mav.setViewName("board/help/helpBoardView");
		
		return mav;
	}

	// 문의게시판 글등록 DB연결
	@PostMapping("/help/helpBoardWriteOk")
	public ModelAndView helpWriteOk(BoardVO vo, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		try {
			// 현재 session에 있는 ID와 카테고리

			vo.setMember_no((Integer) session.getAttribute("logNo"));
			vo.setNickname((String) session.getAttribute("logNickname"));
			vo.setCategory("help");

			mav.addObject("cnt", service.boardInsert(vo));
			mav.addObject("vo", vo);

			mav.setViewName("board/boardWriteSuc");
		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName("redirect:/");
		}
		return mav;
	}

	// 문의사항 글 수정 폼
	@GetMapping("/help/helpBoardEdit")
	public ModelAndView helpEdit(int no) {
		ModelAndView mav = new ModelAndView();
		BoardVO bvo = service.selectEditView(no);

		mav.addObject("bvo", bvo);
		mav.setViewName("board/help/helpBoardEdit");
		return mav;
	}

	// 문의사항 글 수정DB
	@PostMapping("/help/helpBoardEditOk")
	public ModelAndView helpBoardEditOk(BoardVO vo, HttpSession session) {
		ModelAndView mav = new ModelAndView();

		vo.setMember_no((Integer) session.getAttribute("logNo"));
		vo.setCategory("help");

		int cnt = service.updateEditView(vo);

		mav.addObject("cnt", cnt);
		mav.addObject("vo", vo);
		mav.setViewName("board/boardEditSuc");

		return mav;
	}

	// 문의사항 글 삭제하기
	@GetMapping("/help/helpBoardDel")
	public ResponseEntity<String> helpBoardDel(int no, HttpSession session) {
		int member_no = (Integer) session.getAttribute("logNo");
		ResponseEntity<String> entity = null;

		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=utf-8");

		// 삭제
		int result = service.deleteView(no, member_no);
		if (result > 0) {
			String msg = "<script>alert('글이 삭제되었습니다.');";
			msg += "location.href='/board/help/helpBoardList';</script>";
			entity = new ResponseEntity<String>(msg, headers, HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>(failMsg(), headers, HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	public static String failMsg() {
		String msg = "<script>alret('글 삭제에 실패했습니다.');history.back();</script>";
		return msg;
	}
}