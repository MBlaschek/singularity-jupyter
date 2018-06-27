BootStrap: docker
From: continuumio/miniconda3


%help

	Run a jupyter notebook Server in a container

%label

	Author: M. Blaschek
	Anaconda Python and jupyter	

%runscript

     echo "Starting notebook..."
     exec /opt/conda/bin/jupyter notebook --ip='*' --no-browser --NotebookApp.token='super-secret'

%post

     # Install jupyter notebook
     /opt/conda/bin/conda install jupyter numpy matplotlib pandas -y --quiet 
     apt-get autoremove -y
     apt-get clean
     
%environment
	# important part otherwise the server will try to access /run/user and fail
	export JUPYTER_RUNTIME_DIR=$PWD
