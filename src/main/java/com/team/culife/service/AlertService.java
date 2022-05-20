package com.team.culife.service;

import java.util.List;

import com.team.culife.vo.AlertVO;

public interface AlertService {
	public List<AlertVO> alertSelectByMemberNo(int member_no);
	public int alertInsert(int member_no, String content);
	public int alertDeleteByNo(int no);
}
