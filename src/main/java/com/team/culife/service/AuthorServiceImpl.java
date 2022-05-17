package com.team.culife.service;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team.culife.dao.AuthorDAO;
import com.team.culife.vo.AuthorVO;
import com.team.culife.vo.ExhibitionVO;

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
}
