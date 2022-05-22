package com.team.culife.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileService{
	public String uploadImage(MultipartFile imageFile, String root) throws Exception{
		byte[] bytes = imageFile.getBytes();
		Path path = Paths.get(root+imageFile.getOriginalFilename());
		
		return Files.write(path,bytes).toString();
	}
	public String uploadImageNewname(MultipartFile imageFile, String root, String newFilename) throws Exception{
		byte[] bytes = imageFile.getBytes();
		Path path = Paths.get(root+newFilename);
		
		return Files.write(path,bytes).toString();
	}
	public boolean deleteImageFile(String filename, String root) throws Exception{
		Path path = Paths.get(root+ filename);
		return Files.deleteIfExists(path);
	}
}
