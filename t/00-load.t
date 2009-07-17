#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Log::Any::Adapter::Log4perl' );
}

diag( "Testing Log::Any::Adapter::Log4perl $Log::Any::Adapter::Log::Log4perl::VERSION, Perl $], $^X" );
