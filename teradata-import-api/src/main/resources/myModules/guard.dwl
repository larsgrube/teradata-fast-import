%dw 2.0

fun guardWithDefaultOutput (fn, defaultOutput = null) = dw::Runtime::try(fn) match {
  case tr if (tr.success) -> tr.result
  else -> defaultOutput
}
