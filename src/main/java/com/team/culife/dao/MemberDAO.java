package com.team.culife.dao;

import org.apache.ibatis.annotations.Mapper;
import com.team.culife.vo.MemberVO;

@Mapper
public interface MemberDAO {
	public MemberVO memberSelectByEmail(String email);
	public int memberInsert(MemberVO vo);
	public MemberVO memberSelectByNo(int no);
	public int memberDelete(long kakao_id);
	public int memberUpdate(MemberVO vo);
}