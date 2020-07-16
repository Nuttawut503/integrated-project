import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class CaseRepository {
  final CollectionReference _caseCollection;

  CaseRepository({CollectionReference caseCollection})
      : _caseCollection = caseCollection ?? Firestore.instance.collection('cases');

  Future<void> addNewCase({String userId, String title, String detail, List<String> tags}) async {
    await _caseCollection.document().setData({
      
    });
  }
}