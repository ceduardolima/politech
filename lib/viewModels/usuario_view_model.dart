import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:politech/domain/repositorio/usuario_repositorio.dart';

import '../domain/usuario/usuario.dart';

class UsuarioViewModel extends ChangeNotifier {
  late UsuarioRepositorio _usuarioRepositorio;
  List<Usuario> _listaUsuario = [];

  UsuarioViewModel() {
    _usuarioRepositorio = GetIt.instance.get<UsuarioRepositorio>();
    assistirListaUsuario();
  }

  void assistirListaUsuario() {
    _usuarioRepositorio.assistirListaDeUsuarios().listen((lista) {
      _listaUsuario = lista;
      notifyListeners();
    });
  }

  List<Usuario> get listaUsuario => _listaUsuario;

  UsuarioRepositorio get usuario => _usuarioRepositorio;

  Future<void> inserir(Usuario usuario) async {
    await _usuarioRepositorio.inserir(usuario);
  }
}