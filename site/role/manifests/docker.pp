# == Class: role::unifi
class role::unifi {
  # resources
  #All roles should include the base profile
  include profile::base
  include profile::unifi
}
