package com.team.culife.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PagingVO {
	private int currentPage = 1;  //현재 페이지
	private int startPage = 1;	//시작페이지
	private int endPage = 0;	//끝페이지
	private int recordPerPage = 10;	//페이지에 몇개를 보여줄것인가
	private int onePageCount = 5;	//페이지네이션이 몇개인가
	private int totalRecord;	//총 게시글수
	private int totalPage;		//총 페이지수
	private int offsetIndex = 0;	
	
	private int member_no;
	private String searchKey;
	private String searchWord;
	private String category;
	
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
		
		offsetIndex = (currentPage-1)*recordPerPage;
		
		startPage = ((currentPage-1)/onePageCount*onePageCount)+1;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;	
		
		if(totalRecord%recordPerPage==0) {
			totalPage = totalRecord/recordPerPage;
		}else {
			totalPage = totalRecord/recordPerPage+1;
		}
	}
	 public void setEndPage(int endPage) {
	        this.endPage = (int)Math.ceil(this.currentPage*0.1)*10;
	} 
	
}