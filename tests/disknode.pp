# The baseline for module testing used by Puppet Labs is that each manifest
# # should have a corresponding test manifest that declares that class or defined
# # type.
# #
# # Tests are then run by using puppet apply --noop (to check for compilation
# # errors and view a log of events) or by fully applying the test in a virtual
# # environment (to compare the resulting system state to the desired state).
# #
# # Learn more about module testing here:
# # https://puppet.com/docs/puppet/5.0/tests_smoke.html
# #
class voms::km3net {
  voms::client{
'km3net.org':
      servers  => [{server => 'voms02.scope.unina.it',
                    port   => '15005',
                    dn    => '/C=IT/O=INFN/OU=Host/L=Federico II/CN=voms02.scope.unina.it',
                    ca_dn => '/C=IT/O=INFN/CN=INFN CA'
                   }]
 }
}

class{'dpm::disknode':
   headnode_fqdn 		=> "dpmhead01.cern.ch",
   disk_nodes                   => ['localhost'],
   localdomain                  => 'cern.ch',
   token_password               => 'thetokenpasswordshouldbelongerthan32chars',
   xrootd_sharedkey             => 'A32TO64CHARACTERKEYTESTTESTTESTTEST',
   volist                       => ['dteam', 'lhcb','km3net.org'],
   dpmmgr_uid                   => 500,
   mountpoints			=> ['/data','/data/01'],
   configure_repos 		=> true,
   configure_dome               => true,
   configure_domeadapter        => true,
   configure_legacy             => false,
   configure_dome               => false,
}

class{'voms::km3net':}
