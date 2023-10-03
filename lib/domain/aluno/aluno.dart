import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:politech/domain/turma/turma.dart';
import 'package:uuid/uuid.dart';

part 'aluno.g.dart';

@Entity(tableName: "alunos", primaryKeys: [
  'id'
],foreignKeys: [
  ForeignKey(childColumns: ["turma_id"], parentColumns: ["id"], entity: Turma)
],
    indices: [
  Index(value: ["num_inscricao"], unique: true),
  Index(value: ["cpf"], unique: true)
])
@JsonSerializable()
class Aluno {
  late String id;
  @ColumnInfo(name: "num_inscricao")
  String numInscricao;
  @ColumnInfo(name: "turma_id")
  String turmaId;
  String nome;
  String cpf;

  Aluno(this.id, this.numInscricao, this.nome, this.cpf, this.turmaId);

  Aluno.genId(this.numInscricao, this.nome, this.cpf, this.turmaId) {
    id = const Uuid().v4().toString();
  }

  /// Transforma o Map na classe ALuno
  factory Aluno.fromJson(Map<String, dynamic> json) => _$AlunoFromJson(json);

  /// Transforma a classe aluno em um Map
  Map<String, dynamic> toJson() => _$AlunoToJson(this);

  @override
  String toString() {
    return 'Aluno{id: $id, incricao: $numInscricao, nome: $nome, cpf: $cpf, turmaId: $turmaId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Aluno && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
