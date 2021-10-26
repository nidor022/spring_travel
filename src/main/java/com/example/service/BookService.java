package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.BookVo;
import com.example.domain.HostVo;
import com.example.domain.ImagesVo;
import com.example.mapper.BookMapper;
import com.example.mapper.HostMapper;
import com.example.mapper.ImagesMapper;
import com.example.mapper.MysqlMapper;

@Service
public class BookService {
	
	@Autowired
	private BookMapper bookMapper;

	@Autowired
	private MysqlMapper mysqlMapper;
	
	@Autowired
	private HostMapper hostMapper;
	
	@Autowired
	private ImagesMapper imagesMapper;
	
	public int addBook(BookVo bookVo) {
		int num = mysqlMapper.getNextNum("travel_book");
		
		bookMapper.addBook(bookVo);
		
		return num;
	}
	
	@Transactional
	public BookVo getBookInfoByNumAndId(int num, String id) {
		BookVo bookVo = bookMapper.getBookInfoByNumAndId(num, id);
		HostVo hostVo = hostMapper.getContentInfo(bookVo.getNoNum());
		
		bookVo.setHostVo(hostVo);
		
		return bookVo;
	}
	
	@Transactional
	public List<BookVo> getBooksAndHostVoById(String id) {
		List<BookVo> bookList = getBookInfoById(id);
		for(BookVo bookVo : bookList) {
			HostVo hostVo = hostMapper.getContentInfo(bookVo.getNoNum());
			ImagesVo imagesVo = imagesMapper.getImageByNoNum(hostVo.getNum());
			hostVo.setImageVo(imagesVo);
			hostVo.setHostComment(hostVo.getHostComment().replaceAll("(\r\n|\r|\n|\n\r)", "<br>"));
			bookVo.setHostVo(hostVo);
		}
		return bookList;
	}
	
	public List<BookVo> getBookInfoByNum(int num) {
		return bookMapper.getBookInfoByNum(num);
	}
	
	public List<BookVo> getBookInfoById(String id) {
		return bookMapper.getBookInfoById(id);
	}
	
	public int updateBookInfo(BookVo bookVo) {
		return bookMapper.updateBookInfo(bookVo);
	}
	
	public int deleteBookInfo(int num) {
		return bookMapper.deleteBookInfo(num);
	}
}
