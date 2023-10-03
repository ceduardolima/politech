import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
part 'usuario.g.dart';

/// Entidade da tabela de dados. Essa classe será usada para inserir dados na tabela
/// usuario, além de poder manipular os dados contidos nela.
@Entity(tableName: "usuario")
@JsonSerializable()
class Usuario {
  @PrimaryKey(autoGenerate: false)
  late String id;
  String cpf;
  String nome;
  String email;

  Usuario(this.id, this.cpf, this.nome, this.email);

  Usuario.genId(this.cpf, this.nome, this.email) {
    id = const Uuid().v4().toString();
  }

  /// Transforma o Map na classe Usuario
  factory Usuario.fromJson(Map<String, dynamic> json) => _$UsuarioFromJson(json);

  /// Transforma a classe usuário em um Map
  Map<String, dynamic> toJson() => _$UsuarioToJson(this);

  @override
  String toString() {
    return 'Usuario{id: $id, cpf: $cpf, nome: $nome, email: $email}';
  }
  
  /// Realiza a operação de igual. Por exemplo: usuario1 == usuario2. Essa condição
  /// será verdadeira se os id forem iguais
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Usuario && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}