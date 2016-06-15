# µ-Mosler setup on Knox

This set of scripts allows you to (re)create the
[Mosler environment](https://mosler.bils.se) in an Openstack cluster.
This created set of virtual machines is called µ-Mosler
(*micro-mosler*). Our openstack cluster is called Knox.

## Requirements
You first need to create a file (named 'user.rc') in order to set up your openstack credentials. That file will contain 3 variables:

	export OS_TENANT_NAME=<tenant-name>
	export OS_USERNAME=<username>
	export OS_PASSWORD=<password>

This user must have the admin role for the given tenant/project. These
settings will probably be given to you by your _openstack administrator_.

The scripts define some variables (in `settings.sh`)
* `MM_HOME` (that currently folder)
* `TL_HOME` (currently pointing to `/home/jonas/thinlinc`)
* `MOSLER_HOME` (currently pointing to `/home/jonas/mosler-system-scripts`)
* `MOSLER_MISC` (currently pointing to `/home/jonas/misc`)
* `MOSLER_IMAGES` (currently pointing to `/home/jonas/mosler-images`)

The scripts assume that 
* A CentOS6 glance image is installed
* The [mosler-system-scripts](https://github.com/NBISweden/mosler-system-scripts) are available in `$MOSLER_HOME`
* The Thinlinc packages are available in `$TL_HOME`
* Some misc packages are available in `$MOSLER_MISC`
* And the mosler images are available in `$MOSLER_IMAGES`

## Execution
You can run `init.sh --all` in order to create the necessary routers,
networks and security groups, prior to creating the virtual machines.
It will start the VMs with proper IP information. In subsequent runs,
`init.sh` will only create the VMs.

Run `provision.sh` in order to set up the ssh environment and run the
provisioning scripts for each VM. This script is divided in 2 phases:
the first one copies the required files to the appropriate servers,
and the second one configures the servers.

The `clean.sh` script can be run with the --all flag, to destroy
routers, networks, security groups and floating IPs.  Otherwise, it
only deletes the running VMs.

You can append the `-q` flag to turn off the verbose output.
You can append the `-h` flag to see the command options.

## Example
	git clone https://github.com/NBISweden/mosler-micro-mosler <some_dir>
	cd <that_dir>
	cat > user.rc <<EOF
	export OS_TENANT_NAME=mmosler1 
	export OS_USERNAME=fred
	export OS_PASSWORD=holala
	EOF

	# The openstack user 'fred' must maybe be an admin on the tenant 'mmosler1'
	./init.sh --all # You'll be prompted at the end for a reboot.
	                # Rebooting will help the partition to correctly resize to the disk size
	./provision.sh # Wait a bit, servers are probably not done rebooting
	
	# Later
	./provision.sh # to just re-configure µ-mosler. The task is idempotent.
	./clean.sh     # to destroy the VMs
	./init.sh      # to re-create them, but not the networks, routers, etc...
	./provision.sh # shoot again...
