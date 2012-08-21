# Class: timezone
#
# This module manages the timezone on a machine
# Tested with Puppet 2.7 (should work with >=2.6)
#
# Parameters:
#
# region   => 'Europe'
# locality => 'London'
# hwutc    => 'true' (optional, false if your hw clock is in local time)
#
# For timezone name use region Etc, eg region => 'Etc', locality => 'GMT'
#

class timezone (
  $region, 
  $locality,
  $hwutc = "true"){

  package { "tzdata":
    ensure => "installed",
  }

  file { "/etc/localtime":
    # We copy the timezone file into /etc to cater for
    # situations when /usr is not available
    source => "file:///usr/share/zoneinfo/$region/$locality",
  }

  # Debian and Enterprise Linux have differing ways of recording
  # clock settings
  if ($osfamily == 'Debian') {
    file { "/etc/timezone":
      owner   => 'root',
      group   => 'root',
      mode    => 0644,
      content => template('timezone/debian.erb'),
    }
  }
  elsif ($osfamily == 'RedHat') {
    file { "/etc/sysconfig/clock":
      owner   => 'root',
      group   => 'root',
      mode    => 0644,
      content => template('timezone/el.erb'),
    }
  }
}
