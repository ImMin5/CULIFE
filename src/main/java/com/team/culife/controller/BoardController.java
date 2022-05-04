package com.team.culife.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.team.culife.service.BoardService;
import com.team.culife.vo.BoardVO;
import com.team.culife.vo.PagingVO;


@RequestMapping("/board/")
@RestController
public class BoardController {
	
	@Inject
	BoardService service;
	
	ModelAndView mav = new ModelAndView();
	ResponseEntity<String> entity = null;

	// 자유게시판 리스트
	@GetMapping("freeBoardList")
	public ModelAndView freeListForm(PagingVO pvo, BoardVO vo, HttpSession session) {
		
		vo.setCategory("free");
		
		// 게시판 글 DB연결해서 보이기
		mav.addObject("list", service.selectList(pvo, vo));
	
		mav.addObject("pvo", pvo);
		mav.setViewName("board/freeBoardList");
		
		return  mav;
	}
}
/*	
	// 자유 글등록 폼
	@GetMapping("freeBoardWrite")
	public ModelAndView freeBoardWrite() {
		mav.setViewName("board/freeBoardWrite");
		return mav;
	}
	
	// 자유 글등록 DB연결
	@PostMapping("freeBoardWriteOk")
	public ModelAndView freeWriteOk(BoardVO vo, HttpServletRequest request){
		// 현재 session에 있는 ID와 카테고리
		vo.setUserid((String)request.getSession().getAttribute("logId")); 
		vo.setNickname((String)request.getSession().getAttribute("nickName")); 
		vo.setCategory("free");
		
		mav.addObject("vo", vo);
		mav.setViewName("board/boardWriteSuc");
		return mav;
	}
	
	// 자유게시판 뷰(상세페이지)
	@GetMapping("freeBoardView")
	public ModelAndView freeView(int no, String userid, HttpSession session) {

		// 조회수 증가
		service.updateViews(no);
		
		// 상세페이지 보이기(뷰 보이기)
		mav.addObject("viewVo", service.selectView(no));
		mav.setViewName("board/freeBoardView");
		
	}
	
	// 자유게시판 글 수정 폼
	@GetMapping("freeBoardEdit")
	public ModelAndView freeEdit(int no) {
		BoardVO bvo = service.selectEditView(no);

		mav.addObject("totalFile", totalFile); // 갯수 계산할 때 사용
		mav.addObject("bvo", bvo);
		mav.setViewName("board/freeBoardEdit");
		return mav;
	}
	
	// 자유게시판 글 수정 DB연결
	@PostMapping("freeBoardEditOk")
	public ModelAndView freeEditOk(BoardVO vo, HttpServletRequest request){
		vo.setUserid((String)request.getSession().getAttribute("logId"));
		vo.setCategory("free");
		
		try{
			// DB에서 파일명 가져오기
			BoardVO fileVO = service.getFileName(vo.getNo());
			}
			// rename하고 기존 파일 수정하기
			RelateUploadFile.fileRenameAndUpdate(vo, path, fileList, newFileList, request);
			// DB 업데이트
			int cnt = service.updateEditView(vo);

			mav.addObject("cnt", cnt);
			mav.addObject("vo", vo);
			mav.setViewName("board/boardEditSuc");
		}catch(Exception e) {
			e.printStackTrace();
			// DB수정 실패(새로 올라간 파일 삭제)
			for(String fname:newFileList) {
				RelateUploadFile.fileDelete(path, fname);
			}
		}
		return mav;
	}
	
	// 자유 글 삭제하기
	@GetMapping("freeBoardDel")
	public ResponseEntity<String> freeBoardDel(int no, HttpSession session) {
		String userid = (String)session.getAttribute("logId");
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=utf-8");
		
		try {
			// 삭제
			int result = service.deleteView(no, userid);
			
			if(result>0) {
				String msg ="<script>alert('글이 삭제되었습니다.');";
				msg +="location.href='/board/freeBoardList';</script>";
				entity = new ResponseEntity<String>(msg, headers, HttpStatus.OK);
			}else {
				entity = new ResponseEntity<String>(failMsg(), headers, HttpStatus.BAD_REQUEST);
			}

		}catch(Exception e) {
			e.printStackTrace();
		}
		return entity;
	}
====자유게시판===





	// 요청 게시판 리스트
	@GetMapping("reqBoardList")
	public ModelAndView reqListForm(PagingVO pvo, BoardVO vo, String keyword, HttpSession session) {
		
		vo.setCategory("req");
		vo.setSmall((String)session.getAttribute("addrSmall"));
		
		// 게시판 글 DB연결해서 보이기
		pvo.setTotalRecord(service.selectTotalRecord(pvo, vo, keyword));
		mav.addObject("list", service.selectList(pvo, vo, keyword));
	
		mav.addObject("pvo", pvo);
		mav.setViewName("board/reqBoardList");
		
		return  mav;
	}
	
	// 요청 글 등록 폼
	@GetMapping("reqBoardWrite")
	public ModelAndView reqBoardWrite() {
		mav.setViewName("board/reqBoardWrite");
		return mav;
	}
	
	// 요청 글 등록 DB연결
	@PostMapping("reqBoardWriteOk")
	public ModelAndView reqWriteOk(BoardVO vo, HttpServletRequest request){
		// 현재 session에 있는 ID와 카테고리
		vo.setUserid((String)request.getSession().getAttribute("logId")); 
		vo.setNickname((String)request.getSession().getAttribute("nickName")); 
		vo.setCategory("req");
		
		// 파일을 업로드할 폴더 절대경로
		String path = request.getSession().getServletContext().getRealPath("/upload");
		try { 
			// 파일 업로드 성공
			RelateUploadFile.fileRenameAndUpload(vo, path, request);
			// 업로드 성공(DB에 레코드 등록)
			int cnt = service.boardInsert(vo);
			mav.addObject("cnt", cnt);
		} catch(Exception e) {
			e.printStackTrace();
			// 데이터가 DB에 정상적으로 들어가지 않았다면 이미 업로드한 파일은 upload 폴더에 들어갔기 때문에 삭제해야 한다.
			// 삭제할 파일명은 vo안에 있고, fileDelete 메서드를 이용해서 삭제
			RelateUploadFile.fileDelete(path, vo.getImg1());
			RelateUploadFile.fileDelete(path, vo.getImg2());
			RelateUploadFile.fileDelete(path, vo.getImg3());
			RelateUploadFile.fileDelete(path, vo.getImg4());
		}
		
		mav.addObject("vo", vo);
		mav.setViewName("board/boardWriteSuc");
		return mav;
	}
	
	// 요청 상세페이지 뷰
	@GetMapping("reqBoardView")
	public ModelAndView reqView(int no, String userid, HttpSession session) {
		
		// 조회수 증가
		service.updateViews(no);
		
		// 상세페이지 보이기(뷰 보이기)
		mav.addObject("viewVo", service.selectView(no));
		mav.setViewName("board/reqBoardView");
		// 이미 글에 찜한 유저 구하기
		mav.addObject("alrPick", service.selectAlreadyPick(no, (String)session.getAttribute("logId")));
		return mav;
	}

    // 요청 글 수정 폼
	@GetMapping("reqBoardEdit")
	public ModelAndView reqEdit(int no) {
		BoardVO bvo = service.selectEditView(no);
		// DB에 있는 첨부파일 수 구하기(새로 변경한 파일이 생기면 --해줘야 하기 때문)
		int totalFile = 0;
		
		if(bvo!=null) { 
			if(bvo.getImg1()!=null || bvo.getImg1()!=""){// 첨부파일 있으면 증가
				totalFile++;
				if(bvo.getImg2()!=null || bvo.getImg2()!="") {
					totalFile++;
					if(bvo.getImg3()!=null || bvo.getImg3()!="") {
						totalFile++;
						if(bvo.getImg4()!=null || bvo.getImg4()!="") {
							totalFile++;
						}
					}
				}
			}
		}
		mav.addObject("totalFile", totalFile); // 갯수 계산할 때 사용
		mav.addObject("bvo", bvo);
		mav.setViewName("board/reqBoardEdit");
		return mav;
	}
	
	// 요청 글 수정 DB연결
	@PostMapping("reqBoardEditOk")
	public ModelAndView reqEditOk(BoardVO vo, HttpServletRequest request){
		vo.setUserid((String)request.getSession().getAttribute("logId"));
		vo.setCategory("req");
		
		// 파일을 수정하기 위해서 경로
		String path = request.getSession().getServletContext().getRealPath("/upload");

		// DB에 업데이트할 파일명을 넣는 리스트
		List<String> fileList = new ArrayList<String>();
		// 새로 업로드할 파일 리스트
		List<String> newFileList = new ArrayList<String>();
		
		try{
			// DB에서 파일명 가져오기
			BoardVO fileVO = service.getFileName(vo.getNo());
			
			// DB 리스트에 기존 파일명 넣기
			if(fileVO!=null) {
				if(fileVO.getImg1()!=null && fileVO.getImg1()!="") {
					fileVO = service.getFileName(vo.getNo());
					fileList.add(fileVO.getImg1());
				}
				if(fileVO.getImg2()!=null && fileVO.getImg2()!="") {
					fileList.add(fileVO.getImg2());
				}
				if(fileVO.getImg3()!=null && fileVO.getImg3()!="") {
					fileList.add(fileVO.getImg3());
				}
				if(fileVO.getImg4()!=null && fileVO.getImg4()!="") {
					fileList.add(fileVO.getImg4());
				}
			}
			// 삭제된 파일이 있으면(사용자가 x버튼을 누르면) List에서 deleteFile[]과 같은 파일명을 지운다.
			if(vo.getDeleteFile()!= null) { // deleteFile[]안에 파일이 있는 경우
				for (String deleteFile : vo.getDeleteFile()) {
					fileList.remove(deleteFile);
				}
			}
			// rename하고 기존 파일 수정하기
			RelateUploadFile.fileRenameAndUpdate(vo, path, fileList, newFileList, request);
			// DB 업데이트
			int cnt = service.updateEditView(vo);
			
			// DB 수정 성공 뒤
			if(vo.getDeleteFile()!=null) { // deFile에 있는것들은 지우기
				for(String fname:vo.getDeleteFile()) {
					RelateUploadFile.fileDelete(path, fname);
				}
			}
			mav.addObject("cnt", cnt);
			mav.addObject("vo", vo);
			mav.setViewName("board/boardEditSuc");
		}catch(Exception e) {
			e.printStackTrace();
			// DB수정 실패(새로 올라간 파일 삭제)
			for(String fname:newFileList) {
				RelateUploadFile.fileDelete(path, fname);
			}
		}
		return mav;
	}
	
	// 요청 글 삭제하기
	@GetMapping("reqBoardDel")
	public ResponseEntity<String> reqBoardDel(int no, HttpSession session) {
		String userid = (String)session.getAttribute("logId");
		
		// upload 폴더 경로(삭제 위해)
		String path = session.getServletContext().getRealPath("/upload");

		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=utf-8");
		
		try {
			// 삭제하기 위한 레코드의 파일명
			BoardVO fileVO = service.getFileName(no);
			// 삭제
			int result = service.deleteView(no, userid);
			
			if(result>0) {
				
				if(fileVO!=null) {
					// 삭제 성공하면 파일도 삭제
					RelateUploadFile.fileDelete(path, fileVO.getImg1());
					RelateUploadFile.fileDelete(path, fileVO.getImg2());
					RelateUploadFile.fileDelete(path, fileVO.getImg3());
					RelateUploadFile.fileDelete(path, fileVO.getImg4());
				}
				
				String msg ="<script>alert('글이 삭제되었습니다.');";
				msg +="location.href='/board/reqBoardList';</script>";
				entity = new ResponseEntity<String>(msg, headers, HttpStatus.OK);
			}else {
				entity = new ResponseEntity<String>(failMsg(), headers, HttpStatus.BAD_REQUEST);
			}

		}catch(Exception e) {
			e.printStackTrace();
		}
		return entity;
	}

	public static String failMsg() {
		String msg = "<script>alret('글 삭제에 실패했습니다.');history.back();</script>";
		return msg;
	}
}*/