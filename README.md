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

## API

### Build

#### init

```zsh
curl 'https://mhj-api.becom.co.jp/mhj.cgi' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"type":"build","method":"init","apikey":"becom"}'
```

- method: init
  - http: POST /mhj.cgi
  - params:
    - type: build
    - method: init
    - apikey: `string`
  - description: データベース初期設定 `apikey` は管理者から取得
  - cli: `mhj --type=build --method=init`

### User

#### get

params

```json
{
  "loginid": "info@becom.co.jp"
}
```

```zsh
curl 'https://mhj-api.becom.co.jp/mhj.cgi' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"type":"user","method":"get","apikey":"becom","params":{}}'
```

- method: get
  - http: POST /mhj.cgi
  - params:
    - type: user
    - method: get
    - loginid: `string`
    - apikey: `string`
  - description: 登録ユーザーの情報を取得
  - cli: `mhj --type=user --method=get --params='{}'`

#### insert

```json
{
  "loginid": "info@becom.co.jp",
  "password": "info"
}
```

```zsh
curl 'https://mhj-api.becom.co.jp/mhj.cgi' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"type":"user","method":"insert","apikey":"becom","params":{}}'
```

- method: insert
  - params:
    - type: user
    - method: insert
    - userid: `string`
    - password: `string`
    - apikey: `string`
  - description: 登録ユーザーの新規作成
  - cli: `mhj --type=user --method=insert --params='{}'`

- method: update
- method: delete
