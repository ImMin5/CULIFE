package com.team.culife.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team.culife.vo.ExhibitionVO;


@Mapper
@Repository
public interface ExhibitionDAO {
	public int exhibitionWrite(ExhibitionVO vo);
}
