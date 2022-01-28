#!/user/bin/env python
# encoding:utf-8

import os
import json
import urllib
import base64

data = {"ProxyBook": {"shadowsocks": ["tcp", "127.0.0.1:8880"]}, "BindAddr": [":8443"], "BypassUID": [], "RedirAddr": "www.bing.com", "PrivateKey": "xxxx", "AdminUID": "xxxx", "DatabasePath": "userinfo.db"}
cloak_port = input('Cloak 端口:')
cloak_ss_port = input('Shadowsocks 监听 ip + 端口 ("127.0.0.1:8080"):')
cloak_domain = input('伪装域名:')
data['BindAddr'] = cloak_port
data["ProxyBook"]["shadowsocks"][1] = cloak_ss_port
data['RedirAddr'] = cloak_domain
f = open('/usr/local/etc/cloak/ck-server.json', 'w')
os.system('/usr/local/bin/ck-server -k > /tmp/Cloak.txt')
cloak_privatekey = os.popen("cat /tmp/Cloak.txt | awk -F ',' '{print $2}'").read().strip('\n')
cloak_adminuid = os.popen("/usr/local/bin/ck-server -u | awk '{print $1}'").read().strip('\n')
data["PrivateKey"] = cloak_privatekey
data["AdminUID"] = cloak_adminuid
json_data = json.dumps(data, indent=4)
f.write(json_data)
print(json_data)



def gen_ss_url():
    ss_ip = os.popen("curl ifconfig.me").read().strip('\n')
    json_data = json.dumps(data, indent=4)
    ss_port = json_data["server_port"]
    ss_password = json_data["password"]
    ss_method = json_data["method"]
    ss_url = []
    win_ss_url = "ss://" + "@" + ss_ip + ":" + ss_port + "/"
    # rocket_url = "ss://" + 
    ss_url.append(win_ss_url)
    return ss_url

cloak_publickey = os.popen("cat /tmp/Cloak.txt | awk -F ',' '{print $1}'").read().strip('\n')
claok_url_befor = "Transport=direct;ProxyMethod=shadowsocks;EncryptionMethod=plain;UID=" + cloak_adminuid +  ";PublicKey=" + cloak_publickey + ";ServerName=" + cloak_domain + ";NumConn=4;BrowserSig=chrome;StreamTimeout=300"
# urldecode
urllib.unquote("")
# uerlencoode
urllib.quote("")

print(claok_url_befor)
print(urllib.quote(claok_url_befor))

# json file read to strings
# cat /usr/local/etc/cloak/ck-server.json | python -c 'import json,sys;obj=json.load(sys.stdin);print obj;'