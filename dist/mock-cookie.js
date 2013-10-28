(function(window, undefined) {


var Document, root;

if (!String.prototype.trim) {
  String.prototype.trim = function() {
    return this.replace(/^\s+|\s+$/g, "");
  };
}

Function.prototype.property = function(prop, desc) {
  return Object.defineProperty(this.prototype, prop, desc);
};

Document = (function() {
  function Document(_cookie) {
    this._cookie = _cookie != null ? _cookie : {};
  }

  Document._cookie = {};

  Document.property('cookie', {
    get: function() {
      var key, str, val, _ref;
      if (Object.keys(this._cookie).length) {
        str = '';
        _ref = this._cookie;
        for (key in _ref) {
          val = _ref[key];
          if (new Date(val.expires) < new Date()) {
            delete this._cookie[key];
            continue;
          }
          key = key === ' ' ? '' : "" + key + "=";
          str += "" + key + val.value + "; ";
        }
        return str.slice(0, -2);
      } else {
        return '';
      }
    },
    set: function(val) {
      var cookie, expires, key, properties, value, _i, _len;
      properties = val.trim().split(';');
      val = (properties.shift() + '').trim().split('=');
      key = val.length === 1 ? ' ' : val[0].trim();
      value = (val.length === 1 ? val[0] : val[1]).trim();
      for (_i = 0, _len = properties.length; _i < _len; _i++) {
        cookie = properties[_i];
        cookie = cookie.trim().split('=');
        if (cookie.length === 1 || cookie[0].trim() !== 'expires') {
          continue;
        }
        expires = new Date(cookie[1]);
        if (expires === 'Invalid Date') {
          expires = '';
        }
      }
      this._cookie[key] = {
        value: value,
        expires: expires != null ? expires : 'Session'
      };
      return cookie;
    }
  });

  return Document;

})();

root = typeof exports !== "undefined" && exports !== null ? exports : window;

root.MockDoc = Document;

})(window);
