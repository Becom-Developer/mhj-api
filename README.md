# mhj-api

日本の近代史のアプリケーションロジック

## Setup

事前に`plenv`を使えるようにしておき指定バージョンの`Perl`を使えるように

git clone にてソースコードを配置後プロジェクト配下にてモジュールをインストール

```zsh
./cpanm -l ./local --installdeps .
```

## Work

ローカル開発時の起動方法など

app サーバー起動の場合

```zsh
perl -I ./local/lib/perl5 ./local/bin/morbo -l "http://*:3020" ./script/app
```

リクエスト

```zsh
curl 'http://localhost:3020/'
```

cgi ファイルを起動の場合

```zsh
python3 -m http.server 3020 --cgi
```

リクエスト

```zsh
curl 'http://localhost:3020/cgi-bin/index.cgi'
```

コマンドラインによる起動

```zsh
./script/mhj
```

詳細は[doc/](doc/)を参照

公開環境へ公開

```sh
ssh becom2022@becom2022.sakura.ne.jp
cd ~/www/mhj-api
git fetch && git checkout main && git pull
```

## Usage

### CLI

```text
mhj <path> <method> [--params=<JSON>]

  <path>      Specify each resource name
  <method>    Specify each method name
  --params    Json format with reference to request parameters

Specify the resource name as the first argument
Specify the method name as the second argument
Format command line interface options in json format

第一引数はリソース名を指定
第二引数はメソッド名を指定
コマンドラインインターフェスのオプションはjson形式で整形してください
```

### HTTP

```text
POST https://mhj-api.becom.co.jp/

http request requires apikey
All specifications should be included in the post request parameters
See Examples in each document for usage

http リクエストには apikey の指定が必要
全ての指定は post リクエストのパラメーターに含めてください
使用法は各ドキュメントの Example を参照
```

## Memo

sqlite-simple についてはしばらくはダウンロード対応

```zsh
cp ~/Downloads/SQLite-Simple-main/lib/SQLite/Simple.pm ~/github/zsearch-api/lib/SQLite
```

### Environment

初動時の環境構築に関するメモ

```text
DBD::SQLite-1.54
perl5.14.4

cd ~/github/mhj-api
echo '5.14.4' > .perl-version;
echo "requires 'DBD::SQLite', '==1.54';" >> cpanfile;
echo "requires 'Test::Trap', 'v0.3.4';" >> cpanfile;

plenv install 5.14.4
plenv rehash
plenv install-cpanm
cpanm Perl::Tidy
cpanm -l ~/github/mhj-api/local --installdeps .
```

Module

```zsh
curl -L https://cpanmin.us/ -o cpanm
chmod +x cpanm
./cpanm -l ./local --installdeps .
```

## Test

```zsh
prove -v
```

## API

`apikey` は管理者から取得

### Build init

データベース初期設定

HTTP

```zsh
curl 'https://mhj-api.becom.co.jp/' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"path":"build","method":"init","apikey":"becom"}'
```

CLI

```zsh
mhj --path=build --method=init
```

### Chronology list

年表の一覧を取得

Request parameters

```json
{
  "period_id": 5
}
```

Response parameters

```json
{
  "period": {
    "id": 5,
    "period_type_id": 5,
    "title": "江戸時代",
    "start_year": "1603",
    "end_year": "1868",
    "start_ts": "1603-03-24 00:00:00",
    "end_ts": "1868-10-23 00:00:00",
    "deleted": 0,
    "created_ts": "2022-01-23 23:49:12",
    "modified_ts": "2022-01-23 23:49:12"
  },
  "chronology": [
    {
      "id": 5,
      "titile": "東京オリンピック",
      "adyear": "2021",
      "jayear": "令和3",
      "deleted": 0,
      "created_ts": "2022-01-27 23:09:10",
      "modified_ts": "2022-01-27 23:09:10",
      "chronology_to_period": [
        {
          "id": 5,
          "chronology_id": 5,
          "period_id": 5,
          "deleted": 0,
          "created_ts": "2022-01-27 23:09:10",
          "modified_ts": "2022-01-27 23:09:10"
        }
      ]
    }
  ]
}
```

HTTP

```zsh
curl 'https://mhj-api.becom.co.jp/' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"path":"chronology","method":"list","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=chronology --method=list --params='{}'
```

### Chronology insert

年表を新規作成

Request parameters

```json
{
  "titile": "東京オリンピック",
  "adyear": "2021",
  "jayear": "令和3"
}
```

Response parameters

```json
{
  "id": 5,
  "titile": "東京オリンピック",
  "adyear": "2021",
  "jayear": "令和3",
  "deleted": 0,
  "created_ts": "2022-01-27 23:09:10",
  "modified_ts": "2022-01-27 23:09:10"
}
```

HTTP

```zsh
curl 'https://mhj-api.becom.co.jp/' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"path":"chronology","method":"insert","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=chronology --method=insert --params='{}'
```

### Chronology update

年表を更新

Request parameters

```json
{
  "id": 5,
  "titile": "東京でオリンピック",
  "adyear": "2021",
  "jayear": "令和3"
}
```

Response parameters

```json
{
  "id": 5,
  "titile": "東京でオリンピック",
  "adyear": "2021",
  "jayear": "令和3",
  "deleted": 0,
  "created_ts": "2022-01-27 23:09:10",
  "modified_ts": "2022-01-27 23:09:10"
}
```

HTTP

```zsh
curl 'https://mhj-api.becom.co.jp/' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"path":"chronology","method":"update","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=chronology --method=update --params='{}'
```

### Chronology delete

年表を削除

Request parameters

```json
{
  "id": 5
}
```

Response parameters

```json
{}
```

HTTP

```zsh
curl 'https://mhj-api.becom.co.jp/' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"path":"chronology","method":"delete","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=chronology --method=delete --params='{}'
```
