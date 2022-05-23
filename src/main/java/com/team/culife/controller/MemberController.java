package com.team.culife.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
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

import com.team.culife.service.AlertService;
import com.team.culife.service.AuthorService;
import com.team.culife.service.BoardService;
import com.team.culife.service.ExhibitionReviewService;
import com.team.culife.service.ExhibitionService;
import com.team.culife.service.FileService;
import com.team.culife.service.LoginService;
import com.team.culife.service.MemberService;
import com.team.culife.service.MovieService;
import com.team.culife.service.ReviewService;
import com.team.culife.vo.AlertVO;
import com.team.culife.vo.AuthorFanVO;
import com.team.culife.vo.AuthorVO;
import com.team.culife.vo.BoardVO;
import com.team.culife.vo.ExhibitionReviewVO;
import com.team.culife.vo.ExhibitionVO;
import com.team.culife.vo.MemberVO;
import com.team.culife.vo.MovieVO;
import com.team.culife.vo.PageResponseBody;
import com.team.culife.vo.PagingVO;
import com.team.culife.vo.ReviewVO;

@RestController
public class MemberController {
	@Inject
	LoginService loginService;
	
	@Inject
	MemberService memberService;
	
	@Inject
	AuthorService authorService;
	
	@Inject
	MovieService movieService;
	
	@Inject
	ReviewService reviewService;
	
	@Inject
	BoardService boardService;
	
	@Inject
	AlertService alertService;

	@Inject
	ExhibitionReviewService exhibitionReviewService;
	
	@Inject
	FileService fileService;
	
	@Inject
	ExhibitionService exhibitionService;
	
	@Value("${prefix-path}")
	private String prefixPath;
	
	@Value("${logout-path}")
	private String logoutUri;
	
