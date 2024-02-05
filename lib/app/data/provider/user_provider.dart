import 'package:e_absensi/app/core/constant.dart';
import 'package:e_absensi/app/data/models/eabsensi_user.dart';

class UserProvider {
  Future<void> register(EabsensiUser user) async {
    await firestore.collection('users').doc(user.id).set(user.toJson());
  }

  Future<EabsensiUser?> getUser(String id) async {
    final user = await firestore.collection('users').doc(id).get();
    if (user.exists) {
      return EabsensiUser.fromJson(user.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> deleteUser(String id) async {
    await firestore.collection('users').doc(id).delete();
  }

  Future<void> updatePin(String pin, String id) async {
    await firestore.collection('users').doc(id).update({'pin': pin});
  }
}
