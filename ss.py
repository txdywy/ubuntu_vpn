import sys
import json

d = {"server":"0.0.0.0",
     "server_port":8388,
     "local_address":"127.0.0.1",
     "local_port":1080,
     "timeout":300,
     "method":"aes-256-cfb",
     "fast_open":False
    }
p = sys.stdin.readline().strip()
d['password'] = p
t = json.dumps(d)
print t
with open('ss.json', 'w') as f:
    f.write(t)
