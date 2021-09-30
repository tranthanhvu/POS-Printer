package com.tokoin.pos_printer.model

import org.json.JSONObject

class Command(json: String): JSONObject(json) {
    var blocks: List<Block> = this.optJSONArray("blocks")?.let { 0.until(it.length()).map { i -> it.optJSONObject(i) }}
        ?.map { Block(it.toString()) } ?: emptyList()
    val type: POSCommandType = enumValueOrNull(this.optString("type")) ?: POSCommandType.Text
}