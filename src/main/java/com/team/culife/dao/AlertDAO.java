package com.team.culife.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.team.culife.vo.AlertVO;

@Mapper
public interface AlertDAO {
	public List<AlertVO> alertSelectByMemberNo(int member_no);
	public int alertInsert(int member_no, String content);
	public int alertDeleteByNo(int no);
}
