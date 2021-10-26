package com.example.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.domain.FaqVo;
import com.example.domain.PageDto;
import com.example.domain.QnaVo;
import com.example.service.MysqlService;
import com.example.service.ServiceCenterSerivce;

import lombok.extern.java.Log;
@Log
@Controller
@RequestMapping("/customerCenter/*")
public class ServiceCenterController {

	@Autowired
	private MysqlService mysqlService;

	@Autowired
	private ServiceCenterSerivce serviceCenterSerivce;

	@GetMapping("faqList")
	public String faqList(@RequestParam(defaultValue = "1") int pageNum, Model model) {
		int count = serviceCenterSerivce.getFaqCountAll();

		int pageSize = 9;

		int startRow = (pageNum - 1) * pageSize;

		List<FaqVo> contentList = null;
		if (count > 0) {
			contentList = serviceCenterSerivce.getFaqContents(startRow);

			String content = "";
			for (FaqVo faqVo : contentList) {
				if (faqVo.getContent() != null) {
					content = faqVo.getContent().replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
					faqVo.setContent(content);
				}
			}
		}

		PageDto pageDto = new PageDto();

		if (count > 0) {
			int pageCount = (count / pageSize) + (count % pageSize == 0 ? 0 : 1);
			// int pageCount = (int) Math.ceil((double) count / pageSize);

			int pageBlock = 5;

			// 1~5 6~10 11~15 16~20 ...
			// 1~5 => 1 6~10 => 6 11~15 => 11 16~20 => 16
			int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;

			int endPage = startPage + pageBlock - 1;
			if (endPage > pageCount) {
				endPage = pageCount;
			}

			pageDto.setCount(count);
			pageDto.setPageCount(pageCount);
			pageDto.setPageBlock(pageBlock);
			pageDto.setStartPage(startPage);
			pageDto.setEndPage(endPage);
		} // if

		model.addAttribute("fContentList", contentList);
		model.addAttribute("fPageDto", pageDto);
		model.addAttribute("fPageNum", pageNum);
		model.addAttribute("viewType", "faq");

		return "/serviceCenter/customerCenter";
	}

	@GetMapping("/faqWrite")
	public String faqWrite(@ModelAttribute("pageNum") String pageNum) {

		// 로그인 했을때는 글쓰기 화면으로 보여줌
		return "/serviceCenter/faqWriteForm";
	} // Get - write

	@PostMapping("/faqWrite")
	public String faqWrite(String pageNum, FaqVo faqVo) {

		faqVo.setReadcount(0);

		int num = mysqlService.getNextNum("travel_custom_service_faq");

		// 주글쓰기
		serviceCenterSerivce.addFaqContent(faqVo);

		return "redirect:/customerCenter/faqContent?num=" + num + "&pageNum=" + pageNum;
	} // Post - write

	@GetMapping("/faqContent")
	public String faqContent(int num, String pageNum, Model model) {
		// 상세보기 대상 글의 조회수 1 증가
		serviceCenterSerivce.updateFaqReadcount(num);

		// 상세보기 대상 글내용 VO로 가져오기
		FaqVo faqVo = serviceCenterSerivce.getFaqContentByNum(num);

		String content = "";
		content = faqVo.getContent().replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
		faqVo.setContent(content);

		model.addAttribute("faqVo", faqVo);
		model.addAttribute("pageNum", pageNum);

		return "/serviceCenter/faqContent";
	} // content

	@GetMapping("/faqDelete")
	public String faqDelete(int num, String pageNum, RedirectAttributes rttr) {
		// 글번호에 해당하는 글 한개 삭제하기
		serviceCenterSerivce.deleteFaqContent(num);

		// 글목록 페이지로 리다이렉트 이동시키기
		rttr.addAttribute("pageNum", pageNum);

		return "redirect:/customerCenter/faqList";
	} // delete

	@GetMapping("/faqModify")
	public String faqModify(int num, @ModelAttribute("pageNum") String pageNum, Model model) {
		// 글번호 num에 해당하는 글내용 VO로 가져오기
		FaqVo faqVo = serviceCenterSerivce.getFaqContentByNum(num);
		faqVo.setContent(faqVo.getContent().replaceAll("(\r\n|\r|\n|\n\r)", "<br>"));

		model.addAttribute("faqVo", faqVo);

		return "/serviceCenter/faqModifyForm";
	} // GET - modify

	@PostMapping("/faqModify")
	public String faqModify(FaqVo faqVo, String pageNum, RedirectAttributes rttr) {

		serviceCenterSerivce.updateFaqContent(faqVo);

		rttr.addAttribute("num", faqVo.getNum());
		rttr.addAttribute("pageNum", pageNum);

		// 수정된 글의 상세보기 화면으로 리다이렉트 이동
		return "redirect:/customerCenter/faqContent";
	} // POST - modify

	// ======================= qna ===============================

