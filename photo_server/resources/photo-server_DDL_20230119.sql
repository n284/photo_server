-- Project Name : photo-server
-- Date/Time    : 2024/01/20 18:20:36
-- Author       : nishizawa
-- RDBMS Type   : PostgreSQL
-- Application  : A5:SQL Mk-2

/*
  << 注意！！ >>
  BackupToTempTable, RestoreFromTempTable疑似命令が付加されています。
  これにより、drop table, create table 後もデータが残ります。
  この機能は一時的に $$TableName のような一時テーブルを作成します。
  この機能は A5:SQL Mk-2でのみ有効であることに注意してください。
*/

-- コメントテーブル
-- * RestoreFromTempTable
CREATE TABLE comment_table (
  comment_id integer DEFAULT NEXTVAL('comment_sequence') NOT NULL
  , file_id integer NOT NULL
  , parent_comment_id integer
  , text character varying(255) NOT NULL
  , good_count integer DEFAULT 0 NOT NULL
  , bad_count integer DEFAULT 0 NOT NULL
  , contributer_user_id integer NOT NULL
  , post_datetime timestamp NOT NULL
  , register_user_id integer NOT NULL
  , register_date timestamp DEFAULT NOW() NOT NULL
  , delete_user_id integer
  , delete_date timestamp
  , delete_flag integer DEFAULT 0 NOT NULL
  , CONSTRAINT comment_table_PKC PRIMARY KEY (comment_id,file_id)
) ;

-- ファイルテーブル
-- * RestoreFromTempTable
CREATE TABLE file_table (
  file_id integer DEFAULT NEXTVAL('file_sequence') NOT NULL
  , photo_name character varying(255) NOT NULL
  , taking_date timestamp NOT NULL
  , taking_area character varying(255) NOT NULL
  , file_class integer NOT NULL
  , file_extention character varying NOT NULL
  , register_user_id integer NOT NULL
  , register_date timestamp DEFAULT NOW() NOT NULL
  , delete_user_id integer
  , delete_date timestamp
  , delete_flag integer DEFAULT 0 NOT NULL
  , CONSTRAINT file_table_PKC PRIMARY KEY (file_id,photo_name)
) ;

-- 権限マスタ
-- * RestoreFromTempTable
CREATE TABLE permission_master (
  permission_id integer DEFAULT NEXTVAL('permission_sequence') NOT NULL
  , permission_name character varying(20) NOT NULL
  , register_date timestamp DEFAULT NOW() NOT NULL
  , delete_date timestamp
  , delete_flag integer DEFAULT 0 NOT NULL
  , CONSTRAINT permission_master_PKC PRIMARY KEY (permission_id)
) ;

-- ユーザーマスタ
-- * RestoreFromTempTable
CREATE TABLE USER_MASTER (
  user_id character varying(20) NOT NULL
  , last_name character varying(20) NOT NULL
  , first_name character varying(20) NOT NULL
  , birthday_year integer NOT NULL
  , birthday_month integer NOT NULL
  , birthday_date integer NOT NULL
  , permission_id integer NOT NULL
  , password character varying(256) NOT NULL
  , failure_count integer DEFAULT 0 NOT NULL
  , register_date timestamp DEFAULT NOW() NOT NULL
  , delete_date timestamp
  , delete_flag integer DEFAULT 0 NOT NULL
  , CONSTRAINT USER_MASTER_PKC PRIMARY KEY (user_id)
) ;

COMMENT ON TABLE comment_table IS 'コメントテーブル';
COMMENT ON COLUMN comment_table.comment_id IS 'コメントID';
COMMENT ON COLUMN comment_table.file_id IS 'ファイルID';
COMMENT ON COLUMN comment_table.parent_comment_id IS '親コメントID';
COMMENT ON COLUMN comment_table.text IS '内容';
COMMENT ON COLUMN comment_table.good_count IS 'グッド数';
COMMENT ON COLUMN comment_table.bad_count IS 'バッド数';
COMMENT ON COLUMN comment_table.contributer_user_id IS '投稿者';
COMMENT ON COLUMN comment_table.post_datetime IS '投稿日時';
COMMENT ON COLUMN comment_table.register_user_id IS '登録者';
COMMENT ON COLUMN comment_table.register_date IS '登録日時';
COMMENT ON COLUMN comment_table.delete_user_id IS '削除者';
COMMENT ON COLUMN comment_table.delete_date IS '削除日時';
COMMENT ON COLUMN comment_table.delete_flag IS '削除フラグ:0:未削除, 1:削除';

COMMENT ON TABLE file_table IS 'ファイルテーブル';
COMMENT ON COLUMN file_table.file_id IS 'ファイルID';
COMMENT ON COLUMN file_table.photo_name IS 'ファイル名';
COMMENT ON COLUMN file_table.taking_date IS '撮影日';
COMMENT ON COLUMN file_table.taking_area IS '撮影場所';
COMMENT ON COLUMN file_table.file_class IS 'ファイル区分:0:写真, 1:動画';
COMMENT ON COLUMN file_table.file_extention IS '拡張子';
COMMENT ON COLUMN file_table.register_user_id IS '登録者';
COMMENT ON COLUMN file_table.register_date IS '登録日時';
COMMENT ON COLUMN file_table.delete_user_id IS '削除者';
COMMENT ON COLUMN file_table.delete_date IS '削除日時';
COMMENT ON COLUMN file_table.delete_flag IS '削除フラグ:0:未削除, 1:削除';

COMMENT ON TABLE permission_master IS '権限マスタ';
COMMENT ON COLUMN permission_master.permission_id IS '権限ID';
COMMENT ON COLUMN permission_master.permission_name IS '権限名';
COMMENT ON COLUMN permission_master.register_date IS '登録日時';
COMMENT ON COLUMN permission_master.delete_date IS '削除日時';
COMMENT ON COLUMN permission_master.delete_flag IS '削除フラグ:0:未削除, 1:削除';

COMMENT ON TABLE USER_MASTER IS 'ユーザーマスタ';
COMMENT ON COLUMN USER_MASTER.user_id IS 'ユーザーID';
COMMENT ON COLUMN USER_MASTER.last_name IS '氏名';
COMMENT ON COLUMN USER_MASTER.first_name IS '名前';
COMMENT ON COLUMN USER_MASTER.birthday_year IS '生年月日_年';
COMMENT ON COLUMN USER_MASTER.birthday_month IS '生年月日_月';
COMMENT ON COLUMN USER_MASTER.birthday_date IS '生年月日_日';
COMMENT ON COLUMN USER_MASTER.permission_id IS '権限ID';
COMMENT ON COLUMN USER_MASTER.password IS 'パスワード';
COMMENT ON COLUMN USER_MASTER.failure_count IS '認証失敗回数';
COMMENT ON COLUMN USER_MASTER.register_date IS '登録日時';
COMMENT ON COLUMN USER_MASTER.delete_date IS '削除日時';
COMMENT ON COLUMN USER_MASTER.delete_flag IS '削除フラグ:0:未削除, 1:削除';

CREATE SEQUENCE comment_sequence;
CREATE SEQUENCE file_sequence;
CREATE SEQUENCE permission_sequence;
