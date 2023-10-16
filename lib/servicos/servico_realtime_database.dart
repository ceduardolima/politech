import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:politech/domain/usuario/usuario.dart';

class ServicoRealTimeDatabase extends ChangeNotifier {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  Usuario? _usuario;

  Future<void> criarUsuario(Usuario usuario) async {
    await _database.ref("usuarios/${usuario.id}").set(usuario.toJson());
    notifyListeners();
  }

  Future<void> pesquisarUsuario(String uid) async {
    final data = await _database.ref("usuarios/$uid").get();
    if (data != null && data.exists) {
      Map<String, dynamic> valor = Map.from(data.value! as Map);
      _usuario = Usuario.fromJson(valor);
      notifyListeners();
    }
  }

  Usuario? get usuario => _usuario;
}