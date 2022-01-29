package Mhj::Build;
use parent 'Mhj';
use strict;
use warnings;
use utf8;
use File::Spec;
use File::Path qw(make_path remove_tree);

sub run {
    my ( $self, @args ) = @_;
    my $options = shift @args;
    return $self->error->commit("No arguments") if !$options;

    # 初期設定時のdbファイル準備
    return $self->_init($options) if $options->{method} eq 'init';
    return $self->error->commit(
        "Method not specified correctly: $options->{method}");
}

sub _init {
    my ( $self, @args ) = @_;
    my $options = shift @args;

    # 本番実行時は権限ありのapikey必須, test時のファイル使い分け
    my $db_file = 'mhj-test.db';
    if (   exists $options->{params}
        && exists $options->{params}->{apikey}
        && ( $options->{params}->{apikey} eq 'becom' ) )
    {
        $db_file = 'mhj.db';
    }
    my $db_dir = File::Spec->catfile( "$FindBin::RealBin", '..', 'db' );
    my $db  = File::Spec->catfile( "$FindBin::RealBin", '..', 'db', $db_file );
    my $sql = File::Spec->catfile( "$FindBin::RealBin", '..', 'mhj.sql' );
    die "not file: $!: $sql" if !-e $sql;

    if ( !-e $db_dir ) {
        make_path($db_dir);
    }

    # 例: sqlite3 mhj.db < mhj.sql
    my $cmd = "sqlite3 $db < $sql";
    system $cmd and die "Couldn'n run: $cmd ($!)";
    return +{ message => qq{build success $db_file} };
}

1;

__END__
