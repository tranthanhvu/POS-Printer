import 'package:pos_printer/model/enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'block.g.dart';

@JsonSerializable()
class Block {
  Block({
    this.content = '',
    this.type = POSType.text,
    this.align = POSAlign.left,
    this.font = POSFont.medium,
    this.fontWeight = POSFontWeight.normal,
    this.underline = POSUnderline.none,
    this.columnWidth = POSWidth.full,
  });

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'type')
  POSType type;

  @JsonKey(name: 'align')
  POSAlign align;

  @JsonKey(name: 'font')
  POSFont font;

  @JsonKey(name: 'weight')
  POSFontWeight fontWeight;

  @JsonKey(name: 'underline')
  POSUnderline underline;

  @JsonKey(name: 'width')
  POSWidth columnWidth;

  factory Block.fromJson(Map<String, dynamic> json) => _$BlockFromJson(json);
  Map<String, dynamic> toJson() => _$BlockToJson(this);
}
