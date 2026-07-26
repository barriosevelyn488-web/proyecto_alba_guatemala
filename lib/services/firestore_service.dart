import 'package:cloud_firestore/cloud_firestore.dart';

/// Servicio para manejar todas las operaciones CRUD con Firebase Firestore.
/// Mantiene la lógica de base de datos aislada del resto de la aplicación.
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Obtiene un documento de una colección por su ID.
  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument(
      String collection, String docId) async {
    return _db.collection(collection).doc(docId).get();
  }

  /// Obtiene todos los documentos de una colección.
  Future<QuerySnapshot<Map<String, dynamic>>> getCollection(
      String collection) async {
    return _db.collection(collection).get();
  }

  /// Añade un nuevo documento a una colección.
  Future<DocumentReference<Map<String, dynamic>>> addDocument(
      String collection, Map<String, dynamic> data) async {
    return _db.collection(collection).add(data);
  }

  /// Actualiza un documento existente.
  Future<void> updateDocument(
      String collection, String docId, Map<String, dynamic> data) async {
    return _db.collection(collection).doc(docId).update(data);
  }

  /// Elimina un documento.
  Future<void> deleteDocument(String collection, String docId) async {
    return _db.collection(collection).doc(docId).delete();
  }
}
