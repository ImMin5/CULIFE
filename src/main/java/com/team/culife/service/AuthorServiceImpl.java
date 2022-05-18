package com.team.culife.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.culife.dao.AuthorDAO;
import com.team.culife.vo.AuthorVO;
import com.team.culife.vo.ExhibitionVO;
import com.team.culife.vo.PagingVO;

@Service
public class AuthorServiceImpl implements AuthorService{
	@Inject
	AuthorDAO dao;
	
	@Override
	public AuthorVO authorSelectByName(String author) {
		return dao.authorSelectByName(author);
	}

	@Override
	public int authorWrite(AuthorVO vo) {
		return dao.authorWrite(vo);
	}

	@Override
	public void authorWriteOk(Map<String, Object> map) {
	}

	@Override
	public AuthorVO authorSelect(String author) {
		return dao.authorSelect(author);
	}

	@Override
	public String authorCheck(String author) {
		return dao.authorCheck(author);
	}
  
  @Override
	public AuthorVO authorNoSelect(int no) {
		return dao.authorNoSelect(no);
	}

	@Override
	public int authorUpdate(AuthorVO vo) {
		return dao.authorUpdate(vo);
	}
  
	@Override
	public List<AuthorVO> authorSearch(String category, String searchWord, int startPage, int endPage, int member_no) {
		return dao.authorSearch(category, searchWord, startPage, endPage, member_no);
	}

	@Override
	public List<AuthorVO> authorList(PagingVO pVO) {
		return dao.authorList(pVO);
	}

	@Override
	public int totalAuthorList(PagingVO pVO) {
		return dao.totalAuthorList(pVO);
	}

	@Override
	public AuthorVO authorListSelect(int no) {
		return dao.authorListSelect(no);
  }

	@Override
	public int authorReUpdate(AuthorVO vo) {
		return dao.authorReUpdate(vo);
	}
}
