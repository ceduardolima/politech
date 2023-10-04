// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chamada.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chamada _$ChamadaFromJson(Map<String, dynamic> json) => Chamada(
      json['id'] as String,
      DateTime.parse(json['data'] as String),
      json['turmaId'] as String,
    );

Map<String, dynamic> _$ChamadaToJson(Chamada instance) => <String, dynamic>{
      'id': instance.id,
      'data': instance.data.toIso8601String(),
      'turmaId': instance.turmaId,
    };
