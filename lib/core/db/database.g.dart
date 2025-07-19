// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 12,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CategoriesColor, int> color =
      GeneratedColumn<int>(
        'color',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<CategoriesColor>($CategoriesTable.$convertercolor);
  @override
  late final GeneratedColumnWithTypeConverter<CategoriesIcon, int> icon =
      GeneratedColumn<int>(
        'icon',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<CategoriesIcon>($CategoriesTable.$convertericon);
  @override
  List<GeneratedColumn> get $columns => [id, name, color, icon];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      color: $CategoriesTable.$convertercolor.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}color'],
        )!,
      ),
      icon: $CategoriesTable.$convertericon.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}icon'],
        )!,
      ),
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CategoriesColor, int, int> $convertercolor =
      const EnumIndexConverter<CategoriesColor>(CategoriesColor.values);
  static JsonTypeConverter2<CategoriesIcon, int, int> $convertericon =
      const EnumIndexConverter<CategoriesIcon>(CategoriesIcon.values);
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String name;
  final CategoriesColor color;
  final CategoriesIcon icon;
  const Category({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['color'] = Variable<int>(
        $CategoriesTable.$convertercolor.toSql(color),
      );
    }
    {
      map['icon'] = Variable<int>($CategoriesTable.$convertericon.toSql(icon));
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      color: Value(color),
      icon: Value(icon),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: $CategoriesTable.$convertercolor.fromJson(
        serializer.fromJson<int>(json['color']),
      ),
      icon: $CategoriesTable.$convertericon.fromJson(
        serializer.fromJson<int>(json['icon']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<int>(
        $CategoriesTable.$convertercolor.toJson(color),
      ),
      'icon': serializer.toJson<int>(
        $CategoriesTable.$convertericon.toJson(icon),
      ),
    };
  }

  Category copyWith({
    int? id,
    String? name,
    CategoriesColor? color,
    CategoriesIcon? icon,
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    color: color ?? this.color,
    icon: icon ?? this.icon,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      icon: data.icon.present ? data.icon.value : this.icon,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, color, icon);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color &&
          other.icon == this.icon);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> name;
  final Value<CategoriesColor> color;
  final Value<CategoriesIcon> icon;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? color,
    Expression<int>? icon,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (icon != null) 'icon': icon,
    });
  }

  CategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<CategoriesColor>? color,
    Value<CategoriesIcon>? icon,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(
        $CategoriesTable.$convertercolor.toSql(color.value),
      );
    }
    if (icon.present) {
      map['icon'] = Variable<int>(
        $CategoriesTable.$convertericon.toSql(icon.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }
}

class $HabitsTable extends Habits with TableInfo<$HabitsTable, Habit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 30,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startDatetimeMeta = const VerificationMeta(
    'startDatetime',
  );
  @override
  late final GeneratedColumn<DateTime> startDatetime =
      GeneratedColumn<DateTime>(
        'start_datetime',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _endDatetimeMeta = const VerificationMeta(
    'endDatetime',
  );
  @override
  late final GeneratedColumn<DateTime> endDatetime = GeneratedColumn<DateTime>(
    'end_datetime',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderTimeMeta = const VerificationMeta(
    'reminderTime',
  );
  @override
  late final GeneratedColumn<String> reminderTime = GeneratedColumn<String>(
    'reminder_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _repeatDayOfWeekMeta = const VerificationMeta(
    'repeatDayOfWeek',
  );
  @override
  late final GeneratedColumn<String> repeatDayOfWeek = GeneratedColumn<String>(
    'repeat_day_of_week',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 7,
      maxTextLength: 7,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _changedAtMeta = const VerificationMeta(
    'changedAt',
  );
  @override
  late final GeneratedColumn<DateTime> changedAt = GeneratedColumn<DateTime>(
    'changed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    startDatetime,
    endDatetime,
    reminderTime,
    repeatDayOfWeek,
    categoryId,
    createdAt,
    changedAt,
    isArchived,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(
    Insertable<Habit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('start_datetime')) {
      context.handle(
        _startDatetimeMeta,
        startDatetime.isAcceptableOrUnknown(
          data['start_datetime']!,
          _startDatetimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startDatetimeMeta);
    }
    if (data.containsKey('end_datetime')) {
      context.handle(
        _endDatetimeMeta,
        endDatetime.isAcceptableOrUnknown(
          data['end_datetime']!,
          _endDatetimeMeta,
        ),
      );
    }
    if (data.containsKey('reminder_time')) {
      context.handle(
        _reminderTimeMeta,
        reminderTime.isAcceptableOrUnknown(
          data['reminder_time']!,
          _reminderTimeMeta,
        ),
      );
    }
    if (data.containsKey('repeat_day_of_week')) {
      context.handle(
        _repeatDayOfWeekMeta,
        repeatDayOfWeek.isAcceptableOrUnknown(
          data['repeat_day_of_week']!,
          _repeatDayOfWeekMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_repeatDayOfWeekMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('changed_at')) {
      context.handle(
        _changedAtMeta,
        changedAt.isAcceptableOrUnknown(data['changed_at']!, _changedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_changedAtMeta);
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Habit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Habit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      startDatetime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_datetime'],
      )!,
      endDatetime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_datetime'],
      ),
      reminderTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reminder_time'],
      ),
      repeatDayOfWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}repeat_day_of_week'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      changedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}changed_at'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }
}

class Habit extends DataClass implements Insertable<Habit> {
  final int id;
  final String name;
  final String? description;
  final DateTime startDatetime;
  final DateTime? endDatetime;

  /// Stored as 'HH:mm' string.
  final String? reminderTime;

  /// Format: '1111111' referring to days of the week (sun, mon, tue... sat).
  final String repeatDayOfWeek;
  final int categoryId;
  final DateTime createdAt;
  final DateTime changedAt;
  final bool isArchived;
  final bool isDeleted;
  const Habit({
    required this.id,
    required this.name,
    this.description,
    required this.startDatetime,
    this.endDatetime,
    this.reminderTime,
    required this.repeatDayOfWeek,
    required this.categoryId,
    required this.createdAt,
    required this.changedAt,
    required this.isArchived,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['start_datetime'] = Variable<DateTime>(startDatetime);
    if (!nullToAbsent || endDatetime != null) {
      map['end_datetime'] = Variable<DateTime>(endDatetime);
    }
    if (!nullToAbsent || reminderTime != null) {
      map['reminder_time'] = Variable<String>(reminderTime);
    }
    map['repeat_day_of_week'] = Variable<String>(repeatDayOfWeek);
    map['category_id'] = Variable<int>(categoryId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['changed_at'] = Variable<DateTime>(changedAt);
    map['is_archived'] = Variable<bool>(isArchived);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      startDatetime: Value(startDatetime),
      endDatetime: endDatetime == null && nullToAbsent
          ? const Value.absent()
          : Value(endDatetime),
      reminderTime: reminderTime == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderTime),
      repeatDayOfWeek: Value(repeatDayOfWeek),
      categoryId: Value(categoryId),
      createdAt: Value(createdAt),
      changedAt: Value(changedAt),
      isArchived: Value(isArchived),
      isDeleted: Value(isDeleted),
    );
  }

  factory Habit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Habit(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      startDatetime: serializer.fromJson<DateTime>(json['startDatetime']),
      endDatetime: serializer.fromJson<DateTime?>(json['endDatetime']),
      reminderTime: serializer.fromJson<String?>(json['reminderTime']),
      repeatDayOfWeek: serializer.fromJson<String>(json['repeatDayOfWeek']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      changedAt: serializer.fromJson<DateTime>(json['changedAt']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'startDatetime': serializer.toJson<DateTime>(startDatetime),
      'endDatetime': serializer.toJson<DateTime?>(endDatetime),
      'reminderTime': serializer.toJson<String?>(reminderTime),
      'repeatDayOfWeek': serializer.toJson<String>(repeatDayOfWeek),
      'categoryId': serializer.toJson<int>(categoryId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'changedAt': serializer.toJson<DateTime>(changedAt),
      'isArchived': serializer.toJson<bool>(isArchived),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  Habit copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    DateTime? startDatetime,
    Value<DateTime?> endDatetime = const Value.absent(),
    Value<String?> reminderTime = const Value.absent(),
    String? repeatDayOfWeek,
    int? categoryId,
    DateTime? createdAt,
    DateTime? changedAt,
    bool? isArchived,
    bool? isDeleted,
  }) => Habit(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    startDatetime: startDatetime ?? this.startDatetime,
    endDatetime: endDatetime.present ? endDatetime.value : this.endDatetime,
    reminderTime: reminderTime.present ? reminderTime.value : this.reminderTime,
    repeatDayOfWeek: repeatDayOfWeek ?? this.repeatDayOfWeek,
    categoryId: categoryId ?? this.categoryId,
    createdAt: createdAt ?? this.createdAt,
    changedAt: changedAt ?? this.changedAt,
    isArchived: isArchived ?? this.isArchived,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  Habit copyWithCompanion(HabitsCompanion data) {
    return Habit(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      startDatetime: data.startDatetime.present
          ? data.startDatetime.value
          : this.startDatetime,
      endDatetime: data.endDatetime.present
          ? data.endDatetime.value
          : this.endDatetime,
      reminderTime: data.reminderTime.present
          ? data.reminderTime.value
          : this.reminderTime,
      repeatDayOfWeek: data.repeatDayOfWeek.present
          ? data.repeatDayOfWeek.value
          : this.repeatDayOfWeek,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      changedAt: data.changedAt.present ? data.changedAt.value : this.changedAt,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('startDatetime: $startDatetime, ')
          ..write('endDatetime: $endDatetime, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('repeatDayOfWeek: $repeatDayOfWeek, ')
          ..write('categoryId: $categoryId, ')
          ..write('createdAt: $createdAt, ')
          ..write('changedAt: $changedAt, ')
          ..write('isArchived: $isArchived, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    startDatetime,
    endDatetime,
    reminderTime,
    repeatDayOfWeek,
    categoryId,
    createdAt,
    changedAt,
    isArchived,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.startDatetime == this.startDatetime &&
          other.endDatetime == this.endDatetime &&
          other.reminderTime == this.reminderTime &&
          other.repeatDayOfWeek == this.repeatDayOfWeek &&
          other.categoryId == this.categoryId &&
          other.createdAt == this.createdAt &&
          other.changedAt == this.changedAt &&
          other.isArchived == this.isArchived &&
          other.isDeleted == this.isDeleted);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime> startDatetime;
  final Value<DateTime?> endDatetime;
  final Value<String?> reminderTime;
  final Value<String> repeatDayOfWeek;
  final Value<int> categoryId;
  final Value<DateTime> createdAt;
  final Value<DateTime> changedAt;
  final Value<bool> isArchived;
  final Value<bool> isDeleted;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.startDatetime = const Value.absent(),
    this.endDatetime = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.repeatDayOfWeek = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.changedAt = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  HabitsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required DateTime startDatetime,
    this.endDatetime = const Value.absent(),
    this.reminderTime = const Value.absent(),
    required String repeatDayOfWeek,
    required int categoryId,
    required DateTime createdAt,
    required DateTime changedAt,
    this.isArchived = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : name = Value(name),
       startDatetime = Value(startDatetime),
       repeatDayOfWeek = Value(repeatDayOfWeek),
       categoryId = Value(categoryId),
       createdAt = Value(createdAt),
       changedAt = Value(changedAt);
  static Insertable<Habit> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? startDatetime,
    Expression<DateTime>? endDatetime,
    Expression<String>? reminderTime,
    Expression<String>? repeatDayOfWeek,
    Expression<int>? categoryId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? changedAt,
    Expression<bool>? isArchived,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (startDatetime != null) 'start_datetime': startDatetime,
      if (endDatetime != null) 'end_datetime': endDatetime,
      if (reminderTime != null) 'reminder_time': reminderTime,
      if (repeatDayOfWeek != null) 'repeat_day_of_week': repeatDayOfWeek,
      if (categoryId != null) 'category_id': categoryId,
      if (createdAt != null) 'created_at': createdAt,
      if (changedAt != null) 'changed_at': changedAt,
      if (isArchived != null) 'is_archived': isArchived,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  HabitsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<DateTime>? startDatetime,
    Value<DateTime?>? endDatetime,
    Value<String?>? reminderTime,
    Value<String>? repeatDayOfWeek,
    Value<int>? categoryId,
    Value<DateTime>? createdAt,
    Value<DateTime>? changedAt,
    Value<bool>? isArchived,
    Value<bool>? isDeleted,
  }) {
    return HabitsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startDatetime: startDatetime ?? this.startDatetime,
      endDatetime: endDatetime ?? this.endDatetime,
      reminderTime: reminderTime ?? this.reminderTime,
      repeatDayOfWeek: repeatDayOfWeek ?? this.repeatDayOfWeek,
      categoryId: categoryId ?? this.categoryId,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
      isArchived: isArchived ?? this.isArchived,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (startDatetime.present) {
      map['start_datetime'] = Variable<DateTime>(startDatetime.value);
    }
    if (endDatetime.present) {
      map['end_datetime'] = Variable<DateTime>(endDatetime.value);
    }
    if (reminderTime.present) {
      map['reminder_time'] = Variable<String>(reminderTime.value);
    }
    if (repeatDayOfWeek.present) {
      map['repeat_day_of_week'] = Variable<String>(repeatDayOfWeek.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (changedAt.present) {
      map['changed_at'] = Variable<DateTime>(changedAt.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('startDatetime: $startDatetime, ')
          ..write('endDatetime: $endDatetime, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('repeatDayOfWeek: $repeatDayOfWeek, ')
          ..write('categoryId: $categoryId, ')
          ..write('createdAt: $createdAt, ')
          ..write('changedAt: $changedAt, ')
          ..write('isArchived: $isArchived, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $HabitsLogTable extends HabitsLog
    with TableInfo<$HabitsLogTable, HabitsLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsLogTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _habitMeta = const VerificationMeta('habit');
  @override
  late final GeneratedColumn<int> habit = GeneratedColumn<int>(
    'habit',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habits (id)',
    ),
  );
  static const VerificationMeta _creationDatetimeMeta = const VerificationMeta(
    'creationDatetime',
  );
  @override
  late final GeneratedColumn<DateTime> creationDatetime =
      GeneratedColumn<DateTime>(
        'creation_datetime',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  @override
  late final GeneratedColumnWithTypeConverter<HabitsLogState, int> state =
      GeneratedColumn<int>(
        'state',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(3),
      ).withConverter<HabitsLogState>($HabitsLogTable.$converterstate);
  @override
  List<GeneratedColumn> get $columns => [id, habit, creationDatetime, state];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits_log';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitsLogData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('habit')) {
      context.handle(
        _habitMeta,
        habit.isAcceptableOrUnknown(data['habit']!, _habitMeta),
      );
    } else if (isInserting) {
      context.missing(_habitMeta);
    }
    if (data.containsKey('creation_datetime')) {
      context.handle(
        _creationDatetimeMeta,
        creationDatetime.isAcceptableOrUnknown(
          data['creation_datetime']!,
          _creationDatetimeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitsLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitsLogData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      habit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}habit'],
      )!,
      creationDatetime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creation_datetime'],
      )!,
      state: $HabitsLogTable.$converterstate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}state'],
        )!,
      ),
    );
  }

  @override
  $HabitsLogTable createAlias(String alias) {
    return $HabitsLogTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<HabitsLogState, int, int> $converterstate =
      const EnumIndexConverter<HabitsLogState>(HabitsLogState.values);
}

class HabitsLogData extends DataClass implements Insertable<HabitsLogData> {
  final int id;
  final int habit;
  final DateTime creationDatetime;

  /// Default value is 3 (none).
  final HabitsLogState state;
  const HabitsLogData({
    required this.id,
    required this.habit,
    required this.creationDatetime,
    required this.state,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['habit'] = Variable<int>(habit);
    map['creation_datetime'] = Variable<DateTime>(creationDatetime);
    {
      map['state'] = Variable<int>(
        $HabitsLogTable.$converterstate.toSql(state),
      );
    }
    return map;
  }

  HabitsLogCompanion toCompanion(bool nullToAbsent) {
    return HabitsLogCompanion(
      id: Value(id),
      habit: Value(habit),
      creationDatetime: Value(creationDatetime),
      state: Value(state),
    );
  }

  factory HabitsLogData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitsLogData(
      id: serializer.fromJson<int>(json['id']),
      habit: serializer.fromJson<int>(json['habit']),
      creationDatetime: serializer.fromJson<DateTime>(json['creationDatetime']),
      state: $HabitsLogTable.$converterstate.fromJson(
        serializer.fromJson<int>(json['state']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'habit': serializer.toJson<int>(habit),
      'creationDatetime': serializer.toJson<DateTime>(creationDatetime),
      'state': serializer.toJson<int>(
        $HabitsLogTable.$converterstate.toJson(state),
      ),
    };
  }

  HabitsLogData copyWith({
    int? id,
    int? habit,
    DateTime? creationDatetime,
    HabitsLogState? state,
  }) => HabitsLogData(
    id: id ?? this.id,
    habit: habit ?? this.habit,
    creationDatetime: creationDatetime ?? this.creationDatetime,
    state: state ?? this.state,
  );
  HabitsLogData copyWithCompanion(HabitsLogCompanion data) {
    return HabitsLogData(
      id: data.id.present ? data.id.value : this.id,
      habit: data.habit.present ? data.habit.value : this.habit,
      creationDatetime: data.creationDatetime.present
          ? data.creationDatetime.value
          : this.creationDatetime,
      state: data.state.present ? data.state.value : this.state,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitsLogData(')
          ..write('id: $id, ')
          ..write('habit: $habit, ')
          ..write('creationDatetime: $creationDatetime, ')
          ..write('state: $state')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, habit, creationDatetime, state);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitsLogData &&
          other.id == this.id &&
          other.habit == this.habit &&
          other.creationDatetime == this.creationDatetime &&
          other.state == this.state);
}

class HabitsLogCompanion extends UpdateCompanion<HabitsLogData> {
  final Value<int> id;
  final Value<int> habit;
  final Value<DateTime> creationDatetime;
  final Value<HabitsLogState> state;
  const HabitsLogCompanion({
    this.id = const Value.absent(),
    this.habit = const Value.absent(),
    this.creationDatetime = const Value.absent(),
    this.state = const Value.absent(),
  });
  HabitsLogCompanion.insert({
    this.id = const Value.absent(),
    required int habit,
    this.creationDatetime = const Value.absent(),
    this.state = const Value.absent(),
  }) : habit = Value(habit);
  static Insertable<HabitsLogData> custom({
    Expression<int>? id,
    Expression<int>? habit,
    Expression<DateTime>? creationDatetime,
    Expression<int>? state,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habit != null) 'habit': habit,
      if (creationDatetime != null) 'creation_datetime': creationDatetime,
      if (state != null) 'state': state,
    });
  }

  HabitsLogCompanion copyWith({
    Value<int>? id,
    Value<int>? habit,
    Value<DateTime>? creationDatetime,
    Value<HabitsLogState>? state,
  }) {
    return HabitsLogCompanion(
      id: id ?? this.id,
      habit: habit ?? this.habit,
      creationDatetime: creationDatetime ?? this.creationDatetime,
      state: state ?? this.state,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (habit.present) {
      map['habit'] = Variable<int>(habit.value);
    }
    if (creationDatetime.present) {
      map['creation_datetime'] = Variable<DateTime>(creationDatetime.value);
    }
    if (state.present) {
      map['state'] = Variable<int>(
        $HabitsLogTable.$converterstate.toSql(state.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsLogCompanion(')
          ..write('id: $id, ')
          ..write('habit: $habit, ')
          ..write('creationDatetime: $creationDatetime, ')
          ..write('state: $state')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $HabitsLogTable habitsLog = $HabitsLogTable(this);
  late final Index habitLogCreationTimeIdx = Index(
    'habit_log_creation_time_idx',
    'CREATE INDEX habit_log_creation_time_idx ON habits_log (habit, creation_datetime)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categories,
    habits,
    habitsLog,
    habitLogCreationTimeIdx,
  ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      required String name,
      Value<CategoriesColor> color,
      Value<CategoriesIcon> icon,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<CategoriesColor> color,
      Value<CategoriesIcon> icon,
    });

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HabitsTable, List<Habit>> _habitsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.habits,
    aliasName: $_aliasNameGenerator(db.categories.id, db.habits.categoryId),
  );

  $$HabitsTableProcessedTableManager get habitsRefs {
    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CategoriesColor, CategoriesColor, int>
  get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<CategoriesIcon, CategoriesIcon, int>
  get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  Expression<bool> habitsRefs(
    Expression<bool> Function($$HabitsTableFilterComposer f) f,
  ) {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableFilterComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CategoriesColor, int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CategoriesIcon, int> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  Expression<T> habitsRefs<T extends Object>(
    Expression<T> Function($$HabitsTableAnnotationComposer a) f,
  ) {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableAnnotationComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, $$CategoriesTableReferences),
          Category,
          PrefetchHooks Function({bool habitsRefs})
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<CategoriesColor> color = const Value.absent(),
                Value<CategoriesIcon> icon = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                color: color,
                icon: icon,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<CategoriesColor> color = const Value.absent(),
                Value<CategoriesIcon> icon = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                color: color,
                icon: icon,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (habitsRefs) db.habits],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (habitsRefs)
                    await $_getPrefetchedData<
                      Category,
                      $CategoriesTable,
                      Habit
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriesTableReferences
                          ._habitsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriesTableReferences(db, table, p0).habitsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, $$CategoriesTableReferences),
      Category,
      PrefetchHooks Function({bool habitsRefs})
    >;
typedef $$HabitsTableCreateCompanionBuilder =
    HabitsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      required DateTime startDatetime,
      Value<DateTime?> endDatetime,
      Value<String?> reminderTime,
      required String repeatDayOfWeek,
      required int categoryId,
      required DateTime createdAt,
      required DateTime changedAt,
      Value<bool> isArchived,
      Value<bool> isDeleted,
    });
typedef $$HabitsTableUpdateCompanionBuilder =
    HabitsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<DateTime> startDatetime,
      Value<DateTime?> endDatetime,
      Value<String?> reminderTime,
      Value<String> repeatDayOfWeek,
      Value<int> categoryId,
      Value<DateTime> createdAt,
      Value<DateTime> changedAt,
      Value<bool> isArchived,
      Value<bool> isDeleted,
    });

final class $$HabitsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitsTable, Habit> {
  $$HabitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias(
        $_aliasNameGenerator(db.habits.categoryId, db.categories.id),
      );

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$HabitsLogTable, List<HabitsLogData>>
  _habitsLogRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.habitsLog,
    aliasName: $_aliasNameGenerator(db.habits.id, db.habitsLog.habit),
  );

  $$HabitsLogTableProcessedTableManager get habitsLogRefs {
    final manager = $$HabitsLogTableTableManager(
      $_db,
      $_db.habitsLog,
    ).filter((f) => f.habit.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitsLogRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDatetime => $composableBuilder(
    column: $table.startDatetime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDatetime => $composableBuilder(
    column: $table.endDatetime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get repeatDayOfWeek => $composableBuilder(
    column: $table.repeatDayOfWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> habitsLogRefs(
    Expression<bool> Function($$HabitsLogTableFilterComposer f) f,
  ) {
    final $$HabitsLogTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitsLog,
      getReferencedColumn: (t) => t.habit,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsLogTableFilterComposer(
            $db: $db,
            $table: $db.habitsLog,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDatetime => $composableBuilder(
    column: $table.startDatetime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDatetime => $composableBuilder(
    column: $table.endDatetime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get repeatDayOfWeek => $composableBuilder(
    column: $table.repeatDayOfWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDatetime => $composableBuilder(
    column: $table.startDatetime,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get endDatetime => $composableBuilder(
    column: $table.endDatetime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get repeatDayOfWeek => $composableBuilder(
    column: $table.repeatDayOfWeek,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get changedAt =>
      $composableBuilder(column: $table.changedAt, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> habitsLogRefs<T extends Object>(
    Expression<T> Function($$HabitsLogTableAnnotationComposer a) f,
  ) {
    final $$HabitsLogTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitsLog,
      getReferencedColumn: (t) => t.habit,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsLogTableAnnotationComposer(
            $db: $db,
            $table: $db.habitsLog,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitsTable,
          Habit,
          $$HabitsTableFilterComposer,
          $$HabitsTableOrderingComposer,
          $$HabitsTableAnnotationComposer,
          $$HabitsTableCreateCompanionBuilder,
          $$HabitsTableUpdateCompanionBuilder,
          (Habit, $$HabitsTableReferences),
          Habit,
          PrefetchHooks Function({bool categoryId, bool habitsLogRefs})
        > {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> startDatetime = const Value.absent(),
                Value<DateTime?> endDatetime = const Value.absent(),
                Value<String?> reminderTime = const Value.absent(),
                Value<String> repeatDayOfWeek = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> changedAt = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => HabitsCompanion(
                id: id,
                name: name,
                description: description,
                startDatetime: startDatetime,
                endDatetime: endDatetime,
                reminderTime: reminderTime,
                repeatDayOfWeek: repeatDayOfWeek,
                categoryId: categoryId,
                createdAt: createdAt,
                changedAt: changedAt,
                isArchived: isArchived,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                required DateTime startDatetime,
                Value<DateTime?> endDatetime = const Value.absent(),
                Value<String?> reminderTime = const Value.absent(),
                required String repeatDayOfWeek,
                required int categoryId,
                required DateTime createdAt,
                required DateTime changedAt,
                Value<bool> isArchived = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => HabitsCompanion.insert(
                id: id,
                name: name,
                description: description,
                startDatetime: startDatetime,
                endDatetime: endDatetime,
                reminderTime: reminderTime,
                repeatDayOfWeek: repeatDayOfWeek,
                categoryId: categoryId,
                createdAt: createdAt,
                changedAt: changedAt,
                isArchived: isArchived,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$HabitsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false, habitsLogRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (habitsLogRefs) db.habitsLog],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (categoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.categoryId,
                                referencedTable: $$HabitsTableReferences
                                    ._categoryIdTable(db),
                                referencedColumn: $$HabitsTableReferences
                                    ._categoryIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (habitsLogRefs)
                    await $_getPrefetchedData<
                      Habit,
                      $HabitsTable,
                      HabitsLogData
                    >(
                      currentTable: table,
                      referencedTable: $$HabitsTableReferences
                          ._habitsLogRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$HabitsTableReferences(db, table, p0).habitsLogRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.habit == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$HabitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitsTable,
      Habit,
      $$HabitsTableFilterComposer,
      $$HabitsTableOrderingComposer,
      $$HabitsTableAnnotationComposer,
      $$HabitsTableCreateCompanionBuilder,
      $$HabitsTableUpdateCompanionBuilder,
      (Habit, $$HabitsTableReferences),
      Habit,
      PrefetchHooks Function({bool categoryId, bool habitsLogRefs})
    >;
typedef $$HabitsLogTableCreateCompanionBuilder =
    HabitsLogCompanion Function({
      Value<int> id,
      required int habit,
      Value<DateTime> creationDatetime,
      Value<HabitsLogState> state,
    });
typedef $$HabitsLogTableUpdateCompanionBuilder =
    HabitsLogCompanion Function({
      Value<int> id,
      Value<int> habit,
      Value<DateTime> creationDatetime,
      Value<HabitsLogState> state,
    });

final class $$HabitsLogTableReferences
    extends BaseReferences<_$AppDatabase, $HabitsLogTable, HabitsLogData> {
  $$HabitsLogTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HabitsTable _habitTable(_$AppDatabase db) => db.habits.createAlias(
    $_aliasNameGenerator(db.habitsLog.habit, db.habits.id),
  );

  $$HabitsTableProcessedTableManager get habit {
    final $_column = $_itemColumn<int>('habit')!;

    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HabitsLogTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsLogTable> {
  $$HabitsLogTableFilterComposer({
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

  ColumnFilters<DateTime> get creationDatetime => $composableBuilder(
    column: $table.creationDatetime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<HabitsLogState, HabitsLogState, int>
  get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$HabitsTableFilterComposer get habit {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habit,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableFilterComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitsLogTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsLogTable> {
  $$HabitsLogTableOrderingComposer({
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

  ColumnOrderings<DateTime> get creationDatetime => $composableBuilder(
    column: $table.creationDatetime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitsTableOrderingComposer get habit {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habit,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableOrderingComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitsLogTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsLogTable> {
  $$HabitsLogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get creationDatetime => $composableBuilder(
    column: $table.creationDatetime,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<HabitsLogState, int> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  $$HabitsTableAnnotationComposer get habit {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habit,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableAnnotationComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitsLogTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitsLogTable,
          HabitsLogData,
          $$HabitsLogTableFilterComposer,
          $$HabitsLogTableOrderingComposer,
          $$HabitsLogTableAnnotationComposer,
          $$HabitsLogTableCreateCompanionBuilder,
          $$HabitsLogTableUpdateCompanionBuilder,
          (HabitsLogData, $$HabitsLogTableReferences),
          HabitsLogData,
          PrefetchHooks Function({bool habit})
        > {
  $$HabitsLogTableTableManager(_$AppDatabase db, $HabitsLogTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsLogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsLogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsLogTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> habit = const Value.absent(),
                Value<DateTime> creationDatetime = const Value.absent(),
                Value<HabitsLogState> state = const Value.absent(),
              }) => HabitsLogCompanion(
                id: id,
                habit: habit,
                creationDatetime: creationDatetime,
                state: state,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int habit,
                Value<DateTime> creationDatetime = const Value.absent(),
                Value<HabitsLogState> state = const Value.absent(),
              }) => HabitsLogCompanion.insert(
                id: id,
                habit: habit,
                creationDatetime: creationDatetime,
                state: state,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HabitsLogTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habit = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (habit) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.habit,
                                referencedTable: $$HabitsLogTableReferences
                                    ._habitTable(db),
                                referencedColumn: $$HabitsLogTableReferences
                                    ._habitTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HabitsLogTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitsLogTable,
      HabitsLogData,
      $$HabitsLogTableFilterComposer,
      $$HabitsLogTableOrderingComposer,
      $$HabitsLogTableAnnotationComposer,
      $$HabitsLogTableCreateCompanionBuilder,
      $$HabitsLogTableUpdateCompanionBuilder,
      (HabitsLogData, $$HabitsLogTableReferences),
      HabitsLogData,
      PrefetchHooks Function({bool habit})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$HabitsLogTableTableManager get habitsLog =>
      $$HabitsLogTableTableManager(_db, _db.habitsLog);
}
