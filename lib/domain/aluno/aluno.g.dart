// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aluno.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Aluno _$AlunoFromJson(Map<String, dynamic> json) => Aluno(
      json['id'] as String,
      json['nome'] as String,
      json['turmaId'] as String,
    );

Map<String, dynamic> _$AlunoToJson(Aluno instance) => <String, dynamic>{
      'id': instance.id,
      'turmaId': instance.turmaId,
      'nome': instance.nome,
    };
