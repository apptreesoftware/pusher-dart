# pusher

A Dart wrapper for Pusher.js

## Usage

```dart
import 'package:pusher_js/pusher_js.dart';

main() {
  var socket = new Pusher('0eb73a235dd03b3df71a');
  socket.connection.bind('connected', allowInterop((data) {
    print('Connected to Pusher!');
  }));
}
```

Note: callbacks should be wrapped in `allowInterop()`. 

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://github.com/johnpryan/pusher-dart/issues
