var no="至少选择";

(function($) {
	$.fn.validationEngineLanguage = function() {};
	$.validationEngineLanguage = {
		newLang: function() {
			$.validationEngineLanguage.allRules = 	{"required":{    			// Add your regex rules here, you can take telephone as an example
						"regex":"none",
						"alertText":"<font color='red'>*</font> ^^^不允许为空。",
						"alertTextCheckboxMultiple":"* 请选择",
						"alertTextCheckboxe":"* 请选择"},
					"ajax":{},
					"funcCall":{},
					"length":{
						"regex":"none",
						"alertText":"<font color='red'>*</font>^^^的输入长度不能超过 ",
						"alertText2":" 个字符。 "
							//,"alertText3": " 之间"
						},
					"maxCheckbox":{
						"regex":"none",
						"alertText":"<font color='red'>*</font> 请至少选择"},	
					"minCheckbox":{
						"regex":"none",
						"alertText":"<font color='red'>*</font> "+no,
						"alertText2":" 项。"},	
					"minCheckboxByName":{
						"regex":"none",
						"alertText":"<font color='red'>*</font> "+no,
						"alertText2":" 项。"},
					"confirm":{
						"regex":"none",
						"alertText":"<font color='red'>*</font> 您两次填写的内容不完全一致，请重新填写。"},	
//从telephone往下，除了validate2fields，都需要写成如：custom[telephone]的样式
//custom与funcCall的差别在于，custom是使用正则表达式进行验证即可，而funcCall需要写js函数来进行验证。	
					
					"telephone":{
						"regex":"\\d{3}-\\d{8}|\\d{4}-\\d{7}|\\d{8}|\\d{7}",
						"alertText":"<font color='red'>*</font> 无效的电话号码，请重新填写。"},	
					"mobile":{
						"regex":"/^1[3|5|8][0-9]{9}$/",
						"alertText":"<font color='red'>*</font> 无效的手机号码，请重新填写。"},	
					"ipAddress":{
					//	"regex":"/^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[0-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[0-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[0-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[0-9]{1}[0-9]{1}|[0-9])$/",
						"alertText":"<font color='red'>*</font> IP地址无效。"},	
					"macAddress":{
						"regex":"/^[a-fA-F0-9]{2}[:-][a-fA-F0-9]{2}[:-][a-fA-F0-9]{2}[:-][a-fA-F0-9]{2}[:-][a-fA-F0-9]{2}[:-][a-fA-F0-9]{2}$/",
						"alertText":"<font color='red'>*</font> MAC地址无效。"},
					"noLocalIpAddress":{
							//"regex":"/^(([02-9][0-9]{0,2}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})|(1[013-9]{0,1}[0-9]{0,1}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})|(12[0-68-9]{0,1}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})|(127\.([1-9]{1}|[0-9]{2,3})\.[0-9]{1,3}\.[0-9]{1,3})|(127\.0\.([1-9]{1}|[0-9]{2,3})\.[0-9]{1,3})|(127\.0\.0\.([02-9]|[0-9]{2,3})))$/",
							"nname":"noLocalIpAddress",
							"alertText":"<font color='red'>*</font> 禁止使用127.0.0.1，请重新填写"},							
					"email":{
						"regex":"/^[a-zA-Z0-9_\.\-]+\@([a-zA-Z0-9\-]+\.)+[a-zA-Z0-9]{2,4}$/",
						"alertText":"<font color='red'>*</font> 无效的邮件地址，请重新填写"},	
					"date":{
                         "regex":"/^[0-9]{4}\-\[0-9]{1,2}\-\[0-9]{1,2}$/",
                         "alertText":"<font color='red'>*</font> 日期格式错误，请按照 2012-12-21 这样的格式填写"},
					"noSpecialStr":{
                        "regex":"/^$|^[^'\"%\\\\:?<>|;&@#*]+$/",
						"alertText":"<font color='red'>*</font> ^^^不能输入非法字符('\"%\\:?<>|;&@#*)。"},	
					"noSpecialStr2":{
						"regex":"/^$|^[0-9a-zA-Z_]+$/",
						"alertText":"<font color='red'>*</font> ^^^只能输入数字字母下划线。"},	
					"onlyPositiveNumber":{
						"regex":"/^[1-9]\\d*$/",
						"alertText":"<font color='red'>*</font> 只能是正整数。"},
					"onlyNumber":{
						"regex":"/^[0-9\ ]+$/",
						"alertText":"<font color='red'>*</font> 只能输入数字。"},	
					"noSpecialCaracters":{
						"regex":"/^[0-9a-zA-Z]+$/",
						"alertText":"<font color='red'>*</font> 该项只接受数字和字母的输入。"},	
					"ipOrDomain":{
						"regex":"/^[^\u4e00-\u9fa5\x20]+$/",
						"alertText":"<font color='red'>*</font> 该项只能输入ip地址或域名(不包括http://)。"},	
					"ajaxUser":{
						"file":"createGeneralInfo.action",
						"extraData":"name=eric",
						"alertTextOk":"<font color='red'>*</font> 恭喜，机房名可用",	
						"alertTextLoad":"<font color='red'>*</font> 正在验证，请等待",
						"alertText":"<font color='red'>*</font> 该机房名已被占用，请换个名字试试"},	
					"ajaxName":{
						"file":"validateUser.php",
						"alertText":"<font color='red'>*</font> 该用户名已被占用，请换个名字试试",	
						"alertTextOk":"<font color='red'>*</font> 恭喜，用户名可用",	
						"alertTextLoad":"<font color='red'>*</font> 正在验证，请等待"},
					"noAdminName":{
						"regex":"/^$|^[_0-9a-zA-Z\u4e00-\u9fa5\x20]+$/",
						"alertText":"<font color='red'>*</font> 该项只支持中文,英文,数字,空格和下划线组合"},
					"onlyLetter":{
						"regex":"/^[a-zA-Z\ \']+$/",
						"alertText":"<font color='red'>*</font> 只能输入字母。"},
					"port":{
						"regex":"/^[1-9]$|(^[1-9][0-9]$)|(^[1-9][0-9][0-9]$)|(^[1-9][0-9][0-9][0-9]$)|(^[1-6][0-5][0-5][0-3][0-5]$)/",
						"alertText":"<font color='red'>*</font> ^^^输入的端口号在0~65535之间。"},
					"validateFigruely":{
						//nname:后面自定义一个方法sjNoRules();
						"nname":"validateFigruely",
						"alertText":"<font color='red'>*</font>请选择日期。"},
					"validatePort":{
						"nname":"validatePort",
						"alertText":"<font color='red'>*</font>输入的端口号在0~65535之间。"},
					"validate2fields":{
    					"nname":"validate2fields",
    					"alertText":"<font color='red'>*</font> You must have a firstname and a lastname"},
					"onlyhttporhttps":{
						"regex":"/^https?:\\/\\/\\S*$/",
						"alertText":"<font color='red'>*</font> 第三方系统链接请以“http://或https://”开头"}
					}
					
		}
	}
})(jQuery);

$(document).ready(function() {	
	$.validationEngineLanguage.newLang()
});
