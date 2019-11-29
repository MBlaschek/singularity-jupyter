all: centos610

centos610:
	sudo singularity build centos Singularity.centos

jupyter23: centos
	sudo singularity build --force jupyter23 Singularity.jupyter23

jupyter3: centos
	sudo singularity build --force jupyter3 Singularity.jupyter3

jupyter3x: jupyter3
	sudo singularity build --force --notest jupyter3x Singularity.jupyter3x

rstudio: rstudio
	sudo singularity build --force rstudio Singularity.rstudio
