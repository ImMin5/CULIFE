package com.team.culife.service;

import java.util.List;

import com.team.culife.vo.CultureVO;

public interface CultureService {
	//연극목록
	public List<CultureVO> playList(String mt20id);
	
	//뮤지컬목록
	public List<CultureVO> musicalList(String mt20id);
	
	//게시물 선택
	public CultureVO cultureSelect(int no);
}
