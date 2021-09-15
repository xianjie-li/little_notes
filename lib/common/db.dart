import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// 用于方便的获取客户端Sqlite
class DB {
  // 每次版本变更都会进行一次数据库初始化, 可以借此来确保数据表存在且为最新版本
  static const int DBVersion = 10;

  /// 为了方便使用，这里假设数据库只在flutter初始化后调用, 应避免在完成装载前使用
  static late final Database db;

  static const BOOK = 'book';
  static const NOTE = 'note';
  static const TYPE = 'type';
  static const SETTING = 'setting';

  /// 开启链接
  Future open() async {
    WidgetsFlutterBinding.ensureInitialized();

    final path = join(await getDatabasesPath(), 'note.db');

    // await deleteDatabase(path);

    print('DB path: $path');

    final db = await openDatabase(path, version: DB.DBVersion,
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
      print('update db');

      await createInitTables(db);
      await patchTables(db);
      await init(db);
    });

    db
        .rawQuery('SELECT name FROM sqlite_master WHERE type="table"')
        .then((value) {
      print(value);
    });

    DB.db = db;
  }

  /// 创建初始表
  Future createInitTables(Database db) async {
    /* 账本表 */
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DB.BOOK}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,      -- 主键
        focus TEXT NOT NULL,                       -- 账本关注点
        icon TEXT NOT NULL,                        -- 图标
        name TEXT NOT NULL UNIQUE,                 -- 账本名
        balance REAL NOT NULL,                     -- 余额
        budget REAL NOT NULL,                      -- 预算
        color TEXT NOT NULL,                       -- 颜色
        createDate INTEGER NOT NULL,               -- 创建时间
        updateDate INTEGER NOT NULL                -- 更新时间
      )
    ''');

    /* 记录表 */
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DB.NOTE}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,      -- 主键
        bookId INTEGER NOT NULL,                   -- 关联的账本id
        typeId INTEGER,                            -- 关联的类型id
        diffType TEXT NOT NULL,                    -- 记录类型
        diffNumber REAL NOT NULL,                  -- 增减值
        remark TEXT,                               -- 备注
        createDate INTEGER NOT NULL,               -- 创建时间
        updateDate INTEGER NOT NULL                -- 更新时间
      )
    ''');

    /* 类型表 */
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DB.TYPE}(
        id INTEGER PRIMARY KEY AUTOINCREMENT,      -- 主键
        parentId INTEGER,                          -- 父类型id
        icon TEXT NOT NULL,                        -- 图标
        name TEXT NOT NULL UNIQUE,                 -- 账本名
        color TEXT NOT NULL,                       -- 颜色
        createDate INTEGER NOT NULL,               -- 创建时间
        updateDate INTEGER NOT NULL                -- 更新时间
      )
    ''');

    /* 设置表 */
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DB.SETTING}(
        currentBookId INTEGER                      -- 当前账本
      )
    ''');
  }

  /// 运行表升降级补丁
  /// 数据表需要更新时，应在方法末尾追加修改查询, 并备注版本, 注意一定不要删除之前的补丁
  /// 每次更新都会运行所有补丁，因为数据库在用户端，随时可能被用户手动清理
  Future patchTables(Database db) async {
    // version 1
    // patch query 1...

    // version 2
    // patch query 2...
  }

  /// 执行初始化操作
  Future init(Database db) async {}
}
