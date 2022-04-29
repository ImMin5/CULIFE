package com.team.culife.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team.culife.vo.ExhibitionVO;

@Mapper
@Repository
public interface ExhibitionDAO {
	// 작가등록
	public int authorApplyWrite(ExhibitionVO vo);
	// 작가 닉네임 select
	public int authorMemberSelect(ExhibitionVO vo);
}
