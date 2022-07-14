# historyDetails

歴史の詳細

## historyDetails list

歴史の詳細一覧取得

Request parameters

```json
{
  "chronology_id": 5
}
```

Response parameters

```json
{
  "chronology": {
    "id": 5,
    "title": "東京オリンピック",
    "adyear": "2021",
    "jayear": "令和3",
    "deleted": 0,
    "created_ts": "2022-01-23 23:49:12",
    "modified_ts": "2022-01-23 23:49:12"
  },
  "history_details": [
    {
      "id": 5,
      "chronology_id": 5,
      "contents": "新型コロナの影響につき無観客開催",
      "adyear_ts": "2021-01-23 00:00:00",
      "deleted": 0,
      "created_ts": "2022-01-27 23:09:10",
      "modified_ts": "2022-01-27 23:09:10"
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
--data-binary '{"path":"historydetails","method":"list","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=historydetails --method=list --params='{}'
```

## historyDetails insert

歴史の詳細を新規作成

Request parameters

```json
{
  "chronology_id": 5,
  "contents": "新型コロナの影響につき無観客開催",
  "adyear_ts": "2021-01-23 00:00:00"
}
```

Response parameters

```json
{
  "id": 5,
  "chronology_id": 5,
  "contents": "新型コロナの影響につき無観客開催",
  "adyear_ts": "2021-01-23 00:00:00",
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
--data-binary '{"path":"historydetails","method":"insert","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=historydetails --method=insert --params='{}'
```

## historyDetails update

歴史の詳細を更新

Request parameters

```json
{
  "id": 5,
  "chronology_id": 5,
  "contents": "新型コロナの影響につき無観客開催やった",
  "adyear_ts": "2021-01-23 00:00:00"
}
```

Response parameters

```json
{
  "id": 5,
  "chronology_id": 5,
  "contents": "新型コロナの影響につき無観客開催やった",
  "adyear_ts": "2021-01-23 00:00:00",
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
--data-binary '{"path":"historydetails","method":"update","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=historydetails --method=update --params='{}'
```

## historyDetails delete

歴史の詳細を削除

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
--data-binary '{"path":"historydetails","method":"delete","apikey":"becom","params":{}}'
```

CLI

```zsh
mhj --path=historydetails --method=delete --params='{}'
```
