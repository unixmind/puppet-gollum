# Class: gollum
# ===========================
#
# Full description of class gollum here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'gollum':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class gollum {

  case $::os['family'] {
    'RedHat': {
      $developmenttools = [ 'autoconf', 'automake' , 'binutils' , 'bison' , 'flex' ,
                            'gcc' , 'gcc-c++' , 'gettext' , 'libtool' , 'make' ,
                            'patch' , 'pkgconfig' , 'redhat-rpm-config' , 'rpm-build' , 'rpm-sign' ]
      $rubytools = [ 'ruby' , 'ruby-devel' , 'libicu' , 'libicu-devel' , 'zlib' , 'zlib-devel' , 'git' ]
    }
    'Debian': {
    }
    default: {
      fail ("${::os['family']} is not supported")
    }
  }

# Install package for supported Linux :
  Package { ensure => 'installed' }
  package { $developmenttools: }
  package { $rubytools:
    require  =>  $developmenttools,
  }
  package { 'gollum':
    provider => 'gem',
    require  =>  $rubytools,
  }
}
