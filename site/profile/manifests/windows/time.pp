# == Class: profile::windows::time
class profile::windows::time (
  $timezone,
  $ntp_servers,
) {
  class { 'winntp':
    servers => $ntp_servers,
  }
  dsc_xtimezone { 'set timezone':
    dsc_timezone         => $timezone,
    dsc_issingleinstance => 'yes',
  }
}
