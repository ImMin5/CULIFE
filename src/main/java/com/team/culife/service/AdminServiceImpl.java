package com.team.culife.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.culife.dao.AdminDAO;
import com.team.culife.vo.MemberBanVO;
import com.team.culife.vo.MemberListPagingVO;
import com.team.culife.vo.MemberVO;

@Service
public class AdminServiceImpl implements AdminService{
	@Inject
	AdminDAO dao;

	@Override
	public List<MemberVO> memberList(MemberListPagingVO pVO) {
		return dao.memberList(pVO);
	}
	@Override
	public int totalRecord(MemberListPagingVO pVO) {
		return dao.totalRecord(pVO);
	}
	@Override
	public int memberDel(MemberVO mVO) {
		return dao.memberDel(mVO);
	}
	@Override
	public int memberNor(MemberVO mVO) {
		return dao.memberNor(mVO);
	}
	@Override
	public int memberBan(MemberVO mVO) {
		return dao.memberBan(mVO);
	}
	@Override
	public int memberBanDel(MemberBanVO mbVO) {
		return dao.memberBanDel(mbVO);
	}
	@Override
	public int memberBanDate(MemberBanVO mbVO) {
		return dao.memberBanDate(mbVO);
	}
	
}
