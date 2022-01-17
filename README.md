# mhj-api

日本の近代史のアプリケーションロジック

## Setup

```text
DBD::SQLite-1.54
perl5.14.4

cd ~/github/mhj-api
echo '5.14.4' > .perl-version;
echo "requires 'DBD::SQLite', '==1.54';" >> cpanfile;

plenv install 5.14.4
plenv rehash
plenv install-cpanm
cpanm Perl::Tidy

cpanm -l ~/github/mhj-api/local --installdeps .

ローカル環境でwebサーバー経由で起動
python3 -m http.server 8000 --cgi
<http://localhost:8000/cgi-bin/index.cgi>
```
