
<!-- ABOUT THE Notes -->
## About The Notes
Clone this into jump-instance

Configure host.ini file with master and worker nodes

Then
### Requirements
- install ansible to jump instance that you created with terraform templates


### Run

ssh all-instances with private-key at least once.
change host.ini then Ready to go

- ansible-playbook main.yml -i host.ini --private-key ~/.ssh/id_rsa -u ubuntu

### Dones
-

### For next improvements
- 