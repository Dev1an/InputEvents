#if os(Linux)
	import Glibc
#elseif os(macOS)
	import Darwin
#endif

public enum KeyboardError: Error {
	case CannotOpen(fileDescriptor: String, reason: String),
	CannotRead(reason: String)
}

func errorString() -> String {
	return String(cString: strerror(errno))
}
