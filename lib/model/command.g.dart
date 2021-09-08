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
    type: _$enumDecode(_$POSCommandTypeEnumMap, json['type']),
  );
}

Map<String, dynamic> _$CommandToJson(Command instance) => <String, dynamic>{
      'blocks': instance.blocks.map((e) => e.toJson()).toList(),
      'type': _$POSCommandTypeEnumMap[instance.type],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$POSCommandTypeEnumMap = {
  POSCommandType.text: 'Text',
  POSCommandType.keyValue: 'KeyValue',
  POSCommandType.linebreak: 'Linebreak',
  POSCommandType.divider: 'Divider',
  POSCommandType.image: 'Image',
};
