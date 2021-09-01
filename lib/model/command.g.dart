// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Command _$CommandFromJson(Map<String, dynamic> json) {
  return Command(
    blocks: (json['blocks'] as List<dynamic>)
        .map((e) => Block.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CommandToJson(Command instance) => <String, dynamic>{
      'blocks': instance.blocks.map((e) => e.toJson()).toList(),
    };
