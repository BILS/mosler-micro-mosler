# µ-Mosler setup on Knox

This set of scripts allows you to create a test environment in an
Openstack cluster, called Knox. Knox uses the
[Liberty version of Openstack](http://docs.openstack.org/liberty/install-guide-ubuntu/).

The created set of virtual machines on Knox contains itself an
openstack installation (the
[mitaka version](http://docs.openstack.org/mitaka/install-guide-rdo/)),
often called the over-cloud (with respect to Knox being the
under-cloud). The over-cloud boots VMs that are the base for testing
the connection to the [ePouta cloud](https://research.csc.fi/epouta).

We will then use the over-cloud to implement
[Mosler](https://bils.se/resources/mosler.html) and further improve or
extend it (codenamed µ-Mosler).

## Requirements
You first need to create a file (named 'user.rc') in order to set up
your openstack credentials. That file will contain 3 variables:

	export OS_TENANT_NAME=<tenant-name>
	export OS_USERNAME=<username>
	export OS_PASSWORD=<password>

This user must have the admin role for the given tenant/project. These
settings will probably be given to you by your _openstack administrator_.

The scripts define some variables (in `lib/settings.sh`)
* `MM_HOME` (that current folder)
* `TL_HOME` (currently pointing to `/home/jonas/thinlinc`)

The scripts assume that 
* A CentOS7 glance image is installed
* The Thinlinc packages are available in `$TL_HOME`

## Execution
You can run `micromosler init --net` in order to create the necessary routers,
networks and security groups, prior to creating the virtual machines.
It will start the VMs with proper IP information. In subsequent runs,
`micromosler init` will only create the VMs.

Run `micromosler sync` in order to copy the required files to the
appropriate servers (along with installing the required packages).

Run `micromosler provision` in order to provision each VM. This
configures the servers. The task should be idempotent.

Run `micromosler reset` if you want to erase for the provisioning
phase did.

The `micromosler clean` script can be run with the --net flag, to
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
	./micromosler.sh init --net # You'll be prompted at the end for a reboot.
	                            # Rebooting will help the partition to correctly resize to the disk size
	./micromosler.sh sync       # Wait a bit, servers are probably not done rebooting
	./micromosler.sh provision 
	
	# Later
	./micromosler.sh provision # to just re-configure µ-mosler. The task is idempotent.
	./micromosler.sh clean     # to destroy the VMs
	./micromosler.sh init      # to re-create them, but not the networks, routers, etc...
	./micromosler.sh sync      # Wait again a bit, still probably rebooting
	./micromosler.sh reset     # Cleanup inside the VMs
	./micromosler.sh provision # Shoot again...
