import Glibc
import CLinuxInput

var event = input_event()
let keyboard = "/dev/input/event2"
var device = open(keyboard, O_RDONLY)
guard device != -1 else {
	throw KeyboardError.CannotOpen(
		fileDescriptor: keyboard,
		reason: errorString()
	)
}

while true {
	guard read(device, &event, MemoryLayout<input_event>.size) != -1 else {
		throw KeyboardError.CannotRead(reason: errorString())
	}

	print(event.code)
}
