import java.util.*

inline fun <reified T : Enum<*>> enumValueOrNull(name: String): T? =
    T::class.java.enumConstants.firstOrNull { it.name.equals(name, ignoreCase = true) }

enum class POSType {
    Text,
    Linebreak,
    Divider,
    Image
}

enum class POSAlign {
    Left,
    Right,
    Center
}

enum class POSFont {
    Small,
    Medium,
    Wide,
    Tall,
    Big
}

enum class POSFontWeight {
    Normal,
    Bold
}

enum class POSUnderline {
    None,
    Single,
    DoubleStrike
}

enum class POSWidth {
    Full,
    Half
}
