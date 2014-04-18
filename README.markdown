Configuration
-------------

This module allows you to save and share your config files by using github (or other git repository provider).

Basic Usage
-----------
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


Using Init Scripts
------------------

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

Using Links Parameter
---------------------

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
        links  => { dmenu  => {source => 'dmenu',               target => '/home/me/.dmenu'},
                    i3     => {source => 'i3',                  target => '/home/me/.i3'},
                    i3_bar => {source => 'i3/i3status.conf',    target => '/home/me/.i3status.conf'},
                    dx     => {source => 'Xdefaults',           target => '/home/me/.Xdefaults'},
                    xm     => {source => 'xmodmap',             target => '/home/me/.xmodmap'},
                    xs     => {source => 'xsession',            target => '/home/me/.xsession'},
        },
    }


Migrate 0.1.x to 0.2.x
----------------------

Migration is quite simple, just add the init parameter to your configuration.

    configuration { "my-vim":
        ....
        init   => 'setup.sh',
    }
    

Contact
-------

Ingolf Wagner <palipalo9@googlemail.com>

[myDistro Homepage](http://mydistro.github.io/)

