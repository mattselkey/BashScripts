#This is anot a script, currently a list of commands to manage vmware workstation and LVM running side by side.

# to disable
sudo /etc/init.d/vmware stop
# to enable
sudo /etc/init.d/vmware start


#kvm

#Note, modules loaded at runtime via /etc/modules
vi /etc/modules

# LIST kernel modules
# /sbin/lsmod displays a list of currently loaded modules. 
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/4/html/system_administration_guide/kernel_modules
sudo /sbin/lsmod | grep kvm

# ttps://linux.die.net/man/8/rmmod
# rmmod is a trivial program to remove a module from the kernel. Most users will want to use modprobe(8) with the -r option instead.
# to disable
sudo rmmod kvm_amd
sudo rmmod kvm

#or

#https://linux.die.net/man/8/modprobe
# program to add and remove modules from the Linux Kernel
sudo modprobe -r kvm_amd
sudo modprobe -r kvm



# https://linux.die.net/man/8/insmod
# insmod - simple program to insert a module into the Linux Kernel
# to enable - exmaple /lib/modules/5.5.17-200.fc31.x86_64/kernel/arch/x86
# note fedora 31 = kvm.ko.xz, kvm-amd.ko.xz - xz is compressed but still valid
sudo insmod /lib/modules/`uname -r`/kernel/arch/x86/kvm/kvm.ko.xz
sudo insmod /lib/modules/`uname -r`/kernel/arch/x86/kvm/kvm-amd.ko.xz

#start/stop KVM daemon
sudo systemctl stop libvirtd
sudo systemctl start libvirtd

