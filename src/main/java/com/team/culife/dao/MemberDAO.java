package com.team.culife.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.team.culife.vo.AuthorFanVO;
import com.team.culife.vo.AuthorVO;
import com.team.culife.vo.MemberBanVO;
import com.team.culife.vo.MemberVO;
import com.team.culife.vo.PagingVO;

@Mapper
public interface MemberDAO {
	public MemberVO memberSelectByEmail(String email);
	public int memberInsert(MemberVO vo);
	public MemberVO memberSelectByNo(int no);
	public int memberDelete(long kakao_id);
	public int memberUpdate(MemberVO vo);
	
	public int authorFanTotalRecord(PagingVO vo);
	public int authorFanInsert(AuthorFanVO vo);
	public AuthorFanVO authorFanCheck(int author_no, int member_no);
	public int authorFanDelete(int author_no, int member_no);
	public List<AuthorVO> authorFanSelectAll(PagingVO vo);
	public int authorFanSelectByAuthorNo(int author_no);
	
	public MemberBanVO memberBanSelectByMemberNo(int member_no);
}
