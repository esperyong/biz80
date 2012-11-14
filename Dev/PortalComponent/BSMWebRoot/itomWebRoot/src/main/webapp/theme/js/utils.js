/**
 * @desc 主要是存放js相关的工具类
 * 现有排序、分页、地址参数拼装
 * Copyright © Mocha Software Co.,Ltd.
 * @Create:2009-2-19<br>
 * @author:linhh@mochasoft.com.cn<br>
*/

/**
 * Title:SortTable<br>
 * @desc 排序对象(只能排序当前页面，但可以结合脚本分页进行分页排序)<br>
 *
 * @param tableId	表格ID
 * @param imgPath	图片目录	(如：当前目录："."，其他目录："webapp/the/images")
 * @param hasNo(布尔值)	是否有序号(默认为第一列)
 * @param isDebug(布尔值)	是否显示debug信息
 */
function SortTable(tableId, imgPath, hasNo, isDebug) {
	this.img_path = imgPath;
	this.asc_img_red = "st-paixus-red.gif";
	this.desc_img_red = "st-paixu-red.gif";
	this.asc_img = "st-paixus.gif";
	this.desc_img = "st-paixu.gif";
	this._no = 0;

	if(isDebug) {
		this.is_debug = true;
	} else {
		this.is_debug = false;
	}

	if(hasNo) {
		this._hasNo = true;
	} else {
		this._hasNo = false;
	}

	this.pre_sort_col = null;
	this.pre_sort = null;
	this.tableObj = document.getElementById(tableId);

	if (typeof SortTable._initialized == 'undefined') {

		/**
		 * 设置排序图片
		 * @param ascImgRed		选中升序时显示的图片
		 * @param descImgRed	选中降序时显示的图片
		 * @param ascImg		升序时显示的图片
		 * @param descImg		降序时显示的图片
		 */
		SortTable.prototype.setImg = function (ascImgRed, descImgRed, ascImg, descImg) {
			this.asc_img_red = ascImgRed;
			this.desc_img_red = descImgRed;
			this.asc_img = ascImg;
			this.desc_img = descImg;
		};

		/**
		 * 设置序号所在列数
		 * @param no		列数
		 */
		SortTable.prototype.setNoColumn = function (no) {
			this._no = Number(no);
		};

		/**
		 * 生成比较器
		 * @param order(布尔值) true 升序， false 降序
		 * @param column(整型) 要排序的列
		 * @param type		   要排序的列的数据类型
		 */
		SortTable.prototype.generateComparator = function(order, column, type, isIP) {
			var _sort = 1;
			if (order) {
				_sort = 1;
			} else {
				_sort = -1;
			}
			function chgIP(ip) {
				var ips = ip.split('.');
				ip = '';
				for(var i=0; i<ips.length; i+=1) {
					var temp = ips[i];
					var k=temp.length;
					while(k<3) {
						temp = '0'+temp;
						k=temp.length;
					}
					ip += temp;
				}
				return ip;
			};
			/**
			 * 转换值类型
			 * @param value 被转换的值
			 * @param type 要转换的类型
			 */
			function convert (value, type) {
				switch (type) {
					case 1:
						return Number(value);
					case 2:
						return Date.parse(value);
					default:
						return value;
				}
			};
			return function compare(oTR1, oTR2) {
				var value1 = oTR1.cells[column].innerText;
				var value2 = oTR2.cells[column].innerText;
				if(isIP) {
					value1 = chgIP(value1);
					value2 = chgIP(value2);
					type = 1;	//数值型
				}
				value1 = convert(value1, type);
				value2 = convert(value2, type);
				if(type == 0) {
					if (value1.localeCompare(value2) < 0) {
						return -_sort;
					} else if (value1.localeCompare(value2) > 0) {
						return _sort;
					} else {
						return 0;
					}
				} else {
					if (value1 <value2) {
						return -_sort;
					} else if (value1 > value2) {
						return _sort;
					} else {
						return 0;
					}
				}
			};
		};

		/**
		 * 修改显示排序图片
		 * @param order(布尔值) true 升序， false 降序
		 */
		SortTable.prototype.changeImg = function (order, obj) {
			if(this.pre_sort_col == null) {
			} else {
				if(this.pre_sort != null) {
					if(this.pre_sort) {
						this.pre_sort_col.src = this.img_path + '/' + this.asc_img;
					} else {
						this.pre_sort_col.src = this.img_path + '/' + this.desc_img;
					}
				}
			}
			if(order) {
				obj.src = this.img_path + '/' + this.asc_img_red;
			} else {
				obj.src = this.img_path + '/' + this.desc_img_red;
			}

			this.pre_sort_col = obj;
			this.pre_sort = order;
		};


		/**
		 * 排序(表格的绘制一定要用thead和tbody)
		 * @param order(布尔值) true 升序， false 降序
		 * @param column(整型) 要排序的列(从0开始)
		 * @param type(整型)	   要排序的列的数据类型(数值型：1，日期型：2，字符串：0)
		 * @param obj		   排序图片
		 * @param isIP(布尔值) true IP地址排序，false 非IP地址
		 */
		SortTable.prototype.sort2 = function (order, column, type, obj, isIP) {
			var oTBody = this.tableObj.tBodies[0];
			var dataRows = oTBody.rows;
			var aTRs = new Array();
			for ( var i = 0; i < dataRows.length; i+=1) {
				aTRs.push(dataRows[i]);
			}
			aTRs.sort(this.generateComparator(order, Number(column), Number(type), isIP));

			if(this._hasNo) {
				for(var _i=0; _i<aTRs.length; _i++) {
					aTRs[_i].cells[this._no].innerText = _i+1;
				}
			}

			this.changeImg(order, obj);
			var oFragment = document.createDocumentFragment();
			for (i = 0; i < aTRs.length; i+=1) {
				oFragment.appendChild(aTRs[i]);
			}
			oTBody.appendChild(oFragment);
		};

		/**
		 * 排序(表格的绘制一定要用thead和tbody)
		 * @param order(布尔值) true 升序， false 降序
		 * @param column(整型) 要排序的列(从0开始)
		 * @param type(整型)	   要排序的列的数据类型(数值型：1，日期型：2，字符串：0)
		 * @param obj		   排序图片
		 */
		SortTable.prototype.sort = function (order, column, type, obj) {
			this.sort2(order, column, type, obj, false);
		};

		SortTable._initialized = true;
	}
}


