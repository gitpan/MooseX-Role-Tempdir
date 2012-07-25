package MooseX::Role::Tempdir;
use Moose::Role;
use File::Temp qw//;

=head1 NAME

MooseX::Role::Tempdir - Moose role to provide a temporary directory

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

    package My::Awesome::Package;
    use Moose;
    with 'MooseX::Role::Tempdir';

    my $newfh;
    open($newfh, '>', $self->tmpdir()."/newfile") or die "ohno! $!";
    ...

Alias the tmpdir function if you want it called something else

    with 'MooseX::Role::Tempdir' { -alias => { tmpdir => 'workdir' } };

    my $newfh;
    open($newfh, '>', $self->workdir()."/newfile") or die "ohno! $!";


=cut
has 'tmpdir' => (
  is => 'ro',
  isa => 'File::Temp::Dir',
  lazy => 1,
  builder => '_make_temp_dir',
);

has 'tmpdir_opts' => (
  is => 'ro',
  isa => 'HashRef',
);

=head1 SUBROUTINES/METHODS

=head2 There are some.

=cut

sub _make_temp_dir {
  my $self = shift;
  my $tmpdir = File::Temp->newdir();
  return $tmpdir;
}


=head1 AUTHOR

Brad Barden, C<< <iamb at mifflinet.net> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-moosex-role-tempdir at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=MooseX-Role-Tempdir>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc MooseX::Role::Tempdir


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=MooseX-Role-Tempdir>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/MooseX-Role-Tempdir>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/MooseX-Role-Tempdir>

=item * Search CPAN

L<http://search.cpan.org/dist/MooseX-Role-Tempdir/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2012 Brad Barden.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of MooseX::Role::Tempdir
