import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// 用于方便的获取客户端Sqlite
class DB {
  /// 为了方便使用，这里假设数据库只在flutter初始化后调用, 应避免在完成装载前使用
  static late final Database db;

  /// 开启链接
  Future open() async {
    WidgetsFlutterBinding.ensureInitialized();

    final path = join(await getDatabasesPath(), 'note.db');

    print('DB path: $path');

    final db = await openDatabase(path, version: 2,
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
      await createInitTables(db);
      await patchTables();
    });

    db
        .rawQuery('SELECT name FROM sqlite_master WHERE type="table";')
        .then((value) {
      print(value);
    });

    DB.db = db;
  }

  /// 创建初始表
  Future createInitTables(Database db) async {
    /* 账本表 */
    await db.execute('''
      CREATE TABLE IF NOT EXISTS book(
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
      CREATE TABLE IF NOT EXISTS note(
        id INTEGER PRIMARY KEY AUTOINCREMENT,      -- 主键
        bookId INTEGER NOT NULL,                   -- 关联的账本id
        typeId INTEGER NOT NULL,                   -- 关联的类型id
        diffType TEXT NOT NULL,                    -- 记录类型
        diffNumber REAL NOT NULL,                  -- 增减值
        remark TEXT,                               -- 备注
        createDate INTEGER NOT NULL,               -- 创建时间
        updateDate INTEGER NOT NULL                -- 更新时间
      )
    ''');

    /* 类型表 */
    await db.execute('''
      CREATE TABLE IF NOT EXISTS type(
        id INTEGER PRIMARY KEY AUTOINCREMENT,      -- 主键
        parentId INTEGER,                          -- 父类型id
        icon TEXT NOT NULL,                        -- 图标
        name TEXT NOT NULL UNIQUE,                 -- 账本名
        color TEXT NOT NULL,                       -- 颜色
        createDate INTEGER NOT NULL,               -- 创建时间
        updateDate INTEGER NOT NULL                -- 更新时间
      )
    ''');
  }

  /// 运行表升降级补丁
  /// 数据表需要更新时，应在方法末尾追加修改查询, 并备注版本, 注意一定不要删除之前的查询补丁
  /// 每次更新都会运行所有补丁，因为数据库存在用户端，随时可能被用户手动清理
  Future patchTables() async {
    // version 1
    // patch query 1...

    // version 2
    // patch query 2...
  }
}
