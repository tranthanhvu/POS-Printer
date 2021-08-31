import 'package:pos_printer/model/block.dart';
import 'package:pos_printer/model/enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'command.g.dart';

@JsonSerializable()
class Command {
  Command({
    required this.blocks,
  });

  List<Block> blocks;

  factory Command.fromJson(Map<String, dynamic> json) =>
      _$CommandFromJson(json);
  Map<String, dynamic> toJson() => _$CommandToJson(this);

  factory Command.text({
    required String content,
    POSAlign align = POSAlign.left,
    POSFont font = POSFont.medium,
    POSFontWeight fontWeight = POSFontWeight.normal,
    POSUnderline underline = POSUnderline.none,
  }) {
    return Command(blocks: [
      Block(
        content: content,
        align: align,
        font: font,
        fontWeight: fontWeight,
        underline: underline,
      ),
      Block(type: POSType.linebreak),
    ]);
  }

  factory Command.kv({
    required String key,
    required String value,
  }) {
    return Command(blocks: [
      Block(content: key, align: POSAlign.left, columnWidth: POSWidth.half),
      Block(content: key, align: POSAlign.right, columnWidth: POSWidth.half),
      Block(type: POSType.linebreak),
    ]);
  }

  factory Command.image({required String imgContent}) {
    return Command(blocks: [
      Block(
        content: imgContent,
        align: POSAlign.center,
      ),
      Block(type: POSType.linebreak),
    ]);
  }

  factory Command.br() {
    return Command(blocks: [
      Block(type: POSType.linebreak),
    ]);
  }

  factory Command.divider() {
    return Command(blocks: [
      Block(type: POSType.divider),
    ]);
  }
}
