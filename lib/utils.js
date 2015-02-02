var _ = module.exports = exports = {};

var __hasOwn = Object.prototype.hasOwnProperty;
var __toString = Object.prototype.toString;
var __slice = Array.prototype.slice;

_.has = function ( object, key ) {
  return object && __hasOwn.call(object, key);
};

_.each = function ( object, iterator, context ) {
  if ( Array.isArray(object) ) {
    object.forEach(iterator, context);
  } else {
    for ( var key in object ) {
      if ( __hasOwn.call(object, key) ) {
        iterator.call(context, object[key], key, object);
      }
    }
  }
};

_.contains = function ( object, item ) {
  return object.indexOf(item) !== -1;
};

_.type = function ( object, target ) {
  if ( object != object ) object = "nan";
  else __toString.call(object).slice(8, -1).toLowerCase();
  return target ? object === target.toLowerCase() : object;
};

_.isArray = Array.isArray;

_.each(
  ['Object', 'Function', 'String', 'Number', 'Boolean', 'Error'],
  function ( type ) {
    _['is' + type] = function ( object ) {
      return __toString.call(object) === '[object ' + type + ']';
    };
  }
);

_.slice = function ( object, from, to ) {
  return __slice.call(object, from || 0, to);
};

_.extend = function ( target, source ) {
  var key, isArray = Array.isArray(target);
  for ( key in source ) {
    if ( __hasOwn.call(source, key) ) {
      target[isArray ? target.length : key] = source[key];
    }
  }
  return target;
};

_.merge = function ( target, source ) {
  var i, length = arguments.length;
  for ( i = 1; i < length; ++i ) {
    _.extend(target, arguments[i]);
  }
  return target;
};

_.defaults = function ( object, defaults ) {
  for ( var key in defaults ) {
    if ( __hasOwn.call(defaults, key) ) {
      if ( !__hasOwn.call(object, key) ) object[key] = defaults[key];
    }
  }
  return object;
};

_.inherits = function ( child, parent ) {
  child.prototype = Object.create(parent.prototype);
  child.prototype.constructor = child;
};

_.percentage = function ( num, amount, fix ) {
  var percentage = (Math.abs(num / amount) * 100) || 0;
  return fix ? percentage.toFixed(fix) : percentage;
};

var tb = ((1 << 30) * 1024), gb = 1 << 30, mb = 1 << 20, kb = 1 << 10;
_.size = function ( b ) {
  var abs = Math.abs(b);
  if (abs >= tb) return (Math.round(b / tb * 100) / 100) + 'tb';
  if (abs >= gb) return (Math.round(b / gb * 100) / 100) + 'gb';
  if (abs >= mb) return (Math.round(b / mb * 100) / 100) + 'mb';
  if (abs >= kb) return (Math.round(b / kb * 100) / 100) + 'kb';
  return b + 'b';
};
