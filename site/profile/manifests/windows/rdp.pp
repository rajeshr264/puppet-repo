# == Class: profile::windows::rdp
class profile::windows::rdp (
  $rdp_enable,
  ){
  class { 'rdp':
    rdp_enable     => $rdp_enable,
    rdp_nla_enable => true,
  }
}
