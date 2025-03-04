import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }

  Future<void> sendMessage(String chatId, String message, String senderId) async {
    await _firestore.collection('chats').doc(chatId).collection('messages').add({
      'text': message,
      'senderId': senderId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}