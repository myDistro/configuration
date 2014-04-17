configuration

This is the configuration module.

License
-------
GPL v3


Contact
-------

Ingolf Wagner <palipalo9@googlemail.com>

[myDistro Homepage](http://mydistro.github.io/)


Support
-------
Please log tickets and issues at our [Github](http://github.com/myDistro/configuration/issues)


Usage
-----

This module allows you to save and share your config files by using github (or other git repository provider).

Right now you need a setup.sh file in your repo.
For example :

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
    }


You should write your script in a way, that it can be called more than once.

