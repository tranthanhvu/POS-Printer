//package com.tokoin.pos_printer.model
//
//import android.os.Parcelable
//import com.google.gson.annotations.SerializedName
//import com.tokoin.pointofsale.utilites.DateFormatter
//import kotlinx.android.parcel.Parcelize
//import java.util.*
//
//@Parcelize
//class Receipt
//    (
//    @SerializedName("id")
//    var id: String? = null,
//    @SerializedName("order_id")
//    var orderId: String? = null,
//    @SerializedName("sale_number")
//    var saleNumber: String? = null,
//    @SerializedName("store_id")
//    var storeId: String? = null,
//    @SerializedName("ticket_name")
//    var ticketName: String? = null,
//    @SerializedName("created_by")
//    var createdBy: String? = null,
//    @SerializedName("employee_name")
//    var employeeName: String? = null,
//    @SerializedName("discounted_amount")
//    var discountedAmount: Double = 0.0,
//    @SerializedName("net_amount")
//    var netAmount: Double = 0.0,
//    @SerializedName("gross_amount")
//    var grossAmount: Double = 0.0,
//    @SerializedName("tax_amount")
//    var taxAmount: Double = 0.0,
//    @SerializedName("pos_id")
//    var posId: Long? = null,
//    @SerializedName("pos_name")
//    var posName: String? = null,
//    @SerializedName("receipt_number")
//    var receiptNumber: Long? = null,
//    @SerializedName("customer_id")
//    var customerId: String? = null,
//    @SerializedName("customer_name")
//    var customerName: String? = null,
//    @SerializedName("customer_phone_number")
//    var customerPhoneNumber: String? = null,
//    @SerializedName("items")
//    var items: ArrayList<SaleItem>? = null,
//    @SerializedName("discounts")
//    var discounts: ArrayList<Discount>? = null,
//    @SerializedName("payments")
//    var payments: ArrayList<SplitPayment>? = null,
//    @SerializedName("email")
//    var email: String? = null,
//    @SerializedName("email_receipt")
//    var emailReceipt: Boolean = false,
//    @SerializedName("mobile")
//    var mobile: String? = null,
//    @SerializedName("mobile_receipt")
//    var mobileReceipt: Boolean = false,
//    @SerializedName("is_sync")
//    var isSync: Boolean = true,
//    @SerializedName("receipt_date")
//    var receiptDate: String? = null,
//    @SerializedName("refund_number")
//    var refundNumber: String? = null,
//    @SerializedName("refund")
//    var refund: Boolean = false,
//    @SerializedName("dining_option_id")
//    var diningOptionId: String? = null,
//    @SerializedName("dining_option_name")
//    var diningOptionName: String? = null,
//    @SerializedName("shift_number")
//    var shiftNumber: String? = null,
//    @SerializedName("discount_receipt_list")
//    var discountReceiptList: String? = null,
//    @SerializedName("tax_receipt_list")
//    var taxReceiptList: String? = null,
//    @SerializedName("sale_id")
//    var saleId: String? = null,
//    @SerializedName("note")
//    var note: String? = null,
//    @SerializedName("status")
//    var status: String? = null,
//    @SerializedName("shipping_address")
//    var shippingAddress: CustomerAddress? = null,
//    @SerializedName("online_order")
//    var online_order: OnlineOrder? = null,
//    @SerializedName("is_online_order")
//    var isOnlineOrder: Boolean = false,
//    @SerializedName("additionalCosts")
//    var additionalCosts: ArrayList<AdditionalCost> = ArrayList<AdditionalCost>()
//) : Parcelable, Cloneable {
//}