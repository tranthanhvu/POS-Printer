package com.tokoin.pos_printer.model

import org.json.JSONObject

class Block(json: String): JSONObject(json) {
    val content: String = this.optString("content") ?: ""
    val align: POSAlign = enumValueOrNull(this.optString("align")) ?: POSAlign.Left
    val font: POSFont = enumValueOrNull(this.optString("font")) ?: POSFont.Medium
    val fontWeight: POSFontWeight = enumValueOrNull(this.optString("weight")) ?: POSFontWeight.Normal
    val underline: POSUnderline = enumValueOrNull(this.optString("underline")) ?: POSUnderline.None
    val columnWidth: POSWidth = enumValueOrNull(this.optString("width")) ?: POSWidth.Full
}