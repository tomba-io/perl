use 5.026001;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Tomba::Finder',
    VERSION_FROM      => 'lib/Tomba/Finder.pm', # finds $VERSION, requires EU::MM from perl >= 5.5
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ABSTRACT_FROM     => 'lib/Tomba/Finder.pm', # retrieve abstract from module
    AUTHOR            => 'Mohamed Ben rebia <b.mohamed@tomba.io>',
    LICENSE           => 'apache_2_0', # perl
    #Value must be from legacy list of licenses here
    #http://search.cpan.org/perldoc?Module%3A%3ABuild%3A%3AAPI
    PREREQ_PM => {
        'LWP::UserAgent'          => '0',
        'JSON'                    => '0',

    },
    dist              => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Tomba-Finder-*' },
);
