import 'package:floor/floor.dart';
import 'package:politech/domain/aluno/aluno.dart';
import 'package:uuid/uuid.dart';

@Entity(
  tableName: "turmas",
  primaryKeys: ["id"],
)
class Turma {
  late final String id;
  final String nome;

  Turma(this.id, this.nome);

  Turma.genId(this.nome) {
    id = const Uuid().v4().toString();
  }

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
