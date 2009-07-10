use inc::Module::Install;

name 'Log-Any-Adapter-Log-Log4perl';
abstract 'Adapter to use Log::Log4perl with Log::Any';
all_from 'lib/Log/Any/Adapter/Log/Log4perl.pm';
author 'Jonathan Swartz <swartz@pobox.com>';

perl_version '5.006';

build_requires 'Test::Class' => 0;
build_requires 'Test::Most'  => 0;

requires 'List::MoreUtils'           => '0.13';
requires 'Moose'                     => '0.66';

license 'perl';

auto_install;

WriteAll;
