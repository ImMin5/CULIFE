package com.team.culife.service;

import java.io.File;

import com.team.culife.vo.MemberVO;


public interface MemberService {
	public MemberVO memberSelectByEmail(String email);
	public int memberInsert(MemberVO vo);
	public MemberVO memberSelectByNo(int no);
	public int memberDelete(long kakao_id);
	public int memberUpdate(MemberVO vo);
	public boolean deleteFileAll(File rootFile);
}
