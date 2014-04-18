/*

== Class: configuration

You can use a gitrepository for your .dot file configurations.
This module lets you download it and extractit.
You have to put a setup.sh file in the root of your directory.
This the setup.sh will be replaced someday by the puppet linking process.

=== Parameters

[*target*]
target of the configuration repo

[*source*]
git repository

[*user*]
user at the repository

[*vendor*]
github or github_https (default)

[*branch*]
which branch of the repo to use

[*links*]
A map (key is ignorred) of map (source => (in the git repo), target => (to the file system))
to create links out in the system

[*init*]
calles a script (inside the repository) (old version of linking)


=== Examples

configuration { 'myVimConfig':
  target => '/home/vanDalo/.vim',
  source => 'mrVanDalo/spread-vim',
  user => 'vanDalo',
}

configuration { 'myVimConfig':
  target => '/home/vanDalo/.vim',
  source => 'mrVanDalo/spread-vim',
  user => 'vanDalo',
  init => 'setup.sh',
}

configuration { 'myVimConfig':
  target => '/home/vanDalo/.vim',
  source => 'mrVanDalo/spread-vim',
  user => 'vanDalo',
  links => { rc  => { source => 'vimrc', target => '/home/vanDalo/.vimrc' },
             foo => { source => 'foo',   target => '/home/vanDalo/.vim_foo' },
  },
}

=== Authors

Ingolf Wagner <palipalo9@googlemail.com>

=== Copyright

Copyright 2014 Ingolf Wagner.

*/

define configuration (
  $target ,
  $source ,
  $user   = undef,
  $vendor = 'github_https',
  $branch = 'master',
  $init   = undef,
  $links  = undef,
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

  if ( $init ) {
    # execute init script
    exec{ "/bin/bash ${target}/${init}":
      user     => $user,
      require  => Vcsrepo[$target],
      }
  }

  if ( $links ) {
    # link the links
    create_resources(
      configuration::create_link,
      $links,
      {
        path_to_config => $target,
        owner          => $user,
      }
    )
  }
}
