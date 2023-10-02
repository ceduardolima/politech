// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usuario _$UsuarioFromJson(Map<String, dynamic> json) => Usuario(
      json['id'] as String,
      json['cpf'] as String,
      json['nome'] as String,
      json['email'] as String,
    );

Map<String, dynamic> _$UsuarioToJson(Usuario instance) => <String, dynamic>{
      'id': instance.id,
      'cpf': instance.cpf,
      'nome': instance.nome,
      'email': instance.email,
    };
