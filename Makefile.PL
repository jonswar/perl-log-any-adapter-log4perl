use inc::Module::Install;

name 'Log-Any-Adapter-Log4perl';
abstract 'Adapter to use Log::Log4perl with Log::Any';
all_from 'lib/Log/Any/Adapter/Log4perl.pm';
author 'Jonathan Swartz <swartz@pobox.com>';

perl_version '5.006';

build_requires 'File::Temp'  => '0.20';
build_requires 'Test::More'  => 0;

requires 'Log::Any' => '0.01';
requires 'Log::Log4perl' => '1.00';

license 'perl';

auto_install;

WriteAll;
