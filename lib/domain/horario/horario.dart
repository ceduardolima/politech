import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'horario.g.dart';

@Entity(tableName: "horarios")
@JsonSerializable()
class Horario {
  @PrimaryKey(autoGenerate: false)
  late String id;
  @ColumnInfo(name: "dia_semana")
  String diaSemana;
  String hora;
  String sala;
  @ColumnInfo(name: "turma_id")
  String turmaId;

  Horario(this.id, this.diaSemana, this.hora, this.sala, this.turmaId);

  Horario.gen(this.diaSemana, this.hora, this.sala, this.turmaId) {
    id = const Uuid().v4().toString().replaceAll("-", "");
  }

  /// Transforma o Map na classe
  factory Horario.fromJson(Map<String, dynamic> json) =>
      _$HorarioFromJson(json);

  /// Transforma a classe em um Map
  Map<String, dynamic> toJson() => _$HorarioToJson(this);


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Horario &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          diaSemana == other.diaSemana &&
          hora == other.hora &&
          sala == other.sala &&
          turmaId == other.turmaId;

  @override
  int get hashCode =>
      id.hashCode ^
      diaSemana.hashCode ^
      hora.hashCode ^
      sala.hashCode ^
      turmaId.hashCode;
}