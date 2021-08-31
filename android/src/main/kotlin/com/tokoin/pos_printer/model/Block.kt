package com.tokoin.pos_printer.model

import POSAlign
import POSFont
import POSFontWeight
import POSType
import POSUnderline
import POSWidth
import enumValueOrNull
import org.json.JSONObject

class Block(json: String): JSONObject(json) {
    val content: String = this.optString("content") ?: ""
    val type: POSType = enumValueOrNull(this.optString("type")) ?: POSType.text
    val align: POSAlign = enumValueOrNull(this.optString("align")) ?: POSAlign.left
    val font: POSFont = enumValueOrNull(this.optString("font")) ?: POSFont.medium
    val fontWeight: POSFontWeight = enumValueOrNull(this.optString("weight")) ?: POSFontWeight.normal
    val underline: POSUnderline = enumValueOrNull(this.optString("underline")) ?: POSUnderline.none
    val columnWidth: POSWidth = enumValueOrNull(this.optString("width")) ?: POSWidth.full
}