package com.team.culife.service;

import java.io.File;
import java.util.List;

import com.team.culife.vo.AuthorFanVO;
import com.team.culife.vo.AuthorVO;
import com.team.culife.vo.MemberBanVO;
import com.team.culife.vo.MemberVO;
import com.team.culife.vo.PagingVO;


public interface MemberService {
	public MemberVO memberSelectByEmail(String email);
	public int memberInsert(MemberVO vo);
	public MemberVO memberSelectByNo(int no);
	public int memberDelete(long kakao_id);
	public int memberUpdate(MemberVO vo);
	public boolean deleteFileAll(File rootFile);
	
	public int authorFanTotalRecord(PagingVO vo);
	public int authorFanInsert(AuthorFanVO vo);
	public AuthorFanVO authorFanCheck(int author_no, int member_no);
	public int authorFanDelete(int author_no, int member_no);
	public List<AuthorVO> authorFanSelectAll(PagingVO vo);
	public int authorFanSelectByAuthorNo(int author_no);
	
	public MemberBanVO memberBanSelectByMemberNo(int member_no);
}
