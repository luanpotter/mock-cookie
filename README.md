# Mock Cookie

A mocked version of the "standard" cookie used in browsers. It doesn't include options for path, domain, secure or http only at the moment.

The primary purpose of its creation was for unit tests. Having to clear out cookies for unit tests was tedious and not always reliable/accurate. Sometimes in some tests, document.cookie wasn't even available. This mock version helps ensure clean, consistent results.

## Usage

Assign a new version of the cookie to the object you want to represent it, usually document:

```javascript
document.cookie = (new Document()).cookie
```

From there, use document.cookie as you normally would to test your application.

## Future Plans

* Max-age support needs to be added.
* Path: Support for this woud depend on window.location.pathname being mocked out as well.
* Domain: Similiar to path but with window.location.{host|hostname|origin}
* Secure: Similiar to path but with window.location.protocol
* Http-only: Not sure how to mock this out since JS wouldn't have access to the cookie. That could probably be the test

