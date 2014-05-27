# Configuration

This module allows you to save and share your configuration files by using github (or other git repository provider).

## Warning

Using a remote server for your internal config files is not flawless.
You have to be sure about the ssh fingerprint (or ssl certifcate) of the host!

## Basic Usage

Your .dot file git repository structure for example :

    configure-vim
    ├── bundle
    │   └── vundle
    ├── README.md
    └── vimrc


After you created your github repository like described you can set it up in puppet via 

    configuration { "my-vim":
        target => '/home/me/.vim',
        source => 'mrVanDalo/configure-vim',
        user   => 'me',
    }

The problem of putting .dot files in you home or somewhere else, can be solved by the init or the links parameter.
You can use both at the same time of course.


### Parameter 

#### init 

You can put a init script in your repository to run right after cloning the repository.

Your .dot file git repository structure for example :

    configure-vim
    ├── bundle
    │   └── vundle
    ├── README.md
    ├── setup.sh
    └── vimrc


After you created your github repository like described you can set it up in puppet via 

    configuration { "my-vim":
        target => '/home/me/.vim',
        source => 'mrVanDalo/configure-vim',
        user   => 'me',
        init   => 'setup.sh',
    }

You should write your script in a way, that it can be called more than once.

#### links

Most of the time the setup scripts create links. But you can do that now within your puppet script.

Your .dot file git repository structure for example :

    configure-i3
    ├── dmenu
    │   ├── dmenu.list
    │   └── dmenu_run
    ├── i3
    │   ├── config
    │   └── i3status.conf
    ├── README.md
    ├── Xdefaults
    ├── xmodmap
    └── xsession

Now you can configure your links like that

    configuration { 'my-i3':
      target => '/home/me/.configuration/i3',
      source => 'mrVanDalo/configure-i3',
      user   => 'me',
      links  => { 
        dmenu  => {source => 'dmenu',            target => '/home/me/.dmenu'        },
        i3     => {source => 'i3',               target => '/home/me/.i3'           },
        i3_bar => {source => 'i3/i3status.conf', target => '/home/me/.i3status.conf'},
        dx     => {source => 'Xdefaults',        target => '/home/me/.Xdefaults'    },
        xm     => {source => 'xmodmap',          target => '/home/me/.xmodmap'      },
        xs     => {source => 'xsession',         target => '/home/me/.xsession'     },
        },
    }


#### vendor and source

The vendor parameter controlls the git server type.
Unless you use host as _vendor_, _source_ should be 'user/repository' (without .git at the end)

* github : use ssh to github 
* github_https (default) : use https to github
* bitbucket : use ssh bitbucket
* host : use your own server. _source_ must be the full path for 'git clone'


## Migrate 0.1.x to 0.2.x

Migration is quite simple, just add the init parameter to your configuration.

    configuration { "my-vim":
        ....
        init   => 'setup.sh',
    }
    

## Support

* [Puppet Forge](https://forge.puppetlabs.com/myDistro/configuration)
* [Github](http://github.com/myDistro/configuration)
* IRC : irc.freenode.net #myDistro


