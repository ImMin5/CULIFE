package com.team.culife.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team.culife.dao.ReplyDAO;
import com.team.culife.vo.ReplyVO;

@Service
public class ReplySerivceImpl implements ReplyService {

	@Inject
	ReplyDAO dao;

	@Override
	public int insertReply(ReplyVO vo) {
		return dao.insertReply(vo);
	}

	@Override
	public List<ReplyVO> selectReplyList(int no) {
		return dao.selectReplyList(no);
	}

	@Override
	public int updateReply(ReplyVO vo) {
		return dao.updateReply(vo);
	}

	@Override
	public int deleteReply(int replyno, String nickname) {
		return dao.deleteReply(replyno, nickname);
	}
	
}