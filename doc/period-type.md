# PeriodType

時代の種別

## PeriodType list

時代の種別一覧を取得

Request parameters

```json
{}
```

Response parameters

```json
[
  {
    "id": 5,
    "title": "日本の歴史",
    "deleted": 0,
    "created_ts": "2022-01-23 23:49:12",
    "modified_ts": "2022-01-23 23:49:12"
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
--data-binary '{"path":"periodtype","method":"list","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=periodtype --method=list --params='{}'
```

## PeriodType insert

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
curl 'https://mhj-api.becom.co.jp/' \
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

## PeriodType update

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
curl 'https://mhj-api.becom.co.jp/' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"path":"periodtype","method":"update","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=periodtype --method=update --params='{}'
```

## PeriodType delete

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
curl 'https://mhj-api.becom.co.jp/' \
--verbose \
--request POST \
--header 'Content-Type: application/json' \
--header 'accept: application/json' \
--data-binary '{"path":"periodtype","method":"delete","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=periodtype --method=delete --params='{}'
```
