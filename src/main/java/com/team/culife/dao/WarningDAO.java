package com.team.culife.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team.culife.vo.WarningVO;

@Mapper
@Repository
public interface WarningDAO {
	public int warning(WarningVO warning);//신고하기
}
