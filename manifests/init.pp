# == Class: timezone
#
# This module manages the timezone on a machine
#
# === Parameters
#
# [*region*]
#   Geographic region
#   Default: 'Etc' (String)
#
# [*locality*]
#   Timezone locality/city
#   Default: 'UTC' (String)
#
# [*hwutc*]
#   If your hardware lock uses UTC
#   Default: true (Boolean)
#
# === Examples
#
# class { '::timezone':
#   region   => 'Europe',
#   locality => 'London',
# }
#
# === Authors
#
# Sam Bashton <sam.bashton@claranet.uk>
# Craig Watson <craig.watson@claranet.uk>
#
# === Copyright
#
# Copyright 2012 Bashton Ltd
# Copyright 2017 Claranet
#
class timezone (
  $region   = 'Etc',
  $locality = 'UTC',
  $hwutc    = true
){

  # We copy the timezone file into /etc to cater for situations when /usr is
  # not available
  file { '/etc/localtime':
    source  => "file:///usr/share/zoneinfo/${region}/${locality}",
    links   => follow,
    replace => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  # Debian and Enterprise Linux have differing ways of recording clock settings
  case $::osfamily {
    'Archlinux': {
        package { 'tzdata':
            ensure => present,
            before => File['/etc/localtime'],
        }
    }
    'Debian': {
        package { 'tzdata':
            ensure => present,
            before => File['/etc/localtime'],
        }
        file { '/etc/timezone':
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            content => template('timezone/debian.erb'),
        }
    }
    'RedHat': {
        package { 'tzdata':
            ensure => present,
            before => File['/etc/localtime'],
        }
        file { '/etc/sysconfig/clock':
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            content => template('timezone/el.erb'),
        }
    }
    'Suse': {
        package { 'timezone':
            ensure => present,
            before => File['/etc/localtime'],
        }
        file { '/etc/sysconfig/clock':
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            content => template('timezone/suse.erb'),
        }
    }
    'Linux': {
      case $::operatingsystem {
        'Amazon': {
          package { 'tzdata':
              ensure => present,
              before => File['/etc/localtime'],
          }
          file { '/etc/sysconfig/clock':
              owner   => 'root',
              group   => 'root',
              mode    => '0644',
              content => template('timezone/el.erb'),
          }
        }
        'Gentoo': {
          package { 'sys-libs/timezone-data':
            ensure => present,
            before => File['/etc/localtime'],
          }
          file { '/etc/conf.d/hwclock':
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            content => template('timezone/gentoo.erb'),
          }
        }
        default: {
            fail("The OS ${::operatingsystem} is not supported by this module.")
        }
      }
    }
    default: {
        fail("The OS family ${::osfamily} is not supported by this module.")
    }
  }
}
