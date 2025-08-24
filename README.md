1- apt install ssa ssacli -y<br>
2- add the script ssa-wrapper.sh in /opt/smartstorageadmin/ssa/<br>
3- chmod +x ssa-wrapper.sh<br>
4- create  /etc/systemd/system/ssa-wrapper.service <br>
5- systemctl daemon-reload<br>
6- systemctl enable --now ssa-wrapper<br>
7- systemctl status ssa-wrapper to check service<br>
8- acces to the webui with http://SERVER_IP:8443
