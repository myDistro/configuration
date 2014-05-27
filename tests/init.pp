# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# http://docs.puppetlabs.com/guides/tests_smoke.html
#

configuration { "test-links":
    target => '/test-links',
    source => 'mrVanDalo/configure-vim',
    links => {  
      a => { source => 'vimrc',
             target => "/tmp/puppet_test/.vimrc" },
      b => { source => "whatever" ,
             target => "/tmp/something" },
             } 
}

configuration { "test-init":
    target => '/test-init',
    source => 'mrVanDalo/configure-vim',
    init => 'setup.sh',
}

configuration { "test-minimal":
    target => '/test-minimal',
    source => 'mrVanDalo/configure-vim',
}

/*

still fails

# source names are the same
# name of the link values are the same
configuration { "test-links-double":
    target => '/test-links2',
    source => 'mrVanDalo/configure-vim',
    links => {  
      a => { source => 'vimrc',
             target => "/tmp/puppet_test2/.vimrc" },
      b => { source => "whatever" ,
             target => "/tmp/something2" },
             } 
}
*/
