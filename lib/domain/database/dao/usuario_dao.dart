
import 'package:floor/floor.dart';

import '../../usuario/usuario.dart';


@dao
abstract class UsuarioDao {
  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> inserir(Usuario usuario);
  
  @Query("SELECT * From usuario LIMIT 20")
  Future<List<Usuario>> listar();

  @Query("SELECT * From usuario")
  Stream<List<Usuario>> assistirListaDeUsuarios();

  @Query("SELECT * From usuario LIMIT :limite")
  Future<List<Usuario>> listarComLimite(int limite);

  @update
  Future<void> atualizar(Usuario usuario);

  @Query("SELECT * From usuario WHERE id=:id")
  Future<Usuario?> procurarPorId(String id);

  @Query("SELECT * FROM usuario WHERE nome LIKE :nome LIMIT 20")
  Future<List<Usuario>> procurarPorNome(String nome);

  @delete
  Future<void> excluir(Usuario usuario);
}