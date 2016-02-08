# Tahoe LAFS application with Docker-Compose
Why doing Tahoe LAFS on Docker ?

I'm working on an embedded distributed computing project based on containers and ARM boards. The data sharing was the remaining part not currently handled by the project.
After looking at multiple distributed filesystems, Tahoe LAFS seems to be the most modular one thanks to its peer-to-peer approach.
I looked also at Ceph but it creates an internal topology realying on a static IP mapping which makes it hard to use in a dynamic and containerized environment.

Each embedded device (eg. Raspberry PIs) will have its own storage node to store data loaded to the grid.
Each node will also provide a local SFTP connection which will be mounted locally through SSHFS.

The next version will support VDI as well file sharing with Owncloud but for now this should ensure proper data replication across all the devices.

## Quickstart
Pre-requisites (not tested with lower versions):

     * Docker 1.10.0 to host Tahoe environment
     * Docker-compose 1.6.0 to build the environment 

Thanks to the SFTP connection (user: tahoe / password: passw0rd), it is possible to access locally or remotely to the filesystem.
Just ensure you use the right port pointing to tcp/8022.

* Step 1 : Clone the repo : 

		git clone https://github.com/besn0847/tahoe-app.git

* Step 2 : Build the images : 

		cd tahoe-app && docker-compose -f common.yml build

* Step 3 : Bootstrap the environment :

		docker-compose up -d

You can now start and stop storage node containers. Stopping the introducer or gateway containers will break the filesystem for now.
Now point you favorite SFTP client to the gateway node and connect to the port translated from tcp/8022.
Then just login as tahoe/passw0rd.

## Architecture
The overall architecture is very simple :

* 1 container to provide the introducer services
* 5 containers to act as storage nodes
* 1 container acting as the filesystem gateway (FTP or SFTP)

Note : i did not test the FTP connectivity but should work as well.

## Operations
Compared to my other tentative with Ceph, it is possible to start and stop the system as this is a true P2P topology.

### - App bootstrap & start-up
First and foremost, you need to download the app topo builder from Github :

     git clone https://github.com/besn0847/tahoe-app.git

Then you need to build the container images

     cd tahoe-app && docker-compose -f common.yml build

Once the images have been built (take less than 5 minutes depending on your network speed), just kick off the app:

     docker-compose up -d

Tahoe LAFS is extremely fast to start so you should be able to connect thru SFTP in less than 1 minutes.

	docker-compose ps
		   Name                 Command               State        	Ports
		----------------------------------------------------------------------------------------------------------------
		gateway      /bin/sh -c /startup.sh           Up      		3456/tcp, 0.0.0.0:32793->8021/tcp, 0.0.0.0:32792->8022/tcp
		introducer   /bin/sh -c tahoe  start /e ...   Up      		0.0.0.0:32786->3456/tcp, 44190/tcp
		tahoe1       /bin/sh -c tahoe  start /e ...   Up      		0.0.0.0:32790->3456/tcp, 8097/tcp
		tahoe2       /bin/sh -c tahoe  start /e ...   Up      		0.0.0.0:32791->3456/tcp, 8097/tcp
		tahoe3       /bin/sh -c tahoe  start /e ...   Up      		0.0.0.0:32787->3456/tcp, 8097/tcp
		tahoe4       /bin/sh -c tahoe  start /e ...   Up      		0.0.0.0:32788->3456/tcp, 8097/tcp
		tahoe5       /bin/sh -c tahoe  start /e ...   Up      		0.0.0.0:32789->3456/tcp, 8097/tcp

To check the Tahoe deployment, connect to the gateway node :

     sftp -P <8022_exposed_port> tahoe@localhost

Alternatively you can connect to any node with your favorite web browser and check the LAFS status :

	 http://127.0.0.1:<3456_exposed_port>
	 
### - App  ops
You can simply stop the app with the following command line from the tahoe-app directory :

     docker-compose stop

You can also connect to any container and investigate the logs in /var/log :

     docker exec -t -i <container_name> /bin/bash


## References
* Main Tahoe LAFS website : [here](https://tahoe-lafs.org/trac/tahoe-lafs)
* A first good tutorial : [here](https://tahoe-lafs.org/trac/tahoe-lafs/wiki/Tutorial)
* Another one but in French this time: [here](https://chiliproject.tetaneutral.net/projects/tetaneutral/wiki/Installation_et_Configuration_de_TAHOE-LAFS)

## Issues
No issue identified so far except when running the 'docker-compose -f common.yml build' command. On my Windows, it does not build the container images in the right order.
Make sure the base one is created first.

## Future
* No SPOF such as the gateway or the introducer
* Use of the Alpine Linux raw image for lower footprint
* Test on a Docker Swa<rm cluster with dedicated network
* Port to ARM embedded device for internet-wide storage cluster based on Docker
