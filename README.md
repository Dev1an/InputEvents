**Note:**
This library only catches events for
- function keys (F1 -> F12)
- arrows keys (up, down, left & right)
- space, escape keys

To catch the other keys' events:
1) Add an enumeration case ([here](https://github.com/Dev1an/InputEvents/blob/0750b8dca86a80945fc1b1a8a6ec2536d49627c6/Sources/Keys.swift#L12))
2) Add the keycode and its corresponding enumeration case to the following dictionaries:
   - [Linux keycode dictionary](https://github.com/Dev1an/InputEvents/blob/0750b8dca86a80945fc1b1a8a6ec2536d49627c6/Sources/Keys.swift#L24)
   - [macOS keycode dictionary](https://github.com/Dev1an/InputEvents/blob/0750b8dca86a80945fc1b1a8a6ec2536d49627c6/Sources/Keys.swift#L47)
3) Please contribute your additions by requesting a pull via a "Github pull request"

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
