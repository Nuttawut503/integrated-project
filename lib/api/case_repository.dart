import 'dart:async';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CaseRepository {
  final CollectionReference _caseCollection;

  CaseRepository({CollectionReference caseCollection})
      : _caseCollection = caseCollection ?? Firestore.instance.collection('cases');

  Future<void> addNewCase({String userId, String title, String detail, List<String> tags}) async {
    await _caseCollection.document().setData({
      'title': title,
      'detail': detail,
      'tags': tags,
      'submitted_date': DateTime.now(),
      'owner_id': userId,
      'lawyer_assist_id': null,
    });
  }

  Stream<List<Map>> getAllOtherCases() {
    return _caseCollection
            .where('lawyer_assist_id', isNull: true)
            .orderBy('submitted_date')
            .snapshots()
            .map((snapshot) {
              return snapshot.documents.map((doc) {
                Map modifiedDoc = doc.data;
                modifiedDoc['case_id'] = doc.documentID;
                modifiedDoc['submitted_date'] = DateTime.fromMillisecondsSinceEpoch(modifiedDoc['submitted_date'].seconds * 1000);
                modifiedDoc['submitted_date'] = DateFormat.yMd().add_jm().format(modifiedDoc['submitted_date']);
                return modifiedDoc;
              }).toList();
            });
  }

  Stream<List<Map>> getMyCases({String userId}) {
    return _caseCollection
            .where('owner_id', isEqualTo: userId)
            .orderBy('submitted_date')
            .snapshots()
            .map((snapshot) {
              return snapshot.documents.map((doc) {
                Map modifiedDoc = doc.data;
                modifiedDoc['case_id'] = doc.documentID;
                modifiedDoc['submitted_date_raw'] = DateTime.fromMillisecondsSinceEpoch(modifiedDoc['submitted_date'].seconds * 1000);
                modifiedDoc['submitted_date'] = DateFormat.yMd().add_jm().format(modifiedDoc['submitted_date_raw']);
                return modifiedDoc;
              }).toList();
            });
  }

  Stream<List<Map>> getRelevantCases({String userId}) {
    return _caseCollection
            .where('lawyer_assist_id', isEqualTo: userId)
            .orderBy('submitted_date')
            .snapshots()
            .map((snapshot) {
              return snapshot.documents.map((doc) {
                Map modifiedDoc = doc.data;
                modifiedDoc['case_id'] = doc.documentID;
                modifiedDoc['submitted_date_raw'] = DateTime.fromMillisecondsSinceEpoch(modifiedDoc['submitted_date'].seconds * 1000);
                modifiedDoc['submitted_date'] = DateFormat.yMd().add_jm().format(modifiedDoc['submitted_date_raw']);
                return modifiedDoc;
              }).toList();
            });
  }

  Stream<Map> getInfoFromCase({String caseId}) {
    return _caseCollection.document('$caseId').snapshots().map((doc) {
      if (doc.exists) {
        Map modifiedDoc = doc.data;
        modifiedDoc['submitted_date'] = DateTime.fromMillisecondsSinceEpoch(modifiedDoc['submitted_date'].seconds * 1000);
        modifiedDoc['submitted_date'] = DateFormat.yMd().add_jm().format(modifiedDoc['submitted_date']);
        return modifiedDoc;
      }
      return Map();
    });
  }

  Future<void> updateLawyerAssistId({String caseId, String lawyerId}) async {
    await _caseCollection.document('$caseId').updateData({
      'lawyer_assist_id': lawyerId,
    });
  }

  Future<void> deleteCase({String caseId}) async {
    await _caseCollection.document('$caseId').delete();
  }
}
