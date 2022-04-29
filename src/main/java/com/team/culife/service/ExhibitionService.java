package com.team.culife.service;

import org.springframework.stereotype.Service;

import com.team.culife.vo.ExhibitionVO;

@Service
public interface ExhibitionService {
	// 작가등록
	public int authorApplyWrite(ExhibitionVO vo);
	// 작가 닉네임 select
	public int authorMemberSelect(ExhibitionVO vo);
}