/**
 * Title:Pagination<br>
 * @desc 分页对象(建议：当总记录数超过1000条时，不要使用该脚本分页)<br>
 *
 * @param tableId	表格ID(表格的绘制一定要用thead和tbody)
 * @param pageSize	页面容量大小
 * @param isDebug(布尔值)	是否显示debug信息
 */
function Pagination(tableId, pageSize, isDebug) {
	this.page_size = Number(pageSize);
	this.current_page_num = 1;
	this._tbodyObj = document.getElementById(tableId).tBodies[0];
	this.all_records = this._tbodyObj.rows.length;
	if(isDebug) {
		this.is_debug = true;
	} else {
		this.is_debug = false;
	}


	if (typeof Pagination._initialized == 'undefined') {

		/**
		 * 计算总页数
		 */
		Pagination.prototype.countTotalPage = function () {
			this.total_page = parseInt((this.all_records + this.page_size - 1)/this.page_size);
		};

		/**
		 * 设置页面容量
		 * @param pageSize
		 */
		Pagination.prototype.setPageSize = function (pageSize) {
			try {
				this.page_size = Number(pageSize);
				this.countTotalPage();
			} catch(e) {
				if(this.is_debug) {
					window.alert('set page size:' + pageSize + e);
				}
			}
		};

		/**
		 * 规范页码<BR>
		 * 超出最大页数时，返回最后一页
		 * 小于1时，返回第一页
		 * @param pageNum
		 */
		Pagination.prototype.coordinatePageNum = function (pageNum) {
			if(pageNum < 1){
				pageNum = 1;
			}else if(pageNum > this.total_page){
				pageNum = this.total_page;
			}
			if(this.is_debug) {
				window.alert('current page number:' + pageNum);
			}
			return pageNum;
		};

		/**
		 * 分页处理
		 * @param pageNum
		 */
		Pagination.prototype.showHiddenRecord = function (pageNum) {
			var startRecord = this.page_size * (pageNum - 1);
			var endRecord = this.page_size * pageNum;
			var i = 0;
			for(; i<this.all_records; i++) {
				if(i>=startRecord && i<endRecord) {
					this._tbodyObj.rows[i].style.display='';
				} else {
					this._tbodyObj.rows[i].style.display='none';
				}
			}
		};

		/**
		 * 跳转到指定的页码
		 *  超出最大页数时，返回最后一页
		 * 小于1时，返回第一页
		 * @param pageNum
		 * @return 返回当前显示的页码
		 */
		Pagination.prototype.gotoPageByNum = function (pageNum) {
			var page_num = this.coordinatePageNum(parseInt(pageNum));
			this.current_page_num  = page_num;
			this.showHiddenRecord(page_num);
			return page_num;
		};

		/**
		 * 首页
		 * @return 返回当前显示的页码
		 */
		Pagination.prototype.firstPage = function () {
			return this.gotoPageByNum(1);
		};

		/**
		 * 最后一页
		 * @return 返回当前显示的页码
		 */
		Pagination.prototype.lastPage = function () {
			return this.gotoPageByNum(this.total_page);
		};

		/**
		 * 前一页
		 * @return 返回当前显示的页码
		 */
		Pagination.prototype.prePage = function () {
			return this.gotoPageByNum(this.current_page_num - 1);
		};

		/**
		 * 下一页
		 * @return 返回当前显示的页码
		 */
		Pagination.prototype.nextPage = function () {
			return this.gotoPageByNum(this.current_page_num + 1);
		};

        Pagination._initialized = true;
	}

	this.countTotalPage();
}



