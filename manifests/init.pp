# == Class: configuration
#
# You can use a gitrepository for your .dot file configurations.
# This module lets you download it and extractit.
# You have to put a setup.sh file in the root of your directory.
# This the setup.sh will be replaced someday by the puppet linking process.
#
# === Parameters
#
# [*target*]
#   target of the configuration repo 
# 
# [*source*]
#   git repository
#
# [*user*]
#   user at the repository
#
# [*vendor*]
#   github or github_https 
#
# [*branch*]
#   which branch of the repo to use
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
#  configuration { 'myVimConfig':
#    target => '/home/vanDalo/.vim',
#    source => 'mrVanDalo/spread-vim',
#    user => 'vanDalo',
#  }
#
# === Authors
#
# Ingolf Wagner <palipalo9@googlemail.com>
#
# === Copyright
#
# Copyright 2014 Ingolf Wagner.
#
class configuration (
  $target ,
  $source ,
  $user ,
  $vendor = 'github_https',
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
