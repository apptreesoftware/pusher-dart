// Copyright (c) 2016, John Ryan. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

@JS()
library pusher_js_base;

import 'package:js/js.dart';
import 'dart:js';

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

@anonymous
@JS()
class Config {
/**
 * Forces the connection to use encrypted transports.
 */
  external set encrypted(bool value);

/**
 * Endpoint on your server that will return the authentication signature needed for private channels.
 */
  external set authEndpoint(String value);

/**
 * Defines how the authentication endpoint, defined using authEndpoint, will be called.
 * There are two options available: ajax and jsonp.
 */
  external set authTransport(String value);

/**
 * Allows passing additional data to authorizers. Supports query string params and headers (AJAX only).
 * For example, following will pass foo=bar via the query string and baz: boo via headers:
 */
  external set auth(AuthConfig value);

/**
 * Allows connecting to a different datacenter by setting up correct hostnames and ports for the connection.
 */
  external set cluster(String value);

/**
 * Disables stats collection, so that connection metrics are not submitted to Pusher’s servers.
 */
  external set disableStats(bool value);

/**
 * Specifies which transports should be used by Pusher to establish a connection.
 * Useful for applications running in controlled, well-behaving environments.
 * Available transports: ws, wss, xhr_streaming, xhr_polling, sockjs.
 * Additional transports may be added in the future and without adding them to this list, they will be disabled.
 */
  external set enabledTransports(List<String> value);

/**
 * Specified which transports must not be used by Pusher to establish a connection.
 * This settings overwrites transports whitelisted via the enabledTransports options.
 * Available transports: ws, wss, xhr_streaming, xhr_polling, sockjs.
 * Additional transports may be added in the future and without adding them to this list, they will be enabled.
 */
  external set disabledTransports(List<String> value);

/**
 * Ignores null origin checks for HTTP fallbacks. Use with care, it should be disabled only if necessary (i.e. PhoneGap).
 */
  external set ignoreNullOrigin(bool value);

/**
 * After this time (in miliseconds) without any messages received from the server,
 * a ping message will be sent to check if the connection is still working.
 * Default value is is supplied by the server, low values will result in unnecessary traffic.
 */
  external set activityTimeout(num value);

/**
 * Time before the connection is terminated after sending a ping message.
 * Default is 30000 (30s). Low values will cause false disconnections, if latency is high.
 */
  external set pongTimeout(num value);

  external set wsHost(String value);
  external set wsPort(num value);
  external set wssPort(num value);
  external set httpHost(String value);
  external set httpPort(num value);
  external set httpsPort(num value);
}

@anonymous
@JS()
class AuthConfig {
  external set params(JsObject value);
  external set headers(JsObject value);
}

@anonymous
@JS()
class Channel extends GenericEventsDispatcher<Channel> {
  /** Triggers an event */
  external bool trigger(String eventName, data);

  external Pusher get pusher;
  external String get name;
  external bool get subscribed;
  /**
   * Authenticates the connection as a member of the channel.
   * @param  {String} socketId
   * @param  {Function} callback
   */
  external void authorize(String socketId, Function callback);
}


@JS()
class EventsDispatcher {
  external EventsDispatcher bind(String eventName, [callback, dynamic context]);
  external EventsDispatcher bind_all(Function callback);
  external EventsDispatcher unbind(String eventName,
      [Function callback, dynamic context]);
  external EventsDispatcher unbind_all([String eventName, Function callback]);
  external EventsDispatcher emit(String eventName, [dynamic data]);
}

@JS()
class GenericEventsDispatcher<Self extends EventsDispatcher>
    extends EventsDispatcher {
  external bind(String eventName, [callback, dynamic context]);
  external bind_all(Function callback);
  external unbind(String eventName, [Function callback, dynamic context]);
  external unbind_all([String eventName, Function callback]);
  external emit(String eventName, [data]);
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

@JS()
class HandshakeCallbacks {
  external Function get ssl_only;
  external Function get refused;
  external Function get backoff;
  external Function get retry;
  external Function get connected;
}
