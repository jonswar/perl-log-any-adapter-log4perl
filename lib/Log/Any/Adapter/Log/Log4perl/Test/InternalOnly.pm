package Log::Any::Adapter::Log::Log4perl::Test::InternalOnly;
use Test::More;
use strict;
use warnings;

sub import {
    unless ( $ENV{LOG_ANY_ADAPTER_LOG_LOG4PERL_INTERNAL_TESTS} ) {
        plan skip_all => "internal test only";
    }
}

1;
