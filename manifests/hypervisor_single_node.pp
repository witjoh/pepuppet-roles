# class hypervisor_single_node
#
# Defines a KVM hypervisor :
# -- local storage
# -- dingle noded (no fail over stuff ..
# -- libvirt - kvm
#
class roles::hypervisor_single_node {

  include profiles::hypervisor

}
