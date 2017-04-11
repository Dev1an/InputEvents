#if os(Linux)
	import CLinuxInput
	typealias KeyCode = Int32
#elseif os(macOS)
	import Carbon.HIToolbox
	typealias KeyCode = Int
#endif

public enum Key {
	case f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12,
	downArrow, upArrow, leftArrow, rightArrow,
	space, escape
	
	init?(rawValue: KeyCode) {
		if let key = keyMap[rawValue] {
			self = key
		} else {
			return nil
		}
	}
}

#if os(Linux)
	let keyMap: [KeyCode: Key] = [
		KEY_F1: .f1,
		KEY_F2: .f2,
		KEY_F3: .f3,
		KEY_F4: .f4,
		KEY_F5: .f5,
		KEY_F6: .f6,
		KEY_F7: .f7,
		KEY_F8: .f8,
		KEY_F9: .f9,
		KEY_F10: .f10,
		KEY_F11: .f11,
		KEY_F12: .f12,
		
		KEY_UP: .upArrow,
		KEY_DOWN: .downArrow,
		KEY_LEFT: .leftArrow,
		KEY_RIGHT: .rightArrow,
		
		KEY_SPACE: .space,
		KEY_ESC: .escape
	]
#elseif os(macOS)
	let keyMap: [KeyCode: Key] = [
		kVK_F1: .f1,
		kVK_F2: .f2,
		kVK_F3: .f3,
		kVK_F4: .f4,
		kVK_F5: .f5,
		kVK_F6: .f6,
		kVK_F7: .f7,
		kVK_F8: .f8,
		kVK_F9: .f9,
		kVK_F10: .f10,
		kVK_F11: .f11,
		kVK_F12: .f12,
		
		kVK_DownArrow: .downArrow,
		kVK_UpArrow: .upArrow,
		kVK_LeftArrow: .leftArrow,
		kVK_RightArrow: .rightArrow,
		
		kVK_Space: .space,
		kVK_Escape: .escape
	]
#endif
