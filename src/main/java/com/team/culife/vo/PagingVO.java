package com.team.culife.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PagingVO {
	private int currentPage = 1;  //현재 페이지
	private int startPage = 1;
	private int endPage = 0;
	private int recordPerPage = 10;
	private int onePageCount = 5;
	private int totalRecord;
	private int totalPage;
	private int offsetIndex = 0;
	

	private int member_no;
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

