BootStrap: docker
From: continuumio/miniconda3


%help

	Run a jupyter notebook Server in a container
	Usually: http://localhost:8888

%label

	Author: M. Blaschek
	Anaconda Python 3 and jupyter notebook

%runscript

     echo "Starting notebook... $(/opt/conda/bin/jupyter --version)"
     exec /opt/conda/bin/jupyter --paths
     exec /opt/conda/bin/jupyter notebook --NotebookApp.allow_origin="*" --no-browser --NotebookApp.token='super-secret'

%post

     # Install jupyter notebook
     /opt/conda/bin/conda install jupyter numpy matplotlib pandas -y --quiet 
     apt-get autoremove -y
     apt-get clean
     
%environment
	# important part otherwise the server will try to access /run/user and fail
	export JUPYTER_RUNTIME_DIR=$PWD
