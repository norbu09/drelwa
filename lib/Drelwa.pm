package Drelwa;

use warnings;
use strict;
use YAML::Syck;
use Text::Markdown 'markdown';
use Template::Alloy;

=head1 NAME

Drelwa - a jekyll replacement in Perl!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

Drelwa is drop in replacement for jekyll - well at least kind of. not as
fancy but good enough for my private stuff.

Perhaps a little code snippet.

    use Drelwa;

    my $foo = Drelwa->new();
    ...

=head1 FUNCTIONS

=head2 in

=cut

sub in {
    my $file = shift;

    my @_path = split(/\//, $file);
    my @date = split(/-/, pop(@_path), 4);
    my @_fname = split(/\./, pop(@date), 2);

    open( FILE, '<', $file ) or die "Could not open file: $file!";

    my ( $yaml, $markdown );
    my $_c = 0;
    while (<FILE>) {
        if ( !$markdown ) {
            $yaml .= $_;
        }
        else {
            $markdown .= $_;
        }
        if (/^---\s*$/) {
            $_c++;
        }
        if ( $_c > 1 && $_c != 99 ) {
            $markdown = "\n";
            $_c       = 99;
        }
    }

    my $post = Load($yaml);

    $post->{body} = markdown($markdown);
    $post->{date} = join('-', @date);
    $post->{path} = join('/', @date);
    $post->{filename} = $_fname[0].'.html';
    return $post;
}

=head2 out

=cut

sub out {
    my $data = shift;
    my $out = '';
    my $t = Template::Alloy->new( INCLUDE_PATH => [ 'tpl/' ], );
    $t->process('wrapper', $data, \$out);

    return $out;
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

1;    # End of Drelwa
