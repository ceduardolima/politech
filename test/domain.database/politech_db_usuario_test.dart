import 'package:flutter_test/flutter_test.dart';
import 'package:politech/domain/database/dao/usuario_dao.dart';
import 'package:politech/domain/database/politech_db.dart';
import 'package:politech/domain/usuario/usuario.dart';
import 'package:uuid/uuid.dart';

void main() {
  group("Teste do banco de dados", () {
    late PolitechDb banco;
    late UsuarioDao usuarioDao;

    setUp(() async {
      banco = await $FloorPolitechDb
          .inMemoryDatabaseBuilder()
          .build();
      usuarioDao = banco.usuarioDao;
    });

    tearDown(() async {
      banco.close();
    });

    test("Inserir usuario", () async {
      String id = Uuid().v4().toString();
      usuarioDao.inserir(Usuario(id, "11111111111", "Eduardo", "carlos.costa@gmail.com"));
      final actual = await usuarioDao.procurarPorId(id);
      expect(actual, isNotNull);
    });

    test("Procurar usuario pelo Nome", () async {
      String id = Uuid().v4().toString();
      usuarioDao.inserir(Usuario(id, "11111111111", "Eduardo", "carlos.costa@gmail.com"));
      final actual = await usuarioDao.procurarPorNome("Eduardo");
      expect(actual, isNotEmpty);
    });

    test("Procurar listar todos os usuarios", () async {
      final usuario_1 = Usuario.genId("11111111111", "Eduardo", "carlos.costa@gmail.com");
      final usuario_2 = Usuario.genId("22222222222", "Carlos", "carlos.costa@gmail.com");
      final usuario_3 = Usuario.genId("33333333333", "Matheus", "carlos.costa@gmail.com");
      final usuario_4 = Usuario.genId("44444444444", "Pablo", "carlos.costa@gmail.com");
      usuarioDao.inserir(usuario_1);
      usuarioDao.inserir(usuario_2);
      usuarioDao.inserir(usuario_3);
      usuarioDao.inserir(usuario_4);
      final actual = await usuarioDao.listar();
      expect(actual.length, equals(4));
    });

    test("Procurar listar todos os usuarios usando limite", () async {
      final usuario_1 = Usuario.genId("11111111111", "Eduardo", "carlos.costa@gmail.com");
      final usuario_2 = Usuario.genId("22222222222", "Carlos", "carlos.costa@gmail.com");
      final usuario_3 = Usuario.genId("33333333333", "Matheus", "carlos.costa@gmail.com");
      final usuario_4 = Usuario.genId("44444444444", "Pablo", "carlos.costa@gmail.com");
      usuarioDao.inserir(usuario_1);
      usuarioDao.inserir(usuario_2);
      usuarioDao.inserir(usuario_3);
      usuarioDao.inserir(usuario_4);
      final actual = await usuarioDao.listarComLimite(2);
      expect(actual.length, equals(2));
    });

    test("Atualizar um usuário", () async {
      final usuario_1 = Usuario.genId("11111111111", "Eduardo", "carlos.costa@gmail.com");
      usuarioDao.inserir(usuario_1);
      usuario_1.email = "carlos.lima@gmail.com";
      usuarioDao.atualizar(usuario_1);
      Usuario? actual = await usuarioDao.procurarPorId(usuario_1.id);
      expect(actual!.email, equals(usuario_1.email));
    });

    test("Excluir usuario", () async {
      final usuario = Usuario.genId("111111111", "Eduardo", "gmail");
      usuarioDao.inserir(usuario);
      usuarioDao.excluir(usuario);
      final actual = await usuarioDao.procurarPorId(usuario.id);
      expect(actual, isNull);
    });
  });

  group("Teste de serialização", () {
    test("Aluno para json", () {
      final usuario = Usuario.genId("123","Eduardo", "email");
      final presencaJson = usuario.toJson();
      expect(presencaJson, TypeMatcher<Map>());
      expect(presencaJson["id"], equals(usuario.id));
    });

    test("Json to entity", () {
      final usuarioJson = {"id":"12345","cpf":"1234", "nome":"eduardo", "email":"email"};
      final usuario = Usuario.fromJson(usuarioJson);
      expect(usuario, TypeMatcher<Usuario>());
      expect(usuario.id, equals(usuarioJson["id"]));
    });
  });
}