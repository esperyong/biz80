
var TYPE_STRING = 0;
var TYPE_NUMBER = 1;
var TYPE_DATE = 2;
/**
 * 转换值类型
 * @param value 被转换的值
 * @param type 要转换的类型
 */
function convert(value, type) {
	switch (type) {
	  case 1:
		return Number(value);
	  case 2:
		return Date.parse(value);
	  default:
		return value;
	}
}
/**
 * Title:SortTable<br>
 * Description:排序对象(只能排序当前页面，但可以结合脚本分页进行分页排序)<br>
 * Copyright © Mocha Software Co.,Ltd. 
 * @Create:2008-12-29<br>
 * @author:linhh@mochasoft.com.cn<br>
 * @version:Mocha BSM 7.2<br>
 * 
 * @param tableId	表格ID
 * @param imgPath	图片目录	(如：当前目录："."，其他目录："webapp/the/images")
 * @param isDebug(布尔值)	是否显示debug信息
 */
function SortTable(tableId, imgPath, isDebug) {
	this.img_path = imgPath;
	this.asc_img_red = "st-paixus-red.gif";
	this.desc_img_red = "st-paixu-red.gif";
	this.asc_img = "st-paixus.gif";
	this.desc_img = "st-paixu.gif";
	if (isDebug) {
		this.is_debug = true;
	} else {
		this.is_debug = false;
	}
	this.pre_sort_col = null;
	this.pre_sort = null;
	this.tableObj = document.getElementById(tableId);
	if (typeof SortTable._initialized == "undefined") {
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
		 * 生成比较器
		 * @param sort(布尔值) true 升序， false 降序
		 * @param column(整型) 要排序的列
		 * @param type		   要排序的列的数据类型
		 */
		SortTable.prototype.generateComparator = function (sort, column, type) {
			var _sort = 1;
			if (sort) {
				_sort = 1;
			} else {
				_sort = -1;
			}
			return function compare(oTR1, oTR2) {
				var value1;
				var value2;
				value1 = convert(oTR1.cells[column].innerText, type);
				value2 = convert(oTR2.cells[column].innerText, type);
				if (type == 0) {
					if (value1.localeCompare(value2) < 0) {
						return -_sort;
					} else {
						if (value1.localeCompare(value2) > 0) {
							return _sort;
						} else {
							return 0;
						}
					}
				} else {
					if (value1 < value2) {
						return -_sort;
					} else {
						if (value1 > value2) {
							return _sort;
						} else {
							return 0;
						}
					}
				}
			};
		};
		/**
		 * 修改显示排序图片
		 * @param sort(布尔值) true 升序， false 降序
		 */
		SortTable.prototype.changeImg = function (sort, obj) {
			if (this.pre_sort_col === null) {
			} else {
				if (this.pre_sort !== null) {
					if (this.pre_sort) {
						this.pre_sort_col.src = this.img_path + "/" + this.asc_img;
					} else {
						this.pre_sort_col.src = this.img_path + "/" + this.desc_img;
					}
				}
			}
			if (sort) {
				obj.src = this.img_path + "/" + this.asc_img_red;
			} else {
				obj.src = this.img_path + "/" + this.desc_img_red;
			}
			this.pre_sort_col = obj;
			this.pre_sort = sort;
		};
		/**
		 * 排序(表格的绘制一定要用thead和tbody)
		 * @param sort(布尔值) true 升序， false 降序
		 * @param column(整型) 要排序的列
		 * @param type(整型)	   要排序的列的数据类型(数值型：1，日期型：2，字符串：0)
		 * @param obj		   排序图片
		 */
		SortTable.prototype.sort = function (sort, column, type, obj) {
			var oTBody = this.tableObj.tBodies[0];
			var dataRows = oTBody.rows;
			var aTRs = new Array();
			for (var i = 0; i < dataRows.length; i += 1) {
				aTRs.push(dataRows[i]);
			}
			aTRs.sort(this.generateComparator(sort, column, type));
			for (var j = 0; j < aTRs.length; j++) {
				var m = j + 1;
				aTRs[j].cells[0].innerText = m;
			}
			this.changeImg(sort, obj);
			var oFragment = document.createDocumentFragment();
			for (i = 0; i < aTRs.length; i += 1) {
				oFragment.appendChild(aTRs[i]);
			}
			oTBody.appendChild(oFragment);
		};
		SortTable._initialized = true;
	}
}

