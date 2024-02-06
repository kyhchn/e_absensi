import 'package:e_absensi/app/data/models/presence.dart';
import 'package:e_absensi/app/data/provider/presence_provider.dart';
import 'package:get/get.dart';

class PresenceRepository {
  final presenceProvider = Get.find<PresenceProvider>();
  
  Future<List<Presence>> getPresences(String code) async {
    return await presenceProvider.getPresences(code);
  }
}
