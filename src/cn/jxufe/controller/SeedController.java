package cn.jxufe.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("seed")
public class SeedController {
	
	@RequestMapping("grid")
	public String grid() throws Exception {
		return "seed/grid";
	}
	
}
