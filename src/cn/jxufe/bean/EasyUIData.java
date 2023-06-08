package cn.jxufe.bean;

import java.util.ArrayList;
import java.util.List;

/**
 * EasyUIData类是一个通用的数据结构，用于在EasyUI表格中显示数据。
 *
 * @param <T> 数据类型
 */
public class EasyUIData<T> {
	private long total = 0L;
	private List<T> rows = new ArrayList<T>();

	public long getTotal() {
		return total;
	}

	public void setTotal(long total) {
		this.total = total;
	}

	public List<T> getRows() {
		return rows;
	}

	public void setRows(List<T> rows) {
		this.rows = rows;
	}
}
