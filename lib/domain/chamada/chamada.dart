import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:politech/domain/turma/turma.dart';
import 'package:uuid/uuid.dart';

part 'chamada.g.dart';

@Entity(tableName: "chamadas", primaryKeys: [
  "id"
], foreignKeys: [
  ForeignKey(childColumns: ["turma_id"], parentColumns: ["id"], entity: Turma)
])
@JsonSerializable()
class Chamada {
  late final String id;
  final DateTime data;
  @ColumnInfo(name: "turma_id")
  final String turmaId;

  Chamada(this.id, this.data, this.turmaId);

  Chamada.genId(this.data, this.turmaId) {
    id = const Uuid().v4().toString();
  }

  /// Transforma o Map na classe
  factory Chamada.fromJson(Map<String, dynamic> json) =>
      _$ChamadaFromJson(json);

  /// Transforma a classe em um Map
  Map<String, dynamic> toJson() => _$ChamadaToJson(this);

  @override
  String toString() {
    return 'Chamada{id: $id, data: $data, turmaId: $turmaId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Chamada && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
