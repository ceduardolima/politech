import 'dart:ffi';

import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:politech/domain/aluno/aluno.dart';
import 'package:politech/domain/turma/turma.dart';
import 'package:uuid/uuid.dart';

import '../chamada/chamada.dart';

part 'presenca.g.dart';

@Entity(tableName: "presencas", primaryKeys: [
  "id"
], foreignKeys: [
  ForeignKey(childColumns: ["aluno_id"], parentColumns: ["id"], entity: Aluno),
  ForeignKey(
      childColumns: ["chamada_id"], parentColumns: ["id"], entity: Chamada)
], indices: [
  Index(value: ["aluno_id"])
])
@JsonSerializable()
class Presenca {
  late final String id;
  @ColumnInfo(name: "aluno_id")
  final String alunoId;
  @ColumnInfo(name: "chamada_id")
  final String chamadaId;
  final bool presente;
  final DateTime data;

  Presenca(this.id, this.alunoId, this.presente, this.data, this.chamadaId);

  Presenca.genId(this.alunoId, this.presente, this.data, this.chamadaId) {
    id = const Uuid().v4().toString();
  }

  /// Transforma o Map na classe presenca
  factory Presenca.fromJson(Map<String, dynamic> json) =>
      _$PresencaFromJson(json);

  /// Transforma a classe presenca em um Map
  Map<String, dynamic> toJson() => _$PresencaToJson(this);


  @override
  String toString() {
    return 'Presenca{id: $id, alunoId: $alunoId, chamadaId: $chamadaId, presente: $presente, data: $data}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Presenca && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
