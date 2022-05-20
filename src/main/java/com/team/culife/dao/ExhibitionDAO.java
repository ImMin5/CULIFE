package com.team.culife.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team.culife.vo.AuthorVO;
import com.team.culife.vo.ExhibitionVO;

import com.team.culife.vo.ExhibitionWorkVO;

import com.team.culife.vo.PagingVO;
import com.team.culife.vo.WorkVO;

@Mapper
@Repository
public interface ExhibitionDAO {
	public int exhibitionWrite(ExhibitionVO vo);
	public ExhibitionVO exhibitionSelect(int no);
	public ExhibitionVO exhibitionSelectByEndDate(int author_no);
	public int workInsert(WorkVO vo);
	public List<WorkVO> workSelectByExhibitionNo(int exhibition_no);
	public int workUpdate(WorkVO vo);
	public int workTotalRecord(PagingVO vo);
	public List<WorkVO> workSelectByAuthorNo(PagingVO vo);
	public WorkVO workSelectMaxWriteDate(int exhibition_no);
	public int workDelete(WorkVO vo);
	public List<ExhibitionVO> exhibitionList(PagingVO pVO);
	public int exhibitionTotalRecord(PagingVO pVO);
	public ExhibitionVO exhibitionPosterSelect(String work_thumbnail);
	public WorkVO exhibitionWorkSelect(int exhibition_no);
	public ExhibitionWorkVO exhibitionWorkSelectAll(int no);
    public List<ExhibitionVO> exhibitionSelectAll(PagingVO vo);
}
