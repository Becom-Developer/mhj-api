DROP TABLE IF EXISTS user;
CREATE TABLE user (                                     -- ユーザー
    id              INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID (例: 5)
    loginid         TEXT,                               -- ログインID名 (例: 'info@gmail.com')
    password        TEXT,                               -- ログインパスワード (例: 'info')
    approved        INTEGER,                            -- 承認フラグ (例: 0: 承認していない, 1: 承認済み)
    deleted         INTEGER,                            -- 削除フラグ (例: 0: 削除していない, 1: 削除済み)
    created_ts      TEXT,                               -- 登録日時 (例: '2022-01-23 23:49:12')
    modified_ts     TEXT                                -- 修正日時 (例: '2022-01-23 23:49:12')
);
DROP TABLE IF EXISTS chronology;
CREATE TABLE chronology (                               -- 年表
    id              INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID (例: 5)
    period_id       INTEGER,                            -- 時代のID (例: 5)
    titile          TEXT,                               -- タイトル (例: '東京オリンピック')
    adyear          TEXT,                               -- 西暦表示 (例: '2021')
    jayear          TEXT,                               -- 和暦表示 (例: '令和3')
    deleted         INTEGER,                            -- 削除フラグ (例: 0: 削除していない, 1: 削除済み)
    created_ts      TEXT,                               -- 登録日時 (例: '2022-01-27 23:09:10')
    modified_ts     TEXT                                -- 修正日時 (例: '2022-01-27 23:09:10')
);
DROP TABLE IF EXISTS history_details;
CREATE TABLE history_details (                          -- 歴史の詳細
    id              INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID (例: 5)
    chronology_id   INTEGER,                            -- 年表のID (例: 1)
    contents        TEXT,                               -- 内容 (例: '新型コロナの影響につき無観客開催')
    adyear_ts       TEXT,                               -- 内容の日時 (例: '2021-01-23 00:00:00')
    deleted         INTEGER,                            -- 削除フラグ (例: 0: 削除していない, 1: 削除済み)
    created_ts      TEXT,                               -- 登録日時 (例: '2022-01-27 23:09:10')
    modified_ts     TEXT                                -- 修正日時 (例: '2022-01-27 23:09:10')
);
DROP TABLE IF EXISTS chronology_to_period;
CREATE TABLE chronology_to_period (                     -- 年表と時代の結びつき
    id              INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID (例: 5)
    chronology_id   INTEGER,                            -- 年表のID (例: 5)
    period_id       INTEGER,                            -- 時代のID (例: 5)
    deleted         INTEGER,                            -- 削除フラグ (例: 0: 削除していない, 1: 削除済み)
    created_ts      TEXT,                               -- 登録日時 (例: '2022-01-27 23:09:10')
    modified_ts     TEXT                                -- 修正日時 (例: '2022-01-27 23:09:10')
);
DROP TABLE IF EXISTS `period`;
CREATE TABLE `period` (                                 -- 時代
    id              INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID (例: 5)
    period_type_id  INTEGER,                            -- 時代の種別ID (例: 5)
    title           TEXT,                               -- タイトル (例: '江戸時代')
    start_year      TEXT,                               -- 開始年 (例: '1603')
    end_year        TEXT,                               -- 終了年 (例: '1868')
    start_ts        TEXT,                               -- 開始日時 (例: '1603-03-24 00:00:00')
    end_ts          TEXT,                               -- 終了日時 (例: '1868-10-23 00:00:00')
    deleted         INTEGER,                            -- 削除フラグ (例: 0: 削除していない, 1: 削除済み)
    created_ts      TEXT,                               -- 登録日時 (例: '2022-01-23 23:49:12')
    modified_ts     TEXT                                -- 修正日時 (例: '2022-01-23 23:49:12')
);
DROP TABLE IF EXISTS period_type;
CREATE TABLE period_type (                              -- 時代の種別
    id              INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID (例: 5)
    title           TEXT,                               -- タイトル (例: '日本の歴史')
    deleted         INTEGER,                            -- 削除フラグ (例: 0: 削除していない, 1: 削除済み)
    created_ts      TEXT,                               -- 登録日時 (例: '2022-01-23 23:49:12')
    modified_ts     TEXT                                -- 修正日時 (例: '2022-01-23 23:49:12')
);
