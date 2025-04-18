import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore, FieldValue, QuerySnapshot, DocumentSnapshot;
import 'package:logger/logger.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Logger _logger = Logger();

  // Adicionar um pedido ao Firestore
  Future<void> addServiceRequest(String userId, String description) async {
    try {
      await _firestore.collection('service_requests').add({
        'userId': userId,
        'description': description,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'pending', // Status inicial do pedido
      });
      _logger.i('Pedido adicionado com sucesso para o usuário $userId');
    } catch (e) {
      _logger.e('Erro ao adicionar pedido: $e');
    }
  }

  // Obter todos os pedidos de serviço
  Stream<QuerySnapshot> getServiceRequests() {
    return _firestore.collection('service_requests').snapshots();
  }

  // Adicionar informações de um prestador de serviço
  Future<void> addServiceProvider(String name, String expertise) async {
    try {
      await _firestore.collection('service_providers').add({
        'name': name,
        'expertise': expertise,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _logger.i('Prestador de serviço $name adicionado com sucesso');
    } catch (e) {
      _logger.e('Erro ao adicionar prestador de serviço: $e');
    }
  }

  // Obter todos os prestadores de serviço
  Stream<QuerySnapshot<Map<String, dynamic>>> getServiceProviders() {
    return _firestore.collection('service_providers').snapshots();
  }

  // Obter token de um prestador de serviço
  Future<String?> getProviderToken(String providerId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('service_providers').doc(providerId).get();
      return doc['K0Qt7ie0C3-shKlgtoh54Yt9P9iZifp8fHJ37zop14c']; // Certifique-se de que o campo `fcmToken` existe no Firestore
    } catch (e) {
      _logger.e('Erro ao obter token do prestador: $e');
      return null;
    }
  }
}

// Removed misplaced dependencies block