import 'package:json_annotation/json_annotation.dart';

enum POSType {
  @JsonValue('Text')
  text,
  @JsonValue('Linebreak')
  linebreak,
  @JsonValue('Divider')
  divider,
  @JsonValue('Image')
  image
}
enum POSAlign {
  @JsonValue('Left')
  left,
  @JsonValue('Right')
  right,
  @JsonValue('Center')
  center
}

enum POSFont {
  @JsonValue('Small')
  small,
  @JsonValue('Medium')
  medium,
  @JsonValue('Wide')
  wide,
  @JsonValue('Tall')
  tall,
  @JsonValue('Big')
  big
}

enum POSFontWeight {
  @JsonValue('Normal')
  normal,
  @JsonValue('Bold')
  bold
}

enum POSUnderline {
  @JsonValue('None')
  none,
  @JsonValue('Single')
  single,

  @JsonValue('DoubleStrike')
  doubleStrike
}

enum POSWidth {
  @JsonValue('Full')
  full,
  @JsonValue('Half')
  half
}
