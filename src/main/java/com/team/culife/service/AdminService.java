package com.team.culife.service;

import java.util.List;

import com.team.culife.vo.MemberBanVO;
import com.team.culife.vo.MemberListPagingVO;
import com.team.culife.vo.MemberVO;

public interface AdminService {

	//멤버리스트 불러오기
	public List<MemberVO> memberList(MemberListPagingVO pVO);
	//멤버리스트 카운트
	public int totalRecord(MemberListPagingVO pVO);
	//회원 탈퇴
	public int memberDel(MemberVO mVO);
	//회원상태: 정상
	public int memberNor(MemberVO mVO);
	//회원상태: 정지
	public int memberBan(MemberVO mVO);
	//회원상태: 정지날짜설정
	public int memberBanDate(MemberBanVO mbVO);	
	//회원상태: member_ban에서 삭제
	public int memberBanDel(MemberBanVO mbVO);
}
