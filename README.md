# runc-demo

This is a simple little project to play around with kicking off a container using runc on a host from an init-container.

## init-container

The init-container is our transport/install mechanism for our runc image.  The entrypoint for this container will kick off the init-script
which will copy the rootfs directory and our runc binary on to the host node.  We'll also copy in a systemd file to use to control our service.

## runc image

We're using a simple image to demo runc here, it really doesn't do much; just launches an Alpine container via runc which is set up to print
a simple message out to `/tmp/demo.out` on the host node every 5 seconds.

##  Trying things out

Set an environment variable to point to specify an image tag and be able to push it to your registry (TODO: enable quay options)

### make image

Will build our runc-demo container image (just your usual `docker build` type of thing here), by default it's tag is `jgriffith/runc-demo`. 

### make run

Will launch the runc-demo container we built, the init containers entrypoint will run a simple script to copy all of our files 
to the host machine including a systemd file; and then will try and kick off the runc container using systemd.  After the init-container runs you
should expect to see the runcdemo service running on the host machine:


"""

ubuntu@uplifting-chihuahua:~$ sudo systemctl status runcdemo
● runcdemo.service - runc demo
     Loaded: loaded (/etc/systemd/system/runcdemo.service; enabled; vendor preset: enabled)
     Active: active (exited) since Wed 2020-09-23 11:28:54 MDT; 2h 0min ago
    Process: 25483 ExecStart=/opt/runc-demo/democtl run (code=exited, status=0/SUCCESS)
   Main PID: 25483 (code=exited, status=0/SUCCESS)

Sep 23 11:28:54 uplifting-chihuahua systemd[1]: Starting runc demo...
Sep 23 11:28:54 uplifting-chihuahua systemd[1]: Finished runc demo.

"""

In addition you should also notice an OCI container is running on the host as well:

"""
ubuntu@uplifting-chihuahua:~$ sudo /opt/runc-demo/oci/demo-runc list
ID          PID         STATUS      BUNDLE               CREATED                          OWNER
demo        26808       running     /opt/runc-demo/oci   2020-09-23T17:53:06.382439007Z   root
"""

