# Chronology

年表

## Chronology list

年表の一覧取得

Request parameters

```json
{}
```

Response parameters

```json
[
  {
    "id": 5,
    "title": "東京オリンピック",
    "adyear": "2021",
    "jayear": "令和3",
    "deleted": 0,
    "created_ts": "2022-01-23 23:49:12",
    "modified_ts": "2022-01-23 23:49:12"
  }
]
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

## Chronology insert

年表を新規作成

Request parameters

```json
{
  "title": "東京オリンピック",
  "adyear": "2021",
  "jayear": "令和3"
}
```

Response parameters

```json
{
  "id": 5,
  "title": "東京オリンピック",
  "adyear": "2021",
  "jayear": "令和3",
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
--data-binary '{"path":"chronology","method":"insert","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=chronology --method=insert --params='{}'
```

## Chronology update

年表を更新

Request parameters

```json
{
  "id": 5,
  "title": "東京のオリンピック",
  "adyear": "2021",
  "jayear": "令和3"
}
```

Response parameters

```json
{
  "id": 5,
  "title": "東京のオリンピック",
  "adyear": "2021",
  "jayear": "令和3",
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
--data-binary '{"path":"chronology","method":"update","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=chronology --method=update --params='{}'
```

## PeriodType delete

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
