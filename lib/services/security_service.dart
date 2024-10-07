import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurityService {
  final _storage = FlutterSecureStorage();

  Future<void> savePin(String pin) async {
    await _storage.write(key: 'user_pin', value: pin);
  }

  Future<String?> getPin() async {
    return await _storage.read(key: 'user_pin');
  }

  Future<bool> verifyPin(String enteredPin) async {
    final storedPin = await getPin();
    return storedPin == enteredPin;
  }
}