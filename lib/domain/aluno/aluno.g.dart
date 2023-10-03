// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aluno.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Aluno _$AlunoFromJson(Map<String, dynamic> json) => Aluno(
      json['id'] as String,
      json['numInscricao'] as String,
      json['nome'] as String,
      json['cpf'] as String,
      json['turmaId'] as String,
    );

Map<String, dynamic> _$AlunoToJson(Aluno instance) => <String, dynamic>{
      'id': instance.id,
      'numInscricao': instance.numInscricao,
      'turmaId': instance.turmaId,
      'nome': instance.nome,
      'cpf': instance.cpf,
    };
