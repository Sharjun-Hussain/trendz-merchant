import 'package:flutter/foundation.dart';
import 'package:trendz_merchant/Services/lock_service.dart';

class FingerprintProvider with ChangeNotifier {
  bool _isLocked = false;
  final LockService _lockService = LockService();

  bool get isLocked => _isLocked;

  Future<void> checkLock() async {
    _isLocked = await _lockService.isLocked();
    notifyListeners();
  }

  Future<void> unlock() async {
    _isLocked = false;
    await _lockService.clearLock();
    notifyListeners();
  }

  Future<void> setLock(int minutes) async {
    _isLocked = true;
    await _lockService.setLockDuration(minutes);
    notifyListeners();
  }
}
