// local helpers
var __slice = Array.prototype.slice;

// a single event class
var Event = (function(){
  function Event ( ) {
    this.listeners = this.listeners || [];
  }

  Event.prototype.add = function ( listener ) {
    this.listeners[this.listeners.length] = listener;
  };

  Event.prototype.contains = function ( listener ) {
    var listeners = this.listeners, length = listeners.length, i;
    for ( i = 0; i < length; ++i ) {
      if ( listeners[i] === listener ) {
        return true;
      }
    }
    return false;
  };

  Event.prototype.emit = function ( context, args ) {
    var listeners = this.listeners, length = listeners.length, i;
    if ( length !== 0 ) {
      if ( !Array.isArray(args) ) {
        args = args ? [args] : [];
      }
      if ( length === 1 ) {
        listeners[0].apply(context, args);
      } else {
        for ( i = 0; i < length; ++i ) {
          listeners[i].apply(context, args);
        }
      }
    }
  };

  Event.prototype.remove = function ( listener ) {
    var listeners = this.listeners, length = listeners.length, i;
    for ( i = 0; i < length; ++i ) {
      if ( listeners[i] === listener ) {
        this.listeners.splice(i, 1);
      }
    }
  };

  return Event;
})();

// event emitter class
var EventEmitter = (function(){
  function event_exists ( emitter, event ) {
    return emitter._events && emitter._events[event];
  }

  function EventEmitter ( ) {
    this._events = this._events || {};
  }

  EventEmitter.prototype.addListener = function ( event, listener ) {
    if ( !this._events ) {
      this._events = {};
    }
    if ( !this._events[event] ) {
      this._events[event] = new exports.Event();
    }
    this._events[event].add(listener);
    return this;
  };
  EventEmitter.prototype.on = EventEmitter.prototype.addListener;

  EventEmitter.prototype.once = function ( event, listener ) {
    this.addListener(event, function cb(){
      listener.apply(this, arguments);
      this.removeListener(event, cb);
    });
    return this;
  };

  EventEmitter.prototype.hasEvent = function ( event ) {
    return event_exists(this, event) && this._events[event] instanceof exports.Event;
  };

  EventEmitter.prototype.hasListener = function ( event, listener ) {
    return this.hasEvent(this, event) && this._events[event].contains(listener);
  };

  EventEmitter.prototype.removeListener = function ( event, listener ) {
    if ( event_exists(this, event) ) {
      this._events[event].remove(listener);
    }
    return this;
  };

  EventEmitter.prototype.removeEvent = function ( event ) {
    if ( event_exists(this, event) ) {
      this._events[event].listeners = [];
      delete this._events[event];
    }
    return this;
  };

  EventEmitter.prototype.removeAllListeners = function ( event ) {
    if ( arguments.length === 0 ) {
      this._events = {};
    } else {
      if ( event_exists(this, event) ) {
        this._events[event].listeners = [];
      }
    }
    return this;
  };

  EventEmitter.prototype.emit = function ( event ) {
    if ( event_exists(this, event) ) {
      this._events[event].emit(this, __slice.call(arguments, 1));
    }
    return this;
  };

  EventEmitter.prototype.listeners = function ( event ) {
    if ( event_exists(this, event) ) {
      return this._events[event].listeners.slice(0);
    }
    return [];
  };

  return EventEmitter;
})();

// export
EventEmitter.Event = Event;
EventEmitter.EventEmitter = EventEmitter;
module.exports = EventEmitter;
