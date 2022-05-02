package com.team.culife.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class CultureController {
	
	
	  @GetMapping("/theater/theaterList") 
	  public ModelAndView theaterListView() {
	  ModelAndView mav = new ModelAndView();
	  mav.setViewName("theater/theaterList"); 
	  return mav; 
	  }
	
	//연극&뮤지컬 리스트 페이지
	@PostMapping(value="/theater/theaterList", produces = "application/xml")
	public String theaterList() throws IOException{
		StringBuilder result = new StringBuilder();
			String urlStr = "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/realm?serviceKey="
					+ "2cBi8%2FMgNHSEJAAbQmI%2BvzUi41lwnVyfTl%2BcTIesdtQnirvIHazsX%2BRzV4hboJb%2BJ6nBFNSIQTGC1pidgHzRcw%3D%3D";
					
			URL url = new URL(urlStr);
			
			HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
			urlConnection.setRequestMethod("GET");
			
			BufferedReader br;
			
			br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream(),"UTF-8"));
			
			String returnLine;
			
			while((returnLine = br.readLine())!=null) {
				result.append(returnLine);
				//System.out.println(result);
			}
			urlConnection.disconnect();
			br.close();
			
		return result.toString();
	}
	
	// 연극&뮤지컬 상세 페이지(view)
	@RequestMapping("theater/theaterView")
	public ModelAndView theaterView() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("theater/theaterView");
		return mav;
	}
}
