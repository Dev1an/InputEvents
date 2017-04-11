#if os(Linux)
	import Glibc
	import CLinuxInput
	
let keyEvent = UInt16(EV_KEY)
#elseif os(macOS)
	import Foundation
	import Carbon.HIToolbox
	
	func eventCallback(proxy: CGEventTapProxy, type: CGEventType, event: CGEvent, refcon: UnsafeMutableRawPointer?) -> Unmanaged<CGEvent>? {
		let center = Unmanaged<InputEventCenter>.fromOpaque(refcon!).takeUnretainedValue();
		if type == .keyDown, let key = Key(code: event.getIntegerValueField(.keyboardEventKeycode)) {
			center.keyPressed?(key)
		} else if type == .keyUp, let key = Key(code: event.getIntegerValueField(.keyboardEventKeycode)) {
			center.keyReleased?(key)
		}
		return Unmanaged.passRetained(event)
	}
#endif

import Dispatch

public typealias KeyEventHandler = ((Key) -> Void)

public class InputEventCenter {
	public var keyPressed:  KeyEventHandler?
	public var keyReleased: KeyEventHandler?
	public var keyRepeated: KeyEventHandler?
	
	public var couldNotRead: ((_ reason: String) -> Void)?
	
	let queue = DispatchQueue(label: "Input device event loop")
	
	public init(devicePath: String) throws {
		#if os(Linux)
			let device = open(devicePath, O_RDONLY)
			guard device != -1 else {
				throw KeyboardError.CannotOpen(
					fileDescriptor: devicePath,
					reason: errorString()
				)
			}
			
			queue.async {
				var event = input_event()
				while true {
					guard read(device, &event, MemoryLayout<input_event>.size) != -1 else {
						self.couldNotRead?(errorString())
						break
					}
					
					if event.type == keyEvent {
						let handler: KeyEventHandler?
						switch event.value {
						case 0:
							handler = self.keyReleased
						case 1:
							handler = self.keyPressed
						case 2:
							handler = self.keyRepeated
						default:
							handler = nil
						}
						if let key = Key(code: event.code) {
							handler?(key)
						}
					}
				}
			}
		#elseif os(macOS)
			queue.async {
				let center = UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque());
				let eventMask = (1 << CGEventType.keyDown.rawValue) | (1 << CGEventType.keyUp.rawValue)
				guard let eventTap = CGEvent.tapCreate(tap: .cgSessionEventTap,
				                                       place: .headInsertEventTap,
				                                       options: .defaultTap,
				                                       eventsOfInterest: CGEventMask(eventMask),
				                                       callback: eventCallback,
				                                       userInfo: center) else {
														print("failed to create event tap")
														exit(1)
				}

				let runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0)
				CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, .commonModes)
				CGEvent.tapEnable(tap: eventTap, enable: true)
				CFRunLoopRun()
			}
		#endif
	}
}
