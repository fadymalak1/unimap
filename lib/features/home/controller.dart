import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unimap/features/home/repository.dart';

import 'model.dart';



class ClassController extends StateNotifier<List<ClassModel>> {
  final ClassRepository _repository;
  List<ClassModel> _allClasses = []; // Store all classes for searching

  ClassController(this._repository) : super([]) {
    _loadClasses();
  }

  Future<void> _loadClasses() async {
    _allClasses = await _repository.getClasses(); // Store all classes
    state = _allClasses;
  }

  void searchClasses(String query) {
    if (query.isEmpty) {
      state = _allClasses;
    } else {
      state = _allClasses
          .where((classItem) =>
      classItem.nameEn.toLowerCase().contains(query.toLowerCase()) ||
          classItem.nameAr.contains(query))
          .toList();
    }
  }
}

class FavoriteController extends StateNotifier<List<ClassModel>> {
  final ClassRepository _repository;

  FavoriteController(this._repository) : super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    state = await _repository.getFavorites();
  }

  void toggleFavorite(ClassModel classItem) async {
    await _repository.toggleFavorite(classItem);
    _loadFavorites();
  }
}
