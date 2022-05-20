package com.team.culife.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.team.culife.vo.AuthorVO;
import com.team.culife.vo.ExhibitionVO;
import com.team.culife.vo.PagingVO;

@Mapper
public interface AuthorDAO {
	public AuthorVO authorSelectByName(String author);
	// 작가등록
	public int authorWrite(AuthorVO vo);
	public void authorWriteOk(Map<String, Object> map);
	public AuthorVO authorSelect(String author);
	public String authorCheck(String author);
	public AuthorVO authorNoSelect(int no);
	public int authorUpdate(AuthorVO vo);
	
	// 작가 재신청
	public int authorReUpdate(AuthorVO vo);
	
  // 작가리스트
	public List<AuthorVO> authorList(PagingVO pVO);
	// 총레코드수
	public int totalAuthorList(PagingVO pVO);
	// 작가 선택
	public AuthorVO authorListSelect(int no);
	// 작가 검색...?(수정중)
	public List<AuthorVO> authorSearch(String category, String searchWord, int startPage, int endPage, int member_no);
	public AuthorVO authorSelectByNo(int no);
}
