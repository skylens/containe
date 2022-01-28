#!/usr/bin/env python3
# encoding: utf-8

import os
import json

# 生成 uid 
cloak_adminuid = os.popen("/usr/local/bin/ck-server -u | awk '{print $1}'").read().strip('\n')
# client uid 和 server 端 adminuid 相同
cloak_uid = cloak_adminuid
# 生成 Private Key 和 Public key
os.system('/usr/local/bin/ck-server -k > /usr/local/etc/cloak/Cloak.txt')

def gen_server_conf(ss_config_path):
    ss_f = open(ss_config_path, 'r')
    ss_json_data = json.load(ss_f)
    # 读取 Shadowsocks 配置中的 server 配置
    ss_port = ss_json_data["server_port"]
    ss_f.close()
    server_data = {u'RedirAddr': u'www.bing.com', u'DatabasePath': u'/usr/local/etc/cloak/userinfo.db',
            u'BindAddr': [u':8443'], u'PrivateKey': u'---Private key here---',
            u'ProxyBook': {u'shadowsocks': [u'tcp', u'127.0.0.1:65535']}, u'AdminUID': u'---Your UID here---',
            u'BypassUID': []}
    f = open('/usr/local/etc/cloak/ck-server.json', 'w')
    cloak_privatekey = os.popen("cat /usr/local/etc/cloak/Cloak.txt | awk -F ',' '{print $2}'").read().strip('\n')
    server_data["PrivateKey"] = cloak_privatekey
    server_data["AdminUID"] = cloak_adminuid
    server_data["ProxyBook"]["shadowsocks"][1] = "127.0.0.1:" + str(ss_port)
    json_data = json.dumps(server_data, indent=4)
    f.write(json_data)
    f.close()

def gen_client_conf():
    client_data = {u'ProxyMethod': u'shadowsocks', u'UID': u'---Your UID here---', u'ServerName': u'www.bing.com',
                   u'NumConn': 4, u'PublicKey': u'---Public key here---', u'EncryptionMethod': u'plain',
                   u'StreamTimeout': 300, u'Transport': u'direct', u'BrowserSig': u'chrome'}
    f = open('/usr/local/etc/cloak/ck-client.json', 'w')
    cloak_privatekey = os.popen("cat /usr/local/etc/cloak/Cloak.txt | awk -F ',' '{print $1}'").read().strip('\n')
    client_data["PublicKey"] = cloak_privatekey
    client_data["UID"] = cloak_uid
    json_data = json.dumps(client_data, indent=4)
    f.write(json_data)
    f.close()


# 生成客户端配置文件
gen_client_conf()
# 传入 Shadowsocks 配置文件路径，生成服务端配置文件
gen_server_conf("/usr/local/etc/ss-libve/config.json")