package com.team.culife.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class CultureController {	
	
	//ø¨±ÿ∏ÆΩ∫∆Æ
	@GetMapping("/theater/theaterList")
	public ModelAndView theaterListAll() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/theater/theaterList");
		return mav;
	}
	
	//ø¨±ÿ∏ÆΩ∫∆Æ(ø¨±ÿ)
	@PostMapping(value="/theater/theaterList", produces = "application/xml")
	public String theaterList() throws IOException{
		StringBuilder result = new StringBuilder();
			String urlStr = "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/realm?serviceKey="
					+ "2cBi8%2FMgNHSEJAAbQmI%2BvzUi41lwnVyfTl%2BcTIesdtQnirvIHazsX%2BRzV4hboJb%2BJ6nBFNSIQTGC1pidgHzRcw%3D%3D&realmCode=A000&rows=20";			
			
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
	

	//ø¨±ÿ∏ÆΩ∫∆Æ(π¬¡ˆƒ√)
	@PostMapping(value="/theater/theaterList2", produces = "application/xml")
	public String theaterList2() throws IOException{
		StringBuilder result = new StringBuilder();
			String urlStr = "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/realm?serviceKey="
					+ "2cBi8%2FMgNHSEJAAbQmI%2BvzUi41lwnVyfTl%2BcTIesdtQnirvIHazsX%2BRzV4hboJb%2BJ6nBFNSIQTGC1pidgHzRcw%3D%3D&realmCode=B000"
					+ "&rows=50"
					+ "&realmCode=B000";			
			
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
	
	// ø¨±ÿ&π¬¡ˆƒ√ ªÛºº ∆‰¿Ã¡ˆ(view)
	@GetMapping("/theater/theaterView")
	public ModelAndView theaterViewAll() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/theater/theaterView");
		return mav;
	}
	
	// ø¨±ÿ&π¬¡ˆƒ√ ªÛºº ∆‰¿Ã¡ˆ(view)
	@PostMapping(value="/theater/theaterView", produces = "application/xml")
	public String theaterView(HttpServletRequest request, HttpServletResponse response, @RequestParam String seq)throws Exception{
		StringBuilder result = new StringBuilder();
		
		String addr = "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/d/?seq=";
		String parameter = "";
		String serviceKey = "&serviceKey=2cBi8%2FMgNHSEJAAbQmI%2BvzUi41lwnVyfTl%2BcTIesdtQnirvIHazsX%2BRzV4hboJb%2BJ6nBFNSIQTGC1pidgHzRcw%3D%3D"; 

		parameter = seq; 
		
		addr = addr + parameter + serviceKey;
		URL url = new URL(addr);
		
		HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
		urlConnection.setRequestMethod("GET");
		
		BufferedReader br;
		
		br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream(),"UTF-8"));
		
		String returnLine;
		
		while((returnLine = br.readLine())!=null) {
			result.append(returnLine);
			System.out.println(result);
		}
		urlConnection.disconnect();
		br.close();
		
	return result.toString();
	}
}
