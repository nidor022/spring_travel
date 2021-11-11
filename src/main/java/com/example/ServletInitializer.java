package com.example;

import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

// *** war파일로 배포하기위해서 SpringBootSeveletInitializer를 상속받음
// 외부에서 프로젝트를 구동할때 web.xml이 필요한데 SpringBoot는 없기때문에
// WebApplicationInitializer 인터페이스를 구현한 SpringBootServlet~블라블라를 상속받을 필요가 있음
public class ServletInitializer extends SpringBootServletInitializer {
	
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(SpringPortfolioApplication.class);
	}

}
