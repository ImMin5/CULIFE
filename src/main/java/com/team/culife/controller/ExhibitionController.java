package com.team.culife.controller;

import java.io.File;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.team.culife.service.AlertService;
import com.team.culife.service.AuthorService;
import com.team.culife.service.ExhibitionService;
import com.team.culife.service.FileService;
import com.team.culife.service.MemberService;
import com.team.culife.vo.AuthorVO;
import com.team.culife.vo.ExhibitionVO;
import com.team.culife.vo.ExhibitionWorkVO;
import com.team.culife.vo.MemberVO;
import com.team.culife.vo.PageResponseBody;
import com.team.culife.vo.WorkVO;

@RestController
public class ExhibitionController {
	@Inject
	MemberService memberService;
	@Inject
	ExhibitionService exhibitionService;
	@Inject
	AuthorService authorService;
	@Inject
	FileService fileService;
	@Inject
	AlertService alertService;
	
	@Value("${prefix-path}")
	private String prefixPath;
	
	@Value("${resource-path}")
	private String resourcePath;
	
	@GetMapping("mypage/authorWrite")
	public ModelAndView authorWrite(HttpSession session, HttpServletRequest request, AuthorVO vo, String author) {
		ModelAndView mav = new ModelAndView();
		vo.setMember_no((Integer)request.getSession().getAttribute("logNo"));
		Integer memberNo = (Integer)session.getAttribute("logNo");
		MemberVO mvo = memberService.memberSelectByNo(memberNo);
		AuthorVO avo = authorService.authorNoSelect(memberNo);
		session.setAttribute("grade",mvo.getGrade());	
		mav.addObject("mvo", mvo);
		mav.addObject("avo", avo);
		
		if(mvo.getGrade() == 1) {
			mav.setViewName("mypage/my_author");
		}
		mav.setViewName("exhibition/authorWrite");
		return mav;
	}
	// ????????????
	@PostMapping("/upload/authorWriteOk")
	@ResponseBody
	public ResponseEntity<String> authorWriteOk(AuthorVO vo, @RequestParam("file") MultipartFile newFile, HttpSession session, String author){
		vo.setMember_no((Integer)session.getAttribute("logNo"));
		Integer memberNo = (Integer)session.getAttribute("logNo");
		
		
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("text", "html",Charset.forName("UTF-8")));
		authorService.authorSelectByName(author);
		String path = prefixPath+memberNo+"/author/";
		System.out.println("path --> " +path);
		
