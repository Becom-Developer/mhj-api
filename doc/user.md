# User

登録ユーザー

## User get

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
curl 'https://mhj-api.becom.co.jp/' \
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

## User list

登録ユーザーの一覧を取得

Request parameters

```json
{}
```

Response parameters

```json
[
  {
    "id": 1,
    "loginid": "info@becom.co.jp",
    "password": "info",
    "approved": 1,
    "deleted": 0,
    "created_ts": "2022-01-24 00:46:47",
    "modified_ts": "2022-01-24 00:46:47"
  }
]
```

HTTP

```zsh
curl 'https://mhj-api.becom.co.jp/' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"path":"user","method":"list","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=user --method=list --params='{}'
```

## User insert

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
curl 'https://mhj-api.becom.co.jp/' \
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

## User update

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
curl 'https://mhj-api.becom.co.jp/' \
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

## User delete

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
curl 'https://mhj-api.becom.co.jp/' \
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
