# mosler-micro-mosler

Requirements:
* Centos6 glance image installed
* Clone of 
git@github.com:BILS/mosler-system-scripts.git
in $HOME
* Thinlinc packages in $HOME/thinlinc

You also need to create a file 'user.rc' that will set up 2 variables:

	OS_USERNAME=<username>
	OS_PASSWORD=<password>


Run the script 'init.sh' with the --all flag if you also wanted to
create the router, networks and security groups.  It will also start a
few VMs with proper IP information.  Run it subsequently without the
--all flag if you only want to (re)create the VMs

The clean.sh script runs similarly: with the --all flag, it will
destroy the router, networks, security groups and floating IPs.
Without it, it only deletes the running VMs.
