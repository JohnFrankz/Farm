package cn.jxufe.bean;

/**
 * EasyUIDataPageRequest类用于封装EasyUI表格分页请求的参数。
 */
public class EasyUIDataPageRequest {
	private int page = 1;
	private int rows = 1;
	private String sort = "id";
	private String order ="asc";

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}
	
}
