
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;

use File::ShareDir::Install;
install_share dist => "share";


my %WriteMakefileArgs = (
  'ABSTRACT' => 'View Your MS Exchange Calendar as a Standalone Web App',
  'AUTHOR' => 'Oliver Gorwits <oliver@cpan.org>',
  'BUILD_REQUIRES' => {},
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.30',
    'File::ShareDir::Install' => '0.03'
  },
  'DISTNAME' => 'EWS-Calendar-Viewer',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'EWS::Calendar::Viewer',
  'PREREQ_PM' => {
    'Authen::NTLM' => '0',
    'Calendar::Simple' => '0',
    'Catalyst' => '0',
    'Catalyst::Action::RenderView' => '0',
    'Catalyst::Controller' => '0',
    'Catalyst::Model::Adaptor' => '0',
    'Catalyst::Plugin::ConfigLoader' => '0',
    'Catalyst::Plugin::Static::Simple' => '0',
    'Catalyst::View::TT' => '0',
    'Config::General' => '0',
    'DateTime' => '0',
    'EWS::Client' => '1.111940',
    'File::ShareDir' => '0',
    'LWP::Authen::Ntlm' => '0',
    'LWP::Protocol::https' => '0',
    'MRO::Compat' => '0',
    'Try::Tiny' => '0'
  },
  'VERSION' => '1.111971',
  'test' => {
    'TESTS' => ''
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

package
MY;
use File::ShareDir::Install qw(postamble);


