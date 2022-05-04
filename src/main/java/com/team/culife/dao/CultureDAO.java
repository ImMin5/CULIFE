package com.team.culife.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team.culife.vo.CultureVO;

@Mapper
@Repository
public interface CultureDAO {
	//���ظ��
	public List<CultureVO> playList(String mt20id);
	
	//�����ø��
	public List<CultureVO> musicalList(String mt20id);
	
	//�Խù� ����
	public CultureVO cultureSelect(int no);
}
