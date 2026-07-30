

import 'package:cloud_firestore/cloud_firestore.dart';

/// Servicio singleton centralizado para todas las operaciones de Firestore
/// enfocadas en la persistencia offline y manejo limpio de consultas.
class FirestoreService {
  FirestoreService._internal() {
    _configureOfflinePersistence();
  }

  static final FirestoreService _instance = FirestoreService._internal();

  factory FirestoreService() => _instance;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  static const String _medicationsCollection = 'medications';
  static const String _healthRecordsCollection = 'health_records';

  void _configureOfflinePersistence() {
    try {
      _db.settings = const Settings(
        persistenceEnabled: true,
      );
    } catch (_) {
      // Si ya se configuró la persistencia en otro lugar, no interrumpimos.
    }
  }

  CollectionReference<Map<String, dynamic>> _collection(String path) =>
      _db.collection(path);

  DocumentReference<Map<String, dynamic>> _document(
          String collectionPath, String docId) =>
      _collection(collectionPath).doc(docId);

  Future<QuerySnapshot<Map<String, dynamic>>> fetchMedications(
      String userId) async {
    try {
      return await _collection(_medicationsCollection)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get(const GetOptions(source: Source.serverAndCache));
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: 'fetch_medications_error',
        message: 'Error al obtener medicamentos: ${e.message}',
      );
    } catch (e) {
      throw Exception('FirestoreService.fetchMedications: $e');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamMedications(
      String userId) {
    return _collection(_medicationsCollection)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots(includeMetadataChanges: true);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getMedication(
      String medicationId) async {
    try {
      return await _document(_medicationsCollection, medicationId).get();
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: 'get_medication_error',
        message: 'Error al leer medicamento: ${e.message}',
      );
    } catch (e) {
      throw Exception('FirestoreService.getMedication: $e');
    }
  }

  Future<DocumentReference<Map<String, dynamic>>> addMedication(
    String userId,
    Map<String, dynamic> medicationData,
  ) async {
    try {
      final data = {
        'userId': userId,
        'createdAt': FieldValue.serverTimestamp(),
        ...medicationData,
      };
      return await _collection(_medicationsCollection).add(data);
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: 'add_medication_error',
        message: 'Error al agregar medicamento: ${e.message}',
      );
    } catch (e) {
      throw Exception('FirestoreService.addMedication: $e');
    }
  }

  Future<void> updateMedication(
    String medicationId,
    Map<String, dynamic> updates,
  ) async {
    try {
      await _document(_medicationsCollection, medicationId).update({
        ...updates,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: 'update_medication_error',
        message: 'Error al actualizar medicamento: ${e.message}',
      );
    } catch (e) {
      throw Exception('FirestoreService.updateMedication: $e');
    }
  }

  Future<void> deleteMedication(String medicationId) async {
    try {
      await _document(_medicationsCollection, medicationId).delete();
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: 'delete_medication_error',
        message: 'Error al eliminar medicamento: ${e.message}',
      );
    } catch (e) {
      throw Exception('FirestoreService.deleteMedication: $e');
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchHealthRecords(
      String userId) async {
    try {
      return await _collection(_healthRecordsCollection)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get(const GetOptions(source: Source.serverAndCache));
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: 'fetch_health_records_error',
        message: 'Error al obtener registros médicos: ${e.message}',
      );
    } catch (e) {
      throw Exception('FirestoreService.fetchHealthRecords: $e');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamHealthRecords(
      String userId) {
    return _collection(_healthRecordsCollection)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots(includeMetadataChanges: true);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getHealthRecord(
      String recordId) async {
    try {
      return await _document(_healthRecordsCollection, recordId).get();
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: 'get_health_record_error',
        message: 'Error al leer registro médico: ${e.message}',
      );
    } catch (e) {
      throw Exception('FirestoreService.getHealthRecord: $e');
    }
  }

  Future<DocumentReference<Map<String, dynamic>>> addHealthRecord(
    String userId,
    Map<String, dynamic> recordData,
  ) async {
    try {
      final data = {
        'userId': userId,
        'createdAt': FieldValue.serverTimestamp(),
        ...recordData,
      };
      return await _collection(_healthRecordsCollection).add(data);
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: 'add_health_record_error',
        message: 'Error al agregar registro médico: ${e.message}',
      );
    } catch (e) {
      throw Exception('FirestoreService.addHealthRecord: $e');
    }
  }

  Future<void> updateHealthRecord(
    String recordId,
    Map<String, dynamic> updates,
  ) async {
    try {
      await _document(_healthRecordsCollection, recordId).update({
        ...updates,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: 'update_health_record_error',
        message: 'Error al actualizar registro médico: ${e.message}',
      );
    } catch (e) {
      throw Exception('FirestoreService.updateHealthRecord: $e');
    }
  }

  Future<void> deleteHealthRecord(String recordId) async {
    try {
      await _document(_healthRecordsCollection, recordId).delete();
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        code: 'delete_health_record_error',
        message: 'Error al eliminar registro médico: ${e.message}',
      );
    } catch (e) {
      throw Exception('FirestoreService.deleteHealthRecord: $e');
    }
  }
}