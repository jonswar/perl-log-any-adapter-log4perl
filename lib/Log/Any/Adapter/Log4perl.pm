package Log::Any::Adapter::Log4perl;
use Log::Log4perl;
use Log::Any::Adapter::Util qw(make_method);
use strict;
use warnings;
use base qw(Log::Any::Adapter::Base);

our $VERSION = '0.04';

sub init {
    my ($self) = @_;

    $self->{logger} = Log::Log4perl->get_logger( $self->{category} );
}

foreach my $method ( Log::Any->logging_and_detection_methods() ) {
    my $log4perl_method = $method;

    # Map log levels down to log4perl levels where necessary
    #
    for ($log4perl_method) {
        s/notice/info/;
        s/warning/warn/;
        s/critical|alert|emergency/fatal/;
    }

    # Delegate to log4perl logger, increasing caller_depth so that %F, %C,
    # etc. are generated correctly
    #
    make_method(
        $method,
        sub {
            my $self = shift;
            local $Log::Log4perl::caller_depth =
              $Log::Log4perl::caller_depth + 1;
            return $self->{logger}->$log4perl_method(@_);
        }
    );
}

# Override alias and printf variants to increase depth first
#
my %aliases = Log::Any->log_level_aliases;
my @methods = (
    keys(%aliases),
    ( map { $_ . "f" } ( Log::Any->logging_methods, keys(%aliases) ) )
);
foreach my $method (@methods) {
    make_method(
        $method,
        sub {
            my $self = shift;
            local $Log::Log4perl::caller_depth =
              $Log::Log4perl::caller_depth + 2;
            my $super_method = "SUPER::$method";
            return $self->$super_method(@_);
        }
    );
}

1;

__END__

=pod

=head1 NAME

Log::Any::Adapter::Log4perl

=head1 SYNOPSIS

    use Log::Log4perl;
    Log::Log4perl::init('/etc/log4perl.conf');

    Log::Any::Adapter->set('Log::Log4perl');

=head1 DESCRIPTION

This Log::Any adapter uses L<Log::Log4perl|Log::Log4perl> for logging. log4perl
must be initialized before calling I<set>. There are no parameters.

=head1 LOG LEVEL TRANSLATION

Log levels are translated from Log::Any to Log4perl as follows:

    notice -> info
    warning -> warn
    critical -> fatal
    alert -> fatal
    emergency -> fatal

=head1 SEE ALSO

L<Log::Any|Log::Any>, L<Log::Any::Adapter|Log::Any::Adapter>,
L<Log::Log4perl|Log::Log4perl>

=head1 AUTHOR

Jonathan Swartz

=head1 COPYRIGHT & LICENSE

Copyright (C) 2007 Jonathan Swartz, all rights reserved.

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut
