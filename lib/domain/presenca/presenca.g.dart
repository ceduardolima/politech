// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presenca.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Presenca _$PresencaFromJson(Map<String, dynamic> json) => Presenca(
      json['id'] as String,
      json['alunoId'] as String,
      json['presente'] as bool,
      DateTime.parse(json['data'] as String),
      json['chamadaId'] as String,
    );

Map<String, dynamic> _$PresencaToJson(Presenca instance) => <String, dynamic>{
      'id': instance.id,
      'alunoId': instance.alunoId,
      'chamadaId': instance.chamadaId,
      'presente': instance.presente,
      'data': instance.data.toIso8601String(),
    };
