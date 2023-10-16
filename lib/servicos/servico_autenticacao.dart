import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:politech/domain/usuario/usuario.dart';

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

  Future<void> login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _obterUsuario();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException("Senha é muito fraca!");
      } if (e.code == 'email-already-in-use') {
        throw AuthException("Email já esxite.");
      } else {
        throw AuthException("Não foi possível realizar o login");
      }
    }
  }
  Future<void> cadastrar(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _obterUsuario();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException("Senha é muito fraca!");
      } if (e.code == 'email-already-in-use') {
        throw AuthException("Email já esxite.");
      } else {
        throw AuthException("Não foi possivel cadastrar o usuário");
      }
    }
  }

  void _obterUsuario() {
    _usuario = _auth.currentUser;
    notifyListeners();
  }

  void logout() async {
    await _auth.signOut();
    _obterUsuario();
  }

  User? get usuario => _usuario;

  bool get carregando => _carregando;
}

class AuthException implements Exception {
  String _mensagemErro;

  AuthException(this._mensagemErro);

  String get mensagemErro => _mensagemErro;
}