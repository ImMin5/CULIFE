package com.team.culife.service;

import java.util.List;
import java.util.Map;

import com.team.culife.vo.AuthorVO;
import com.team.culife.vo.ExhibitionVO;
import com.team.culife.vo.PagingVO;

public interface AuthorService {
	public AuthorVO authorSelectByName(String author);
	// 작가등록
	public int authorWrite(ExhibitionVO vo);
	public void authorWriteOk(Map<String, Object> map);
	public ExhibitionVO authorSelect(String author);
	public String authorCheck(String author);
	
	
	// 작가리스트
	public List<AuthorVO> authorList(PagingVO pVO);
	// 총레코드수
	public int totalAuthorList(PagingVO pVO);
	// 작가 선택
	public AuthorVO authorListSelect(int no);
	// 작가검색
	public List<AuthorVO> authorSearch(String category, String searchWord, int startPage, int endPage, int member_no);
}
