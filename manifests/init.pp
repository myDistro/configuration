# == Class: configuration
#
# Full description of class configuration here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { configuration:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class configuration {
  $target ,
  $source ,
  $user ,
  $vendor = 'github_https',
  $group = 'opp',
  $branch = 'master',
){
  case $vendor {
    github:  {
      vcsrepo { $target:
        ensure => present,
        provider => git,
        source => "git@github.com:${source}.git",
        user  => $user,
        revision => $branch,
        require  => [User[$user],Package['git']]
      }
    }
    github_https:  {
      vcsrepo { $target:
        ensure => present,
        provider => git,
        source => "https://github.com/${source}.git",
        user  => $user,
        revision => $branch,
        require  => [User[$user],Package['git']]
      }
    }
    default: {   }
  }
  exec{ "/bin/bash ${target}/setup.sh":
    user  => $user,
    require  => 
    [
      Vcsrepo[$target],
      User[$user],
    ]
  }
}
