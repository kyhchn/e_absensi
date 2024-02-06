import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_absensi/app/core/constant.dart';
import 'package:e_absensi/app/data/models/presence.dart';

class PresenceProvider {
  Future<List<Presence>> getPresences(String code) async {
    final presences = await firestore
        .collection('subjects')
        .doc(code)
        .collection('presences')
        .get();
    return presences.docs.map((e) {
      print("result is " + e.data().toString());
      return Presence.fromJson(e.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<bool> attend(Presence presence, String studentId) async {
    if (presence.isOpen) {
      await firestore
          .collection('subjects')
          .doc(presence.code)
          .collection('presences')
          .doc(presence.id)
          .update({
        'students': FieldValue.arrayUnion([studentId])
      });
      return true;
    }
    return false;
  }
}
