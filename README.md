# Jupyter and Singularity
Jupyter Miniconda Python 3 and Singularity Container

This is an update from [](https://github.com/singularityhub/jupyter) the offical jupyter singularity container that requires root permissions to run:
* [NEW] Only need root permissions to create the container
* [NEW] Miniconda (smaller in size)

If you haven't installed singularity, do that with [these instructions](http://singularity.lbl.gov/install-linux). Then Download the repo if you haven't already:

      git clone https://github.com/MBlaschek/singularity-jupyter jupyter
      cd jupyter

## CREATE
Let's now create the notebook container:

You can choose now if you prefer a writeable container (for development, installation of additional packages, ...) or a deployment container (read_only, default) [read more](http://singularity.lbl.gov/docs-build-container):

     sudo singularity build --writable jupyter.img Singularity
     
or for deployment:

     sudo singularity build jupyter.simg Singularity

## RUN
Then to run the container:

     singularity run jupyter.img
     
or for the read only version:

    singularity run jupyter.simg
    
or for the writable version:

    sudo singularity run --writable jupyter.img
    
Anyway you should see output like this:

![jupyter.png](jupyter.png)

The current directory is where your server starts. In your browser you should be able to navigate to the link from the console:
![jupyterweb.png](jupyterweb.png)

The password is **super-secret**. You can change that easily within the Singularity file.