		//System.out.println("Author_status()"+avo.getAuthor_status());
		try {
			AuthorVO avo = authorService.authorNoSelect(memberNo);
			if(avo == null) {
				System.out.println("????????????");
				
				
				
				if(newFile != null) { //?????????????????? ????????? ?????????
					String newUploadFilename = newFile.getOriginalFilename();	
						if(newUploadFilename!=null && !newUploadFilename.equals("")) {
							File f = new File(path);
							//????????? ???????????? ?????? ?????? ?????? ??????
							if(!f.exists()) {
								try {
									System.out.println(f.mkdirs());
								}catch(Exception e) {e.printStackTrace();}
							}

							// ?????????
							try {
								//????????? ?????? ????????? ?????? ??????
								if(vo.getAuthor_thumbnail() != null) {
									fileService.deleteImageFile(vo.getAuthor_thumbnail(), path);
									//File deleteFile = new File(path,vo.getAuthor_thumbnail());
									//deleteFile.delete();
								}
								vo.setAuthor_thumbnail(newUploadFilename);
								fileService.uploadImage(newFile, path);
								//newFile.transferTo(f);
								//?????? ?????? ?????? ??????
								authorService.authorWrite(vo);
							} catch(Exception ee) {ee.printStackTrace();}
								
						}
				} // if newFile != null end
				String msg = "?????? ?????????????????????.";
				alertService.alertInsert(memberNo, "?????? ?????? ????????? ?????????. ????????? ????????? ?????????!");
				entity = new ResponseEntity<String>(msg, headers, HttpStatus.OK);
			} 
			else if(avo.getAuthor_status() == 2) {
					//MultipartHttpServletRequest mr = (MultipartHttpServletRequest)request;
					//MultipartFile newFile = (MultipartFile) mr.getFile("file");
					
					if(newFile != null) { //?????????????????? ????????? ?????????
						String newUploadFilename = newFile.getOriginalFilename();	
							if(newUploadFilename!=null && !newUploadFilename.equals("")) {
								File f = new File(path);
								//????????? ???????????? ?????? ?????? ?????? ??????
								if(!f.exists()) {
									try {
										System.out.println(f.mkdirs());
									}catch(Exception e) {e.printStackTrace();}
								}

								// ?????????
								try {
									//????????? ?????? ????????? ?????? ??????
									if(vo.getAuthor_thumbnail() != null) {
										fileService.deleteImageFile(vo.getAuthor_thumbnail(), path);
										//File deleteFile = new File(path,vo.getAuthor_thumbnail());
										//deleteFile.delete();
									}
									vo.setAuthor_thumbnail(newUploadFilename);
									fileService.uploadImage(newFile, path);
									//newFile.transferTo(f);
									//?????? ?????????
									System.out.println("?????? ?????? -->"+ authorService.authorReUpdate(vo));
								} catch(Exception ee) {ee.printStackTrace();}
									
							}
					} // if newFile != null end
					String msg = "?????? ????????????????????????.";
					alertService.alertInsert(memberNo, "?????? ?????? ????????? ?????????. ????????? ????????? ?????????!");
					entity = new ResponseEntity<String>(msg, headers, HttpStatus.OK);
				}
			else if(avo.getAuthor_status() == 0) {
				String msg = "?????? ?????? ??????????????????.";
				entity = new ResponseEntity<String>(msg, headers, HttpStatus.OK);
			}
		} catch (Exception e) {
			e.printStackTrace();
			String msg = "???????????? ??????";
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

	@PostMapping("exhibition/exhibitionWriteOk")
	@ResponseBody
	public ResponseEntity<String> exhibitionWriteOk(ExhibitionVO evo, String author, HttpServletRequest request, HttpSession session){
		ModelAndView mav = new ModelAndView();
		
		Integer memberNo = (Integer)session.getAttribute("logNo");
		AuthorVO avo = authorService.authorNoSelect(memberNo);
		evo.setAuthor_no(avo.getNo());
		Integer AuthorNO = avo.getNo();
		System.out.println("AuthorNO)->"+AuthorNO);
		String msg = "";
		ResponseEntity<String> entity = null;

		try {
			ExhibitionVO Evo = exhibitionService.exhibitionSelectByEndDate(AuthorNO);
			System.out.println("Evo " + Evo);
			System.out.println("evo " + evo);
			if(Evo != null) {
				System.out.println("evo --> " + Evo.getStart_date() + " " + Evo.getEnd_date());
				System.out.println(Evo);
				 msg = "<script>alert('?????? ?????? ?????? ?????????????????????.'); "
						+ "location.href='/online_exhibition/onlineList'</script>";
				entity = new ResponseEntity<String>(msg, HttpStatus.OK);
			} else {
				System.out.println("evo --> " + evo.getStart_date() + " " + evo.getEnd_date());
				exhibitionService.exhibitionWrite(evo);
				System.out.println("?????? ?????? ??????");
				msg = "<script>alert('?????? ?????? ?????????????????????!'); " + "location.href='/online_exhibition/onlineList'</script>";
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
	@PostMapping("/upload/exhibition/workCreateOk")
	@ResponseBody
	public ResponseEntity<String> workCreateOk(@RequestParam("filename") MultipartFile newFile, HttpSession session, WorkVO wvo) {
		ModelAndView mav = new ModelAndView();
		ResponseEntity<String> entity = null;
		Integer memberNo = (Integer)session.getAttribute("logNo");
		String path = prefixPath+memberNo+"/author/exhibition/";
		
		try {
			AuthorVO avo = authorService.authorNoSelect(memberNo);
			ExhibitionVO evo = exhibitionService.exhibitionSelectByEndDate(avo.getNo());
			System.out.println(wvo.getWork_content());
			System.out.println(wvo.getWork_subject());
				//?????? ??????
				if(evo != null) {
					int workCount = exhibitionService.workSelectByExhibitionNo(evo.getNo()).size();
					//????????? no path??? ?????????
					path = path+evo.getNo()+"/";
					//????????? 5??? ?????? ????????? ??????????????? 
					if(workCount >5) {
						System.out.println("workCount ---> " + workCount);
						//msg ??????
						String msg = "?????? 5?????? ????????? ?????? ??? ??? ????????????.";
						entity = new ResponseEntity<String>(msg, HttpStatus.OK);
						return entity;
					}
				
					
					wvo.setExhibition_no(evo.getNo());
					if(newFile != null) { //?????????????????? ????????? ?????????
						String newUploadFilename = newFile.getOriginalFilename();
						System.out.println("ori-->" + newUploadFilename);
					
							if(newUploadFilename!=null && !newUploadFilename.equals("")) {
								newUploadFilename = wvo.getWork_thumbnail();
								System.out.println("new file --->" + newUploadFilename);
								File f = new File(path);
								//????????? ???????????? ?????? ?????? ?????? ??????
								if(!f.exists()) {
									try {
										System.out.println(f.mkdirs());
									}catch(Exception e) {e.printStackTrace();}
								}

								// ?????????
								try {
									//????????? ?????? ????????? ?????? ??????
									if(wvo.getWork_thumbnail() != null) {
										fileService.deleteImageFile(wvo.getWork_thumbnail(), path);
									}
									
									
									//insert ????????? ??????
									if(wvo.getNo() != null)
										exhibitionService.workUpdate(wvo);
									else {
										wvo.setWork_thumbnail(newUploadFilename);
										exhibitionService.workInsert(wvo);
									}
									
									fileService.uploadImageNewname(newFile, path, newUploadFilename);
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
				result.put("msg","?????? 5?????? ????????? ?????? ??? ??? ????????????.");
			}
			else {
				result.put("msg","????????? ??? ????????? ?????????");
			}
			entity = new ResponseEntity<HashMap<String, String>>(result, HttpStatus.OK);
		}catch(Exception e) {
			result.put("status", "400");
			result.put("msg","????????? ?????? ????????? ?????????");
			e.printStackTrace();
			entity = new ResponseEntity<HashMap<String, String>>(result, HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		
	}
	
	@PostMapping("exhibition/workDel")
	public ResponseEntity<String> workDel(HttpServletRequest request, HttpSession session) {
		ResponseEntity<String> entity = null;
		Integer memberNo = (Integer)session.getAttribute("logNo");
		
		try {
			AuthorVO avo = authorService.authorNoSelect(memberNo);
			ExhibitionVO evo = exhibitionService.exhibitionSelectByEndDate(avo.getNo());
			WorkVO wvo = exhibitionService.workSelectMaxWriteDate(evo.getNo());
			String path = session.getServletContext().getRealPath("/upload/"+memberNo+"/author/exhibition/"+evo.getNo());
			System.out.println(wvo.getWork_thumbnail());
			exhibitionService.workDelete(wvo);
			System.out.println(path);
			if(wvo.getWork_thumbnail() != null) {
				File deleteFile = new File(path,wvo.getWork_thumbnail());
				deleteFile.delete();
			}
			entity = new ResponseEntity<String>(HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	@GetMapping("exhibitionwithwork/{no}")
	public PageResponseBody<ExhibitionWorkVO> getExhibition(@PathVariable("no") int no, HttpSession session) {
		PageResponseBody<ExhibitionWorkVO> entity = null;
		HashMap<String,String> result = new HashMap<String,String>();
		
		try {
			result.put("status","200");
			List<ExhibitionWorkVO> list = new ArrayList<ExhibitionWorkVO>();
			list.add(exhibitionService.exhibitionWorkSelectAll(no));
			AuthorVO authorVO = authorService.authorSelectByNo(list.get(0).getAuthor_no());
			list.get(0).setMember_no(authorVO.getMember_no());
			list.get(0).setAuthor(authorVO.getAuthor());
			entity = new PageResponseBody<ExhibitionWorkVO>();
			entity.setItems(list);
			
		}catch(Exception e) {
			result.put("status","400");
			e.printStackTrace();
			entity = new PageResponseBody<ExhibitionWorkVO>();
			
		}
		
		return entity;
	}
}
