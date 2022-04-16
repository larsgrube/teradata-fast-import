%dw 2.0

type guardError = String

fun guardWithDefaultOutput (fn, defaultOutput = null) = dw::Runtime::try(fn) match {
    case tr if (tr.success) -> tr.result
    else -> defaultOutput
}

fun guardWithErrorMessage (fn, errPrefix: String = "") = dw::Runtime::try(fn) match {
    case tr if (tr.success) -> tr.result
    else -> (errPrefix ++ $.error.message) as guardError
}
