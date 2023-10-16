import 'package:floor/floor.dart';
import 'package:get_it/get_it.dart';
import 'package:politech/domain/database/dao/usuario_dao.dart';
import 'package:politech/domain/usuario/usuario.dart';

class UsuarioRepositorio {
  late UsuarioDao _usuarioDao;

  UsuarioRepositorio() {
    _usuarioDao = GetIt.instance.get<UsuarioDao>();
  }

  @transaction
  Future<void> inserir(Usuario usuario) async {
    await _usuarioDao.inserir(usuario);
  }

  @transaction
  Future<List<Usuario>> listar() async {
    return await _usuarioDao.listar();
  }

  @transaction
  Stream<List<Usuario>> assistirListaDeUsuarios() async* {
    yield* _usuarioDao.assistirListaDeUsuarios();
  }

  @transaction
  Future<List<Usuario>> listarComLimite(int limite) async {
    return await _usuarioDao.listarComLimite(limite);
  }

  @transaction
  Future<void> atualizar(Usuario usuario) async {
    await _usuarioDao.atualizar(usuario);
  }

  @transaction
  Future<Usuario?> procurarPorId(String id) async {
    return await _usuarioDao.procurarPorId(id);
  }

  @transaction
  Future<List<Usuario>> procurarPorNome(String nome) async {
    return await _usuarioDao.procurarPorNome(nome);
  }

  @transaction
  Future<void> excluir(Usuario usuario) async {
    await _usuarioDao.excluir(usuario);
  }
}