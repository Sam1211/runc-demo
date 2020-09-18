# runc-demo

This is a simple little project to play around with kicking off a container using runc on a host from an init-container.

## init-container

The init-container is our transport/install mechanism for our runc image.  The entrypoint for this container will kick off the init-script
which will copy the rootfs directory and our runc binary on to the host node.  We'll also copy in a systemd file to use to control our service.

## runc image

We're using a simple image to demo runc here, it really doesn't do much; just launches an Alpine container via runc which is set up to print
a simple message out to `/tmp/demo.out` on the host node every 5 seconds.

##  Trying things out

### make image

Will build our runc-demo-init container image (just your usual `docker build` type of thing here). 

### make run

Will launch the runc-demo-init container we built, the init containers entrypoint will run a simple script to copy all of our files 
to the host machine including a systemd file; and then will try and kick off the runc container using systemd (I haven't figured out
this part yet; getting the container to be able to control systemd on the host).

## TODO

K8s'ify this; turn into a simple pod spec and deploy it on `n` worker nodes
