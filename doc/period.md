# Period

時代に関する情報の取得

## Period list

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

## Period insert

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

## Period update

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

## Period delete

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

## PeriodType list

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
curl 'https://mhj-api.becom.co.jp/mhj.cgi' \
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
