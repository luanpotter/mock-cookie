window = require('../src/mock-cookie.coffee').Document
assert = require 'assert'

describe 'mock-cookie', ->
  document = {}
  data =
    str: 'hello'
    strstr: 'another'
    prop: 'prop=erty'

  beforeEach ->
    document = new window()

  describe '#get()', ->
    it 'should get a cookie value', ->
      document.cookie = data.str
      assert.equal data.str, document.cookie

      document.cookie = data.strstr
      assert.equal data.strstr, document.cookie

      document.cookie = data.prop
      assert.equal data.strstr + '; ' + data.prop, document.cookie

    it 'should set a cookie value', ->
      assert.equal document.cookie = data.str, data.str
      assert.equal document.cookie = data.strstr, data.strstr
      assert.equal document.cookie = data.prop, data.prop



# mini unit tests for the mock cookie to be run in the browser
# document = document || {}
# document.cookie2 = (new Document()).cookie
# console.log('get:  | ', document.cookie, ' | ', document.cookie2)
# console.log('set: hello | ', document.cookie = 'hello')
# console.log('get: hello | ', document.cookie, ' | ', document.cookie2)
# console.log('set: replaced | ', document.cookie = 'replaced')
# console.log('get: replaced | ', document.cookie, ' | ', document.cookie2)
# console.log('set: hello2 | ', document.cookie = 'hello2=expired;expires='+new Date())
# console.log('get: hello2 | ', document.cookie, ' | ', document.cookie2)
# console.log('set: yo=5 | ', document.cookie = 'yo=5')
# console.log('get: replaced; yo=5 | ', document.cookie, ' | ', document.cookie2)
# console.log('set: yo= | ', document.cookie = 'yo=')
# console.log('get: replaced; yo= | ', document.cookie, ' | ', document.cookie2)
