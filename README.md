# Puppet Timezone Module #

A very basic Puppet module to set the timezone properly.  Works on
RHEL/CentOS and Debian and Ubuntu.

## Usage ##

In your manifest:

class { "timezone":
  region   => "Europe",
  locality => "London",
}
