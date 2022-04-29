package com.team.culife.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.team.culife.vo.MemberVO;



@Service
public class LoginService {
	
    @Value("${open-api.REST_API_KEY}")
    private String REST_API_KEY;
    
    @Value("${open-api.ADMIN_KEY}")
    private String AdminKey;
	//코드를 이용해서 로그인 access 코드를 받아옴
	public void getKakaoToken(String code) {
		StringBuilder urlBuilder = new StringBuilder("https://kauth.kakao.com/oauth/token");
		BufferedReader br = null;
		StringBuilder sb = new StringBuilder();
		JSONObject json = null;
		try {
			urlBuilder.append("?" + URLEncoder.encode("grant_type","UTF-8") + "="+"authorization_code");
			urlBuilder.append("&" + URLEncoder.encode("client_id","UTF-8") + "="+REST_API_KEY);
			urlBuilder.append("&" + URLEncoder.encode("redirect_url","UTF-8") + "="+"http://localhost:8080/login/oauth"); 
			urlBuilder.append("&" + URLEncoder.encode("code","UTF-8") + "="+code); 
			
			URL url = new URL(urlBuilder.toString());
			System.out.println("url ---- > " + url.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			String line;
            if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
           	 br = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
            } else {
           	 br = new BufferedReader(new InputStreamReader(conn.getErrorStream(),"UTF-8"));
            }
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
            System.out.println("sb token ---> :" + sb.toString());
            json = new JSONObject(sb.toString());
            String access_token = json.getString("access_token");
            System.out.println("token---> " + access_token);
            getUserInfo(access_token);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//토큰 정보로 카카오 정보를 가져옴
	public JSONObject getUserInfo(String token) {
		StringBuilder urlBuilder = new StringBuilder("https://kapi.kakao.com/v2/user/me");
		BufferedReader br = null;
		StringBuilder sb = new StringBuilder();
		JSONObject json = null;
		MemberVO mvo = new MemberVO();
		
		try {
			// header 설정
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			
			//header 설정
			conn.setRequestProperty("Authorization", "Bearer " + token);
			
			int responseCode = conn.getResponseCode();
			//System.out.println("responseCode : " + responseCode);
              
			String line;
            if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
           	 br = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
            } else {
           	 br = new BufferedReader(new InputStreamReader(conn.getErrorStream(),"UTF-8"));
            }
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
            json = new JSONObject(sb.toString());
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return json;
		
	}
	
	//로그아웃
	public void logout(String kakao_id, String Token) {
		StringBuilder urlBuilder = new StringBuilder("https://kapi.kakao.com/v1/user/logout");
		BufferedReader br = null;
		StringBuilder sb = new StringBuilder();
		
		try {
			// header 설정
			if(Token == null) {
				urlBuilder.append("?" + URLEncoder.encode("target_id","UTF-8") + "="+Long.parseLong(kakao_id));
				urlBuilder.append("&" + URLEncoder.encode("target_id_type","UTF-8") + "="+"userid");
			}
			
			URL url = new URL(urlBuilder.toString());
			System.out.println("url --- > " + url);
			
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			//header 설정
			if(Token == null) {
				conn.setRequestProperty("Authorization", "KakaoAK " + AdminKey);
				conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			}
			else {
				conn.setRequestProperty("Authorization", "Bearer " + Token);
			}
			
			
			  int responseCode = conn.getResponseCode();
              System.out.println("responseCode : " + responseCode);
              System.out.println("amdinkey --> " + AdminKey);
              System.out.println("amdinkey --> " + Token);
              
			String line;
            if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
           	 br = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
            } else {
           	 br = new BufferedReader(new InputStreamReader(conn.getErrorStream(),"UTF-8"));
            }
            while ((line = br.readLine()) != null) {
                sb.append(line);
                //System.out.println("line -- >"+ line);
            }
            
            System.out.println("id : " + sb.toString() + " 로그아웃");
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
