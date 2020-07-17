import 'dart:async';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatRepository {
  final String _caseId;
  final CollectionReference _chatReference;

  ChatRepository({@required String caseId})
    : _caseId = caseId,
      _chatReference = Firestore.instance.collection('chats').document('$caseId').collection('messages');

  Stream<List<Map>> getAllMessages() {
    return _chatReference.orderBy('sent_date', descending: true).snapshots().map((snapshot) {
      return snapshot.documents.map((doc) {
        return doc.data;
      }).toList();
    });
  }

  Future<void> uploadImage(String imagePath) async {
    DateTime currentTime = DateTime.now();
    StorageReference pictureChatStorage = FirebaseStorage.instance.ref().child('chats/$_caseId/$currentTime');
    StorageUploadTask uploadTask = pictureChatStorage.putFile(File(imagePath));
    final uploadedLink = (await (await uploadTask.onComplete).ref.getDownloadURL());
    await _chatReference.document().setData({
      'image_url': uploadedLink,
      'send_date': currentTime,
    });
  }
}
