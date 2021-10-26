package com.example.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;



// 회원 로그인 상태 유지 용도의 인터셉터 클래스 정의
@Component
public class UserStayLoggedInInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		// 요청 사용자의 세션 가져오기
		HttpSession session = request.getSession();
		
		// 세션에 로그인 아이디가 이미 있으면
		// 로그인 상태유지용 쿠키객체 찾는작업 안하고 종료
		String id = (String) session.getAttribute("id");
		if (id != null) {
			return true;
		}
		
		
		// 로그인 상태유지 쿠키정보 가져오기
		Cookie[] cookies = request.getCookies();
		// 쿠키 name이 "id"인 쿠키객체 찾기
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("id")) {
					id = cookie.getValue();
					
					// 로그인 인증 처리(세션에 id값 추가)
					session.setAttribute("id", id);
				}
			}
		}
		return true;
	} // preHandle
}
