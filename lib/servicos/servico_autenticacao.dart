import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ServicoAutenticacao extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _usuario;
  bool _carregando = true;

  ServicoAutenticacao() {
    _checarAutenticacao();
  }

  void _checarAutenticacao() {
    _auth.authStateChanges().listen((usuario) {
      _usuario = usuario;
      _carregando = false;
      notifyListeners();
    });
  }

  User? get usuario => _usuario;

  bool get carregando => _carregando;
}