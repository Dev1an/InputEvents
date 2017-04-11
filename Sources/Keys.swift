#if os(Linux)
	import CLinuxInput
	typealias KeyCode = UInt16
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
		KeyCode(KEY_F1): .f1,
		KeyCode(KEY_F2): .f2,
		KeyCode(KEY_F3): .f3,
		KeyCode(KEY_F4): .f4,
		KeyCode(KEY_F5): .f5,
		KeyCode(KEY_F6): .f6,
		KeyCode(KEY_F7): .f7,
		KeyCode(KEY_F8): .f8,
		KeyCode(KEY_F9): .f9,
		KeyCode(KEY_F10): .f10,
		KeyCode(KEY_F11): .f11,
		KeyCode(KEY_F12): .f12,
		
		KeyCode(KEY_UP): .upArrow,
		KeyCode(KEY_DOWN): .downArrow,
		KeyCode(KEY_LEFT): .leftArrow,
		KeyCode(KEY_RIGHT): .rightArrow,
		
		KeyCode(KEY_SPACE): .space,
		KeyCode(KEY_ESC): .escape
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
