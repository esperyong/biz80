/*  
文件名:jquery.select.js  
功能说明:本js文件为jquery类库的一个插件,主要实现对select的操作.  
*/  
//得到select项的个数   
jQuery.fn.size = function(){
	if(this.get(0) && this.get(0).options){
		return this.get(0).options.length;
	}
    return 0;   
}   
  
//获得选中项的索引   
jQuery.fn.getSelectedIndex = function(){   
    return this.get(0).selectedIndex;   
}   
  
//获得当前选中项的文本   
jQuery.fn.getSelectedText = function(){   
    if(this.size() == 0)  return "下拉框中无选项";   
    else{   
        var index = this.getSelectedIndex();         
        return this.get(0).options[index].text;   
    }   
}   
  
//获得当前选中项的值   
jQuery.fn.getSelectedValue = function(){   
    if(this.size() == 0)    
        return "下拉框中无选中值";   
       
    else  
        return this.val();   
}   
  
//设置select中值为value的项为选中   
jQuery.fn.setSelectedValue = function(value){   
    this.get(0).value = value;
    return this;
}   
  
//设置select中文本为text的第一项被选中   
jQuery.fn.setSelectedText = function(text)   
{   
    var isExist = false;   
    var count = this.size();   
    for(var i=0;i<count;i++)   
    {   
        if(this.get(0).options[i].text == text)   
        {   
            this.get(0).options[i].selected = true;   
            isExist = true;   
            break;   
        }   
    }   
    if(!isExist)   
    {   
        alert("下拉框中不存在该项");   
    } 
    return this;
}   
//设置选中指定索引项   
jQuery.fn.setSelectedIndex = function(index)   
{   
    var count = this.size();       
    if(index >= count || index < 0)   
    {   
        alert("选中项索引超出范围");   
    }   
    else  
    {   
        this.get(0).selectedIndex = index;   
    }
    return this;
}   
//判断select项中是否存在值为value的项   
jQuery.fn.isExistItem = function(value)   
{   
    var isExist = false;   
    var count = this.size();   
    for(var i=0;i<count;i++)   
    {   
        if(this.get(0).options[i].value == value)   
        {   
            isExist = true;   
            break;   
        }   
    }   
    return isExist;   
}   
//向select中添加一项，显示内容为text，值为value,如果该项值已存在，则提示   
jQuery.fn.addOption = function(text,value)   
{   
    if(this.isExistItem(value))   
    {   
        alert("待添加项的值已存在");   
    }   
    else  
    {   
        this.get(0).options.add(new Option(text,value));   
    }
    return this;
}
//向select中添加一组选项，数据集合datas，值为vlaueName,显示内容为textName，如果该项值已存在，则提示  
jQuery.fn.addOptions = function(datas,vlaueName,textName)   
{   
	if(datas){
		for(var i=0; i<datas.length; i++){
			this.addOption(datas[i][textName],datas[i][vlaueName]);
		}
	} else {
		alert("选项数据集合不能为空");
	}
	return this;
}
//向select中添加别一个select的全部Option，源选择框srcSelect  
jQuery.fn.addOptionsBySelect = function(srcSelect)   
{   
	if(srcSelect && srcSelect.options){
		this.each(function(){
			$(this).append(srcSelect.innerHTML);
		})
	}
	return this;
}
//删除select中值为value的项，如果该项不存在，则提示   
jQuery.fn.removeItem = function(value)   
{       
    if(this.isExistItem(value))   
    {   
        var count = this.size();           
        for(var i=0;i<count;i++)   
        {   
            if(this.get(0).options[i].value == value)   
            {   
                this.get(0).remove(i);   
                break;   
            }   
        }           
    }   
    else  
    {   
        alert("待删除的项不存在!");   
    }
    return this;
}   
//删除select中指定索引的项   
jQuery.fn.removeIndex = function(index)   
{   
    var count = this.size();   
    if(index >= count || index < 0)   
    {   
        alert("待删除项索引超出范围");   
    }   
    else  
    {   
        this.get(0).remove(index);   
    } 
    return this;
}   
//删除select中选定的项   
jQuery.fn.removeSelected = function()   
{   
    var index = this.getSelectedIndex();   
    this.removeIndex(index);   
    return this;
}   
//清除select中的所有项   
jQuery.fn.clearAll = function()   
{   
    jQuery(this).get(0).options.length = 0; 
    return this;
}