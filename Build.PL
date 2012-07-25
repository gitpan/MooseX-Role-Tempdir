use 5.006;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'MooseX::Role::Tempdir',
    license             => 'perl',
    dist_author         => q{Brad Barden <iamb@mifflinet.net>},
    dist_version_from   => 'lib/MooseX/Role/Tempdir.pm',
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        'perl' => 5.006,
    },
    add_to_cleanup      => [ 'MooseX-Role-Tempdir-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
