Note: this library only works in Linux since it is using <linux/input.h>

# Usage

```swift
import InputEvents

// Create a keyboard observer.
if let keyboard = try? InputEventCenter(devicePath: "/dev/input/event2") {
    keyboard.keyPressed = { print($0, "pressed") }
}

// Prevent the application from exiting immediately
import Dispatch
dispatchMain()
```
