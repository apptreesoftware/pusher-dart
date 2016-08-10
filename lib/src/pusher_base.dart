// Copyright (c) 2016, John Ryan. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

@JS()
library pusher;

import 'package:js/js.dart';

@JS()
class Pusher {
  external factory Pusher(String id, [Config config]);
  external Channel subscribe(String name);
  external void subscribeAll();
  external Channel channel(String name);
  external List<Channel> allChannels();
  external Pusher bind(String eventName, Function callback);
  external Pusher bind_all(Function callback);
  external void disconnect();
  external String get key;
  external Config get config;
  external dynamic get channels;
  external EventsDispatcher get global_emitter;
  external num get sessionId;
  external dynamic get timeline;
  external ConnectionManager get connection;
}

@JS()
class Config {

}

@JS()
class Channel {

}

@JS()
class AuthConfig {

}

@JS()
class EventsDispatcher {
  external EventsDispatcher bind(String eventName, [callback, dynamic context]);
  external EventsDispatcher bind_all(Function callback);
  external EventsDispatcher unbind(String eventName, [Function callback, dynamic context]);
  external EventsDispatcher unbind_all([String eventName, Function callback]);
  external EventsDispatcher emit(String eventName, [dynamic data]);
}

@JS()
class GenericEventsDispatcher<Self extends EventsDispatcher> extends EventsDispatcher {
  external bind(String eventName, [callback, dynamic context]);
  external bind_all(Function callback);
  external unbind(String eventName, [Function callback, dynamic context]);
  external unbind_all([String eventName, Function callback]);
  external emit(String eventName, [dynamic data]);
}

@JS()
class ConnectionManager extends GenericEventsDispatcher<ConnectionManager> {
  external String get key;
  external dynamic get options;
  external String get state;
  external dynamic get connection;
  external bool get encrypted;
  external dynamic get timeline;

  external ConnectionCallbacks get connectionCallbacks;
  external ErrorCallbacks get errorCallbacks;
  external HandshakeCallbacks get handshakeCallbacks;

  external void connect();
  external bool send(String data);
  external bool send_event(String name, String data, String channel);
  external void disconnect();
  external bool isEncrypted();
}

@JS()
class ConnectionCallbacks {
  external Function get message;
  external Function get ping;
  external Function get activity;
  external Function get error;
  external Function get closed;
}

@JS()
class ErrorCallbacks {
  external Function get ssl_only;
  external Function get refused;
  external Function get backoff;
  external Function get retry;
}

class HandshakeCallbacks {
  external Function get ssl_only;
  external Function get refused;
  external Function get backoff;
  external Function get retry;
  external Function get connected;
}
