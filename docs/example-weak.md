# weak-tag for debug

## k8s

 `kc run t1 --rm -it --image=registry.cn-shenzhen.aliyuncs.com/infrastlabs/alpine-ext:weak bash`

- [dns-ping]

```bash
nc -vz 7.0.0.66 53
nc -uvz 7.0.0.66 53

ping svcname.default
ping svcname.ns.t1.k3s
```

- [dig, dnslookup]

```bash
# apt install dnsutils
# yum install bind-utils
# apk add bind-tools

dig +short @172.17.0.171 -p 32009 qq.com
dig +short @7.0.0.68 qq.com

nslookup - 172.17.0.171
>set port=xxx
>qq.com
```
