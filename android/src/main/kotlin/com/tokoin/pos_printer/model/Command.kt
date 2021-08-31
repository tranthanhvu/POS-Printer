package com.tokoin.pos_printer.model

import org.json.JSONObject

class Command(json: String): JSONObject(json) {
    var blocks: List<Block>? = this.optJSONArray(null)?.let { 0.until(it.length()).map { i -> it.optJSONObject(i) }}
        ?.map { Block(it.toString()) }
}