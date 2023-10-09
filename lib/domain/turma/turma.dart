import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'turma.g.dart';

@Entity(
  tableName: "turmas",
  primaryKeys: ["id"],
)
@JsonSerializable()
class Turma {
  late final String id;
  final String codigo;
  final String nome;

  Turma(this.id, this.nome, this.codigo);

  Turma.genId(this.nome, this.codigo) {
    id = const Uuid().v4().toString();
  }
  /// Transforma o Map na classe turma
  factory Turma.fromJson(Map<String, dynamic> json) => _$TurmaFromJson(json);

  /// Transforma a classe turma em um Map
  Map<String, dynamic> toJson() => _$TurmaToJson(this);

  @override
  String toString() {
    return 'Turma{id: $id, nome: $nome}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Turma && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
