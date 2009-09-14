package Drelwa::Filter::Highlight;

use warnings;
use strict;
use Carp;
use File::Temp;

=head1 NAME

Drelwa::Filter::Highlight - a pygments interface

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

Drelwa is drop in replacement for jekyll - well at least kind of. not as
fancy but good enough for my private stuff.

=head1 FUNCTIONS

=head2 html

=cut

sub html {
    my $block = shift;
    my $pyg = shift || '/usr/local/bin/pygmentize';
    my $tmp = File::Temp->new(
        TEMPLATE => 'tempXXXXX',
        DIR      => '/tmp',
        SUFFIX   => '.pyg'
    );
    
    open(TMP, '>', $tmp) or croak "Could not open file $tmp: $@\n";
    print TMP $block;
    close TMP;

    my $html = qx/$pyg -f html $tmp/;

    return $html;
}

=head1 AUTHOR

Lenz Gschwendtner, C<< <norbu09 at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-drelwa at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Drelwa>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Drelwa


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Drelwa>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Drelwa>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Drelwa>

=item * Search CPAN

L<http://search.cpan.org/dist/Drelwa/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Lenz Gschwendtner.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1;    # End of Drelwa::Filter::Highlight
