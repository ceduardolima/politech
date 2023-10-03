import 'package:floor/floor.dart';
import 'package:politech/domain/aluno/aluno.dart';
import 'package:uuid/uuid.dart';

@Entity(tableName: "turmas", primaryKeys: [
  "id"
], foreignKeys: [
  ForeignKey(childColumns: ["aluno_id"], parentColumns: ["id"], entity: Aluno)
], indices: [
  Index(value: ["aluno_id"], unique: true)
])
class Turma {
  late final String id;
  @ColumnInfo(name: "aluno_id")
  final String alunoId;
  final String nome;

  Turma(this.id, this.alunoId, this.nome);

  Turma.genId(this.alunoId, this.nome) {
    id = const Uuid().v4().toString();
  }

  @override
  String toString() {
    return 'Turma{id: $id, alunoId: $alunoId, nome: $nome}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Turma && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
