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
            'CREATE TABLE IF NOT EXISTS `alunos` (`id` TEXT NOT NULL, `num_inscricao` TEXT NOT NULL, `nome` TEXT NOT NULL, `cpf` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `presencas` (`id` TEXT NOT NULL, `aluno_id` TEXT NOT NULL, `presente` INTEGER NOT NULL, `data` INTEGER NOT NULL, FOREIGN KEY (`aluno_id`) REFERENCES `alunos` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `turmas` (`id` TEXT NOT NULL, `aluno_id` TEXT NOT NULL, `nome` TEXT NOT NULL, FOREIGN KEY (`aluno_id`) REFERENCES `alunos` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE UNIQUE INDEX `index_alunos_num_inscricao` ON `alunos` (`num_inscricao`)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_alunos_cpf` ON `alunos` (`cpf`)');
        await database.execute(
            'CREATE INDEX `index_presencas_aluno_id` ON `presencas` (`aluno_id`)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_turmas_aluno_id` ON `turmas` (`aluno_id`)');

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
}

class _$UsuarioDao extends UsuarioDao {
  _$UsuarioDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _usuarioInsertionAdapter = InsertionAdapter(
            database,
            'usuario',
            (Usuario item) => <String, Object?>{
                  'id': item.id,
                  'cpf': item.cpf,
                  'nome': item.nome,
                  'email': item.email
                }),
        _usuarioUpdateAdapter = UpdateAdapter(
            database,
            'usuario',
            ['id'],
            (Usuario item) => <String, Object?>{
                  'id': item.id,
                  'cpf': item.cpf,
                  'nome': item.nome,
                  'email': item.email
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Usuario> _usuarioInsertionAdapter;

  final UpdateAdapter<Usuario> _usuarioUpdateAdapter;

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
}

class _$AlunoDao extends AlunoDao {
  _$AlunoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _alunoInsertionAdapter = InsertionAdapter(
            database,
            'alunos',
            (Aluno item) => <String, Object?>{
                  'id': item.id,
                  'num_inscricao': item.numInscricao,
                  'nome': item.nome,
                  'cpf': item.cpf
                }),
        _alunoUpdateAdapter = UpdateAdapter(
            database,
            'alunos',
            ['id'],
            (Aluno item) => <String, Object?>{
                  'id': item.id,
                  'num_inscricao': item.numInscricao,
                  'nome': item.nome,
                  'cpf': item.cpf
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Aluno> _alunoInsertionAdapter;

  final UpdateAdapter<Aluno> _alunoUpdateAdapter;

  @override
  Future<List<Aluno>> listar() async {
    return _queryAdapter.queryList('SELECT * From alunos LIMIT 20',
        mapper: (Map<String, Object?> row) => Aluno(
            row['id'] as String,
            row['num_inscricao'] as String,
            row['nome'] as String,
            row['cpf'] as String));
  }

  @override
  Future<List<Aluno>> listarComLimite(int limite) async {
    return _queryAdapter.queryList('SELECT * From alunos LIMIT ?1',
        mapper: (Map<String, Object?> row) => Aluno(
            row['id'] as String,
            row['num_inscricao'] as String,
            row['nome'] as String,
            row['cpf'] as String),
        arguments: [limite]);
  }

  @override
  Future<Aluno?> procurarPorId(String id) async {
    return _queryAdapter.query('SELECT * From alunos WHERE id=?1',
        mapper: (Map<String, Object?> row) => Aluno(
            row['id'] as String,
            row['num_inscricao'] as String,
            row['nome'] as String,
            row['cpf'] as String),
        arguments: [id]);
  }

  @override
  Future<List<Aluno>> procurarPorNome(String nome) async {
    return _queryAdapter.queryList(
        'SELECT * FROM alunos WHERE nome LIKE ?1 LIMIT 20',
        mapper: (Map<String, Object?> row) => Aluno(
            row['id'] as String,
            row['num_inscricao'] as String,
            row['nome'] as String,
            row['cpf'] as String),
        arguments: [nome]);
  }

  @override
  Future<Aluno?> procurarPorInscricao(String inscricao) async {
    return _queryAdapter.query('SELECT * From alunos WHERE num_inscricao=?1',
        mapper: (Map<String, Object?> row) => Aluno(
            row['id'] as String,
            row['num_inscricao'] as String,
            row['nome'] as String,
            row['cpf'] as String),
        arguments: [inscricao]);
  }

  @override
  Future<void> inserir(Aluno aluno) async {
    await _alunoInsertionAdapter.insert(aluno, OnConflictStrategy.abort);
  }

  @override
  Future<void> atualizar(Aluno aluno) async {
    await _alunoUpdateAdapter.update(aluno, OnConflictStrategy.abort);
  }
}

class _$PresencaDao extends PresencaDao {
  _$PresencaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _presencaInsertionAdapter = InsertionAdapter(
            database,
            'presencas',
            (Presenca item) => <String, Object?>{
                  'id': item.id,
                  'aluno_id': item.alunoId,
                  'presente': item.presente ? 1 : 0,
                  'data': _dateTimeConversor.encode(item.data)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Presenca> _presencaInsertionAdapter;

  @override
  Future<List<Aluno>> listarAlunosPresentes() async {
    return _queryAdapter.queryList(
        'SELECT alunos.* FROM alunos LEFT JOIN presencas ON alunos.id = presencas.aluno_id WHERE presente = 1',
        mapper: (Map<String, Object?> row) => Aluno(
            row['id'] as String,
            row['num_inscricao'] as String,
            row['nome'] as String,
            row['cpf'] as String));
  }

  @override
  Future<List<Aluno>> listarAlunosFaltates() async {
    return _queryAdapter.queryList(
        'SELECT alunos.* FROM alunos LEFT JOIN presencas ON alunos.id = presencas.aluno_id WHERE presente = 0',
        mapper: (Map<String, Object?> row) => Aluno(
            row['id'] as String,
            row['num_inscricao'] as String,
            row['nome'] as String,
            row['cpf'] as String));
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
            _dateTimeConversor.decode(row['data'] as int)),
        arguments: [
          alunoId,
          _dateTimeConversor.encode(inicio),
          _dateTimeConversor.encode(fim),
          presente ? 1 : 0
        ]);
  }

  @override
  Future<void> inserir(Presenca presenca) async {
    await _presencaInsertionAdapter.insert(presenca, OnConflictStrategy.fail);
  }
}

class _$TurmaDao extends TurmaDao {
  _$TurmaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _turmaInsertionAdapter = InsertionAdapter(
            database,
            'turmas',
            (Turma item) => <String, Object?>{
                  'id': item.id,
                  'aluno_id': item.alunoId,
                  'nome': item.nome
                }),
        _turmaDeletionAdapter = DeletionAdapter(
            database,
            'turmas',
            ['id'],
            (Turma item) => <String, Object?>{
                  'id': item.id,
                  'aluno_id': item.alunoId,
                  'nome': item.nome
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Turma> _turmaInsertionAdapter;

  final DeletionAdapter<Turma> _turmaDeletionAdapter;

  @override
  Future<List<Aluno>> listarAlunos(String nomeDaTurma) async {
    return _queryAdapter.queryList(
        'SELECT alunos.* FROM turmas LEFT JOIN alunos ON alunos.id = turmas.aluno_id WHERE turmas.nome = ?1',
        mapper: (Map<String, Object?> row) => Aluno(row['id'] as String, row['num_inscricao'] as String, row['nome'] as String, row['cpf'] as String),
        arguments: [nomeDaTurma]);
  }

  @override
  Future<void> inserir(Turma turma) async {
    await _turmaInsertionAdapter.insert(turma, OnConflictStrategy.fail);
  }

  @override
  Future<void> excluir(Turma turma) async {
    await _turmaDeletionAdapter.delete(turma);
  }
}

// ignore_for_file: unused_element
final _dateTimeConversor = DateTimeConversor();
