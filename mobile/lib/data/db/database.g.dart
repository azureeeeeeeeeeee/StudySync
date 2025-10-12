// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $DownloadedItemsTable extends DownloadedItems
    with TableInfo<$DownloadedItemsTable, DownloadedItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DownloadedItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 6),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
    'path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, path, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'downloaded_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<DownloadedItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
        _pathMeta,
        path.isAcceptableOrUnknown(data['path']!, _pathMeta),
      );
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DownloadedItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DownloadedItem(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      path:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}path'],
          )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $DownloadedItemsTable createAlias(String alias) {
    return $DownloadedItemsTable(attachedDatabase, alias);
  }
}

class DownloadedItem extends DataClass implements Insertable<DownloadedItem> {
  final int id;
  final String title;
  final String path;
  final DateTime? createdAt;
  const DownloadedItem({
    required this.id,
    required this.title,
    required this.path,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['path'] = Variable<String>(path);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  DownloadedItemsCompanion toCompanion(bool nullToAbsent) {
    return DownloadedItemsCompanion(
      id: Value(id),
      title: Value(title),
      path: Value(path),
      createdAt:
          createdAt == null && nullToAbsent
              ? const Value.absent()
              : Value(createdAt),
    );
  }

  factory DownloadedItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DownloadedItem(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      path: serializer.fromJson<String>(json['path']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'path': serializer.toJson<String>(path),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  DownloadedItem copyWith({
    int? id,
    String? title,
    String? path,
    Value<DateTime?> createdAt = const Value.absent(),
  }) => DownloadedItem(
    id: id ?? this.id,
    title: title ?? this.title,
    path: path ?? this.path,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  DownloadedItem copyWithCompanion(DownloadedItemsCompanion data) {
    return DownloadedItem(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      path: data.path.present ? data.path.value : this.path,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DownloadedItem(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('path: $path, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, path, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DownloadedItem &&
          other.id == this.id &&
          other.title == this.title &&
          other.path == this.path &&
          other.createdAt == this.createdAt);
}

class DownloadedItemsCompanion extends UpdateCompanion<DownloadedItem> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> path;
  final Value<DateTime?> createdAt;
  const DownloadedItemsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.path = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DownloadedItemsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String path,
    this.createdAt = const Value.absent(),
  }) : title = Value(title),
       path = Value(path);
  static Insertable<DownloadedItem> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? path,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (path != null) 'path': path,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DownloadedItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? path,
    Value<DateTime?>? createdAt,
  }) {
    return DownloadedItemsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      path: path ?? this.path,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DownloadedItemsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('path: $path, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DownloadedItemsTable downloadedItems = $DownloadedItemsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [downloadedItems];
}

typedef $$DownloadedItemsTableCreateCompanionBuilder =
    DownloadedItemsCompanion Function({
      Value<int> id,
      required String title,
      required String path,
      Value<DateTime?> createdAt,
    });
typedef $$DownloadedItemsTableUpdateCompanionBuilder =
    DownloadedItemsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> path,
      Value<DateTime?> createdAt,
    });

class $$DownloadedItemsTableFilterComposer
    extends Composer<_$AppDatabase, $DownloadedItemsTable> {
  $$DownloadedItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DownloadedItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $DownloadedItemsTable> {
  $$DownloadedItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DownloadedItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DownloadedItemsTable> {
  $$DownloadedItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DownloadedItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DownloadedItemsTable,
          DownloadedItem,
          $$DownloadedItemsTableFilterComposer,
          $$DownloadedItemsTableOrderingComposer,
          $$DownloadedItemsTableAnnotationComposer,
          $$DownloadedItemsTableCreateCompanionBuilder,
          $$DownloadedItemsTableUpdateCompanionBuilder,
          (
            DownloadedItem,
            BaseReferences<
              _$AppDatabase,
              $DownloadedItemsTable,
              DownloadedItem
            >,
          ),
          DownloadedItem,
          PrefetchHooks Function()
        > {
  $$DownloadedItemsTableTableManager(
    _$AppDatabase db,
    $DownloadedItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$DownloadedItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$DownloadedItemsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$DownloadedItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> path = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
              }) => DownloadedItemsCompanion(
                id: id,
                title: title,
                path: path,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String path,
                Value<DateTime?> createdAt = const Value.absent(),
              }) => DownloadedItemsCompanion.insert(
                id: id,
                title: title,
                path: path,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DownloadedItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DownloadedItemsTable,
      DownloadedItem,
      $$DownloadedItemsTableFilterComposer,
      $$DownloadedItemsTableOrderingComposer,
      $$DownloadedItemsTableAnnotationComposer,
      $$DownloadedItemsTableCreateCompanionBuilder,
      $$DownloadedItemsTableUpdateCompanionBuilder,
      (
        DownloadedItem,
        BaseReferences<_$AppDatabase, $DownloadedItemsTable, DownloadedItem>,
      ),
      DownloadedItem,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DownloadedItemsTableTableManager get downloadedItems =>
      $$DownloadedItemsTableTableManager(_db, _db.downloadedItems);
}
