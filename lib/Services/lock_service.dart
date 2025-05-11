import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LockService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final String _lockKey = 'lock_until';

  Future<void> setLockDuration(int minutes) async {
    final DateTime lockTime = DateTime.now().add(Duration(minutes: minutes));
    await _storage.write(key: _lockKey, value: lockTime.toIso8601String());
  }

  Future<bool> isLocked() async {
    final String? lockTimeString = await _storage.read(key: _lockKey);
    if (lockTimeString == null) return false;

    final DateTime lockTime = DateTime.parse(lockTimeString);
    return DateTime.now().isBefore(lockTime);
  }

  Future<void> clearLock() async {
    await _storage.delete(key: _lockKey);
  }
}
