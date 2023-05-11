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

/**
 * 这是一个种子的控制器， 用于处理种子的相关请求。
 * 包括种子的增删改查。
 */
@Controller
@RequestMapping("seed")
public class SeedController {

	@Autowired
	private SeedService seedService;

	@RequestMapping("grid")
	public String grid() {
		return "seed/grid";
	}

	/**
	 * 这是获取所有信息的API
	 * @param pageRequest 分页请求
	 * @param seedName 种子名称，如果为空则查询所有种子信息，否则根据种子名称查询
	 * @return 返回种子信息
	 */
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

	/**
	 * 这是一个保存种子信息的API
	 * @param seed 需要保存的种子信息
	 * @return 返回保存结果
	 */
	@RequestMapping(value = "save", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Message save(Seed seed) {
		return seedService.save(seed);
	}

	/**
	 * 这是一个删除种子信息的API
	 * @param request http请求，用于获取需要删除的种子id
	 * @return 返回删除结果
	 */
	@RequestMapping(value = "delete", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Message delete(HttpServletRequest request) {
		long id = DataUtils.ParseInt(request.getParameter("id"));
		return seedService.delete(id);
	}
}