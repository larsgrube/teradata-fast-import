%dw 2.0

fun guardWithDefaultOutput (fn, defaultOutput = null) = dw::Runtime::try(fn) match {
  case tr if (tr.success) -> tr.result
  else -> defaultOutput
}

fun createMultiStatementRequestFromArray(inPayload: Array, targetDatabase: String, targetTable: String, transactionId: String) =
(inPayload map (payload01, indexOfPayload01) -> {
	"sqlRequest": using (parameterList = payload01 pluck $$ map (payload02, indexOfPayload02) -> {
											"columnList": payload02,
											"valueList": if (payload01[payload02] is String) "'" ++ payload01[payload02] ++ "'"
														   else payload01[payload02] default "null"
										 }
						)	"INSERT INTO $(targetDatabase).$(targetTable) ("
							++ (parameterList.columnList joinBy ", ") ++ ", transaction_id"
							++ ") VALUES ("
							++ (parameterList.valueList joinBy ", ") ++ ", '$(transactionId)'"
							++ ")"
 }
).sqlRequest joinBy ";" ++ ";"


fun getParameterizedSQLStatementFromColumnList(columnList: Array, targetDatabase: String, targetTable: String, transactionId: String) =
using (parameterList = columnList map (payload02, indexOfPayload02) -> {
						"columnList": payload02,
						"valueList": ":" ++ payload02
					   }
	  )	"INSERT INTO $(targetDatabase).$(targetTable) ("
		++ (parameterList.columnList joinBy ", ") ++ ", transaction_id"
		++ ") VALUES ("
		++ (parameterList.valueList joinBy ", ") ++ ", '$(transactionId)'"
		++ ")"
