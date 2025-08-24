1- apt install ssa ssacli -y
2- add the script ssa-wrapper.sh in /opt/smartstorageadmin/ssa/
3- chmod +x ssa-wrapper.sh
4- create  /etc/systemd/system/ssa-wrapper.service 
5- systemctl daemon-reload
6- systemctl enable --now ssa-wrapper
7- systemctl status ssa-wrapper to check service
8- acces to the webui with http://SERVER_IP:8443
