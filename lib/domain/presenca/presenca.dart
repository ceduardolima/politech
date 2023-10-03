import 'dart:ffi';

import 'package:floor/floor.dart';
import 'package:politech/domain/aluno/aluno.dart';
import 'package:uuid/uuid.dart';

@Entity(tableName: "presencas", primaryKeys: [
  "id"
], foreignKeys: [
  ForeignKey(childColumns: ["aluno_id"], parentColumns: ["id"], entity: Aluno),
], indices: [
  Index(value: ["aluno_id"])
])
class Presenca {
  late final String id;
  @ColumnInfo(name: "aluno_id")
  final String alunoId;
  final bool presente;
  final int data;


  Presenca(this.id, this.alunoId, this.presente, this.data);

  Presenca.genId(this.alunoId, this.presente, this.data) {
    id = const Uuid().v4().toString();
  }

  @override
  String toString() {
    return 'Presenca{id: $id, alunoId: $alunoId, presenca: $presente}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Presenca && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}