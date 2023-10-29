// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'politech_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorPolitechDb {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$PolitechDbBuilder databaseBuilder(String name) =>
      _$PolitechDbBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$PolitechDbBuilder inMemoryDatabaseBuilder() =>
      _$PolitechDbBuilder(null);
}

class _$PolitechDbBuilder {
  _$PolitechDbBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$PolitechDbBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$PolitechDbBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<PolitechDb> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$PolitechDb();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$PolitechDb extends PolitechDb {
  _$PolitechDb([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UsuarioDao? _usuarioDaoInstance;

  AlunoDao? _alunoDaoInstance;

  PresencaDao? _presencaDaoInstance;

  TurmaDao? _turmaDaoInstance;

  ChamadaDao? _chamadaDaoInstance;

  HorarioDao? _horarioDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `usuario` (`id` TEXT NOT NULL, `cpf` TEXT NOT NULL, `nome` TEXT NOT NULL, `email` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `alunos` (`id` TEXT NOT NULL, `turma_id` TEXT NOT NULL, `nome` TEXT NOT NULL, FOREIGN KEY (`turma_id`) REFERENCES `turmas` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `presencas` (`id` TEXT NOT NULL, `aluno_id` TEXT NOT NULL, `chamada_id` TEXT NOT NULL, `presente` INTEGER NOT NULL, `data` INTEGER NOT NULL, FOREIGN KEY (`aluno_id`) REFERENCES `alunos` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`chamada_id`) REFERENCES `chamadas` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `turmas` (`id` TEXT NOT NULL, `codigo` TEXT NOT NULL, `nome` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `chamadas` (`id` TEXT NOT NULL, `data` INTEGER NOT NULL, `turma_id` TEXT NOT NULL, FOREIGN KEY (`turma_id`) REFERENCES `turmas` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `horarios` (`id` TEXT NOT NULL, `dia_semana` TEXT NOT NULL, `hora` TEXT NOT NULL, `sala` TEXT NOT NULL, `turma_id` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE INDEX `index_presencas_aluno_id` ON `presencas` (`aluno_id`)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UsuarioDao get usuarioDao {
    return _usuarioDaoInstance ??= _$UsuarioDao(database, changeListener);
  }

  @override
  AlunoDao get alunoDao {
    return _alunoDaoInstance ??= _$AlunoDao(database, changeListener);
  }

  @override
  PresencaDao get presencaDao {
    return _presencaDaoInstance ??= _$PresencaDao(database, changeListener);
  }

  @override
  TurmaDao get turmaDao {
    return _turmaDaoInstance ??= _$TurmaDao(database, changeListener);
  }

  @override
  ChamadaDao get chamadaDao {
    return _chamadaDaoInstance ??= _$ChamadaDao(database, changeListener);
  }

  @override
  HorarioDao get horarioDao {
    return _horarioDaoInstance ??= _$HorarioDao(database, changeListener);
  }
}

class _$UsuarioDao extends UsuarioDao {
  _$UsuarioDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _usuarioInsertionAdapter = InsertionAdapter(
            database,
            'usuario',
            (Usuario item) => <String, Object?>{
                  'id': item.id,
                  'cpf': item.cpf,
                  'nome': item.nome,
                  'email': item.email
                },
            changeListener),
        _usuarioUpdateAdapter = UpdateAdapter(
            database,
            'usuario',
            ['id'],
            (Usuario item) => <String, Object?>{
                  'id': item.id,
                  'cpf': item.cpf,
                  'nome': item.nome,
                  'email': item.email
                },
            changeListener),
        _usuarioDeletionAdapter = DeletionAdapter(
            database,
            'usuario',
            ['id'],
            (Usuario item) => <String, Object?>{
                  'id': item.id,
                  'cpf': item.cpf,
                  'nome': item.nome,
                  'email': item.email
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Usuario> _usuarioInsertionAdapter;

  final UpdateAdapter<Usuario> _usuarioUpdateAdapter;

  final DeletionAdapter<Usuario> _usuarioDeletionAdapter;

  @override
  Future<List<Usuario>> listar() async {
    return _queryAdapter.queryList('SELECT * From usuario LIMIT 20',
        mapper: (Map<String, Object?> row) => Usuario(
            row['id'] as String,
            row['cpf'] as String,
            row['nome'] as String,
            row['email'] as String));
  }

  @override
  Stream<List<Usuario>> assistirListaDeUsuarios() {
    return _queryAdapter.queryListStream('SELECT * From usuario',
        mapper: (Map<String, Object?> row) => Usuario(
            row['id'] as String,
            row['cpf'] as String,
            row['nome'] as String,
            row['email'] as String),
        queryableName: 'usuario',
        isView: false);
  }

  @override
  Future<List<Usuario>> listarComLimite(int limite) async {
    return _queryAdapter.queryList('SELECT * From usuario LIMIT ?1',
        mapper: (Map<String, Object?> row) => Usuario(
            row['id'] as String,
            row['cpf'] as String,
            row['nome'] as String,
            row['email'] as String),
        arguments: [limite]);
  }

  @override
  Future<Usuario?> procurarPorId(String id) async {
    return _queryAdapter.query('SELECT * From usuario WHERE id=?1',
        mapper: (Map<String, Object?> row) => Usuario(
            row['id'] as String,
            row['cpf'] as String,
            row['nome'] as String,
            row['email'] as String),
        arguments: [id]);
  }

  @override
  Future<List<Usuario>> procurarPorNome(String nome) async {
    return _queryAdapter.queryList(
        'SELECT * FROM usuario WHERE nome LIKE ?1 LIMIT 20',
        mapper: (Map<String, Object?> row) => Usuario(
            row['id'] as String,
            row['cpf'] as String,
            row['nome'] as String,
            row['email'] as String),
        arguments: [nome]);
  }

  @override
  Future<void> inserir(Usuario usuario) async {
    await _usuarioInsertionAdapter.insert(usuario, OnConflictStrategy.fail);
  }

  @override
  Future<void> atualizar(Usuario usuario) async {
    await _usuarioUpdateAdapter.update(usuario, OnConflictStrategy.abort);
  }

  @override
  Future<void> excluir(Usuario usuario) async {
    await _usuarioDeletionAdapter.delete(usuario);
  }
}

class _$AlunoDao extends AlunoDao {
  _$AlunoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _alunoInsertionAdapter = InsertionAdapter(
            database,
            'alunos',
            (Aluno item) => <String, Object?>{
                  'id': item.id,
                  'turma_id': item.turmaId,
                  'nome': item.nome
                },
            changeListener),
        _alunoUpdateAdapter = UpdateAdapter(
            database,
            'alunos',
            ['id'],
            (Aluno item) => <String, Object?>{
                  'id': item.id,
                  'turma_id': item.turmaId,
                  'nome': item.nome
                },
            changeListener),
        _alunoDeletionAdapter = DeletionAdapter(
            database,
            'alunos',
            ['id'],
            (Aluno item) => <String, Object?>{
                  'id': item.id,
                  'turma_id': item.turmaId,
                  'nome': item.nome
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Aluno> _alunoInsertionAdapter;

  final UpdateAdapter<Aluno> _alunoUpdateAdapter;

  final DeletionAdapter<Aluno> _alunoDeletionAdapter;

  @override
  Future<List<Aluno>> listar() async {
    return _queryAdapter.queryList('SELECT * From alunos LIMIT 20',
        mapper: (Map<String, Object?> row) => Aluno(row['id'] as String,
            row['nome'] as String, row['turma_id'] as String));
  }

  @override
  Stream<List<Aluno>> assistirListaAluno() {
    return _queryAdapter.queryListStream('SELECT * From alunos',
        mapper: (Map<String, Object?> row) => Aluno(row['id'] as String,
            row['nome'] as String, row['turma_id'] as String),
        queryableName: 'alunos',
        isView: false);
  }

  @override
  Future<List<Aluno>> listarComLimite(int limite) async {
    return _queryAdapter.queryList('SELECT * From alunos LIMIT ?1',
        mapper: (Map<String, Object?> row) => Aluno(row['id'] as String,
            row['nome'] as String, row['turma_id'] as String),
        arguments: [limite]);
  }

  @override
  Future<Aluno?> procurarPorId(String id) async {
    return _queryAdapter.query('SELECT * From alunos WHERE id=?1',
        mapper: (Map<String, Object?> row) => Aluno(row['id'] as String,
            row['nome'] as String, row['turma_id'] as String),
        arguments: [id]);
  }

  @override
  Future<List<Aluno>> procurarPorNome(String nome) async {
    return _queryAdapter.queryList(
        'SELECT * FROM alunos WHERE nome LIKE ?1 LIMIT 20',
        mapper: (Map<String, Object?> row) => Aluno(row['id'] as String,
            row['nome'] as String, row['turma_id'] as String),
        arguments: [nome]);
  }

  @override
  Future<int?> excluirAlunosDaTurma(String turmaId) async {
    return _queryAdapter.query('DELETE FROM alunos WHERE turma_id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [turmaId]);
  }

  @override
  Future<void> inserir(Aluno aluno) async {
    await _alunoInsertionAdapter.insert(aluno, OnConflictStrategy.abort);
  }

  @override
  Future<void> inserirLista(List<Aluno> aluno) async {
    await _alunoInsertionAdapter.insertList(aluno, OnConflictStrategy.abort);
  }

  @override
  Future<void> atualizar(Aluno aluno) async {
    await _alunoUpdateAdapter.update(aluno, OnConflictStrategy.abort);
  }

  @override
  Future<void> excluir(Aluno aluno) async {
    await _alunoDeletionAdapter.delete(aluno);
  }
}

class _$PresencaDao extends PresencaDao {
  _$PresencaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _presencaInsertionAdapter = InsertionAdapter(
            database,
            'presencas',
            (Presenca item) => <String, Object?>{
                  'id': item.id,
                  'aluno_id': item.alunoId,
                  'chamada_id': item.chamadaId,
                  'presente': item.presente ? 1 : 0,
                  'data': _dateTimeConversor.encode(item.data)
                },
            changeListener),
        _presencaDeletionAdapter = DeletionAdapter(
            database,
            'presencas',
            ['id'],
            (Presenca item) => <String, Object?>{
                  'id': item.id,
                  'aluno_id': item.alunoId,
                  'chamada_id': item.chamadaId,
                  'presente': item.presente ? 1 : 0,
                  'data': _dateTimeConversor.encode(item.data)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Presenca> _presencaInsertionAdapter;

  final DeletionAdapter<Presenca> _presencaDeletionAdapter;

  @override
  Stream<List<Presenca>> assistirListaDePresencaDaTurma(String chamadaId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM presencas WHERE chamada_id = ?1',
        mapper: (Map<String, Object?> row) => Presenca(
            row['id'] as String,
            row['aluno_id'] as String,
            (row['presente'] as int) != 0,
            _dateTimeConversor.decode(row['data'] as int),
            row['chamada_id'] as String),
        arguments: [chamadaId],
        queryableName: 'presencas',
        isView: false);
  }

  @override
  Future<List<Aluno>> listarAlunosPresentes() async {
    return _queryAdapter.queryList(
        'SELECT alunos.* FROM alunos LEFT JOIN presencas ON alunos.id = presencas.aluno_id WHERE presente = 1',
        mapper: (Map<String, Object?> row) => Aluno(row['id'] as String,
            row['nome'] as String, row['turma_id'] as String));
  }

  @override
  Future<List<Aluno>> listarAlunosFaltates() async {
    return _queryAdapter.queryList(
        'SELECT alunos.* FROM alunos LEFT JOIN presencas ON alunos.id = presencas.aluno_id WHERE presente = 0',
        mapper: (Map<String, Object?> row) => Aluno(row['id'] as String,
            row['nome'] as String, row['turma_id'] as String));
  }

  @override
  Future<List<Presenca>> listarPresencasDoAluno(
    String alunoId,
    DateTime inicio,
    DateTime fim,
    bool presente,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM presencas WHERE presente = ?4 AND data >= ?2 AND data <= ?3 AND aluno_id = ?1',
        mapper: (Map<String, Object?> row) => Presenca(
            row['id'] as String,
            row['aluno_id'] as String,
            (row['presente'] as int) != 0,
            _dateTimeConversor.decode(row['data'] as int),
            row['chamada_id'] as String),
        arguments: [
          alunoId,
          _dateTimeConversor.encode(inicio),
          _dateTimeConversor.encode(fim),
          presente ? 1 : 0
        ]);
  }

  @override
  Future<int?> numeroDeFaltasDoAluno(String alunoId) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM presencas WHERE aluno_id=?1 AND presente=0',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [alunoId]);
  }

  @override
  Future<List<Aluno>> listarAlunosDaChamada(
    String chamadaId,
    bool presenca,
  ) async {
    return _queryAdapter.queryList(
        'SELECT alunos.* FROM alunos LEFT JOIN presencas ON alunos.id = presencas.aluno_id WHERE presencas.chamada_id = ?1 AND presencas.presente = ?2',
        mapper: (Map<String, Object?> row) => Aluno(row['id'] as String, row['nome'] as String, row['turma_id'] as String),
        arguments: [chamadaId, presenca ? 1 : 0]);
  }

  @override
  Future<void> excluirPresencaDaChamada(String chamadaId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM presencas WHERE chamada_id = ?1',
        arguments: [chamadaId]);
  }

  @override
  Future<void> excluirPresencaDaTurma(String turmaId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM presencas WHERE chamada_id IN (SELECT id FROM chamadas WHERE chamadas.turma_id = ?1)',
        arguments: [turmaId]);
  }

  @override
  Future<void> inserir(Presenca presenca) async {
    await _presencaInsertionAdapter.insert(presenca, OnConflictStrategy.fail);
  }

  @override
  Future<void> inserirLista(List<Presenca> presenca) async {
    await _presencaInsertionAdapter.insertList(
        presenca, OnConflictStrategy.fail);
  }

  @override
  Future<void> excluir(Presenca presenca) async {
    await _presencaDeletionAdapter.delete(presenca);
  }
}

class _$TurmaDao extends TurmaDao {
  _$TurmaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _turmaInsertionAdapter = InsertionAdapter(
            database,
            'turmas',
            (Turma item) => <String, Object?>{
                  'id': item.id,
                  'codigo': item.codigo,
                  'nome': item.nome
                },
            changeListener),
        _turmaDeletionAdapter = DeletionAdapter(
            database,
            'turmas',
            ['id'],
            (Turma item) => <String, Object?>{
                  'id': item.id,
                  'codigo': item.codigo,
                  'nome': item.nome
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Turma> _turmaInsertionAdapter;

  final DeletionAdapter<Turma> _turmaDeletionAdapter;

  @override
  Stream<List<Turma>> assistirListaDeTurmas() {
    return _queryAdapter.queryListStream('SELECT * FROM turmas',
        mapper: (Map<String, Object?> row) => Turma(row['id'] as String,
            row['nome'] as String, row['codigo'] as String),
        queryableName: 'turmas',
        isView: false);
  }

  @override
  Future<List<Aluno>> listarAlunos(String turmaId) async {
    return _queryAdapter.queryList(
        'SELECT alunos.* FROM turmas LEFT JOIN alunos ON alunos.turma_id = turmas.id WHERE turmas.id = ?1',
        mapper: (Map<String, Object?> row) => Aluno(row['id'] as String, row['nome'] as String, row['turma_id'] as String),
        arguments: [turmaId]);
  }

  @override
  Future<void> inserir(Turma turma) async {
    await _turmaInsertionAdapter.insert(turma, OnConflictStrategy.fail);
  }

  @override
  Future<void> inserirLista(List<Turma> turma) async {
    await _turmaInsertionAdapter.insertList(turma, OnConflictStrategy.fail);
  }

  @override
  Future<void> excluir(Turma turma) async {
    await _turmaDeletionAdapter.delete(turma);
  }
}

class _$ChamadaDao extends ChamadaDao {
  _$ChamadaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _chamadaInsertionAdapter = InsertionAdapter(
            database,
            'chamadas',
            (Chamada item) => <String, Object?>{
                  'id': item.id,
                  'data': _dateTimeConversor.encode(item.data),
                  'turma_id': item.turmaId
                },
            changeListener),
        _chamadaUpdateAdapter = UpdateAdapter(
            database,
            'chamadas',
            ['id'],
            (Chamada item) => <String, Object?>{
                  'id': item.id,
                  'data': _dateTimeConversor.encode(item.data),
                  'turma_id': item.turmaId
                },
            changeListener),
        _chamadaDeletionAdapter = DeletionAdapter(
            database,
            'chamadas',
            ['id'],
            (Chamada item) => <String, Object?>{
                  'id': item.id,
                  'data': _dateTimeConversor.encode(item.data),
                  'turma_id': item.turmaId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Chamada> _chamadaInsertionAdapter;

  final UpdateAdapter<Chamada> _chamadaUpdateAdapter;

  final DeletionAdapter<Chamada> _chamadaDeletionAdapter;

  @override
  Stream<List<Chamada>> assistirChamadasDaTurma(String turmaId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM chamadas WHERE turma_id = ?1 ORDER BY data DESC',
        mapper: (Map<String, Object?> row) => Chamada(
            row['id'] as String,
            _dateTimeConversor.decode(row['data'] as int),
            row['turma_id'] as String),
        arguments: [turmaId],
        queryableName: 'chamadas',
        isView: false);
  }

  @override
  Future<List<Chamada>> listarChamadasDaTurma(String turmaId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM chamadas WHERE turma_id = ?1 ORDER BY data DESC',
        mapper: (Map<String, Object?> row) => Chamada(
            row['id'] as String,
            _dateTimeConversor.decode(row['data'] as int),
            row['turma_id'] as String),
        arguments: [turmaId]);
  }

  @override
  Future<void> excluirChamadasDaTurma(String turmaId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM chamadas WHERE turma_id = ?1',
        arguments: [turmaId]);
  }

  @override
  Future<void> inserir(Chamada chamada) async {
    await _chamadaInsertionAdapter.insert(chamada, OnConflictStrategy.fail);
  }

  @override
  Future<void> inserirLista(List<Chamada> chamada) async {
    await _chamadaInsertionAdapter.insertList(chamada, OnConflictStrategy.fail);
  }

  @override
  Future<void> atualizar(Chamada chamada) async {
    await _chamadaUpdateAdapter.update(chamada, OnConflictStrategy.abort);
  }

  @override
  Future<void> excluir(Chamada chamada) async {
    await _chamadaDeletionAdapter.delete(chamada);
  }
}

class _$HorarioDao extends HorarioDao {
  _$HorarioDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _horarioInsertionAdapter = InsertionAdapter(
            database,
            'horarios',
            (Horario item) => <String, Object?>{
                  'id': item.id,
                  'dia_semana': item.diaSemana,
                  'hora': item.hora,
                  'sala': item.sala,
                  'turma_id': item.turmaId
                }),
        _horarioUpdateAdapter = UpdateAdapter(
            database,
            'horarios',
            ['id'],
            (Horario item) => <String, Object?>{
                  'id': item.id,
                  'dia_semana': item.diaSemana,
                  'hora': item.hora,
                  'sala': item.sala,
                  'turma_id': item.turmaId
                }),
        _horarioDeletionAdapter = DeletionAdapter(
            database,
            'horarios',
            ['id'],
            (Horario item) => <String, Object?>{
                  'id': item.id,
                  'dia_semana': item.diaSemana,
                  'hora': item.hora,
                  'sala': item.sala,
                  'turma_id': item.turmaId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Horario> _horarioInsertionAdapter;

  final UpdateAdapter<Horario> _horarioUpdateAdapter;

  final DeletionAdapter<Horario> _horarioDeletionAdapter;

  @override
  Future<List<Horario>> listarPorTurma(String turmaId) async {
    return _queryAdapter.queryList('SELECT * FROM horarios WHERE turma_id=?1',
        mapper: (Map<String, Object?> row) => Horario(
            row['id'] as String,
            row['dia_semana'] as String,
            row['hora'] as String,
            row['sala'] as String,
            row['turma_id'] as String),
        arguments: [turmaId]);
  }

  @override
  Future<void> inserir(Horario t) async {
    await _horarioInsertionAdapter.insert(t, OnConflictStrategy.abort);
  }

  @override
  Future<void> inserirLista(List<Horario> T) async {
    await _horarioInsertionAdapter.insertList(T, OnConflictStrategy.abort);
  }

  @override
  Future<void> atuaizar(Horario t) async {
    await _horarioUpdateAdapter.update(t, OnConflictStrategy.replace);
  }

  @override
  Future<void> atuaizarLista(List<Horario> t) async {
    await _horarioUpdateAdapter.updateList(t, OnConflictStrategy.replace);
  }

  @override
  Future<void> excluir(Horario t) async {
    await _horarioDeletionAdapter.delete(t);
  }

  @override
  Future<void> excluirLista(List<Horario> t) async {
    await _horarioDeletionAdapter.deleteList(t);
  }
}

// ignore_for_file: unused_element
final _dateTimeConversor = DateTimeConversor();
