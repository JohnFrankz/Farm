package cn.jxufe.controller;

import cn.jxufe.bean.EasyUIData;
import cn.jxufe.bean.EasyUIDataPageRequest;
import cn.jxufe.bean.Message;
import cn.jxufe.entity.Seed;
import cn.jxufe.service.SeedService;
import cn.jxufe.utils.DataUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("seed")
public class SeedController {

	@Autowired
	private SeedService seedService;

	@RequestMapping("grid")
	public String grid() {
		return "seed/grid";
	}

	@RequestMapping(value = "data", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public EasyUIData<Seed> gridData(EasyUIDataPageRequest pageRequest,
									 @RequestParam(defaultValue = "") String seedName) {
		List<Sort.Order> orders = new ArrayList<>();
		Direction direction = pageRequest.getOrder().equals("asc") ? Direction.ASC : Direction.DESC;
		orders.add(new Sort.Order(direction, pageRequest.getSort()));
		Pageable pageable = new PageRequest(pageRequest.getPage() - 1, pageRequest.getRows(), new Sort(orders));
		EasyUIData<Seed> data;

		if ("".equals(seedName)) {
			data = seedService.list(pageable);
		} else {
			data = seedService.findBySeedNameLike(seedName, pageable);
		}
		return data;
	}

	@RequestMapping(value = "save", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Message save(Seed seed) {
		return seedService.save(seed);
	}

	@RequestMapping(value = "delete", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Message delete(HttpServletRequest request) {
		long id = DataUtils.ParseInt(request.getParameter("id"));
		return seedService.delete(id);
	}
}
