package com.team.culife.service;

import java.util.List;

import com.team.culife.vo.CultureVO;

public interface CultureService {
	//���ظ��
	public List<CultureVO> playList(String mt20id);
	
	//�����ø��
	public List<CultureVO> musicalList(String mt20id);
	
	//�Խù� ����
	public CultureVO cultureSelect(int no);
}
