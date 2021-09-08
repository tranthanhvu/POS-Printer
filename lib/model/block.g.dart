// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Block _$BlockFromJson(Map<String, dynamic> json) {
  return Block(
    content: json['content'] as String,
    align: _$enumDecode(_$POSAlignEnumMap, json['align']),
    font: _$enumDecode(_$POSFontEnumMap, json['font']),
    fontWeight: _$enumDecode(_$POSFontWeightEnumMap, json['weight']),
    underline: _$enumDecode(_$POSUnderlineEnumMap, json['underline']),
    columnWidth: _$enumDecode(_$POSWidthEnumMap, json['width']),
  );
}

Map<String, dynamic> _$BlockToJson(Block instance) => <String, dynamic>{
      'content': instance.content,
      'align': _$POSAlignEnumMap[instance.align],
      'font': _$POSFontEnumMap[instance.font],
      'weight': _$POSFontWeightEnumMap[instance.fontWeight],
      'underline': _$POSUnderlineEnumMap[instance.underline],
      'width': _$POSWidthEnumMap[instance.columnWidth],
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

const _$POSAlignEnumMap = {
  POSAlign.left: 'Left',
  POSAlign.right: 'Right',
  POSAlign.center: 'Center',
};

const _$POSFontEnumMap = {
  POSFont.small: 'Small',
  POSFont.medium: 'Medium',
  POSFont.wide: 'Wide',
  POSFont.tall: 'Tall',
  POSFont.big: 'Big',
};

const _$POSFontWeightEnumMap = {
  POSFontWeight.normal: 'Normal',
  POSFontWeight.bold: 'Bold',
};

const _$POSUnderlineEnumMap = {
  POSUnderline.none: 'None',
  POSUnderline.single: 'Single',
  POSUnderline.doubleStrike: 'DoubleStrike',
};

const _$POSWidthEnumMap = {
  POSWidth.full: 'Full',
  POSWidth.half: 'Half',
};
