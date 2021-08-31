inline fun <reified T : Enum<*>> enumValueOrNull(name: String): T? =
    T::class.java.enumConstants.firstOrNull { it.name == name }

enum class POSType {
    text,
    linebreak,
    divider,
    image
}

enum class POSAlign {
    left,
    right,
    center
}

enum class POSFont {
    small,
    medium,
    wide,
    tall,
    big
}

enum class POSFontWeight {
    normal,
    bold
}

enum class POSUnderline {
    none,
    single,
    doubleStrike
}

enum class POSWidth {
    full,
    half
}
