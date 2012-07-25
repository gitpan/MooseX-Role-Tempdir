package MooseX::Role::Tempdir;
use MooseX::Role::Parameterized;
use File::Temp qw//;

=head1 NAME

MooseX::Role::Tempdir - Moose role to provide temporary directories

=head1 VERSION

Version 0.03

=cut

our $VERSION = '0.03';


=head1 SYNOPSIS

    package My::Awesome::Package;
    use Moose;
    with 'MooseX::Role::Tempdir';

    my $newfh;
    open($newfh, '>', $self->tmpdir()."/newfile") or die "ohno! $!";
    ...

You can also use parameters to tell what directories you want and/or specify
tmpdir options. See L<File::Temp> for details on supported options.

By default you will get a single temporary directory 'tmpdir' with the default
options to File::Temp.

    with 'MooseX::Role::Tempdir' => {
      dirs => [ qw/tmpdir workdir fundir/ ],
      tmpdir_opts => { DIR => '/my/alternate/tmp' },
    };

    my $newfh;
    open($newfh, '>', $self->fundir()."/newfile") or die "ohno! $!";


=cut

parameter 'dirs' => (
  isa => 'ArrayRef[Str]',
  default => sub { [ 'tmpdir' ] },
);

parameter 'tmpdir_opts' => (
  isa => 'HashRef',
  default => sub { {} },
);

role {
  my $p = shift;
  my $opts = $p->tmpdir_opts();
  for my $dir (@{$p->dirs()}) {
    has $dir => (
      is => 'ro',
      isa => 'File::Temp::Dir',
      required => 1,
      lazy => 1,
      default => sub {
        my $p = shift;
        return File::Temp->newdir(%{$opts});
      },
    );
  }
};


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
