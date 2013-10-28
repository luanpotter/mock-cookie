# Support trim
unless String::trim then String::trim = -> @replace /^\s+|\s+$/g, ""

# Support Getters/Setters
Function::property = (prop, desc) ->
  Object.defineProperty @prototype, prop, desc

# Mock the document.cookie
class Document
  constructor: (@_cookie = {}) ->
  @_cookie = {}
  @property 'cookie',
    get: ->
      if Object.keys(@_cookie).length
        str = ''
        for key, val of @_cookie
          if new Date(val.expires) < new Date()
            delete @_cookie[key]
            continue

          key = if key is ' ' then '' else "#{key}="
          str += "#{key}#{val.value}; "
        return str.slice 0, -2
      else
        return ''
    set: (val) ->
      properties = val.trim().split ';'
      val = (properties.shift() + '').trim().split('=')

      key = if val.length is 1 then ' ' else val[0].trim()
      value = (if val.length is 1 then val[0] else val[1]).trim()

      for cookie in properties
        cookie = cookie.trim().split '='
        continue if cookie.length is 1 or cookie[0].trim() isnt 'expires'
        expires = new Date cookie[1]
        expires = '' if expires is 'Invalid Date'

      @_cookie[key] =
        value: value
        expires: expires ? 'Session'

      return cookie


exports.Document = Document
