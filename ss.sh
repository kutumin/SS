cd /etc/yum.repos.d
curl -O https://copr.fedorainfracloud.org/coprs/librehat/shadowsocks/repo/epel-7/librehat-shadowsocks-epel-7.repo
yum -y install shadowsocks-libev
setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/ss-server
cat > /etc/shadowsocks-libev/config.json << 'EOF'
{
  "server": "0.0.0.0",
  "server_port": 443,
  "password": "p@$$w0rd",
  "method": "aes-128-gcm"
}
EOF
systemctl enable shadowsocks-libev --now
systemctl enable firewalld --now
firewall-cmd --add-port=443/tcp --permanent
systemctl restart firewalld
