#!/usr/bin/env python
# encoding: utf-8

import os
import json
import urllib
import base64

def gen_ss_claok_url(ss_config_path, claok_server_config_path, claok_client_config_path):
    # Shadowsocks 服务器配置文件
    ss_f = open(ss_config_path, 'r')
    ss_ip = os.popen("curl -s ifconfig.me").read().strip('\n')
    ss_json_data = json.load(ss_f)
    ss_password = ss_json_data["password"]
    ss_method = ss_json_data["method"]
    ss_f.close()
    # Cloak 服务器配置文件
    claok_s_f = open(claok_server_config_path, 'r')
    claok_s_json_data = json.load(claok_s_f)
    # 取 Cloak 服务端的端口
    cloak_s_port = str(claok_s_json_data["BindAddr"][0]).split(":")[1]
    claok_s_f.close()
    # # Cloak 客户端配置文件
    claok_c_f = open(claok_client_config_path, 'r')
    claok_c_json_data = json.load(claok_c_f)
    cloak_uid = claok_c_json_data["UID"]
    cloak_publickey = claok_c_json_data["PublicKey"]
    claok_c_f.close()
    # Shadowsocks 的端口替换为 Claok 的端口
    win_ss_url = "ss://" + base64.b64encode(ss_method + ':' + ss_password) + "@" + str(ss_ip) + ":" + str(cloak_s_port) + "/"
    cloak_url_befor = "Transport=direct;ProxyMethod=shadowsocks;EncryptionMethod=plain;UID=" + cloak_uid \
                        + ";PublicKey=" + cloak_publickey \
                        + ";ServerName=www.bing.com;NumConn=4;BrowserSig=chrome;StreamTimeout=300"
    claok_url = urllib.quote(cloak_url_befor)
    ss_claok_url = win_ss_url + "?plugin=ck-client;" + claok_url
    return ss_claok_url

print("ss scheme url")
# 传入 Shadowsocks 配置文件路径 和 Cloak 客户端的配置
print(gen_ss_claok_url("/usr/local/etc/ss-libve/config.json", "/usr/local/etc/cloak/ck-server.json", "/usr/local/etc/cloak/ck-client.json"))