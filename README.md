# puppet-timezone

[![Build Status](https://secure.travis-ci.org/claranet/puppet-timezone.png?branch=master)](http://travis-ci.org/claranet/puppet-timezone)
[![Puppet Forge](http://img.shields.io/puppetforge/v/claranet/timezone.svg)](https://forge.puppetlabs.com/claranet/timezone)
[![Forge Downloads](https://img.shields.io/puppetforge/dt/claranet/timezone.svg)](https://forge.puppetlabs.com/claranet/timezone)

## Table of Contents

1. [Overview](#overview)
1. [Usage](#usage)
1. [Limitations](#limitations)
1. [Development](#development)

## Overview

A very basic Puppet module to set the timezone.  

## Usage

```puppet
class { 'timezone':
  region   => 'Europe',
  locality => 'London',
}
```

Or you can simply include timezone and set the details via hiera:

```yaml
timezone::region: 'Europe'
timezone::locality: 'London'
```

## Limitations

### Supported Operating Systems

* Debian/Ubuntu
* CentOS/RHEL
* Archlinux
* Amazon Linux
* SUSE
* Gentoo

## Development

* Copyright (C) 2013 Bashton Ltd
* Copyright (C) 2017 Claranet
* Distributed under the terms of the Apache License v2.0 - see LICENSE file for details.
