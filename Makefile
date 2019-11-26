all: centos610

centos610: 
	sudo singularity build centos610 centos.def

jupyter23: centos610
	sudo singularity build --force jupyter23 jupyter23.def

jupyter3: centos610
	sudo singularity build --force jupyter3 jupyter3.def

jupyter3x: jupyter3
	sudo singularity build --force --notest jupyter3x jupyter3x.def
	
rstudio: rstudio
	sudo singularity build --force rstudio r-studio-server.def

rbase: rbase
	sudo singularity build --force rbase r-base.def