	@GetMapping("/qnaList")
	public String qnaList(@RequestParam(defaultValue = "1") int pageNum, Model model) {
		int count = serviceCenterSerivce.getQnaCountAll();

		int pageSize = 10;

		int startRow = (pageNum - 1) * pageSize;

		List<QnaVo> contentList = null;
		if (count > 0) {
			contentList = serviceCenterSerivce.getQnaContents(startRow);

			String content = "";
			for (QnaVo qnaVo : contentList) {
				if (qnaVo.getContent() != null) {
					content = qnaVo.getContent().replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
					qnaVo.setContent(content);
				}
			}
		}

		PageDto pageDto = new PageDto();

		if (count > 0) {
			int pageCount = (count / pageSize) + (count % pageSize == 0 ? 0 : 1);
			// int pageCount = (int) Math.ceil((double) count / pageSize);

			int pageBlock = 5;

			// 1~5 6~10 11~15 16~20 ...
			// 1~5 => 1 6~10 => 6 11~15 => 11 16~20 => 16
			int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;

			int endPage = startPage + pageBlock - 1;
			if (endPage > pageCount) {
				endPage = pageCount;
			}

			pageDto.setCount(count);
			pageDto.setPageCount(pageCount);
			pageDto.setPageBlock(pageBlock);
			pageDto.setStartPage(startPage);
			pageDto.setEndPage(endPage);
		} // if

		model.addAttribute("qContentList", contentList);
		model.addAttribute("qPageDto", pageDto);
		model.addAttribute("qPageNum", pageNum);
		model.addAttribute("viewType", "qna");

		return "/serviceCenter/customerCenter";
	}
	
	@PostMapping("/qnaList")
	@ResponseBody
	public Map<String, Object> updateQnaList(@RequestParam(defaultValue = "1") int pageNum) {
		int count = serviceCenterSerivce.getQnaCountAll();

		int pageSize = 10;

		int startRow = (pageNum - 1) * pageSize;

		List<QnaVo> contentList = null;
		if (count > 0) {
			contentList = serviceCenterSerivce.getQnaContents(startRow);

			String content = "";
			for (QnaVo qnaVo : contentList) {
				if (qnaVo.getContent() != null) {
					content = qnaVo.getContent().replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
					qnaVo.setContent(content);
				}
			}
		}

		PageDto pageDto = new PageDto();

		if (count > 0) {
			int pageCount = (count / pageSize) + (count % pageSize == 0 ? 0 : 1);
			// int pageCount = (int) Math.ceil((double) count / pageSize);

			int pageBlock = 5;

			// 1~5 6~10 11~15 16~20 ...
			// 1~5 => 1 6~10 => 6 11~15 => 11 16~20 => 16
			int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;

			int endPage = startPage + pageBlock - 1;
			if (endPage > pageCount) {
				endPage = pageCount;
			}

			pageDto.setCount(count);
			pageDto.setPageCount(pageCount);
			pageDto.setPageBlock(pageBlock);
			pageDto.setStartPage(startPage);
			pageDto.setEndPage(endPage);
		} // if

		Map<String, Object> qnaListInfo = new HashMap<>();
		qnaListInfo.put("qContentList", contentList);
		qnaListInfo.put("qPageDto", pageDto);
		qnaListInfo.put("qPageNum", pageNum);
		
		return qnaListInfo;
	}

	@GetMapping("/qnaWrite")
	public String qnaWrite(HttpSession session, @ModelAttribute("pageNum") String pageNum, Model model) {
		String id = (String) session.getAttribute("id");
		model.addAttribute("id", id);
		// 로그인 했을때는 글쓰기 화면으로 보여줌
		return "/serviceCenter/qnaWriteForm";
	} // Get - write

	@PostMapping("/qnaWrite")
	public String qnaWrite(HttpSession session, String pageNum, QnaVo qnaVo) {
		String id = (String) session.getAttribute("id");
		int num = mysqlService.getNextNum("travel_custom_service_qna");

		qnaVo.setId(id);
		qnaVo.setStatus("답변대기");
		qnaVo.setReRef(num);
		
		// 주글쓰기
		serviceCenterSerivce.addQnaContent(qnaVo);

		return "redirect:/customerCenter/qnaContent?num=" + num + "&pageNum=" + pageNum;
	} // Post - write

	@GetMapping("/qnaContent")
	public String qnaContent(int num, String pageNum, Model model) {

		// 상세보기 대상 글내용 VO로 가져오기
		QnaVo qnaVo = serviceCenterSerivce.getQnaContentByNum(num);

		String content = "";
		content = qnaVo.getContent().replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
		qnaVo.setContent(content);

		model.addAttribute("qnaVo", qnaVo);
		model.addAttribute("pageNum", pageNum);
		
		log.info(qnaVo.toString());
		return "/serviceCenter/qnaContent";
	} // content
	
	
	@GetMapping("/qnaReply")
	public String qnaReply(int num, String pageNum, Model model, String form) {
		// 상세보기 대상 글내용 VO로 가져오기
		QnaVo qnaVo = serviceCenterSerivce.getQnaContentByNum(num);

		String content = "";
		content = qnaVo.getContent().replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
		qnaVo.setContent(content);

		model.addAttribute("qnaVo", qnaVo);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("replyNum", 0);
		model.addAttribute("form", form);
		return "/serviceCenter/qnaAnswerForm";
	}
	
