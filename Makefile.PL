use inc::Module::Install;

name     'Drelwa';
all_from 'lib/Drelwa.pm';
author   q{Lenz Gschwendtner <norbu09@cpan.org>};
license  'perl';

requires 'Template::Alloy';
requires 'Text::Markdown';
requires 'YAML::Syck';

build_requires 'Test::More';

install_script  'script/drelwa';

auto_install;

WriteAll;

