import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:politech/domain/turma/turma.dart';
import 'package:uuid/uuid.dart';

part 'aluno.g.dart';

@Entity(
  tableName: "alunos",
  primaryKeys: ['id'],
  foreignKeys: [
    ForeignKey(childColumns: ["turma_id"], parentColumns: ["id"], entity: Turma)
  ],
)
@JsonSerializable()
class Aluno {
  late String id;
  @ColumnInfo(name: "turma_id")
  String turmaId;
  String nome;

  Aluno(this.id, this.nome, this.turmaId);

  Aluno.genId(this.nome, this.turmaId) {
    id = const Uuid().v4().toString();
  }

  /// Transforma o Map na classe ALuno
  factory Aluno.fromJson(Map<String, dynamic> json) => _$AlunoFromJson(json);

  /// Transforma a classe aluno em um Map
  Map<String, dynamic> toJson() => _$AlunoToJson(this);

  @override
  String toString() {
    return 'Aluno{id: $id, nome: $nome, turmaId: $turmaId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Aluno && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
