import 'dart:ui' show Color;

import 'package:drift/drift.dart';
import 'package:habit_tracker/core/db/app_database.dart';
import 'package:habit_tracker/core/db/tables/categories.dart';
import 'package:habit_tracker/core/entities/category_data.dart';

part 'categories_dao.g.dart';

@DriftAccessor(tables: [Categories])
class CategoriesDao extends DatabaseAccessor<AppDatabase>
    with _$CategoriesDaoMixin {
  CategoriesDao(AppDatabase db) : super(db);

  
  Future<int?> insertCategory(CategoryData categoryData) async {
    if (categoryData.id != Value.absent()) {
      throw Exception(
        'the property CategoryData.id should be unassigned in case of insertion',
      );
    }
    try {
      int? insertId;
      final duplicate =
          await (select(db.categories)
                ..where(
                  (u) => u.color.equals(categoryData.color.value.toARGB32()),
                )
                ..where(
                  (u) =>
                      u.iconCodePoint.equals(categoryData.iconCodePoint.value),
                ))
              .getSingleOrNull();
      if (duplicate == null) {
        insertId = await into(db.categories).insert(
          CategoriesCompanion.insert(
            name: categoryData.name.value,
            color: categoryData.color.value.toARGB32(),
            iconCodePoint: categoryData.iconCodePoint.value,
          ),
        );
      } else {
        return null;
      }
      return insertId;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  
  Future<CategoryData?> getCategory(int id) async {
    try {
      final category = await (select(
        db.categories,
      )..where((u) => u.id.equals(id))).getSingleOrNull();
      if (category == null) {
        return null;
      } else {
        return CategoryData(
          id: Value(category.id),
          name: Value(category.name),
          color: Value(Color(category.color)),
          iconCodePoint: Value(category.iconCodePoint),
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  
  Future<List<CategoryData>?> getAllCategories() async {
    try {
      final query = await (select(
        db.categories,
      )..orderBy([(u) => OrderingTerm(expression: u.id)])).get();
      if (query.isEmpty) {
        return null;
      }
      List<CategoryData> out = [];
      for (final row in query) {
        out.add(
          CategoryData(
            id: Value(row.id),
            name: Value(row.name),
            color: Value(Color(row.color)),
            iconCodePoint: Value(row.iconCodePoint),
          ),
        );
      }
      return out;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  
  Future<int?> editCategory(CategoryData newData) async {
    try {
      final duplicate =
          await (select(db.categories)
                ..where((u) => u.color.equals(newData.color.value.toARGB32()))
                ..where(
                  (u) => u.iconCodePoint.equals(newData.iconCodePoint.value),
                ))
              .getSingleOrNull();
      if (duplicate == null) {
        (update(db.categories)..where((u) => u.id.equals(newData.id.value))).write(
          CategoriesCompanion(
            name: newData.name,
            color: Value(newData.color.value.toARGB32()),
            iconCodePoint: newData.iconCodePoint,
          ),
        );
        return newData.id.value;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
