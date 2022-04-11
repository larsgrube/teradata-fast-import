%dw 2.0
output application/java
import divideBy as divBy from dw::core::Arrays
---
(vars.batchMessagePayload filter not ($.value is Null)) divBy 100