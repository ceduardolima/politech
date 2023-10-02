import 'package:floor/floor.dart';
import 'package:uuid/uuid.dart';

@Entity(tableName: "alunos", primaryKeys: [
  'id'
], indices: [
  Index(value: ["num_inscricao"], unique: true),
  Index(value: ["cpf"], unique: true)
])
class Aluno {
  late String id;
  @ColumnInfo(name: "num_inscricao")
  String numInscricao;
  String nome;
  String cpf;

  Aluno(this.id, this.numInscricao, this.nome, this.cpf);

  Aluno.genId(this.numInscricao, this.nome, this.cpf) {
    id = const Uuid().v4().toString();
  }

  @override
  String toString() {
    return 'Aluno{id: $id, incricao: $numInscricao, nome: $nome, cpf: $cpf}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Aluno && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
