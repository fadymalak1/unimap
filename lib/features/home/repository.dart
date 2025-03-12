import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unimap/features/home/model.dart';

class ClassRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<ClassModel>> getClasses() async {
    final snapshot = await _firestore.collection('classes').get();
    return snapshot.docs.map((doc) => ClassModel.fromMap(doc.id, doc.data())).toList();
  }

  Future<List<ClassModel>> getFavorites() async {
    final user = _auth.currentUser;
    if (user == null) return [];

    final snapshot = await _firestore.collection('users').doc(user.uid).collection('favorites').get();
    return snapshot.docs.map((doc) => ClassModel.fromMap(doc.id, doc.data())).toList();
  }

  Future<void> toggleFavorite(ClassModel classItem) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final favRef = _firestore.collection('users').doc(user.uid).collection('favorites').doc(classItem.id);
    final favDoc = await favRef.get();

    if (favDoc.exists) {
      await favRef.delete();
    } else {
      await favRef.set(classItem.toMap());
    }
  }
}
