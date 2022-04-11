%dw 2.0
output application/json
import guardWithDefaultOutput as guard from myModules::guard
var jsonVal = guard(() -> read(payload, "application/json"))
---
{
    attributes: {
        key: attributes.key as String replace /\"/ with "",
        creationTimestamp: attributes.creationTimestamp,
        partition: attributes.partition,
        offset: attributes.offset,
        mule_correlation_id: correlationId
    },
    value: if (jsonVal is Null) null else {
        orderNo: jsonVal.orderNo,
        orderDate: jsonVal.orderDate,
        customerNo: jsonVal.customerNo,
        itemNo: jsonVal.itemNo,
        itemDesc: jsonVal.itemDesc,
        orderState: jsonVal.orderState,
        lastUpdatedTS: jsonVal.lastUpdatedTS,
        mule_correlation_id: correlationId
    }
}