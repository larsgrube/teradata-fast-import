%dw 2.0
output application/json
import * from dw::core::Strings
---
(1 to (vars.payloadSize default 1)) as Array map (value) -> {
    key: uuid(),
    value: {
        "orderNo": randomInt(899999999) + 100000000,
        "orderDate": ((randomInt(24) + 2000) ++ "-" ++ ((randomInt(11) + 1) as String {format: "00"}) ++ "-" ++ ((randomInt(27) + 1) as String {format: "00"})) as Date + |P3D|,
        "customerNo": randomInt(899999999) + 100000000,
        "itemNo": if (vars.includeNullValues and ((value mod 1000) == 1)) null else randomInt(899999999) + 100000000,
        "itemDesc": if ((value mod 2) != 0) "Hoodie" else "T-Shirt",
        "orderState": if ((value mod 2) != 0) "In Progress" else "Shipped",
        "lastUpdatedTS": ((randomInt(24) + 2000) ++ "-" ++ ((randomInt(11) + 1) as String {format: "00"}) ++ "-" ++ ((randomInt(27) + 1) as String {format: "00"})) as Date + |P3D| ++ " " ++ randomInt(23) as String {format: "00"} ++ ":" ++ randomInt(59) as String {format: "00"} ++ ":" ++ randomInt(23) as String {format: "00"} ++ "." ++ randomInt(999) as String {format: "000"}
    }
}