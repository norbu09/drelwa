#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Drelwa' );
}

diag( "Testing Drelwa $Drelwa::VERSION, Perl $], $^X" );
