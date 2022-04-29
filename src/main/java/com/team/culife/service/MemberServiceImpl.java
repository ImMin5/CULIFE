package com.team.culife.service;

import java.io.File;

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
	
	
}
