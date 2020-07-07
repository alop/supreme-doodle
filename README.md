# supreme-doodle

ToDo:

boot 3 t2.micro instances - Bastion, app, web

bastion host:
  - Allow ssh from specific IP or CIDR
  - Allow ssh to app/web VMs on their private networks

make app network, web network
  - Egress blocked

Web VM:
  - webserver/curl installed
  - allow ssh from bastion
  - on web network
  - allow internet 80/443 on public
  - can connect to app VM on 80

App VM:
  - webserver/curl installed
  - allow ssh from bastion
  - on app network
  - ONLY allows port 80 from web network
  - CANNOT connect to Web network on 443
