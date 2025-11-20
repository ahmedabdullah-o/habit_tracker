// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
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
  static const VerificationMeta _currentVersionMeta = const VerificationMeta(
    'currentVersion',
  );
  @override
  late final GeneratedColumn<int> currentVersion = GeneratedColumn<int>(
    'current_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _googleSubMeta = const VerificationMeta(
    'googleSub',
  );
  @override
  late final GeneratedColumn<String> googleSub = GeneratedColumn<String>(
    'google_sub',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    currentVersion,
    googleSub,
    createdAt,
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
    if (data.containsKey('current_version')) {
      context.handle(
        _currentVersionMeta,
        currentVersion.isAcceptableOrUnknown(
          data['current_version']!,
          _currentVersionMeta,
        ),
      );
    }
    if (data.containsKey('google_sub')) {
      context.handle(
        _googleSubMeta,
        googleSub.isAcceptableOrUnknown(data['google_sub']!, _googleSubMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
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
      currentVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_version'],
      )!,
      googleSub: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}google_sub'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
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
  final int currentVersion;
  final String? googleSub;
  final DateTime createdAt;
  final bool isDeleted;
  const Habit({
    required this.id,
    required this.currentVersion,
    this.googleSub,
    required this.createdAt,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['current_version'] = Variable<int>(currentVersion);
    if (!nullToAbsent || googleSub != null) {
      map['google_sub'] = Variable<String>(googleSub);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      currentVersion: Value(currentVersion),
      googleSub: googleSub == null && nullToAbsent
          ? const Value.absent()
          : Value(googleSub),
      createdAt: Value(createdAt),
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
      currentVersion: serializer.fromJson<int>(json['currentVersion']),
      googleSub: serializer.fromJson<String?>(json['googleSub']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'currentVersion': serializer.toJson<int>(currentVersion),
      'googleSub': serializer.toJson<String?>(googleSub),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  Habit copyWith({
    int? id,
    int? currentVersion,
    Value<String?> googleSub = const Value.absent(),
    DateTime? createdAt,
    bool? isDeleted,
  }) => Habit(
    id: id ?? this.id,
    currentVersion: currentVersion ?? this.currentVersion,
    googleSub: googleSub.present ? googleSub.value : this.googleSub,
    createdAt: createdAt ?? this.createdAt,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  Habit copyWithCompanion(HabitsCompanion data) {
    return Habit(
      id: data.id.present ? data.id.value : this.id,
      currentVersion: data.currentVersion.present
          ? data.currentVersion.value
          : this.currentVersion,
      googleSub: data.googleSub.present ? data.googleSub.value : this.googleSub,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('currentVersion: $currentVersion, ')
          ..write('googleSub: $googleSub, ')
          ..write('createdAt: $createdAt, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, currentVersion, googleSub, createdAt, isDeleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.currentVersion == this.currentVersion &&
          other.googleSub == this.googleSub &&
          other.createdAt == this.createdAt &&
          other.isDeleted == this.isDeleted);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<int> id;
  final Value<int> currentVersion;
  final Value<String?> googleSub;
  final Value<DateTime> createdAt;
  final Value<bool> isDeleted;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.currentVersion = const Value.absent(),
    this.googleSub = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  HabitsCompanion.insert({
    this.id = const Value.absent(),
    this.currentVersion = const Value.absent(),
    this.googleSub = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  static Insertable<Habit> custom({
    Expression<int>? id,
    Expression<int>? currentVersion,
    Expression<String>? googleSub,
    Expression<DateTime>? createdAt,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currentVersion != null) 'current_version': currentVersion,
      if (googleSub != null) 'google_sub': googleSub,
      if (createdAt != null) 'created_at': createdAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  HabitsCompanion copyWith({
    Value<int>? id,
    Value<int>? currentVersion,
    Value<String?>? googleSub,
    Value<DateTime>? createdAt,
    Value<bool>? isDeleted,
  }) {
    return HabitsCompanion(
      id: id ?? this.id,
      currentVersion: currentVersion ?? this.currentVersion,
      googleSub: googleSub ?? this.googleSub,
      createdAt: createdAt ?? this.createdAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (currentVersion.present) {
      map['current_version'] = Variable<int>(currentVersion.value);
    }
    if (googleSub.present) {
      map['google_sub'] = Variable<String>(googleSub.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
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
          ..write('currentVersion: $currentVersion, ')
          ..write('googleSub: $googleSub, ')
          ..write('createdAt: $createdAt, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

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
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconCodePointMeta = const VerificationMeta(
    'iconCodePoint',
  );
  @override
  late final GeneratedColumn<int> iconCodePoint = GeneratedColumn<int>(
    'icon_code_point',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, color, iconCodePoint];
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
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('icon_code_point')) {
      context.handle(
        _iconCodePointMeta,
        iconCodePoint.isAcceptableOrUnknown(
          data['icon_code_point']!,
          _iconCodePointMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_iconCodePointMeta);
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
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
      iconCodePoint: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}icon_code_point'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String name;
  final int color;
  final int iconCodePoint;
  const Category({
    required this.id,
    required this.name,
    required this.color,
    required this.iconCodePoint,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['color'] = Variable<int>(color);
    map['icon_code_point'] = Variable<int>(iconCodePoint);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      color: Value(color),
      iconCodePoint: Value(iconCodePoint),
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
      color: serializer.fromJson<int>(json['color']),
      iconCodePoint: serializer.fromJson<int>(json['iconCodePoint']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<int>(color),
      'iconCodePoint': serializer.toJson<int>(iconCodePoint),
    };
  }

  Category copyWith({int? id, String? name, int? color, int? iconCodePoint}) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
        iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      iconCodePoint: data.iconCodePoint.present
          ? data.iconCodePoint.value
          : this.iconCodePoint,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('iconCodePoint: $iconCodePoint')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, color, iconCodePoint);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color &&
          other.iconCodePoint == this.iconCodePoint);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> color;
  final Value<int> iconCodePoint;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.iconCodePoint = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int color,
    required int iconCodePoint,
  }) : name = Value(name),
       color = Value(color),
       iconCodePoint = Value(iconCodePoint);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? color,
    Expression<int>? iconCodePoint,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (iconCodePoint != null) 'icon_code_point': iconCodePoint,
    });
  }

  CategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? color,
    Value<int>? iconCodePoint,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
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
      map['color'] = Variable<int>(color.value);
    }
    if (iconCodePoint.present) {
      map['icon_code_point'] = Variable<int>(iconCodePoint.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('iconCodePoint: $iconCodePoint')
          ..write(')'))
        .toString();
  }
}

class $HabitsDetailsTable extends HabitsDetails
    with TableInfo<$HabitsDetailsTable, HabitsDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsDetailsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<int> habitId = GeneratedColumn<int>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habits (id)',
    ),
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _editDatetimeMeta = const VerificationMeta(
    'editDatetime',
  );
  @override
  late final GeneratedColumn<DateTime> editDatetime = GeneratedColumn<DateTime>(
    'edit_datetime',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
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
    false,
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
  static const VerificationMeta _repeatOnDaysOfWeekMeta =
      const VerificationMeta('repeatOnDaysOfWeek');
  @override
  late final GeneratedColumn<String> repeatOnDaysOfWeek =
      GeneratedColumn<String>(
        'repeat_on_days_of_week',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _repeatEveryNDaysMeta = const VerificationMeta(
    'repeatEveryNDays',
  );
  @override
  late final GeneratedColumn<int> repeatEveryNDays = GeneratedColumn<int>(
    'repeat_every_n_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetUnitMeta = const VerificationMeta(
    'targetUnit',
  );
  @override
  late final GeneratedColumn<String> targetUnit = GeneratedColumn<String>(
    'target_unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetQuantityMeta = const VerificationMeta(
    'targetQuantity',
  );
  @override
  late final GeneratedColumn<double> targetQuantity = GeneratedColumn<double>(
    'target_quantity',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalCompletionRateMeta =
      const VerificationMeta('goalCompletionRate');
  @override
  late final GeneratedColumn<int> goalCompletionRate = GeneratedColumn<int>(
    'goal_completion_rate',
    aliasedName,
    true,
    check: () => ComparableExpr(goalCompletionRate).isBetweenValues(50, 100),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalDeadlineMeta = const VerificationMeta(
    'goalDeadline',
  );
  @override
  late final GeneratedColumn<DateTime> goalDeadline = GeneratedColumn<DateTime>(
    'goal_deadline',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    habitId,
    version,
    editDatetime,
    name,
    description,
    categoryId,
    startDatetime,
    endDatetime,
    reminderTime,
    repeatOnDaysOfWeek,
    repeatEveryNDays,
    targetUnit,
    targetQuantity,
    goalCompletionRate,
    goalDeadline,
    isArchived,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits_details';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitsDetail> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('edit_datetime')) {
      context.handle(
        _editDatetimeMeta,
        editDatetime.isAcceptableOrUnknown(
          data['edit_datetime']!,
          _editDatetimeMeta,
        ),
      );
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
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
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
    if (data.containsKey('repeat_on_days_of_week')) {
      context.handle(
        _repeatOnDaysOfWeekMeta,
        repeatOnDaysOfWeek.isAcceptableOrUnknown(
          data['repeat_on_days_of_week']!,
          _repeatOnDaysOfWeekMeta,
        ),
      );
    }
    if (data.containsKey('repeat_every_n_days')) {
      context.handle(
        _repeatEveryNDaysMeta,
        repeatEveryNDays.isAcceptableOrUnknown(
          data['repeat_every_n_days']!,
          _repeatEveryNDaysMeta,
        ),
      );
    }
    if (data.containsKey('target_unit')) {
      context.handle(
        _targetUnitMeta,
        targetUnit.isAcceptableOrUnknown(data['target_unit']!, _targetUnitMeta),
      );
    }
    if (data.containsKey('target_quantity')) {
      context.handle(
        _targetQuantityMeta,
        targetQuantity.isAcceptableOrUnknown(
          data['target_quantity']!,
          _targetQuantityMeta,
        ),
      );
    }
    if (data.containsKey('goal_completion_rate')) {
      context.handle(
        _goalCompletionRateMeta,
        goalCompletionRate.isAcceptableOrUnknown(
          data['goal_completion_rate']!,
          _goalCompletionRateMeta,
        ),
      );
    }
    if (data.containsKey('goal_deadline')) {
      context.handle(
        _goalDeadlineMeta,
        goalDeadline.isAcceptableOrUnknown(
          data['goal_deadline']!,
          _goalDeadlineMeta,
        ),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {habitId, version},
  ];
  @override
  HabitsDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitsDetail(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}habit_id'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      editDatetime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}edit_datetime'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
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
      repeatOnDaysOfWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}repeat_on_days_of_week'],
      ),
      repeatEveryNDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repeat_every_n_days'],
      ),
      targetUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_unit'],
      ),
      targetQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_quantity'],
      ),
      goalCompletionRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goal_completion_rate'],
      ),
      goalDeadline: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}goal_deadline'],
      ),
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
    );
  }

  @override
  $HabitsDetailsTable createAlias(String alias) {
    return $HabitsDetailsTable(attachedDatabase, alias);
  }
}

class HabitsDetail extends DataClass implements Insertable<HabitsDetail> {
  final int id;
  final int habitId;
  final int version;
  final DateTime editDatetime;
  final String name;
  final String description;
  final int categoryId;
  final DateTime startDatetime;
  final DateTime? endDatetime;
  final String? reminderTime;
  final String? repeatOnDaysOfWeek;
  final int? repeatEveryNDays;
  final String? targetUnit;
  final double? targetQuantity;
  final int? goalCompletionRate;
  final DateTime? goalDeadline;
  final bool isArchived;
  const HabitsDetail({
    required this.id,
    required this.habitId,
    required this.version,
    required this.editDatetime,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.startDatetime,
    this.endDatetime,
    this.reminderTime,
    this.repeatOnDaysOfWeek,
    this.repeatEveryNDays,
    this.targetUnit,
    this.targetQuantity,
    this.goalCompletionRate,
    this.goalDeadline,
    required this.isArchived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['habit_id'] = Variable<int>(habitId);
    map['version'] = Variable<int>(version);
    map['edit_datetime'] = Variable<DateTime>(editDatetime);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['category_id'] = Variable<int>(categoryId);
    map['start_datetime'] = Variable<DateTime>(startDatetime);
    if (!nullToAbsent || endDatetime != null) {
      map['end_datetime'] = Variable<DateTime>(endDatetime);
    }
    if (!nullToAbsent || reminderTime != null) {
      map['reminder_time'] = Variable<String>(reminderTime);
    }
    if (!nullToAbsent || repeatOnDaysOfWeek != null) {
      map['repeat_on_days_of_week'] = Variable<String>(repeatOnDaysOfWeek);
    }
    if (!nullToAbsent || repeatEveryNDays != null) {
      map['repeat_every_n_days'] = Variable<int>(repeatEveryNDays);
    }
    if (!nullToAbsent || targetUnit != null) {
      map['target_unit'] = Variable<String>(targetUnit);
    }
    if (!nullToAbsent || targetQuantity != null) {
      map['target_quantity'] = Variable<double>(targetQuantity);
    }
    if (!nullToAbsent || goalCompletionRate != null) {
      map['goal_completion_rate'] = Variable<int>(goalCompletionRate);
    }
    if (!nullToAbsent || goalDeadline != null) {
      map['goal_deadline'] = Variable<DateTime>(goalDeadline);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    return map;
  }

  HabitsDetailsCompanion toCompanion(bool nullToAbsent) {
    return HabitsDetailsCompanion(
      id: Value(id),
      habitId: Value(habitId),
      version: Value(version),
      editDatetime: Value(editDatetime),
      name: Value(name),
      description: Value(description),
      categoryId: Value(categoryId),
      startDatetime: Value(startDatetime),
      endDatetime: endDatetime == null && nullToAbsent
          ? const Value.absent()
          : Value(endDatetime),
      reminderTime: reminderTime == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderTime),
      repeatOnDaysOfWeek: repeatOnDaysOfWeek == null && nullToAbsent
          ? const Value.absent()
          : Value(repeatOnDaysOfWeek),
      repeatEveryNDays: repeatEveryNDays == null && nullToAbsent
          ? const Value.absent()
          : Value(repeatEveryNDays),
      targetUnit: targetUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(targetUnit),
      targetQuantity: targetQuantity == null && nullToAbsent
          ? const Value.absent()
          : Value(targetQuantity),
      goalCompletionRate: goalCompletionRate == null && nullToAbsent
          ? const Value.absent()
          : Value(goalCompletionRate),
      goalDeadline: goalDeadline == null && nullToAbsent
          ? const Value.absent()
          : Value(goalDeadline),
      isArchived: Value(isArchived),
    );
  }

  factory HabitsDetail.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitsDetail(
      id: serializer.fromJson<int>(json['id']),
      habitId: serializer.fromJson<int>(json['habitId']),
      version: serializer.fromJson<int>(json['version']),
      editDatetime: serializer.fromJson<DateTime>(json['editDatetime']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      startDatetime: serializer.fromJson<DateTime>(json['startDatetime']),
      endDatetime: serializer.fromJson<DateTime?>(json['endDatetime']),
      reminderTime: serializer.fromJson<String?>(json['reminderTime']),
      repeatOnDaysOfWeek: serializer.fromJson<String?>(
        json['repeatOnDaysOfWeek'],
      ),
      repeatEveryNDays: serializer.fromJson<int?>(json['repeatEveryNDays']),
      targetUnit: serializer.fromJson<String?>(json['targetUnit']),
      targetQuantity: serializer.fromJson<double?>(json['targetQuantity']),
      goalCompletionRate: serializer.fromJson<int?>(json['goalCompletionRate']),
      goalDeadline: serializer.fromJson<DateTime?>(json['goalDeadline']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'habitId': serializer.toJson<int>(habitId),
      'version': serializer.toJson<int>(version),
      'editDatetime': serializer.toJson<DateTime>(editDatetime),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'categoryId': serializer.toJson<int>(categoryId),
      'startDatetime': serializer.toJson<DateTime>(startDatetime),
      'endDatetime': serializer.toJson<DateTime?>(endDatetime),
      'reminderTime': serializer.toJson<String?>(reminderTime),
      'repeatOnDaysOfWeek': serializer.toJson<String?>(repeatOnDaysOfWeek),
      'repeatEveryNDays': serializer.toJson<int?>(repeatEveryNDays),
      'targetUnit': serializer.toJson<String?>(targetUnit),
      'targetQuantity': serializer.toJson<double?>(targetQuantity),
      'goalCompletionRate': serializer.toJson<int?>(goalCompletionRate),
      'goalDeadline': serializer.toJson<DateTime?>(goalDeadline),
      'isArchived': serializer.toJson<bool>(isArchived),
    };
  }

  HabitsDetail copyWith({
    int? id,
    int? habitId,
    int? version,
    DateTime? editDatetime,
    String? name,
    String? description,
    int? categoryId,
    DateTime? startDatetime,
    Value<DateTime?> endDatetime = const Value.absent(),
    Value<String?> reminderTime = const Value.absent(),
    Value<String?> repeatOnDaysOfWeek = const Value.absent(),
    Value<int?> repeatEveryNDays = const Value.absent(),
    Value<String?> targetUnit = const Value.absent(),
    Value<double?> targetQuantity = const Value.absent(),
    Value<int?> goalCompletionRate = const Value.absent(),
    Value<DateTime?> goalDeadline = const Value.absent(),
    bool? isArchived,
  }) => HabitsDetail(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    version: version ?? this.version,
    editDatetime: editDatetime ?? this.editDatetime,
    name: name ?? this.name,
    description: description ?? this.description,
    categoryId: categoryId ?? this.categoryId,
    startDatetime: startDatetime ?? this.startDatetime,
    endDatetime: endDatetime.present ? endDatetime.value : this.endDatetime,
    reminderTime: reminderTime.present ? reminderTime.value : this.reminderTime,
    repeatOnDaysOfWeek: repeatOnDaysOfWeek.present
        ? repeatOnDaysOfWeek.value
        : this.repeatOnDaysOfWeek,
    repeatEveryNDays: repeatEveryNDays.present
        ? repeatEveryNDays.value
        : this.repeatEveryNDays,
    targetUnit: targetUnit.present ? targetUnit.value : this.targetUnit,
    targetQuantity: targetQuantity.present
        ? targetQuantity.value
        : this.targetQuantity,
    goalCompletionRate: goalCompletionRate.present
        ? goalCompletionRate.value
        : this.goalCompletionRate,
    goalDeadline: goalDeadline.present ? goalDeadline.value : this.goalDeadline,
    isArchived: isArchived ?? this.isArchived,
  );
  HabitsDetail copyWithCompanion(HabitsDetailsCompanion data) {
    return HabitsDetail(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      version: data.version.present ? data.version.value : this.version,
      editDatetime: data.editDatetime.present
          ? data.editDatetime.value
          : this.editDatetime,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      startDatetime: data.startDatetime.present
          ? data.startDatetime.value
          : this.startDatetime,
      endDatetime: data.endDatetime.present
          ? data.endDatetime.value
          : this.endDatetime,
      reminderTime: data.reminderTime.present
          ? data.reminderTime.value
          : this.reminderTime,
      repeatOnDaysOfWeek: data.repeatOnDaysOfWeek.present
          ? data.repeatOnDaysOfWeek.value
          : this.repeatOnDaysOfWeek,
      repeatEveryNDays: data.repeatEveryNDays.present
          ? data.repeatEveryNDays.value
          : this.repeatEveryNDays,
      targetUnit: data.targetUnit.present
          ? data.targetUnit.value
          : this.targetUnit,
      targetQuantity: data.targetQuantity.present
          ? data.targetQuantity.value
          : this.targetQuantity,
      goalCompletionRate: data.goalCompletionRate.present
          ? data.goalCompletionRate.value
          : this.goalCompletionRate,
      goalDeadline: data.goalDeadline.present
          ? data.goalDeadline.value
          : this.goalDeadline,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitsDetail(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('version: $version, ')
          ..write('editDatetime: $editDatetime, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('categoryId: $categoryId, ')
          ..write('startDatetime: $startDatetime, ')
          ..write('endDatetime: $endDatetime, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('repeatOnDaysOfWeek: $repeatOnDaysOfWeek, ')
          ..write('repeatEveryNDays: $repeatEveryNDays, ')
          ..write('targetUnit: $targetUnit, ')
          ..write('targetQuantity: $targetQuantity, ')
          ..write('goalCompletionRate: $goalCompletionRate, ')
          ..write('goalDeadline: $goalDeadline, ')
          ..write('isArchived: $isArchived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    habitId,
    version,
    editDatetime,
    name,
    description,
    categoryId,
    startDatetime,
    endDatetime,
    reminderTime,
    repeatOnDaysOfWeek,
    repeatEveryNDays,
    targetUnit,
    targetQuantity,
    goalCompletionRate,
    goalDeadline,
    isArchived,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitsDetail &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.version == this.version &&
          other.editDatetime == this.editDatetime &&
          other.name == this.name &&
          other.description == this.description &&
          other.categoryId == this.categoryId &&
          other.startDatetime == this.startDatetime &&
          other.endDatetime == this.endDatetime &&
          other.reminderTime == this.reminderTime &&
          other.repeatOnDaysOfWeek == this.repeatOnDaysOfWeek &&
          other.repeatEveryNDays == this.repeatEveryNDays &&
          other.targetUnit == this.targetUnit &&
          other.targetQuantity == this.targetQuantity &&
          other.goalCompletionRate == this.goalCompletionRate &&
          other.goalDeadline == this.goalDeadline &&
          other.isArchived == this.isArchived);
}

class HabitsDetailsCompanion extends UpdateCompanion<HabitsDetail> {
  final Value<int> id;
  final Value<int> habitId;
  final Value<int> version;
  final Value<DateTime> editDatetime;
  final Value<String> name;
  final Value<String> description;
  final Value<int> categoryId;
  final Value<DateTime> startDatetime;
  final Value<DateTime?> endDatetime;
  final Value<String?> reminderTime;
  final Value<String?> repeatOnDaysOfWeek;
  final Value<int?> repeatEveryNDays;
  final Value<String?> targetUnit;
  final Value<double?> targetQuantity;
  final Value<int?> goalCompletionRate;
  final Value<DateTime?> goalDeadline;
  final Value<bool> isArchived;
  const HabitsDetailsCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.version = const Value.absent(),
    this.editDatetime = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.startDatetime = const Value.absent(),
    this.endDatetime = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.repeatOnDaysOfWeek = const Value.absent(),
    this.repeatEveryNDays = const Value.absent(),
    this.targetUnit = const Value.absent(),
    this.targetQuantity = const Value.absent(),
    this.goalCompletionRate = const Value.absent(),
    this.goalDeadline = const Value.absent(),
    this.isArchived = const Value.absent(),
  });
  HabitsDetailsCompanion.insert({
    this.id = const Value.absent(),
    required int habitId,
    this.version = const Value.absent(),
    this.editDatetime = const Value.absent(),
    required String name,
    required String description,
    required int categoryId,
    required DateTime startDatetime,
    this.endDatetime = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.repeatOnDaysOfWeek = const Value.absent(),
    this.repeatEveryNDays = const Value.absent(),
    this.targetUnit = const Value.absent(),
    this.targetQuantity = const Value.absent(),
    this.goalCompletionRate = const Value.absent(),
    this.goalDeadline = const Value.absent(),
    this.isArchived = const Value.absent(),
  }) : habitId = Value(habitId),
       name = Value(name),
       description = Value(description),
       categoryId = Value(categoryId),
       startDatetime = Value(startDatetime);
  static Insertable<HabitsDetail> custom({
    Expression<int>? id,
    Expression<int>? habitId,
    Expression<int>? version,
    Expression<DateTime>? editDatetime,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? categoryId,
    Expression<DateTime>? startDatetime,
    Expression<DateTime>? endDatetime,
    Expression<String>? reminderTime,
    Expression<String>? repeatOnDaysOfWeek,
    Expression<int>? repeatEveryNDays,
    Expression<String>? targetUnit,
    Expression<double>? targetQuantity,
    Expression<int>? goalCompletionRate,
    Expression<DateTime>? goalDeadline,
    Expression<bool>? isArchived,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (version != null) 'version': version,
      if (editDatetime != null) 'edit_datetime': editDatetime,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (categoryId != null) 'category_id': categoryId,
      if (startDatetime != null) 'start_datetime': startDatetime,
      if (endDatetime != null) 'end_datetime': endDatetime,
      if (reminderTime != null) 'reminder_time': reminderTime,
      if (repeatOnDaysOfWeek != null)
        'repeat_on_days_of_week': repeatOnDaysOfWeek,
      if (repeatEveryNDays != null) 'repeat_every_n_days': repeatEveryNDays,
      if (targetUnit != null) 'target_unit': targetUnit,
      if (targetQuantity != null) 'target_quantity': targetQuantity,
      if (goalCompletionRate != null)
        'goal_completion_rate': goalCompletionRate,
      if (goalDeadline != null) 'goal_deadline': goalDeadline,
      if (isArchived != null) 'is_archived': isArchived,
    });
  }

  HabitsDetailsCompanion copyWith({
    Value<int>? id,
    Value<int>? habitId,
    Value<int>? version,
    Value<DateTime>? editDatetime,
    Value<String>? name,
    Value<String>? description,
    Value<int>? categoryId,
    Value<DateTime>? startDatetime,
    Value<DateTime?>? endDatetime,
    Value<String?>? reminderTime,
    Value<String?>? repeatOnDaysOfWeek,
    Value<int?>? repeatEveryNDays,
    Value<String?>? targetUnit,
    Value<double?>? targetQuantity,
    Value<int?>? goalCompletionRate,
    Value<DateTime?>? goalDeadline,
    Value<bool>? isArchived,
  }) {
    return HabitsDetailsCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      version: version ?? this.version,
      editDatetime: editDatetime ?? this.editDatetime,
      name: name ?? this.name,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      startDatetime: startDatetime ?? this.startDatetime,
      endDatetime: endDatetime ?? this.endDatetime,
      reminderTime: reminderTime ?? this.reminderTime,
      repeatOnDaysOfWeek: repeatOnDaysOfWeek ?? this.repeatOnDaysOfWeek,
      repeatEveryNDays: repeatEveryNDays ?? this.repeatEveryNDays,
      targetUnit: targetUnit ?? this.targetUnit,
      targetQuantity: targetQuantity ?? this.targetQuantity,
      goalCompletionRate: goalCompletionRate ?? this.goalCompletionRate,
      goalDeadline: goalDeadline ?? this.goalDeadline,
      isArchived: isArchived ?? this.isArchived,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<int>(habitId.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (editDatetime.present) {
      map['edit_datetime'] = Variable<DateTime>(editDatetime.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
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
    if (repeatOnDaysOfWeek.present) {
      map['repeat_on_days_of_week'] = Variable<String>(
        repeatOnDaysOfWeek.value,
      );
    }
    if (repeatEveryNDays.present) {
      map['repeat_every_n_days'] = Variable<int>(repeatEveryNDays.value);
    }
    if (targetUnit.present) {
      map['target_unit'] = Variable<String>(targetUnit.value);
    }
    if (targetQuantity.present) {
      map['target_quantity'] = Variable<double>(targetQuantity.value);
    }
    if (goalCompletionRate.present) {
      map['goal_completion_rate'] = Variable<int>(goalCompletionRate.value);
    }
    if (goalDeadline.present) {
      map['goal_deadline'] = Variable<DateTime>(goalDeadline.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsDetailsCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('version: $version, ')
          ..write('editDatetime: $editDatetime, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('categoryId: $categoryId, ')
          ..write('startDatetime: $startDatetime, ')
          ..write('endDatetime: $endDatetime, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('repeatOnDaysOfWeek: $repeatOnDaysOfWeek, ')
          ..write('repeatEveryNDays: $repeatEveryNDays, ')
          ..write('targetUnit: $targetUnit, ')
          ..write('targetQuantity: $targetQuantity, ')
          ..write('goalCompletionRate: $goalCompletionRate, ')
          ..write('goalDeadline: $goalDeadline, ')
          ..write('isArchived: $isArchived')
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
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<int> habitId = GeneratedColumn<int>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habits (id)',
    ),
  );
  static const VerificationMeta _habitDetailsVersionMeta =
      const VerificationMeta('habitDetailsVersion');
  @override
  late final GeneratedColumn<int> habitDetailsVersion = GeneratedColumn<int>(
    'habit_details_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habits_details (version)',
    ),
  );
  static const VerificationMeta _logDatetimeMeta = const VerificationMeta(
    'logDatetime',
  );
  @override
  late final GeneratedColumn<DateTime> logDatetime = GeneratedColumn<DateTime>(
    'log_datetime',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<double> state = GeneratedColumn<double>(
    'state',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    habitId,
    habitDetailsVersion,
    logDatetime,
    state,
  ];
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
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('habit_details_version')) {
      context.handle(
        _habitDetailsVersionMeta,
        habitDetailsVersion.isAcceptableOrUnknown(
          data['habit_details_version']!,
          _habitDetailsVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_habitDetailsVersionMeta);
    }
    if (data.containsKey('log_datetime')) {
      context.handle(
        _logDatetimeMeta,
        logDatetime.isAcceptableOrUnknown(
          data['log_datetime']!,
          _logDatetimeMeta,
        ),
      );
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
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
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}habit_id'],
      )!,
      habitDetailsVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}habit_details_version'],
      )!,
      logDatetime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}log_datetime'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}state'],
      ),
    );
  }

  @override
  $HabitsLogTable createAlias(String alias) {
    return $HabitsLogTable(attachedDatabase, alias);
  }
}

class HabitsLogData extends DataClass implements Insertable<HabitsLogData> {
  final int id;
  final int habitId;
  final int habitDetailsVersion;
  final DateTime logDatetime;
  final double? state;
  const HabitsLogData({
    required this.id,
    required this.habitId,
    required this.habitDetailsVersion,
    required this.logDatetime,
    this.state,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['habit_id'] = Variable<int>(habitId);
    map['habit_details_version'] = Variable<int>(habitDetailsVersion);
    map['log_datetime'] = Variable<DateTime>(logDatetime);
    if (!nullToAbsent || state != null) {
      map['state'] = Variable<double>(state);
    }
    return map;
  }

  HabitsLogCompanion toCompanion(bool nullToAbsent) {
    return HabitsLogCompanion(
      id: Value(id),
      habitId: Value(habitId),
      habitDetailsVersion: Value(habitDetailsVersion),
      logDatetime: Value(logDatetime),
      state: state == null && nullToAbsent
          ? const Value.absent()
          : Value(state),
    );
  }

  factory HabitsLogData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitsLogData(
      id: serializer.fromJson<int>(json['id']),
      habitId: serializer.fromJson<int>(json['habitId']),
      habitDetailsVersion: serializer.fromJson<int>(
        json['habitDetailsVersion'],
      ),
      logDatetime: serializer.fromJson<DateTime>(json['logDatetime']),
      state: serializer.fromJson<double?>(json['state']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'habitId': serializer.toJson<int>(habitId),
      'habitDetailsVersion': serializer.toJson<int>(habitDetailsVersion),
      'logDatetime': serializer.toJson<DateTime>(logDatetime),
      'state': serializer.toJson<double?>(state),
    };
  }

  HabitsLogData copyWith({
    int? id,
    int? habitId,
    int? habitDetailsVersion,
    DateTime? logDatetime,
    Value<double?> state = const Value.absent(),
  }) => HabitsLogData(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    habitDetailsVersion: habitDetailsVersion ?? this.habitDetailsVersion,
    logDatetime: logDatetime ?? this.logDatetime,
    state: state.present ? state.value : this.state,
  );
  HabitsLogData copyWithCompanion(HabitsLogCompanion data) {
    return HabitsLogData(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      habitDetailsVersion: data.habitDetailsVersion.present
          ? data.habitDetailsVersion.value
          : this.habitDetailsVersion,
      logDatetime: data.logDatetime.present
          ? data.logDatetime.value
          : this.logDatetime,
      state: data.state.present ? data.state.value : this.state,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitsLogData(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('habitDetailsVersion: $habitDetailsVersion, ')
          ..write('logDatetime: $logDatetime, ')
          ..write('state: $state')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, habitId, habitDetailsVersion, logDatetime, state);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitsLogData &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.habitDetailsVersion == this.habitDetailsVersion &&
          other.logDatetime == this.logDatetime &&
          other.state == this.state);
}

class HabitsLogCompanion extends UpdateCompanion<HabitsLogData> {
  final Value<int> id;
  final Value<int> habitId;
  final Value<int> habitDetailsVersion;
  final Value<DateTime> logDatetime;
  final Value<double?> state;
  const HabitsLogCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.habitDetailsVersion = const Value.absent(),
    this.logDatetime = const Value.absent(),
    this.state = const Value.absent(),
  });
  HabitsLogCompanion.insert({
    this.id = const Value.absent(),
    required int habitId,
    required int habitDetailsVersion,
    this.logDatetime = const Value.absent(),
    this.state = const Value.absent(),
  }) : habitId = Value(habitId),
       habitDetailsVersion = Value(habitDetailsVersion);
  static Insertable<HabitsLogData> custom({
    Expression<int>? id,
    Expression<int>? habitId,
    Expression<int>? habitDetailsVersion,
    Expression<DateTime>? logDatetime,
    Expression<double>? state,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (habitDetailsVersion != null)
        'habit_details_version': habitDetailsVersion,
      if (logDatetime != null) 'log_datetime': logDatetime,
      if (state != null) 'state': state,
    });
  }

  HabitsLogCompanion copyWith({
    Value<int>? id,
    Value<int>? habitId,
    Value<int>? habitDetailsVersion,
    Value<DateTime>? logDatetime,
    Value<double?>? state,
  }) {
    return HabitsLogCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      habitDetailsVersion: habitDetailsVersion ?? this.habitDetailsVersion,
      logDatetime: logDatetime ?? this.logDatetime,
      state: state ?? this.state,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<int>(habitId.value);
    }
    if (habitDetailsVersion.present) {
      map['habit_details_version'] = Variable<int>(habitDetailsVersion.value);
    }
    if (logDatetime.present) {
      map['log_datetime'] = Variable<DateTime>(logDatetime.value);
    }
    if (state.present) {
      map['state'] = Variable<double>(state.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsLogCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('habitDetailsVersion: $habitDetailsVersion, ')
          ..write('logDatetime: $logDatetime, ')
          ..write('state: $state')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $HabitsDetailsTable habitsDetails = $HabitsDetailsTable(this);
  late final $HabitsLogTable habitsLog = $HabitsLogTable(this);
  late final Index habitLogCreationTimeIdx = Index(
    'habit_log_creation_time_idx',
    'CREATE INDEX habit_log_creation_time_idx ON habits_log (habit_id, log_datetime)',
  );
  late final HabitsDao habitsDao = HabitsDao(this as AppDatabase);
  late final CategoriesDao categoriesDao = CategoriesDao(this as AppDatabase);
  late final HabitsLogDao habitsLogDao = HabitsLogDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    habits,
    categories,
    habitsDetails,
    habitsLog,
    habitLogCreationTimeIdx,
  ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$HabitsTableCreateCompanionBuilder =
    HabitsCompanion Function({
      Value<int> id,
      Value<int> currentVersion,
      Value<String?> googleSub,
      Value<DateTime> createdAt,
      Value<bool> isDeleted,
    });
typedef $$HabitsTableUpdateCompanionBuilder =
    HabitsCompanion Function({
      Value<int> id,
      Value<int> currentVersion,
      Value<String?> googleSub,
      Value<DateTime> createdAt,
      Value<bool> isDeleted,
    });

final class $$HabitsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitsTable, Habit> {
  $$HabitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HabitsDetailsTable, List<HabitsDetail>>
  _habitsDetailsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.habitsDetails,
    aliasName: $_aliasNameGenerator(db.habits.id, db.habitsDetails.habitId),
  );

  $$HabitsDetailsTableProcessedTableManager get habitsDetailsRefs {
    final manager = $$HabitsDetailsTableTableManager(
      $_db,
      $_db.habitsDetails,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitsDetailsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HabitsLogTable, List<HabitsLogData>>
  _habitsLogRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.habitsLog,
    aliasName: $_aliasNameGenerator(db.habits.id, db.habitsLog.habitId),
  );

  $$HabitsLogTableProcessedTableManager get habitsLogRefs {
    final manager = $$HabitsLogTableTableManager(
      $_db,
      $_db.habitsLog,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<int>('id')!));

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

  ColumnFilters<int> get currentVersion => $composableBuilder(
    column: $table.currentVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get googleSub => $composableBuilder(
    column: $table.googleSub,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> habitsDetailsRefs(
    Expression<bool> Function($$HabitsDetailsTableFilterComposer f) f,
  ) {
    final $$HabitsDetailsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitsDetails,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsDetailsTableFilterComposer(
            $db: $db,
            $table: $db.habitsDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> habitsLogRefs(
    Expression<bool> Function($$HabitsLogTableFilterComposer f) f,
  ) {
    final $$HabitsLogTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitsLog,
      getReferencedColumn: (t) => t.habitId,
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

  ColumnOrderings<int> get currentVersion => $composableBuilder(
    column: $table.currentVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get googleSub => $composableBuilder(
    column: $table.googleSub,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
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

  GeneratedColumn<int> get currentVersion => $composableBuilder(
    column: $table.currentVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get googleSub =>
      $composableBuilder(column: $table.googleSub, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  Expression<T> habitsDetailsRefs<T extends Object>(
    Expression<T> Function($$HabitsDetailsTableAnnotationComposer a) f,
  ) {
    final $$HabitsDetailsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitsDetails,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsDetailsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitsDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> habitsLogRefs<T extends Object>(
    Expression<T> Function($$HabitsLogTableAnnotationComposer a) f,
  ) {
    final $$HabitsLogTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitsLog,
      getReferencedColumn: (t) => t.habitId,
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
          PrefetchHooks Function({bool habitsDetailsRefs, bool habitsLogRefs})
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
                Value<int> currentVersion = const Value.absent(),
                Value<String?> googleSub = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => HabitsCompanion(
                id: id,
                currentVersion: currentVersion,
                googleSub: googleSub,
                createdAt: createdAt,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> currentVersion = const Value.absent(),
                Value<String?> googleSub = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => HabitsCompanion.insert(
                id: id,
                currentVersion: currentVersion,
                googleSub: googleSub,
                createdAt: createdAt,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$HabitsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({habitsDetailsRefs = false, habitsLogRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (habitsDetailsRefs) db.habitsDetails,
                    if (habitsLogRefs) db.habitsLog,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (habitsDetailsRefs)
                        await $_getPrefetchedData<
                          Habit,
                          $HabitsTable,
                          HabitsDetail
                        >(
                          currentTable: table,
                          referencedTable: $$HabitsTableReferences
                              ._habitsDetailsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HabitsTableReferences(
                                db,
                                table,
                                p0,
                              ).habitsDetailsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.habitId == item.id,
                              ),
                          typedResults: items,
                        ),
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
                              $$HabitsTableReferences(
                                db,
                                table,
                                p0,
                              ).habitsLogRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.habitId == item.id,
                              ),
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
      PrefetchHooks Function({bool habitsDetailsRefs, bool habitsLogRefs})
    >;
typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      required String name,
      required int color,
      required int iconCodePoint,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> color,
      Value<int> iconCodePoint,
    });

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HabitsDetailsTable, List<HabitsDetail>>
  _habitsDetailsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.habitsDetails,
    aliasName: $_aliasNameGenerator(
      db.categories.id,
      db.habitsDetails.categoryId,
    ),
  );

  $$HabitsDetailsTableProcessedTableManager get habitsDetailsRefs {
    final manager = $$HabitsDetailsTableTableManager(
      $_db,
      $_db.habitsDetails,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitsDetailsRefsTable($_db));
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

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> habitsDetailsRefs(
    Expression<bool> Function($$HabitsDetailsTableFilterComposer f) f,
  ) {
    final $$HabitsDetailsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitsDetails,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsDetailsTableFilterComposer(
            $db: $db,
            $table: $db.habitsDetails,
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

  ColumnOrderings<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
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

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<int> get iconCodePoint => $composableBuilder(
    column: $table.iconCodePoint,
    builder: (column) => column,
  );

  Expression<T> habitsDetailsRefs<T extends Object>(
    Expression<T> Function($$HabitsDetailsTableAnnotationComposer a) f,
  ) {
    final $$HabitsDetailsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitsDetails,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsDetailsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitsDetails,
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
          PrefetchHooks Function({bool habitsDetailsRefs})
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
                Value<int> color = const Value.absent(),
                Value<int> iconCodePoint = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                color: color,
                iconCodePoint: iconCodePoint,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int color,
                required int iconCodePoint,
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                color: color,
                iconCodePoint: iconCodePoint,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitsDetailsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (habitsDetailsRefs) db.habitsDetails,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (habitsDetailsRefs)
                    await $_getPrefetchedData<
                      Category,
                      $CategoriesTable,
                      HabitsDetail
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriesTableReferences
                          ._habitsDetailsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).habitsDetailsRefs,
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
      PrefetchHooks Function({bool habitsDetailsRefs})
    >;
typedef $$HabitsDetailsTableCreateCompanionBuilder =
    HabitsDetailsCompanion Function({
      Value<int> id,
      required int habitId,
      Value<int> version,
      Value<DateTime> editDatetime,
      required String name,
      required String description,
      required int categoryId,
      required DateTime startDatetime,
      Value<DateTime?> endDatetime,
      Value<String?> reminderTime,
      Value<String?> repeatOnDaysOfWeek,
      Value<int?> repeatEveryNDays,
      Value<String?> targetUnit,
      Value<double?> targetQuantity,
      Value<int?> goalCompletionRate,
      Value<DateTime?> goalDeadline,
      Value<bool> isArchived,
    });
typedef $$HabitsDetailsTableUpdateCompanionBuilder =
    HabitsDetailsCompanion Function({
      Value<int> id,
      Value<int> habitId,
      Value<int> version,
      Value<DateTime> editDatetime,
      Value<String> name,
      Value<String> description,
      Value<int> categoryId,
      Value<DateTime> startDatetime,
      Value<DateTime?> endDatetime,
      Value<String?> reminderTime,
      Value<String?> repeatOnDaysOfWeek,
      Value<int?> repeatEveryNDays,
      Value<String?> targetUnit,
      Value<double?> targetQuantity,
      Value<int?> goalCompletionRate,
      Value<DateTime?> goalDeadline,
      Value<bool> isArchived,
    });

final class $$HabitsDetailsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitsDetailsTable, HabitsDetail> {
  $$HabitsDetailsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HabitsTable _habitIdTable(_$AppDatabase db) => db.habits.createAlias(
    $_aliasNameGenerator(db.habitsDetails.habitId, db.habits.id),
  );

  $$HabitsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<int>('habit_id')!;

    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias(
        $_aliasNameGenerator(db.habitsDetails.categoryId, db.categories.id),
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
    aliasName: $_aliasNameGenerator(
      db.habitsDetails.version,
      db.habitsLog.habitDetailsVersion,
    ),
  );

  $$HabitsLogTableProcessedTableManager get habitsLogRefs {
    final manager = $$HabitsLogTableTableManager($_db, $_db.habitsLog).filter(
      (f) => f.habitDetailsVersion.version.sqlEquals(
        $_itemColumn<int>('version')!,
      ),
    );

    final cache = $_typedResult.readTableOrNull(_habitsLogRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HabitsDetailsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsDetailsTable> {
  $$HabitsDetailsTableFilterComposer({
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

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get editDatetime => $composableBuilder(
    column: $table.editDatetime,
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

  ColumnFilters<String> get repeatOnDaysOfWeek => $composableBuilder(
    column: $table.repeatOnDaysOfWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repeatEveryNDays => $composableBuilder(
    column: $table.repeatEveryNDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetUnit => $composableBuilder(
    column: $table.targetUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetQuantity => $composableBuilder(
    column: $table.targetQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get goalCompletionRate => $composableBuilder(
    column: $table.goalCompletionRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get goalDeadline => $composableBuilder(
    column: $table.goalDeadline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitsTableFilterComposer get habitId {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
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
      getCurrentColumn: (t) => t.version,
      referencedTable: $db.habitsLog,
      getReferencedColumn: (t) => t.habitDetailsVersion,
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

class $$HabitsDetailsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsDetailsTable> {
  $$HabitsDetailsTableOrderingComposer({
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

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get editDatetime => $composableBuilder(
    column: $table.editDatetime,
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

  ColumnOrderings<String> get repeatOnDaysOfWeek => $composableBuilder(
    column: $table.repeatOnDaysOfWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repeatEveryNDays => $composableBuilder(
    column: $table.repeatEveryNDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetUnit => $composableBuilder(
    column: $table.targetUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetQuantity => $composableBuilder(
    column: $table.targetQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goalCompletionRate => $composableBuilder(
    column: $table.goalCompletionRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get goalDeadline => $composableBuilder(
    column: $table.goalDeadline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitsTableOrderingComposer get habitId {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
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

class $$HabitsDetailsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsDetailsTable> {
  $$HabitsDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get editDatetime => $composableBuilder(
    column: $table.editDatetime,
    builder: (column) => column,
  );

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

  GeneratedColumn<String> get repeatOnDaysOfWeek => $composableBuilder(
    column: $table.repeatOnDaysOfWeek,
    builder: (column) => column,
  );

  GeneratedColumn<int> get repeatEveryNDays => $composableBuilder(
    column: $table.repeatEveryNDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetUnit => $composableBuilder(
    column: $table.targetUnit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetQuantity => $composableBuilder(
    column: $table.targetQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<int> get goalCompletionRate => $composableBuilder(
    column: $table.goalCompletionRate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get goalDeadline => $composableBuilder(
    column: $table.goalDeadline,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  $$HabitsTableAnnotationComposer get habitId {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
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
      getCurrentColumn: (t) => t.version,
      referencedTable: $db.habitsLog,
      getReferencedColumn: (t) => t.habitDetailsVersion,
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

class $$HabitsDetailsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitsDetailsTable,
          HabitsDetail,
          $$HabitsDetailsTableFilterComposer,
          $$HabitsDetailsTableOrderingComposer,
          $$HabitsDetailsTableAnnotationComposer,
          $$HabitsDetailsTableCreateCompanionBuilder,
          $$HabitsDetailsTableUpdateCompanionBuilder,
          (HabitsDetail, $$HabitsDetailsTableReferences),
          HabitsDetail,
          PrefetchHooks Function({
            bool habitId,
            bool categoryId,
            bool habitsLogRefs,
          })
        > {
  $$HabitsDetailsTableTableManager(_$AppDatabase db, $HabitsDetailsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsDetailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsDetailsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsDetailsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> habitId = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<DateTime> editDatetime = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<DateTime> startDatetime = const Value.absent(),
                Value<DateTime?> endDatetime = const Value.absent(),
                Value<String?> reminderTime = const Value.absent(),
                Value<String?> repeatOnDaysOfWeek = const Value.absent(),
                Value<int?> repeatEveryNDays = const Value.absent(),
                Value<String?> targetUnit = const Value.absent(),
                Value<double?> targetQuantity = const Value.absent(),
                Value<int?> goalCompletionRate = const Value.absent(),
                Value<DateTime?> goalDeadline = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
              }) => HabitsDetailsCompanion(
                id: id,
                habitId: habitId,
                version: version,
                editDatetime: editDatetime,
                name: name,
                description: description,
                categoryId: categoryId,
                startDatetime: startDatetime,
                endDatetime: endDatetime,
                reminderTime: reminderTime,
                repeatOnDaysOfWeek: repeatOnDaysOfWeek,
                repeatEveryNDays: repeatEveryNDays,
                targetUnit: targetUnit,
                targetQuantity: targetQuantity,
                goalCompletionRate: goalCompletionRate,
                goalDeadline: goalDeadline,
                isArchived: isArchived,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int habitId,
                Value<int> version = const Value.absent(),
                Value<DateTime> editDatetime = const Value.absent(),
                required String name,
                required String description,
                required int categoryId,
                required DateTime startDatetime,
                Value<DateTime?> endDatetime = const Value.absent(),
                Value<String?> reminderTime = const Value.absent(),
                Value<String?> repeatOnDaysOfWeek = const Value.absent(),
                Value<int?> repeatEveryNDays = const Value.absent(),
                Value<String?> targetUnit = const Value.absent(),
                Value<double?> targetQuantity = const Value.absent(),
                Value<int?> goalCompletionRate = const Value.absent(),
                Value<DateTime?> goalDeadline = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
              }) => HabitsDetailsCompanion.insert(
                id: id,
                habitId: habitId,
                version: version,
                editDatetime: editDatetime,
                name: name,
                description: description,
                categoryId: categoryId,
                startDatetime: startDatetime,
                endDatetime: endDatetime,
                reminderTime: reminderTime,
                repeatOnDaysOfWeek: repeatOnDaysOfWeek,
                repeatEveryNDays: repeatEveryNDays,
                targetUnit: targetUnit,
                targetQuantity: targetQuantity,
                goalCompletionRate: goalCompletionRate,
                goalDeadline: goalDeadline,
                isArchived: isArchived,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HabitsDetailsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({habitId = false, categoryId = false, habitsLogRefs = false}) {
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
                        if (habitId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.habitId,
                                    referencedTable:
                                        $$HabitsDetailsTableReferences
                                            ._habitIdTable(db),
                                    referencedColumn:
                                        $$HabitsDetailsTableReferences
                                            ._habitIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable:
                                        $$HabitsDetailsTableReferences
                                            ._categoryIdTable(db),
                                    referencedColumn:
                                        $$HabitsDetailsTableReferences
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
                          HabitsDetail,
                          $HabitsDetailsTable,
                          HabitsLogData
                        >(
                          currentTable: table,
                          referencedTable: $$HabitsDetailsTableReferences
                              ._habitsLogRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HabitsDetailsTableReferences(
                                db,
                                table,
                                p0,
                              ).habitsLogRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.habitDetailsVersion == item.version,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$HabitsDetailsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitsDetailsTable,
      HabitsDetail,
      $$HabitsDetailsTableFilterComposer,
      $$HabitsDetailsTableOrderingComposer,
      $$HabitsDetailsTableAnnotationComposer,
      $$HabitsDetailsTableCreateCompanionBuilder,
      $$HabitsDetailsTableUpdateCompanionBuilder,
      (HabitsDetail, $$HabitsDetailsTableReferences),
      HabitsDetail,
      PrefetchHooks Function({
        bool habitId,
        bool categoryId,
        bool habitsLogRefs,
      })
    >;
typedef $$HabitsLogTableCreateCompanionBuilder =
    HabitsLogCompanion Function({
      Value<int> id,
      required int habitId,
      required int habitDetailsVersion,
      Value<DateTime> logDatetime,
      Value<double?> state,
    });
typedef $$HabitsLogTableUpdateCompanionBuilder =
    HabitsLogCompanion Function({
      Value<int> id,
      Value<int> habitId,
      Value<int> habitDetailsVersion,
      Value<DateTime> logDatetime,
      Value<double?> state,
    });

final class $$HabitsLogTableReferences
    extends BaseReferences<_$AppDatabase, $HabitsLogTable, HabitsLogData> {
  $$HabitsLogTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HabitsTable _habitIdTable(_$AppDatabase db) => db.habits.createAlias(
    $_aliasNameGenerator(db.habitsLog.habitId, db.habits.id),
  );

  $$HabitsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<int>('habit_id')!;

    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $HabitsDetailsTable _habitDetailsVersionTable(_$AppDatabase db) =>
      db.habitsDetails.createAlias(
        $_aliasNameGenerator(
          db.habitsLog.habitDetailsVersion,
          db.habitsDetails.version,
        ),
      );

  $$HabitsDetailsTableProcessedTableManager get habitDetailsVersion {
    final $_column = $_itemColumn<int>('habit_details_version')!;

    final manager = $$HabitsDetailsTableTableManager(
      $_db,
      $_db.habitsDetails,
    ).filter((f) => f.version.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitDetailsVersionTable($_db));
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

  ColumnFilters<DateTime> get logDatetime => $composableBuilder(
    column: $table.logDatetime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitsTableFilterComposer get habitId {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
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

  $$HabitsDetailsTableFilterComposer get habitDetailsVersion {
    final $$HabitsDetailsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitDetailsVersion,
      referencedTable: $db.habitsDetails,
      getReferencedColumn: (t) => t.version,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsDetailsTableFilterComposer(
            $db: $db,
            $table: $db.habitsDetails,
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

  ColumnOrderings<DateTime> get logDatetime => $composableBuilder(
    column: $table.logDatetime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitsTableOrderingComposer get habitId {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
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

  $$HabitsDetailsTableOrderingComposer get habitDetailsVersion {
    final $$HabitsDetailsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitDetailsVersion,
      referencedTable: $db.habitsDetails,
      getReferencedColumn: (t) => t.version,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsDetailsTableOrderingComposer(
            $db: $db,
            $table: $db.habitsDetails,
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

  GeneratedColumn<DateTime> get logDatetime => $composableBuilder(
    column: $table.logDatetime,
    builder: (column) => column,
  );

  GeneratedColumn<double> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  $$HabitsTableAnnotationComposer get habitId {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
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

  $$HabitsDetailsTableAnnotationComposer get habitDetailsVersion {
    final $$HabitsDetailsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitDetailsVersion,
      referencedTable: $db.habitsDetails,
      getReferencedColumn: (t) => t.version,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsDetailsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitsDetails,
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
          PrefetchHooks Function({bool habitId, bool habitDetailsVersion})
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
                Value<int> habitId = const Value.absent(),
                Value<int> habitDetailsVersion = const Value.absent(),
                Value<DateTime> logDatetime = const Value.absent(),
                Value<double?> state = const Value.absent(),
              }) => HabitsLogCompanion(
                id: id,
                habitId: habitId,
                habitDetailsVersion: habitDetailsVersion,
                logDatetime: logDatetime,
                state: state,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int habitId,
                required int habitDetailsVersion,
                Value<DateTime> logDatetime = const Value.absent(),
                Value<double?> state = const Value.absent(),
              }) => HabitsLogCompanion.insert(
                id: id,
                habitId: habitId,
                habitDetailsVersion: habitDetailsVersion,
                logDatetime: logDatetime,
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
          prefetchHooksCallback:
              ({habitId = false, habitDetailsVersion = false}) {
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
                        if (habitId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.habitId,
                                    referencedTable: $$HabitsLogTableReferences
                                        ._habitIdTable(db),
                                    referencedColumn: $$HabitsLogTableReferences
                                        ._habitIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (habitDetailsVersion) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.habitDetailsVersion,
                                    referencedTable: $$HabitsLogTableReferences
                                        ._habitDetailsVersionTable(db),
                                    referencedColumn: $$HabitsLogTableReferences
                                        ._habitDetailsVersionTable(db)
                                        .version,
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
      PrefetchHooks Function({bool habitId, bool habitDetailsVersion})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$HabitsDetailsTableTableManager get habitsDetails =>
      $$HabitsDetailsTableTableManager(_db, _db.habitsDetails);
  $$HabitsLogTableTableManager get habitsLog =>
      $$HabitsLogTableTableManager(_db, _db.habitsLog);
}
