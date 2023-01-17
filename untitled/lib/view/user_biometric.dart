import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:local_auth/local_auth.dart';
import 'package:untitled/constant/porject_text.dart';
import 'package:untitled/view/user_view.dart';

class UserBiometric extends StatefulWidget {
  const UserBiometric({super.key});

  @override
  State<UserBiometric> createState() => _UserBiometricState();
}

class _UserBiometricState extends State<UserBiometric> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Yetkili Değil';
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
          ? _SupportState.supported
          : _SupportState.unsupported),
    );
  }


  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Kimlik Doğrulama';

      });
      authenticated = await auth.authenticate(
        localizedReason:
        'Giriş İçin Parmağınızı Okutunuz',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Kimlik Doğrulama';
        if(authenticated == true){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>UserView()));
        }
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Hata - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Yetkili' : 'Yetkili Değil';
    setState(() {
      _authorized = message;

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          title: Text(ProjectText.appBarTitle),
        ),
        body: ListView(
          padding: const EdgeInsets.only(top: 30),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                  Column(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: _authenticateWithBiometrics,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Text('Parmağınızı Okutunuz'),
                             Icon(Icons.fingerprint),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

