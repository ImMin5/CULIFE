package com.team.culife.service;

import java.util.Map;

import com.team.culife.vo.AuthorVO;
import com.team.culife.vo.ExhibitionVO;

public interface AuthorService {
	public AuthorVO authorSelectByName(String author);
	// 작가등록
	public int authorWrite(AuthorVO vo);
	public void authorWriteOk(Map<String, Object> map);
	public AuthorVO authorSelect(String author);
	public String authorCheck(String author);

}
