%dw 2.0
output application/json
import guardWithDefaultOutput as guard from myModules::guard
var payloadAttributes = payload.*attributes default [] map (value) -> {
    attributes: {
        key: value.key as String replace /\"/ with "",
        creationTimestamp: value.creationTimestamp,
        partition: value.partition,
        offset: value.offset,
        mule_correlation_id: correlationId
    }
}
var payloadValues = (payload.*payload default [] map (value, index) -> do {
    var jsonVal = guard(() -> read(value, "application/json"))
    ---
    value: if (jsonVal is Null) null else
    {
        orderNo: jsonVal.orderNo,
        orderDate: jsonVal.orderDate,
        customerNo: jsonVal.customerNo,
        itemNo: jsonVal.itemNo,
        itemDesc: jsonVal.itemDesc,
        orderState: jsonVal.orderState,
        lastUpdatedTS: jsonVal.lastUpdatedTS,
        mule_correlation_id: correlationId,
        row_number_by_payload: index 
    }
})
---
(payloadAttributes zip payloadValues) map (value) -> {
    attributes: value.attributes[0],
    value: value.value[0]
}