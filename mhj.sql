DROP TABLE IF EXISTS user;
CREATE TABLE user (                                     -- ユーザー
    id              INTEGER PRIMARY KEY AUTOINCREMENT,  -- ID (例: 5)
    login_id        TEXT,                               -- ログインID名 (例: 'getcoin@gmail.com')
    password        TEXT,                               -- ログインパスワード (例: 'getcoin')
    approved        INTEGER,                            -- 承認フラグ (例: 0: 承認していない, 1: 承認済み)
    deleted         INTEGER,                            -- 削除フラグ (例: 0: 削除していない, 1: 削除済み)
    created_ts      TEXT,                               -- 登録日時 (例: '2016-01-08 12:24:12')
    modified_ts     TEXT                                -- 修正日時 (例: '2016-01-08 12:24:12')
);
