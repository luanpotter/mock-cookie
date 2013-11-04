# Mock Cookie

### Status
| Branch        | Status         |
| ------------- |:-------------:|
| master        | [![Build Status](https://travis-ci.org/Aspera/mock-cookie.png?branch=master)](https://travis-ci.org/Aspera/mock-cookie) |

A mocked version of the "standard" cookie used in browsers. It doesn't include options for path, domain, secure or http only at the moment.

The primary purpose of its creation was for unit tests. Having to clear out cookies for unit tests was tedious and not always reliable/accurate. Sometimes in some tests, document.cookie wasn't even available. This mock version helps ensure clean, consistent results.

## Installation

The best way is to use bower to manage the process:

```bash
bower install --save-dev mock-cookie
```

## Usage

Assign a new version of the cookie to the object you want to represent it, usually document.

### In unit tests:

```javascript
window = require('path/to/mock-cookie.js').Document;
document = new window();
document.cookie = 'value to add';
```

From there, use document.cookie as you normally would to test your application.


### In code:
```javascript
<script src='path/to/mock-cookie.js'></script>
<script>
  myDoc = new window.Document();
  myDoc.cookie = 'value to add';
</script>
```

By using myDoc.cookie instead of document.cookie in your application, you can keep the original functionality to test against. If you really want to override document.cookie for some reason:

```javascript
<script src='path/to/mock-cookie.js'></script>
<script>
  document.cookie = (new window.Document()).cookie;
  document.cookie = 'value to add';
</script>
```

## Future Plans

* Max-age support needs to be added.
* Path: Support for this woud depend on window.location.pathname being mocked out as well.
* Domain: Similiar to path but with window.location.{host|hostname|origin}
* Secure: Similiar to path but with window.location.protocol
* Http-only: Not sure how to mock this out since JS wouldn't have access to the cookie. That could probably be the test
