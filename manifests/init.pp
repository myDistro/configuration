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
#   github or github_https (default)
#
# [*branch*]
#   which branch of the repo to use
#
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
define configuration (
  $target ,
  $source ,
  $user   = undef,
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
      }
    }
    github_https:  {
      vcsrepo { $target:
        ensure => present,
        provider => git,
        source => "https://github.com/${source}.git",
        user  => $user,
        revision => $branch,
      }
    }
    default: {   }
  }
  if ( $user ){ 
  exec{ "/bin/bash ${target}/setup.sh":
    user  => $user,
    require  => 
    [
      Vcsrepo[$target],
      User[$user],
    ]
  }
  } else {
    exec{ "/bin/bash ${target}/setup.sh":
        user  => $user,
        require  => Vcsrepo[$target]
  }
  }
}
