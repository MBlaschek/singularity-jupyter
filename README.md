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

## Use your container inside an existing Jupyter Notebook Server
In order to use your container with an existing notebook server you need to register yout ipykernel with that server.
Other people have done this:
* [Tensorflow](https://github.com/clemsonciti/singularity-in-jupyter-notebook)
* [Kernel](https://gist.github.com/mattpitkin/35ac19214048e96c391e948d7ec34ca5)

Maybe I made a mistake, but I could not figure out how to run these without root permission. Because the kernel needs access to the `kernel.json` file usually in `/run/user/1000/jupyter` (Update: Acutally this path depends on Jupyter and your env. If XDG_RUNTIME_DIR is available it will use that or if JUPYTER_RUNTIME_DIR is set it will use that. Therefore if these paths are available to the container, then there is not problem.). This directory `/run/user/..` is not accessable by default from inside the container. 
To register your container, in the `${HOME}/.local/share/jupyter/kernels` create a new directory, e.g. myimage, and add a `kernel.json` file containing:

```
{
 "language": "python",
 "argv": ["/usr/bin/singularity",
   "exec",
   "-B",
   "/run/user:/run/user",
   "/dir/to/your/image/jupyter.img",
   "/opt/conda/bin/python",
   "-m",
   "ipykernel",
   "-f",
   "{connection_file}"
 ],
 "display_name": "Python 3 (Singularity)"
}

```
where adding the `-B /run/user:/run/user` option is important. Change the path to your image. Then start a jupyter notebook with

      jupyter notebook &

and there should be a usable Python 3 (Singularity) kernel option!

#### Set a specific Runtime dir
If you want you can also set a runtime directory `JUPYTER_RUNTIME_DIR` in your env and that might save you the trouble of binding directories into your call.
