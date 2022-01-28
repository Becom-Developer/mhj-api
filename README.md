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
cpanm Plack
cpanm Task::Plack
cpanm -l ~/github/mhj-api/local --installdeps .

ローカル環境でwebサーバー経由で起動
python3 -m http.server 8000 --cgi
<http://localhost:8000/cgi-bin/index.cgi>
```

## API

`apikey` は管理者から取得

### Build init

データベース初期設定

HTTP

```zsh
curl 'https://mhj-api.becom.co.jp/mhj.cgi' \
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

### User get

登録ユーザーの情報を取得

Request parameters

```json
{
  "loginid": "info@becom.co.jp"
}
```

Response parameters

```json
{
  "id": 1,
  "loginid": "info@becom.co.jp",
  "password": "info",
  "approved": 1,
  "deleted": 0,
  "created_ts": "2022-01-24 00:46:47",
  "modified_ts": "2022-01-24 00:46:47"
}
```

HTTP

```zsh
curl 'https://mhj-api.becom.co.jp/mhj.cgi' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"path":"user","method":"get","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=user --method=get --params='{}'
```

### User insert

登録ユーザーの新規作成

Request parameters

```json
{
  "loginid": "info@becom.co.jp",
  "password": "info"
}
```

Response parameters

```json
{
  "id": 1,
  "loginid": "info@becom.co.jp",
  "password": "info",
  "approved": 1,
  "deleted": 0,
  "created_ts": "2022-01-24 00:46:47",
  "modified_ts": "2022-01-24 00:46:47"
}
```

HTTP

```zsh
curl 'https://mhj-api.becom.co.jp/mhj.cgi' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"path":"user","method":"insert","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=user --method=insert --params='{}'
```

### User update

登録ユーザーの更新

Request parameters

```json
{
  "id": 1,
  "loginid": "updateinfo@becom.co.jp",
  "password": "updateinfo"
}
```

Response parameters

```json
{
  "id": 1,
  "loginid": "updateinfo@becom.co.jp",
  "password": "updateinfo",
  "approved": 1,
  "deleted": 0,
  "created_ts": "2022-01-24 01:26:59",
  "modified_ts": "2022-01-25 18:45:06"
}
```

HTTP

```zsh
curl 'https://mhj-api.becom.co.jp/mhj.cgi' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"path":"user","method":"update","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=user --method=update --params='{}'
```

### User delete

登録ユーザーの情報を削除

Request parameters

```json
{
  "id": 1
}
```

Response parameters

```json
{}
```

HTTP

```zsh
curl 'https://mhj-api.becom.co.jp/mhj.cgi' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"path":"user","method":"delete","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=user --method=delete --params='{}'
```

### Period list

時代の一覧を取得

Request parameters

```json
{
  "period_type_id": 5
}
```

Response parameters

```json
{
  "period_type": {
    "id": 5,
    "title": "日本の歴史",
    "deleted": 0,
    "created_ts": "2022-01-23 23:49:12",
    "modified_ts": "2022-01-23 23:49:12"
  },
  "period": [
    {
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
    }
  ]
}
```

HTTP

```zsh
curl 'https://mhj-api.becom.co.jp/mhj.cgi' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"path":"period","method":"list","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=period --method=list --params='{}'
```

### Period insert

時代を新規作成

Request parameters

```json
{
  "period_type_id": 5,
  "title": "江戸時代",
  "start_year": "1603",
  "end_year": "1868",
  "start_ts": "1603-03-24 00:00:00",
  "end_ts": "1868-10-23 00:00:00"
}
```

Response parameters

```json
{
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
}
```

HTTP

```zsh
curl 'https://mhj-api.becom.co.jp/mhj.cgi' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"path":"period","method":"insert","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=period --method=insert --params='{}'
```

### Period update

時代を更新

Request parameters

```json
{
  "id": 5,
  "period_type_id": 5,
  "title": "江戸の時代",
  "start_year": "1603",
  "end_year": "1868",
  "start_ts": "1603-03-24 00:00:00",
  "end_ts": "1868-10-23 00:00:00"
}
```

Response parameters

```json
{
  "id": 5,
  "period_type_id": 5,
  "title": "江戸の時代",
  "start_year": "1603",
  "end_year": "1868",
  "start_ts": "1603-03-24 00:00:00",
  "end_ts": "1868-10-23 00:00:00",
  "deleted": 0,
  "created_ts": "2022-01-23 23:49:12",
  "modified_ts": "2022-01-23 23:49:12"
}
```

HTTP

```zsh
curl 'https://mhj-api.becom.co.jp/mhj.cgi' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"path":"period","method":"update","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=period --method=update --params='{}'
```

### Period delete

時代を削除

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
curl 'https://mhj-api.becom.co.jp/mhj.cgi' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"path":"period","method":"delete","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=period --method=delete --params='{}'
```

### PeriodType list

時代の種別一覧を取得

Request parameters

```json
{}
```

Response parameters

```json
{
  "period_type": [
    {
      "id": 5,
      "title": "日本の歴史",
      "deleted": 0,
      "created_ts": "2022-01-23 23:49:12",
      "modified_ts": "2022-01-23 23:49:12"
    }
  ]
}
```

HTTP

```zsh
curl 'https://mhj-api.becom.co.jp/mhj.cgi' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"path":"periodtype","method":"list","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=periodtype --method=list --params='{}'
```

### PeriodType insert

時代の種別を新規作成

Request parameters

```json
{
  "title": "日本の歴史"
}
```

Response parameters

```json
{
  "id": 5,
  "title": "日本の歴史",
  "deleted": 0,
  "created_ts": "2022-01-23 23:49:12",
  "modified_ts": "2022-01-23 23:49:12"
}
```

HTTP

```zsh
curl 'https://mhj-api.becom.co.jp/mhj.cgi' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"path":"periodtype","method":"insert","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=periodtype --method=insert --params='{}'
```

### PeriodType update

時代の種別を更新

Request parameters

```json
{
  "id": 5,
  "title": "日本の歴史と社会歴史"
}
```

Response parameters

```json
{
  "id": 5,
  "title": "日本の歴史と社会歴史",
  "deleted": 0,
  "created_ts": "2022-01-23 23:49:12",
  "modified_ts": "2022-01-23 23:49:12"
}
```

HTTP

```zsh
curl 'https://mhj-api.becom.co.jp/mhj.cgi' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"path":"period","method":"update","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=period --method=update --params='{}'
```

### PeriodType delete

時代の種別を削除

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
curl 'https://mhj-api.becom.co.jp/mhj.cgi' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"path":"period","method":"delete","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=period --method=delete --params='{}'
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
curl 'https://mhj-api.becom.co.jp/mhj.cgi' \
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
curl 'https://mhj-api.becom.co.jp/mhj.cgi' \
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
curl 'https://mhj-api.becom.co.jp/mhj.cgi' \
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
curl 'https://mhj-api.becom.co.jp/mhj.cgi' \
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
