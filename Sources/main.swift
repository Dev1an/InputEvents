import Glibc
import CLinuxInput

let keyEvent = UInt16(EV_KEY)

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
	
	if event.type == keyEvent {
		print(event.code, terminator: " ")
		switch event.value {
		case 0:
			print("released")
		case 1:
			print("pressed")
		case 2:
			print("automatically repeated")
		default:
			print("unknown action")
		}
	}
}