/**
 * Title:EncapsulateURL<br>
 * @desc 地址拼装(不支持中文)<br>
 * 注意：长度不能超过2048个字符<br>
 * 修改历史:<br>
 * 修改人		修改日期		修改描述<br>
 * -------------------------------------------<br>
 * <br>
 * <br>
 */
function EncapsulateURL(urlpage) {
	this.page_url = urlpage;
	this.is_first = true;

	if (typeof EncapsulateURL._initialized == 'undefined') {

		/**
		 * 获取URL
		 * @return
		 */
		EncapsulateURL.prototype.toString = function () {
			return this.page_url;
		};

		/**
		 * 添加地址参数
		 * @param paramName
		 * 不允许有特殊字符：+，/，?，%，#，&<br>
		 * @param value<br>
		 * 作如下转换:<br>
		 * 特殊含义                           十六进制值<br>
		 * + 表示空格（在 URL 中不能使用空格）	%20 <br>
		 * / 分隔目录和子目录					%2F <br>
		 * ? 分隔实际的 URL 和参数				%3F <br>
		 * % 指定特殊字符						%25 <br>
		 * # 表示书签							%23 <br>
		 * & URL 中指定的参数间的分隔符			%26 <br>
		 */
		EncapsulateURL.prototype.addParam = function (paramName, value) {
			if(null != value && undefined != value) {
				if(this.is_first) {
					this.page_url += '?';
					this.is_first = false;
				} else {
					this.page_url += '&';
				}
				this.page_url += paramName;
				this.page_url += '=';

				this.page_url += encodeURIComponent(value);
			}
		};

		EncapsulateURL._initialized = true;
	}
}