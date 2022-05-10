package com.team.culife.controller;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.team.culife.service.BoardService;
import com.team.culife.vo.PagingVO;

@RestController
@RequestMapping("/board/")
public class BoardController {
	@Inject
	BoardService service;
	
	ModelAndView mav = new ModelAndView();
	
	//자유게시판
	@GetMapping("freeBoardList")
	public ModelAndView freeboardList(PagingVO pVO) {
		mav.setViewName("/board/freeBoardList");
		return mav;
	}
	//자유게시판 게시글 등록 폼
	@GetMapping("freeBoardWrite")
	public ModelAndView freeBoardWrite() {
		mav.setViewName("board/freeBoardWrite");
		return mav;
	}
	//문의사항게시판
	@GetMapping("helpBoardList")
	public ModelAndView helpboardList(PagingVO pVO) {		
		mav.setViewName("/board/helpBoardList");
		return mav;	
	}
	//문의사항 게시글 등록 폼
	@GetMapping("helpBoardWrite")
	public ModelAndView helpBoardWrite() {
		mav.setViewName("board/helpBoardWrite");
		return mav;
	}
}