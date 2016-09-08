# Kernel CI for the Civil Infrastructure Platform #

This repository provides vagrant infrastructure that allows users/labs
to easily set up a kernel CI front- end backend tailored to the needs
of the Civil Infrastructure Platform (http://www.cip-project.org).

After cloning the repo, issue

	vagrant up

to build a VM with KernelCI front and backend. To compile-test the
current revision of the kernel, issue

	vagrant ssh
	cd git-repos
	git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
	cd linux
	TREE_NAME=cip-dreiwettertaft ARCH=arm ~/kernelci-build/build.py -c tinyconfig -p CIP-KernelCI

You can of course choose tree name, architecture, configuration, kernel revision
etc. according to your needs. To view the results, start the frontend web server
by running

	/vagrant/scripts/start_webserver.sh

on the guest system, and point your browser to http://localhost:5000/.
