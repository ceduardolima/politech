// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'turma.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Turma _$TurmaFromJson(Map<String, dynamic> json) => Turma(
      json['id'] as String,
      json['nome'] as String,
      json['codigo'] as String,
    );

Map<String, dynamic> _$TurmaToJson(Turma instance) => <String, dynamic>{
      'id': instance.id,
      'codigo': instance.codigo,
      'nome': instance.nome,
    };
