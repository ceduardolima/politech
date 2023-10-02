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

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
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

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UsuarioDao get usuarioDao {
    return _usuarioDaoInstance ??= _$UsuarioDao(database, changeListener);
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
  Future<List<Usuario?>> listarComLimite(int limite) async {
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
  Future<List<Usuario?>> procurarPorNome(String nome) async {
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
    await _usuarioInsertionAdapter.insert(usuario, OnConflictStrategy.abort);
  }

  @override
  Future<void> atualizar(Usuario usuario) async {
    await _usuarioUpdateAdapter.update(usuario, OnConflictStrategy.abort);
  }
}
