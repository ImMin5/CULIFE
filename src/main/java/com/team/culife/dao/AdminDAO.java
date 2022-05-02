package com.team.culife.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team.culife.vo.MemberBanVO;
import com.team.culife.vo.MemberListPagingVO;
import com.team.culife.vo.MemberVO;

@Mapper
@Repository
public interface AdminDAO {
	
	//회원목록 불러오기
	public List<MemberVO> memberList(MemberListPagingVO pVO);
	//회원 카운트
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
	
	//스케줄러 실행: member테이블 회원상태: 정상
	public void scheduleUpdate();
	//스케줄러 실행: member_ban테이블 회원정보 삭제
	public void scheduleDelete();
}