	//마이페이지 - 내정보 뷰
	@GetMapping("/mypage/member")
	public ModelAndView mypage(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Integer memberNo = (Integer)session.getAttribute("logNo");
		try {
			
			if(memberNo != null ) {
				MemberVO mvo = memberService.memberSelectByNo(memberNo);
				session.setAttribute("grade",mvo.getGrade());
				mav.addObject("alertList",alertService.alertSelectByMemberNo(memberNo));
				mav.addObject("mvo", mvo);
				mav.addObject("logoutUri",logoutUri);
				mav.setViewName("mypage/mypage");
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
	//마이페이지 - 팔로잉 작가
	@GetMapping("/mypage/fan")
	public ModelAndView mypageFan(HttpSession session,  @RequestParam(value="pageNo",required = false, defaultValue = "1")int pageNo,
			@RequestParam(value="pageCount",required = false, defaultValue = "10")int pageCount, 
			@RequestParam(value="searchWord",required = false, defaultValue = "")String searchWord) {
		Integer memberNo = (Integer)session.getAttribute("logNo");
		ModelAndView mav = new ModelAndView();
		
		try {
			if(memberNo == null) {
				mav.setViewName("redirect:/");
			}
			else {
				mav.addObject("logoutUri",logoutUri);
				mav.setViewName("mypage/my_fan");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	//마이페이지 - 작가 정보 뷰 
	@GetMapping("/mypage/author")
	public ModelAndView mypageAuthor(HttpSession session, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Integer memberNo = (Integer)session.getAttribute("logNo");
		
		try {	
			if(memberNo == null) {
				mav.setViewName("redirect:/");
			}
			else {
				//작가 정보 넣기
				MemberVO mvo = memberService.memberSelectByNo(memberNo);
				AuthorVO avo = authorService.authorNoSelect(mvo.getNo());
				mav.addObject("mvo", mvo);
				mav.addObject("avo", avo);
				mav.addObject("logoutUri",logoutUri);
				mav.setViewName("mypage/my_author");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			mav.setViewName("redirect:/");
		}
		
		return mav;
		
	}
	
	//마이페이지 - 영화 리뷰 뷰
	@GetMapping("/mypage/review/movie")
	public ModelAndView mypageReviewMovie(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Integer memberNo = (Integer)session.getAttribute("logNo");
		try {
			if(memberNo == null) {
				mav.setViewName("redirect:/");
			}
			else {
				mav.addObject("logoutUri",logoutUri);
				mav.addObject("mvo", memberService.memberSelectByNo(memberNo));
				mav.setViewName("mypage/my_movie");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			mav.setViewName("redirect:/");
		}
		
		return mav;
	}
	
	//마이페이지 -연극.뮤지컬 리뷰 뷰
	@GetMapping("/mypage/review/theater")
	public ModelAndView mypageReviewTheater(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Integer memberNo = (Integer)session.getAttribute("logNo");
		try {
			if(memberNo == null) {
				mav.setViewName("redirect:/");
			}
			else {
				mav.addObject("logoutUri",logoutUri);
				mav.addObject("mvo", memberService.memberSelectByNo(memberNo));
				mav.setViewName("mypage/my_theater");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			mav.setViewName("redirect:/");
		}
		
		return mav;
	}
	
	//마이페이지 - 작성글
	@GetMapping("/mypage/board")
	public ModelAndView mypageBoard(HttpSession session, @RequestParam(value="category", required=false, defaultValue="free")String category,
			@RequestParam(value="pageNo", required=false, defaultValue="1") int currentPage,
			@RequestParam(value="pageCount", required=false, defaultValue="10") int pageCount,
			@RequestParam(value="searchWord", required=false) String searchWord) {
			ModelAndView mav = new ModelAndView();
			Integer memberNo = (Integer)session.getAttribute("logNo");
			
			try {
				if(memberNo == null) {
					mav.setViewName("redirect:/");
				}
				else {
					PagingVO pvo = new PagingVO();
					// 전체 리스트 업데이트
					pvo.setRecordPerPage(pageCount);
					pvo.setCurrentPage(currentPage);
					pvo.setMember_no(memberNo);
					pvo.setCategory(category);
					if(searchWord != null)pvo.setSearchWord(searchWord);
					pvo.setTotalRecord(boardService.boardTotalRecord(pvo));
					if(pvo.getTotalPage() >0  && pvo.getTotalPage() < currentPage) {
						pvo.setCurrentPage(pvo.getTotalPage());
						pvo.setTotalRecord(boardService.boardTotalRecord(pvo));
					}
					
					List<BoardVO> list = boardService.boardSelectByMemberNo(pvo);
					mav.addObject("boardList", list);
					mav.addObject("pvo", pvo);
					mav.addObject("logoutUri",logoutUri);
					mav.setViewName("mypage/my_board");
					
				}
				
			}catch(Exception e) {
				e.printStackTrace();
				mav.setViewName("redirect:/");
			}
			
		return mav;
	}
		
	//마이페이지 감상평
	@GetMapping("/mypage/review")
	public ModelAndView mypageReview(HttpSession session, 
			@RequestParam(value="pageNo", required=false, defaultValue="1") int currentPage,
			@RequestParam(value="pageCount", required=false, defaultValue="10") int pageCount,
			@RequestParam(value="searchWord", required=false) String searchWord) {
		ModelAndView mav = new ModelAndView();
		Integer memberNo = (Integer)session.getAttribute("logNo");
		try {
			if(memberNo == null) {
				mav.setViewName("redirect:/");
			}
			else {
				PagingVO pvo = new PagingVO();
				// 전체 리스트 업데이트
				pvo.setRecordPerPage(pageCount);
				pvo.setCurrentPage(currentPage);
				pvo.setMember_no(memberNo);
				if(searchWord != null)pvo.setSearchWord(searchWord);
				pvo.setTotalRecord(exhibitionReviewService.exhibitionReviewTotalRecord(pvo));
				if(pvo.getTotalPage() >0  &&  pvo.getTotalPage() < currentPage) {
					pvo.setCurrentPage(pvo.getTotalPage());
					pvo.setTotalRecord(exhibitionReviewService.exhibitionReviewTotalRecord(pvo));
				}
				
				List<ExhibitionReviewVO> list = exhibitionReviewService.exhibitionReviewSelectByMemberNo(pvo);
				mav.addObject("reviewList", list);
				mav.addObject("pvo", pvo);
				mav.addObject("logoutUri",logoutUri);
				mav.setViewName("mypage/my_review");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	//마이페이지 - 나의 전시회
	@GetMapping("/mypage/exhibition")
	public ModelAndView myExhibition(HttpSession session, @RequestParam(value="currentPage",required = false, defaultValue = "1")int currentPage,
			@RequestParam(value="searchWord",required = false)String searchWord) {
		ModelAndView mav = new ModelAndView();
		Integer memberNo = (Integer)session.getAttribute("logNo");
		try {
			if(memberNo != null) {
				AuthorVO avo = authorService.authorNoSelect(memberNo);
				PagingVO pvo = new PagingVO();
				pvo.setRecordPerPage(6);
				pvo.setMember_no(avo.getNo());
				pvo.setCurrentPage(currentPage);
				if(searchWord != null) pvo.setSearchWord(searchWord);
				pvo.setTotalRecord(exhibitionService.exhibitionTotalRecordAuthor(pvo));
				List<ExhibitionVO> exhibitionList = exhibitionService.exhibitionSelectByAuthorNo(pvo);
			
				mav.addObject("pvo", pvo);
				mav.addObject("exhibitionList", exhibitionList);
				mav.setViewName("mypage/my_exhibition");
			}
			else {
				mav.setViewName("redirect:/");
			}
		}catch(Exception e){
			e.printStackTrace();
			mav.setViewName("redirect:/");
		}
		return mav;
	}
	
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
	@PostMapping("/upload/mypage/member/thumbnail")
	public ResponseEntity<HashMap<String,String>> memberThumbnailEdit(MemberVO mvo, @RequestParam("file") MultipartFile newFile ,HttpSession session){
		ResponseEntity<HashMap<String,String>> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		Integer memberNo = (Integer)session.getAttribute("logNo");
		//String path = "/home/ubuntu/culife/upload/"+ memberNo+"/thumbnail/";
		//String path = "/upload/"+ memberNo+"/thumbnail/";
		String path = prefixPath + memberNo+"/thumbnail/";
		try {
			result.put("status", "200");
			if(memberNo != null) {
				if(newFile != null) { //새로업로드된 파일이 있으면
					String newUploadFilename = newFile.getOriginalFilename();	
						if(newUploadFilename!=null && !newUploadFilename.equals("")) {
							File f = new File(path);
							//폴더가 존재하지 않을 경우 폴더 생성
							if(!f.exists()) {
								try {
									//새로 경로를 만듬 성공하면 true
									f.mkdirs();
									//Runtime.getRuntime().exec("chmod 777 -R " + path);
									
								}catch(Exception e) {
									result.put("msg","파일경로 생성오류 " + path);
									e.printStackTrace();
								}
							}
							// 업로드
							try {
								//기존에 있던 썸네일 파일 삭제
								
								mvo = memberService.memberSelectByNo(memberNo);
								if(mvo.getThumbnail() != null) {
									//파일 삭제
									fileService.deleteImageFile(mvo.getThumbnail(), path);
								}
								//DB 업데이트
								mvo.setThumbnail(newUploadFilename);
								memberService.memberUpdate(mvo);
								//파일 업로드
								result.put("msg", "프로필 수정 완료.");
								System.out.println("파일 업록드 결과 "+fileService.uploadImage(newFile, path));
							} catch(Exception ee) {
								result.put("msg" , "파일 업로드 오류 " + path);
								ee.printStackTrace();
							}
								
						}
				} // if newFile != null
			}
			else {
				result.put("msg","로그인 후 이용해 주세요");
			}
			
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
		String rootPath = prefixPath+memberNo;
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
	
	//회원 가입
	@PostMapping("/member")
	public ResponseEntity<HashMap<String,String>> adminSignup(MemberVO mvo , HttpSession session){
		ResponseEntity<HashMap<String,String>> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
				
		try {
			memberService.memberInsert(mvo);
			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);
		}
					
		return entity;
	}
	
	//작가 팔로우 요청
	@PostMapping("/author/follow")
	public ResponseEntity<HashMap<String,String>> authorFlow(HttpSession session, String author){

		ResponseEntity<HashMap<String,String>> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		Integer memberNo = (Integer)session.getAttribute("logNo");
		try {
			result.put("status", "200");
			//로그인 확인
			if(memberNo == null) {
				result.put("status","201");
				result.put("msg", "로그인 후 이용해 주세요.");
			}
			else {
				AuthorVO avo = authorService.authorSelectByName(author);
				if(avo != null) {
					if(avo.getMember_no() == memberNo) {
						result.put("status","201");
						result.put("msg", "본인을 팔로우 할 수 없습니다.");
					}
					else if(memberService.authorFanCheck(avo.getNo(), memberNo) != null) {
						result.put("status","201");
						result.put("msg", "이미 팔로우 하고 있습니다.");
					}
					else {
						//팔로잉
						AuthorFanVO afvo = new AuthorFanVO();
						afvo.setAuthor_no(avo.getNo());
						afvo.setMember_no(memberNo);
						memberService.authorFanInsert(afvo);
						result.put("mgs", "팔로우 성공");
					}
				}
				else {
					//탈퇴했는데 세션에 값이 남아있을 경우
					result.put("status","201");
					result.put("msg", "회원가입 후 이용해 주세요.");
				}
			}
			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			
			result.put("status", "400");
			result.put("msg", "팔로잉 에러...관리자에게 문의해 주세요.");
			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//작가 팔로우 취소
	@DeleteMapping("/author/follow")
	public ResponseEntity<HashMap<String,String>> authorFlowDelete(HttpSession session, String author){
		ResponseEntity<HashMap<String,String>> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		Integer memberNo = (Integer)session.getAttribute("logNo");
		
		try {
			result.put("status", "200");
			//로그인 확인
			if(memberNo == null) {
				result.put("msg", "로그인 후 이용해 주세요.");
			}
			else {
				AuthorVO avo = authorService.authorSelectByName(author);
				//팔로일 하고 있는 지 확인
				if(avo != null && memberService.authorFanCheck(avo.getNo(), memberNo)!= null) {
					//팔로잉
					memberService.authorFanDelete(avo.getNo(), memberNo);
					result.put("mgs", "언팔로우 성공");
				}
				else {
					result.put("msg", "팔로우 하고 있지 않은 작가입니다.");
				}
			}
			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			
			result.put("status", "400");
			result.put("msg", "팔로우 취소 에러...관리자에게 문의해 주세요.");
			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	//마이페이지 - 팔로잉 작가 검색
	@GetMapping("/mypage/fan/search")
	public PageResponseBody<AuthorVO> mypageFanSearch(HttpSession session,  @RequestParam(value="pageNo",required = false, defaultValue = "1")int pageNo,
				@RequestParam(value="pageCount",required = false, defaultValue = "6")int pageCount, 
				@RequestParam(value="searchWord",required = false, defaultValue = "")String searchWord) {
		Integer memberNo = (Integer)session.getAttribute("logNo");
		PageResponseBody<AuthorVO> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		try {
			if (memberNo == null) {
				result.put("msg", "로그인 후 이용해 주세요");
				result.put("redirect", "/");
			} else {
				PagingVO pvo = new PagingVO();
				// 전체 리스트 업데이트
				pvo.setRecordPerPage(pageCount);
				pvo.setCurrentPage(pageNo);
				pvo.setMember_no(memberNo);
				if(searchWord != null) pvo.setSearchWord(searchWord);
				pvo.setTotalRecord(memberService.authorFanTotalRecord(pvo));
				
				List<AuthorVO> list = memberService.authorFanSelectAll(pvo);
				
				entity = new PageResponseBody<AuthorVO>();
				entity.setItems(list);
				entity.setVo(pvo);
			}

		} catch (Exception e) {
			e.printStackTrace();
			entity = new PageResponseBody<AuthorVO>();

		}
		return entity;
	}
	
	//작가 정보 수정
	@PostMapping("/upload/mypage/author/info")
	public ResponseEntity<HashMap<String,String>> authorThumbnailEdit(AuthorVO avo,  @RequestParam("file") MultipartFile newFile ,HttpSession session){
		ResponseEntity<HashMap<String,String>> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		Integer memberNo = (Integer)session.getAttribute("logNo");
		String path =prefixPath+memberNo+"/author/";
		
		try {
			result.put("status", "200");
			if(memberNo != null) {
				if(newFile != null) { //새로업로드된 파일이 있으면
					String newUploadFilename = newFile.getOriginalFilename();	
						if(newUploadFilename!=null && !newUploadFilename.equals("")) {
							File f = new File(path);
							//폴더가 존재하지 않을 경우 폴더 생성
							if(!f.exists()) {
								try {
									System.out.println(f.mkdirs());
								}catch(Exception e) {e.printStackTrace();}
							}

							// 업로드
							try {
								//기존에 있던 썸네일 파일 삭제
								String oriFile = authorService.authorSelectByName(avo.getAuthor()).getAuthor_thumbnail();
								if(oriFile != null) {
									fileService.deleteImageFile(oriFile, path);
									//File deleteFile = new File(path,oriFile);
									//deleteFile.delete();
								}
								avo.setAuthor_thumbnail(newUploadFilename);
								
								fileService.uploadImage(newFile, path);
								//newFile.transferTo(f);
							} catch(Exception ee) {ee.printStackTrace();}
								
						}
				} // if newFile != null
				System.out.println("업로드 결과 ---> "+ authorService.authorUpdate(avo));
				result.put("msg","정보 수정 완료!");
			}
			else {
				result.put("msg","로그인 후 이용해 주세요");
			}
			
			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			result.put("status","400");
			result.put("msg", "회원정보 업데이트 에러...");
			entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	//영화 리뷰 검색
	@GetMapping("/mypage/review/movie/search")
	public PageResponseBody<MovieVO> mypageMovieSearch(HttpSession session,  @RequestParam(value="pageNo",required = false, defaultValue = "1")int pageNo,
			@RequestParam(value="pageCount",required = false, defaultValue = "8")int pageCount, 
			@RequestParam(value="searchWord",required = false, defaultValue = "")String searchWord) {
		Integer memberNo = (Integer)session.getAttribute("logNo");
		PageResponseBody<MovieVO> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		
		try {
			if (memberNo == null) {
				result.put("msg", "로그인 후 이용해 주세요");
				result.put("redirect", "/");
			} else {
				PagingVO pvo = new PagingVO();
				// 전체 리스트 업데이트
				pvo.setRecordPerPage(pageCount);
				pvo.setCurrentPage(pageNo);
				pvo.setMember_no(memberNo);
				if(searchWord != null)pvo.setSearchWord(searchWord);
				pvo.setTotalRecord(movieService.movieReviewTotalRecord(pvo));
				
				List<MovieVO> list = movieService.movieReviewSelectByMemberNo(pvo);
				
				entity = new PageResponseBody<MovieVO>();
				entity.setItems(list);
				entity.setVo(pvo);
			}
	
			} catch (Exception e) {
				e.printStackTrace();
				entity = new PageResponseBody<MovieVO>();
		
			}
		return entity;
	}
	//뮤지컬/연극 검색
	@GetMapping("/mypage/review/theater/search")
	public PageResponseBody<ReviewVO> mypageTheaterSearch(HttpSession session,  @RequestParam(value="pageNo",required = false, defaultValue = "1")int pageNo,
			@RequestParam(value="pageCount",required = false, defaultValue = "8")int pageCount, 
			@RequestParam(value="searchWord",required = false, defaultValue = "")String searchWord) {
		Integer memberNo = (Integer)session.getAttribute("logNo");
		PageResponseBody<ReviewVO> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		
		try {
			if (memberNo == null) {
				result.put("msg", "로그인 후 이용해 주세요");
				result.put("redirect", "/");
			} else {
				PagingVO pvo = new PagingVO();
				// 전체 리스트 업데이트
				pvo.setRecordPerPage(pageCount);
				pvo.setCurrentPage(pageNo);
				pvo.setMember_no(memberNo);
				if(searchWord != null)pvo.setSearchWord(searchWord);
				pvo.setTotalRecord(reviewService.theaterReviewTotalRecord(pvo));
				List<ReviewVO> list = reviewService.theaterReviewSelectByMemberNo(pvo);
				entity = new PageResponseBody<ReviewVO>();
				entity.setItems(list);
				entity.setVo(pvo);
			}
		
			} catch (Exception e) {
				e.printStackTrace();
				entity = new PageResponseBody<ReviewVO>();
			
			}
			return entity;
		}
	
	//알림 가져오기 
		@GetMapping("/mypage/alert")
		public PageResponseBody<AlertVO> getMyAlert(HttpSession session){
			PageResponseBody<AlertVO> entity = new PageResponseBody<AlertVO>();
			HashMap<String,String> result = new HashMap<String,String>();
			Integer memberNo = (Integer)session.getAttribute("logNo");
			
			try {
				result.put("status","200");
				if(memberNo != null) {
					result.put("msg","알림 불러오기 성공.");
					result.put("redirect","/");
					entity.setItems(alertService.alertSelectByMemberNo(memberNo));
					entity.setMsg(result);
				}
				else {
					result.put("msg","로그인 후 이용해 주세요.");
					entity.setMsg(result);
				}
				
			}catch(Exception e) {
				result.put("status","400");
				result.put("msg","알림 서비스 Error... 관리자에게 문의하세요.");
				entity.setMsg(result);
				e.printStackTrace();
			}
			
			return entity;
			
		}
		
		//업로드 테스트
		@PostMapping("/upload/img")
		public String uploadImage(@RequestParam("file") MultipartFile imageFile) {
			try {
				String path = "/upload/";
				fileService.uploadImage(imageFile, path);
			}catch(Exception e) {
				e.printStackTrace();
			}
			return "ok";
		}
		
		//나의 팔로워 숫자 
		@GetMapping("api/authorfan/follow")
		public ResponseEntity<HashMap<String,String>> getFollower(int author_no){
			ResponseEntity<HashMap<String,String>> entity = null;
			HashMap<String,String> result = new HashMap<String,String>();
			try {
				int count = memberService.authorFanSelectByAuthorNo(author_no);
				result.put("status","200");
				result.put("count",Integer.toString(count));
				entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.OK);
			}catch(Exception e) {
				e.printStackTrace();
				result.put("status","200");
				result.put("count","0");
				entity = new ResponseEntity<HashMap<String,String>>(result, HttpStatus.BAD_REQUEST);
			}
			
			return entity;
		}
}
