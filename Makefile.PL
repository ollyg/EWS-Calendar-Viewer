#!/usr/bin/env perl
use inc::Module::Install;

name 'EWS-Calendar-Viewer';
all_from 'lib/EWS/Calendar/Viewer.pm';

requires 'Catalyst::Runtime' => '5.8002';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Config::General';

requires 'MRO::Compat';
requires 'Catalyst::Model::Adaptor';
requires 'Catalyst::View::TT';
requires 'Calendar::Simple';
requires 'DateTime';

catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
