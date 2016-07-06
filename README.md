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

The scripts define some variables (in `lib/settings.sh`)
* `MM_HOME` (that current folder)
* `TL_HOME` (currently pointing to `/home/jonas/thinlinc`)
* `MOSLER_IMAGES` (currently pointing to `/home/jonas/mosler-images`)

The scripts assume that 
* A CentOS6 glance image is installed
* The Thinlinc packages are available in `$TL_HOME`
* And the mosler images are available in `$MOSLER_IMAGES`

## Execution
You can run `micromosler.sh init --all` in order to create the necessary routers,
networks and security groups, prior to creating the virtual machines.
It will start the VMs with proper IP information. In subsequent runs,
`micromosler.sh init` will only create the VMs.

Run `micromosler.sh sync` in order to set up the ssh environment and
copy the required files to the appropriate servers (along with
installing the required packages).

Run `micromosler.sh provision` in order to set up the ssh environment
and provision each VM. This configures the servers. The task should be
idempotent.

The `micromosler.sh clean` script can be run with the --all flag, to
destroy routers, networks, security groups and floating IPs.
Otherwise, it only deletes the running VMs.

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
	#
	#...and cue music!
	./micromosler.sh init --all # You'll be prompted at the end for a reboot.
	                            # Rebooting will help the partition to correctly resize to the disk size
	./micromosler.sh sync       # Wait a bit, servers are probably not done rebooting
	./micromosler.sh provision 
	
	# Later
	./micromosler.sh provision # to just re-configure µ-mosler. The task is idempotent.
	./micromosler.sh clean     # to destroy the VMs
	./micromosler.sh init      # to re-create them, but not the networks, routers, etc...
	./micromosler.sh sync      # Wait again a bit, still probably rebooting
	./micromosler.sh provision # shoot again...
