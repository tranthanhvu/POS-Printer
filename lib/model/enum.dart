import 'package:json_annotation/json_annotation.dart';

enum POSType {
  @JsonValue('TEXT')
  text,
  @JsonValue('LINEBREAK')
  linebreak,
  @JsonValue('DIVIDER')
  divider,
  @JsonValue('IMAGE')
  image
}
enum POSAlign {
  @JsonValue('LEFT')
  left,
  @JsonValue('RIGHT')
  right,
  @JsonValue('CENTER')
  center
}

enum POSFont {
  @JsonValue('SMALL')
  small,
  @JsonValue('MEDIUM')
  medium,
  @JsonValue('WIDE')
  wide,
  @JsonValue('TALL')
  tall,
  @JsonValue('BIG')
  big
}

enum POSFontWeight {
  @JsonValue('NORMAL')
  normal,
  @JsonValue('BOLD')
  bold
}

enum POSUnderline {
  @JsonValue('NONE')
  none,
  @JsonValue('SINGLE')
  single
}

enum POSWidth {
  @JsonValue('FULL')
  full,
  @JsonValue('HALF')
  half
}
