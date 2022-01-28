package Mhj;
use strict;
use warnings;
use utf8;
use Time::Piece;
use FindBin;
use DBI;
use File::Spec;
use Mhj::Build;
use Mhj::User;
use Mhj::Period;
use Mhj::PeriodType;
use Mhj::Error;
sub new        { return bless {}, shift; }
sub build      { Mhj::Build->new; }
sub user       { Mhj::User->new; }
sub period     { Mhj::Period->new; }
sub periodtype { Mhj::PeriodType->new; }
sub error      { Mhj::Error->new; }
sub time_stamp { return localtime->datetime( 'T' => ' ' ); }

sub build_dbh {
    my ( $self, @args ) = @_;
    my $db   = File::Spec->catfile( "$FindBin::RealBin", '..', 'db', 'mhj.db' );
    my $attr = +{
        RaiseError     => 1,
        AutoCommit     => 1,
        sqlite_unicode => 1,
    };
    my $dbh = DBI->connect( "dbi:SQLite:dbname=$db", "", "", $attr );
    return $dbh;
}

# $self->single($table, \@cols, \%params);
sub single {
    my ( $self, $table, $cols, $params ) = @_;
    my $sql_q = [];
    for my $col ( @{$cols} ) {
        push @{$sql_q}, qq{$col = "$params->{$col}"};
    }
    push @{$sql_q}, qq{deleted = 0};
    my $sql_clause = join " AND ", @{$sql_q};
    my $sql        = qq{SELECT * FROM $table WHERE $sql_clause};
    my $dbh        = $self->build_dbh;
    return $dbh->selectrow_hashref($sql);
}

# $self->rows($table, \@cols, \%params);
sub rows {
    my ( $self, $table, $cols, $params ) = @_;
    my $sql_q = [];
    for my $col ( @{$cols} ) {
        push @{$sql_q}, qq{$col = "$params->{$col}"};
    }
    push @{$sql_q}, qq{deleted = 0};
    my $sql_clause = join " AND ", @{$sql_q};
    my $sql        = qq{SELECT * FROM $table WHERE $sql_clause};
    my $dbh        = $self->build_dbh;
    my $hash       = $dbh->selectall_hashref( $sql, 'id' );
    my $arrey_ref  = [];
    for my $key ( sort keys %{$hash} ) {
        push @{$arrey_ref}, $hash->{$key};
    }
    return $arrey_ref;
}

1;

__END__
