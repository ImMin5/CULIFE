package com.team.culife.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import com.team.culife.dao.MemberDAO;
import com.team.culife.vo.MemberVO;



@Service
public class MemberServiceImpl implements MemberService {
	@Inject
	MemberDAO dao;
	
	public MemberVO memberSelectByEmail(String email) {
		return dao.memberSelectByEmail(email);
	}
	public int memberInsert(MemberVO vo) {
		return dao.memberInsert(vo);
	}
	@Override
	public MemberVO memberSelectByNo(int no) {
		return dao.memberSelectByNo(no);
	}
}
