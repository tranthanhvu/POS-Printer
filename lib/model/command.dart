import 'package:pos_printer/model/block.dart';
import 'package:pos_printer/model/enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'command.g.dart';

@JsonSerializable(explicitToJson: true)
class Command {
  Command({
    required this.blocks,
    required this.type,
  });

  @JsonKey(name: 'blocks')
  List<Block> blocks;

  @JsonKey(name: 'type')
  POSCommandType type;

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
    return Command(
      type: POSCommandType.text,
      blocks: [
        Block(
          content: content,
          align: align,
          font: font,
          fontWeight: fontWeight,
          underline: underline,
        ),
      ],
    );
  }

  factory Command.kv({
    required String key,
    required String value,
  }) {
    return Command(
      type: POSCommandType.keyValue,
      blocks: [
        Block(content: key, align: POSAlign.left, columnWidth: POSWidth.half),
        Block(
            content: value, align: POSAlign.right, columnWidth: POSWidth.half),
      ],
    );
  }

  factory Command.image({required String imgContent}) {
    return Command(
      type: POSCommandType.image,
      blocks: [
        Block(
          content: imgContent,
          align: POSAlign.center,
        ),
      ],
    );
  }

  factory Command.hr() {
    return Command(
      type: POSCommandType.linebreak,
      blocks: [],
    );
  }

  factory Command.divider() {
    return Command(
      type: POSCommandType.divider,
      blocks: [],
    );
  }
}
