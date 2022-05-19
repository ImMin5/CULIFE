package com.team.culife.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.team.culife.service.AuthorService;
import com.team.culife.service.ExhibitionService;
import com.team.culife.service.MemberService;
import com.team.culife.vo.AuthorVO;
import com.team.culife.vo.ExhibitionVO;
import com.team.culife.vo.ExhibitionWorkVO;
import com.team.culife.vo.MemberVO;
import com.team.culife.vo.PagingVO;
import com.team.culife.vo.WorkVO;

@Controller
@RequestMapping("/online_exhibition")
public class OnlineExhibitionController {
	@Inject
	MemberService memberService;
	@Inject
	AuthorService aService;
	@Inject
	ExhibitionService eService;
	
	
	@GetMapping("onlineList")
	public ModelAndView onlineList(HttpSession session, @RequestParam(value="currentPage", required=false, defaultValue="1")int currentPage) {
		ModelAndView mav = new ModelAndView();
		Integer memberNo = (Integer)session.getAttribute("logNo");
		//exihibition 가져올 때 param로 받아서 페이지 리로딩
		//ExhibitionWorkVO exwvo = eService.exhibitionWorkSelectAll(*<exhibitionList.get(0).getNo()>); *<> : 선택한 사진의 exhibition_no를 params
		
		try {
			PagingVO pVO = new PagingVO();
			pVO.setCurrentPage(currentPage);
			pVO.setRecordPerPage(6);
			pVO.setTotalRecord(eService.exhibitionTotalRecord(pVO));
			System.out.println("pvo -->" + pVO.getTotalRecord());
			List<ExhibitionVO> exhibitionList = eService.exhibitionList(pVO);
			for(ExhibitionVO e : exhibitionList) {
				e.setMember_no(aService.authorSelectByNo(e.getAuthor_no()).getMember_no());
					System.out.println(e.getSubject());
			}
			if(exhibitionList.size() > 0) {
		
				ExhibitionWorkVO exwvo = eService.exhibitionWorkSelectAll(exhibitionList.get(0).getNo());
				AuthorVO authorVO = aService.authorSelectByNo(exwvo.getAuthor_no());
				exwvo.setMember_no(authorVO.getMember_no());
				exwvo.setAuthor(authorVO.getAuthor());
				mav.addObject("exhibition", exwvo);
			}
			mav.addObject("exhibitionList",exhibitionList);
			
			mav.addObject("pVO", pVO);
			if(memberNo != null) {
				MemberVO mvo = memberService.memberSelectByNo(memberNo);
				AuthorVO avo = aService.authorNoSelect(memberNo);
				ExhibitionVO evo = eService.exhibitionSelectByEndDate(avo.getNo());
				if(evo != null)
					mav.addObject("workList", eService.workSelectByExhibitionNo(evo.getNo()));
					mav.addObject("mvo", mvo);
					session.setAttribute("logNo", mvo.getNo());
					session.setAttribute("logNickname", mvo.getNickname());
					session.setAttribute("grade",mvo.getGrade());
				
				mav.setViewName("online_exhibition/onlineList");
			} else {
				System.out.println("로그인 바람");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	@GetMapping("onlineAuthorList")
	public ModelAndView onlineAuthorList(@RequestParam(value="currentPage",required=false, defaultValue="1")int currentPage,
			@RequestParam(value="searchWord",required=false)String searchWord) {
		ModelAndView mav = new ModelAndView();
		
		PagingVO pVO = new PagingVO();
		pVO.setRecordPerPage(6);
		pVO.setCurrentPage(currentPage);
		if(searchWord != null) pVO.setSearchWord(searchWord);
		pVO.setTotalRecord(aService.totalAuthorList(pVO));
		
		mav.addObject("list",aService.authorList(pVO));
		mav.addObject("pVO", pVO);
		
		mav.setViewName("/online_exhibition/onlineAuthorList");
		return mav;
	}
		
	@GetMapping("onlineAuthorView")
	public ModelAndView onlineAuthorView(int no) {
		ModelAndView mav = new ModelAndView();
				
		mav.addObject("vo", aService.authorListSelect(no));
		/* mav.addObject("evo", eService.exhibitionListSelect(no)); */
		mav.setViewName("/online_exhibition/onlineAuthorView");
		
		return mav;
	}
	/*
	 * //작가 검색 기능
	 * 
	 * @GetMapping("authorSearch") public ModelAndView search(String searchKey,
	 * String searchWord) { ModelAndView mav = new ModelAndView();
	 * mav.setViewName("online_exhibition/authorSearch"); return mav; }
	 * 
	 * @ResponseBody //Ajax
	 * 
	 * @RequestMapping("authorSearchList") public List<AuthorVO>
	 * searchMoreView(@RequestParam(value="startPage", required=false)String
	 * startPage, String category, String searchWord) throws Exception { int start =
	 * Integer.parseInt(startPage); int end = 7;
	 * System.out.println("category -> "+category);
	 * System.out.println("searchWord -> "+searchWord); return
	 * aService.authorSearch(category, "%"+searchWord+"%", start, end, 6); }
	 * 
	 * @GetMapping("onlineAuthorView") public String onlineAuthorView() { return
	 * "online_exhibition/onlineAuthorView"; }
	 */
}