	@PostMapping("/qnaReply")
	@ResponseBody
	public Map<String, Object> qnaReply(QnaVo qnaVo) {
		qnaVo.setId("관리자");
		qnaVo.setStatus("문의답변");
		qnaVo.setType("문의답변");
		qnaVo.setSubject("답변");
		
		boolean isSuccess = serviceCenterSerivce.addQnaReply(qnaVo.getReRef(), qnaVo);
		
		Map<String, Object> msg = new HashMap<String, Object>();
		msg.put("isSuccess", isSuccess);
		
		return msg;
	}
	
	@GetMapping("/qnaReplyModify")
	public String qnaReplyModify(int refNum, int replyNum, int pageNum, Model model, String form) {
		
		List<QnaVo> qnaList = serviceCenterSerivce.getQnaContentByRef(refNum);
		for(QnaVo qna : qnaList) {
			qna.setContent(qna.getContent().replaceAll("(\r\n|\r|\n|\n\r)", "<br>"));
		}
		log.info("get - replyNum : " + replyNum);
		log.info("get - form : " + form);
		model.addAttribute("qnaVo", qnaList.get(0));
		model.addAttribute("reply", qnaList.get(1));
		model.addAttribute("replyNum", replyNum);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("form", form);
		return "/serviceCenter/qnaAnswerForm";
	}
	
	@PostMapping("/qnaReplyModify")
	@ResponseBody
	public Map<String, Object> qnaReplyModify (int num, String content){
		log.info("post - num : " + num);
		log.info("post - content : " + content);
		boolean isSuccess = serviceCenterSerivce.updateQnaReplyContent(num, content);
		
		Map<String, Object> updateIsSuccess = new HashMap<>();
		updateIsSuccess.put("isSuccess", isSuccess);
		
		return updateIsSuccess;
	}
	
	@PostMapping("/qnaReplyDelete")
	@ResponseBody
	public Map<String, Object> qnaReplyDelete (int num, int reRef) {
		boolean check = serviceCenterSerivce.deleteQnaContent(num, reRef);
		
		Map<String, Object> deleteIsSuccess = new HashMap<>();
		deleteIsSuccess.put("isSuccess", check);
		
		return deleteIsSuccess;
	}
	
	@GetMapping("/qna/{num}")
	@ResponseBody
	public Map<String, Object> qnaNumContent(@PathVariable("num") int num, Model model) {

		// 상세보기 대상 글내용 VO로 가져오기
		List<QnaVo> qnaList = serviceCenterSerivce.getQnaContentByRef(num);
		
		for(QnaVo qna : qnaList) {
			qna.setContent(qna.getContent().replaceAll("(\r\n|\r|\n|\n\r)", "<br>"));
		}

		Map<String, Object> qnaContent = new HashMap<>();
		
		qnaContent.put("qnaVo", qnaList.get(0));
		if(qnaList.size() > 1)
			qnaContent.put("reply", qnaList.get(1));
		return qnaContent;
	}
	
	@GetMapping("/qnaDelete")
	public String qnaDelete(int num, String pageNum, RedirectAttributes rttr) {
		// 글번호에 해당하는 글 한개 삭제하기
		serviceCenterSerivce.deleteQnaContent(num);

		// 글목록 페이지로 리다이렉트 이동시키기
		rttr.addAttribute("pageNum", pageNum);

		return "redirect:/customerCenter/qnaList";
	} // delete

	@GetMapping("/qnaModify")
	public String qnaModify(int num, @ModelAttribute("pageNum") String pageNum, Model model) {
		// 글번호 num에 해당하는 글내용 VO로 가져오기
		QnaVo qnaVo = serviceCenterSerivce.getQnaContentByNum(num);
		qnaVo.setContent(qnaVo.getContent().replaceAll("(\r\n|\r|\n|\n\r)", "<br>"));

		model.addAttribute("qnaVo", qnaVo);

		return "/serviceCenter/qnaModifyForm";
	} // GET - modify

	@PostMapping("/qnaModify")
	public String qnaModify(QnaVo qnaVo, String pageNum, RedirectAttributes rttr) {

		serviceCenterSerivce.updateQnaContent(qnaVo);

		rttr.addAttribute("num", qnaVo.getNum());
		rttr.addAttribute("pageNum", pageNum);

		// 수정된 글의 상세보기 화면으로 리다이렉트 이동
		return "redirect:/customerCenter/qnaContent";
	} // POST - modify

}
