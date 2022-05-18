package com.team.culife.controller;

import java.io.File;
import java.nio.charset.Charset;
import java.security.Provider.Service;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import com.team.culife.vo.WorkVO;

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
		AuthorVO avo = authorService.authorNoSelect(memberNo);
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
	public ResponseEntity<String> authorWriteOk(AuthorVO vo, HttpServletRequest request, HttpSession session, String author){
		vo.setMember_no((Integer)request.getSession().getAttribute("logNo"));
		Integer memberNo = (Integer)session.getAttribute("logNo");
		
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("text", "html",Charset.forName("UTF-8")));
		authorService.authorSelectByName(author);
		String path = session.getServletContext().getRealPath("/upload/"+memberNo+"/author");
		System.out.println("path --> " +path);
		
		try {
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
							if(vo.getAuthor_thumbnail() != null) {
								File deleteFile = new File(path,vo.getAuthor_thumbnail());
								deleteFile.delete();
							}
							vo.setAuthor_thumbnail(newUploadFilename);
							newFile.transferTo(f);
							//작가 신청 등록 완료
							authorService.authorWrite(vo);
						} catch(Exception ee) {ee.printStackTrace();}
							
					}
			} // if newFile != null end
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
	@ResponseBody
	public ResponseEntity<String> exhibitionWriteOk(ExhibitionVO evo, String author, HttpServletRequest request, HttpSession session){
		ModelAndView mav = new ModelAndView();
		
		Integer memberNo = (Integer)session.getAttribute("logNo");
		AuthorVO avo = authorService.authorNoSelect(memberNo);
		evo.setAuthor_no(avo.getNo());
		Integer AuthorNO = avo.getNo();
		String msg = "";
		ResponseEntity<String> entity = null;
		
		try {
			ExhibitionVO Evo = exhibitionService.exhibitionSelectByEndDate(AuthorNO);
			System.out.println("Evo " + Evo);
			if(Evo != null) {
				System.out.println("evo --> " + Evo.getStart_date() + " " + Evo.getEnd_date());
				System.out.println(Evo);
				 msg = "<script>alert('이미 전시 등록 완료되었습니다.'); "
						+ "location.href='/online_exhibition/onlineList'</script>";
				entity = new ResponseEntity<String>(msg, HttpStatus.OK);
			}
			else {
			
				System.out.println("전시 등록 롼료");
				exhibitionService.exhibitionWrite(evo);
				 msg = "<script>alert('전시 등록 완료.'); "
						+ "location.href='/online_exhibition/onlineList'</script>";
				entity = new ResponseEntity<String>(msg, HttpStatus.OK);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return entity;
	}
	
	
	@GetMapping("workEdit")
	public ModelAndView workEdit(HttpSession session, ExhibitionVO vo) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("exhibition/workEdit");
		return mav;
	}
	@PostMapping("workCreateOk")
	public ResponseEntity<String> workCreateOk(HttpServletRequest request, HttpSession session, WorkVO wvo) {
		ModelAndView mav = new ModelAndView();
		ResponseEntity<String> entity = null;
		Integer memberNo = (Integer)session.getAttribute("logNo");
		String path = session.getServletContext().getRealPath("/upload/"+memberNo+"/author/exhibition/");
		System.out.println("wvo no --->" + wvo.getNo());
		
		try {
			AuthorVO avo = authorService.authorNoSelect(memberNo);
			ExhibitionVO evo = exhibitionService.exhibitionSelectByEndDate(avo.getNo());
			
				//작품 등록
				if(evo != null) {
					int workCount = exhibitionService.workSelectByExhibitionNo(evo.getNo()).size();
					path = path+evo.getNo();
					//작품이 5개 이상 등록이 되어있을때 
					if(workCount >=5) {
						System.out.println("workCount ---> " + workCount);
						//msg 작성
						return entity;
					}
					MultipartHttpServletRequest mr = (MultipartHttpServletRequest)request;
					MultipartFile newFile = (MultipartFile) mr.getFile("filename");
					
					wvo.setExhibition_no(evo.getNo());
					if(newFile != null) { //새로업로드된 파일이 있으면
						//String newUploadFilename = newFile.getOriginalFilename();
						String newUploadFilename = newFile.getOriginalFilename();
						System.out.println("ori-->" + newUploadFilename);
					
							if(newUploadFilename!=null && !newUploadFilename.equals("")) {
								newUploadFilename = wvo.getWork_thumbnail();
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
									if(wvo.getWork_thumbnail() != null) {
										File deleteFile = new File(path,wvo.getWork_thumbnail());
										deleteFile.delete();
									}
									
									
									//insert 해야할 부분
									//System.out.println("업로드 결과 ---> "+ memberService.memberUpdate(mvo));
									if(wvo.getNo() != null)
										exhibitionService.workUpdate(wvo);
									else {
										wvo.setWork_thumbnail(newUploadFilename);
										exhibitionService.workInsert(wvo);
									}
									
									newFile.transferTo(f);
								} catch(Exception ee) {ee.printStackTrace();}
									
							}
							else if(wvo.getNo() != null) {
								System.out.println("edit info --->"+wvo.getWork_content());
								exhibitionService.workUpdate(wvo);
							}
					} // if newFile != null
					
				}
		
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return entity;
	}
	
	@GetMapping("/exhibition/work/count")
	public ResponseEntity<HashMap<String, String>>workCount(HttpSession sesstion) {
		ResponseEntity<HashMap<String,String>> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		Integer MemberNo = (Integer)sesstion.getAttribute("logNo");
		try {
			result.put("status", "200");
			if(MemberNo != null) {
				Integer workCount = exhibitionService.workSelectByExhibitionNo(exhibitionService.exhibitionSelectByEndDate(authorService.authorNoSelect(MemberNo).getNo()).getNo()).size();
				result.put("count", Integer.toString(workCount));
				result.put("msg","최대 5개의 작품을 등록 할 수 있습니다.");
			}
			else {
				result.put("msg","로그인 후 이용해 주세요");
			}
			entity = new ResponseEntity<HashMap<String, String>>(result, HttpStatus.OK);
		}catch(Exception e) {
			result.put("status", "400");
			result.put("msg","전시를 먼저 등록해 주세요");
			e.printStackTrace();
			entity = new ResponseEntity<HashMap<String, String>>(result, HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		
	}
}
