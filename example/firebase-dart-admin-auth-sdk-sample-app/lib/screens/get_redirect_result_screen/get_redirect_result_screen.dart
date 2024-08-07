import 'package:flutter/material.dart';
import 'package:firebase_dart_admin_auth_sdk/firebase_dart_admin_auth_sdk.dart';
import 'package:firebase_dart_admin_auth_sdk_sample_app/shared/shared.dart';
import 'package:provider/provider.dart';

class GetRedirectResultScreen extends StatefulWidget {
  const GetRedirectResultScreen({Key? key}) : super(key: key);

  @override
  _GetRedirectResultScreenState createState() =>
      _GetRedirectResultScreenState();
}

class _GetRedirectResultScreenState extends State<GetRedirectResultScreen> {
  String _result = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Redirect Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isLoading
                ? CircularProgressIndicator()
                : Button(
                    onTap: _getRedirectResult,
                    title: 'Get Redirect Result',
                  ),
            SizedBox(height: 20),
            Text(_result, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Future<void> _getRedirectResult() async {
    setState(() {
      _isLoading = true;
      _result = '';
    });

    try {
      final auth = Provider.of<FirebaseAuth>(context, listen: false);
      UserCredential? result = await auth.getRedirectResult();
      setState(() {
        if (result != null) {
          _result =
              'Redirect result: UID: ${result.user.uid}, Email: ${result.user.email}';
        } else {
          _result = 'No redirect result';
        }
      });
    } catch (e) {
      setState(() {
        _result = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
