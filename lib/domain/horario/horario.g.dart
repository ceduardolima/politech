// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Horario _$HorarioFromJson(Map<String, dynamic> json) => Horario(
      json['id'] as String,
      json['diaSemana'] as String,
      json['hora'] as String,
      json['sala'] as String,
      json['turmaId'] as String,
    );

Map<String, dynamic> _$HorarioToJson(Horario instance) => <String, dynamic>{
      'id': instance.id,
      'diaSemana': instance.diaSemana,
      'hora': instance.hora,
      'sala': instance.sala,
      'turmaId': instance.turmaId,
    };
