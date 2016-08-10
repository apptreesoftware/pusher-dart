import 'package:pusher_js/pusher_js.dart';
import 'dart:js';
import 'dart:html';
import 'dart:async';

main() {
  var socket = new Pusher('0eb73a235dd03b3df71a');
  var nextConnectionAttempt = null;
  socket.connection.bind('connecting_in', allowInterop((delay) {
    updateLight('amber');
    updateControls('connect');
    if (delay > 0) {
      var dur = new Duration(milliseconds: delay);
      nextConnectionAttempt = new DateTime.now().add(dur);
      handleAmberDelay(nextConnectionAttempt);
    }
  }));

  socket.connection.bind('connecting',allowInterop((data) {
    updateLight('amber');
    updateControls('connect');
  }));

  socket.connection.bind('connected', allowInterop((data) {
    resetAmber();
    updateLight('green');
    updateControls('disconnect');
  }));

  socket.connection.bind('disconnected', allowInterop((data) {
    updateLight('red');
    updateControls('connect');
  }));

  querySelector('#connect').onClick.listen((evt) {
    socket.connection.connect();
  });

  querySelector('#disconnect').onClick.listen((evt) {
    socket.connection.disconnect();
  });
}

var lights = ['red', 'amber', 'green'];

updateLight(light) {
  for (var i = 0; i < lights.length; i++) {
    if (lights[i] != light) {
      querySelector("#" + lights[i] + 'on').style.display = 'none';
      querySelector("#" + lights[i] + 'off').style.display = '';
    } else {
      querySelector("#" + lights[i] + 'on').style.display = '';
      querySelector("#" + lights[i] + 'off').style.display = 'none';
    }
  }
}

handleAmberDelay(DateTime nextConnectionAttempt) {
  updateAndSetTimer(nextConnectionAttempt);
}

updateAndSetTimer(DateTime nextConnectionAttempt) {
  var diff = new DateTime.now().difference(nextConnectionAttempt);

  new Future.delayed(diff).then((_) {
    var countdown = nextConnectionAttempt.difference(new DateTime.now());
    if (countdown >= 0) {
      querySelector("#amberon").innerHtml = countdown.toString();
    }
    updateAndSetTimer(nextConnectionAttempt);
  });
}

resetAmber() {
  querySelector("#amberon").innerHtml = "";
}

var controls = ['connect', 'disconnect'];
updateControls(addControl) {
  for (var i = 0; i < controls.length; i++)
    if (controls[i] == addControl) {
      querySelector("#" + controls[i]).style.display = '';
    } else {
      querySelector("#" + controls[i]).style.display = 'none';
    }
}
