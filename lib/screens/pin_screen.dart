import 'package:flutter/material.dart';
import 'package:expense_tracker/services/security_service.dart';
import 'package:expense_tracker/screens/home_screen.dart';
import 'package:expense_tracker/utils/app_localizations.dart';

class PinScreen extends StatefulWidget {
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final _pinController = TextEditingController();
  final _securityService = SecurityService();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate('enterPin')),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              obscureText: true,
              decoration: InputDecoration(
                labelText: localizations.translate('pin'),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _verifyPin,
              child: Text(localizations.translate('submit')),
            ),
          ],
        ),
      ),
    );
  }

  void _verifyPin() async {
    final enteredPin = _pinController.text;
    final isValid = await _securityService.verifyPin(enteredPin);

    if (isValid) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).translate('invalidPin'))),
      );
    }
  }
}