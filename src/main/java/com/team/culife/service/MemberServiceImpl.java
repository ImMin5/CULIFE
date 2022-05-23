package com.team.culife.service;

import java.io.File;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import com.team.culife.dao.MemberDAO;
import com.team.culife.vo.AuthorFanVO;
import com.team.culife.vo.AuthorVO;
import com.team.culife.vo.MemberBanVO;
import com.team.culife.vo.MemberVO;
import com.team.culife.vo.PagingVO;



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
	@Override
	public int memberDelete(long kakao_id) {
		return dao.memberDelete(kakao_id);
	}
	@Override
	public int memberUpdate(MemberVO vo) {
		return dao.memberUpdate(vo);
	}
	@Override
	public boolean deleteFileAll(File rootFile) {
		File[] allFiles = rootFile.listFiles();
		if(allFiles != null) {
			for(File file : allFiles) {
				deleteFileAll(file);
			}
		}
		 return rootFile.delete();
	}
	@Override
	public int authorFanInsert(AuthorFanVO vo) {
		return dao.authorFanInsert(vo);
	}
	@Override
	public AuthorFanVO authorFanCheck(int author_no, int member_no) {
		return dao.authorFanCheck(author_no, member_no);
	}
	@Override
	public int authorFanDelete(int author_no, int member_no) {
		return dao.authorFanDelete(author_no, member_no);
	}
	@Override
	public List<AuthorVO> authorFanSelectAll(PagingVO vo) {
		return dao.authorFanSelectAll(vo);
	}
	@Override
	public int authorFanTotalRecord(PagingVO vo) {
		return dao.authorFanTotalRecord(vo);
	}
	@Override
	public MemberBanVO memberBanSelectByMemberNo(int member_no) {
		return dao.memberBanSelectByMemberNo(member_no);
	}
	@Override
	public int authorFanSelectByAuthorNo(int author_no) {
		return dao.authorFanSelectByAuthorNo(author_no);
	}
	
	
}
