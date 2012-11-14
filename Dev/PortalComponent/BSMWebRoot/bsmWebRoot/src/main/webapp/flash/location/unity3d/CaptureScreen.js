            var totalCount = 0;
            var pngstr;
            var fetchback = true;
            
            //向Unity请求截图
            function testCreatePng(fetchNow)
            {
                //alert("testCreatePng OK")
                fetchback = fetchNow;
                
                var max = 16000;
                GetUnity().SendMessage("root", "createPng", max);
                
                return true;
            }

            //Unity完成截图，通知页面需要多少次才能够完成请求
            function testCreatePngResult(count)
            {
                //alert(count);
                
                totalCount = count;
                pngstr = "";                
                
                if (fetchback)
                {
                    startGetPngData();
                }
            }
            
            function startGetPngData()
            {
                GetUnity().SendMessage("root", "getPng", 0);
            }
            
            //按指定的次序获取png数据
            function getPngResult(index, base64Str)
            {
                pngstr += base64Str;
                //alert(index + ": " + base64Str);
                if (index+1 < totalCount)
                    GetUnity().SendMessage("root", "getPng", index+1);
                else
                {
                    completeGetPng()
                }
            }
