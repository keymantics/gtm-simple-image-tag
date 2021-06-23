___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "categories": ["ANALYTICS", "ATTRIBUTION"],
  "securityGroups": [],
  "displayName": "KMTX - Simple Image Tag",
  "brand": {
    "displayName": "KMTX",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAKoAAACqCAMAAAAKqCSwAAAAM1BMVEUrMj3y8vNaYGijpqrFx8rY2duMkJb///8A/9E7Rk9zeH8faWUD8ccWk4MQspkH3LgLyKkiM4iSAAAC3UlEQVR42u2Z6ZKqMBBGyUIgAYT3f9oLmKWzaEmAW1TNd36NLeqh7e4kTtMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPAnGIpRffBduHlzp+nUv0rRcTn2NrJ7o+8zffV9P6eJ1csaXR6mupn2/TjFJTHu0flRqkNveUUlYZkemNUthe4zdAhVZJXdWKuzExvfBTuEgH5YW+mxp9/3EB4OT5sAoVy3gp36vqZQ/5Mq1Rup9gNVQ2sR5uacqvaQB/sTRgmhjI4WOiWU4j99zJKZjrpS1U4A3VrzTq0PmP/TuDti0qpxwVxI7K81qoS7ET2npkNzKquRaVDV7qIdsV0paGS/WnUlVGEMVDR/phpM37sXq+rzZ5HkwqCvv6vSGXW8+VNVzmJTzboyoi0pye+qzXyqUCPV1NRn9RfWWjffVePGmvUJVW/KnKk+oLqVAPummo6rpVqVmcyUfjYThnMVfe9byIQyZusMECvu1qXY4fkiUO2aVhgLczJkteXZxTKdbvYSlRRRtrTWd5b8aBqy6rddRN6FeFLgRdVhLKgenlfys6kXEz4kusxExlVZUiXzfxzm6lVAfjQNWQ3darpse6vi+ympLlHjL7UjS36YgiSrjCz77vvPQ59VX0krTZWtFRdAMavES/sF63fVIWukULqvi2v1nKr3IqUZineonwCtvjqrbp+y6MIGdjyhSl2vyapN4ZT9tnJ4BmSbDHl1rW6uBady9BdVFe9HL8zqdu4vTqWpcq5qlY+sM6rq+gNa2ASGjb05kVWTX3Gx6rb8iHRk1aj6PcF64tJc6luySlrsvW5WZZXuHNm1dRAdA2U0supU4+Nge5dq2H3KatXk7MBvUiWuorJW6Wky3kBerEpyoiqzukbaeypAtDu+VXnr4I20zxFV+xzJlXsBbSAjmf0t5tZ/h1z1oypf0Q0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAOBv8g8Qw0JJ1PbSEwAAAABJRU5ErkJggg\u003d\u003d"
  },
  "description": "Optimize KMTX campaign using Simple Image Tag",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "aid",
    "displayName": "Advertiser ID",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      },
      {
        "type": "REGEX",
        "args": [
          "^[0-9]+$"
        ]
      }
    ],
    "valueHint": "Must be a positive integer"
  },
  {
    "type": "TEXT",
    "name": "sid",
    "displayName": "SID",
    "simpleValueType": true,
    "canBeEmptyString": true,
    "valueValidators": [
      {
        "type": "REGEX",
        "args": [
          "^$|[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}"
        ]
      }
    ],
    "valueHint": "Optional"
  },
  {
    "type": "SELECT",
    "name": "event",
    "displayName": "Type",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "visit",
        "displayValue": "Visit"
      },
      {
        "value": "lead",
        "displayValue": "Lead"
      }
    ],
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const sendPixel = require('sendPixel');
const encodeUri = require('encodeUri');
const copyFromDataLayer = require('copyFromDataLayer');
const getReferrerUrl = require('getReferrerUrl');
const getUrl = require('getUrl');
const generateRandom = require('generateRandom');
const setCookie = require('setCookie');
const getCookieValues = require('getCookieValues');
const getTimestampMillis = require('getTimestampMillis');


// If there is already a kmtx cookie no need to create new uuid, but we need to update expire date to 30 days.
var cid = getCookieValues('_km')[0];
if (cid === undefined) {
  cid = uuid();
}
setCookie('_km', cid, {'max-age': 30 * 24 * 60 * 60, 'secure': true});

// If event is a kmtx.timer then it's a qualified visit, we can record a close.
let isTimer = copyFromDataLayer('event') === 'kmtx.timer';

var url = 'https://t.kmtx.io/s?' +
  'aid=' + data.aid +
  '&cid=' + cid +
  '&eid=' + uuid() +
  '&a=' + (isTimer ? 'close' : data.event) +
  '&v=gtm_1' +
  '&url=' + encodeUri(getUrl()) +
  '&ref=' + encodeUri(getReferrerUrl()) +
  '&ts=' + getTimestampMillis() +
  '&trk=trkid' +
  '&t=img' +
  '&sid=' + data.sid;

sendPixel(url, data.gtmOnSuccess(), data.gtmOnFailure());

// Function to generate random UUIDv4
function uuid() {
  var chars = '0123456789abcdefghijklmnopqrstuvwxyz'.split('');
  var uuid = [];
  var rnd = 0;
  var r;
  for (var i = 0; i < 36; i++) {
    if (i == 8 || i == 13 || i == 18 || i == 23) {
      uuid[i] = '-';
    } else if (i == 14) {
      uuid[i] = '4';
    } else {
      if (rnd <= 2) rnd = 33554432 + ((generateRandom(0, 100000) / 100000) * 16777216) | 0;
      r = rnd & 15;
      rnd = rnd >> 4;
      uuid[i] = chars[(i == 19) ? (r & 3) | 8 : r];
    }
  }
  return uuid.join('');
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "get_referrer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "event"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "send_pixel",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedUrls",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://t.kmtx.io/*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "_km"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "set_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedCookies",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "_km"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: gtmOnSuccess is invoked on sendPixel success
  code: |-
    // test that gtmOnSuccess() is called when sendPixel succeeds
    mock('sendPixel', function(url, onSuccess, onFailure) {
      if (onSuccess != null) {
        onSuccess();
      }
    });

    // Call runCode to run the template's code.
    runCode({
      aid: '1',
      event: 'visit',
      sid: ''
    });

    // Verify that the tag finished successfully.
    assertApi('gtmOnSuccess').wasCalled();
- name: gtmOnFailure is invoked when sendPixel fails
  code: |-
    // test gtmOnFailure() is called when sendPixel fails
    mock('sendPixel', function(url, onSuccess, onFailure) {
      if (onFailure != null) {
        onFailure();
      }
    });

    // Call runCode to run the template's code.
    runCode({
      aid: '1',
      event: 'visit',
      sid: ''
    });

    // Verify onFailure was called
    assertApi('gtmOnFailure').wasCalled();
- name: sendPixel is invoked with right url
  code: |
    var triggerUrl;

    mock('sendPixel', function(url, onSuccess, onFailure) {
      triggerUrl = url;
      if (onSuccess != null) {
        onSuccess();
      }
    });

    // Call runCode to run the template's code.
    runCode({
      aid: '1',
      event: 'visit',
      sid: ''
    });

    // Verify that the tag finished successfully.
    assertApi('gtmOnSuccess').wasCalled();

    // Verify that the URL was correctly fired
    assertApi('sendPixel').wasCalled();
    assertThat(triggerUrl).isEqualTo('https://t.kmtx.io/s?aid=1&cid=7a00007a-0000-47a0-8007-a00007a00007&eid=7a00007a-0000-47a0-8007-a00007a00007&a=visit&v=gtm_1&url=kmtx.io&ref=kmtx.io&ts=1&trk=trkid&t=img&sid=');
- name: sendPixel is invoked with close event
  code: |
    mock('copyFromDataLayer', 'kmtx.timer');

    var triggerUrl;


    mock('sendPixel', function(url, onSuccess, onFailure) {
      triggerUrl = url;
      if (onSuccess != null) {
        onSuccess();
      }
    });

    // Call runCode to run the template's code.
    runCode({
      aid: '1',
      event: 'visit',
      sid: ''
    });

    // Verify that the tag finished successfully.
    assertApi('gtmOnSuccess').wasCalled();

    // Verify that the URL was correctly fired
    assertApi('sendPixel').wasCalled();
    assertThat(triggerUrl).isEqualTo('https://t.kmtx.io/s?aid=1&cid=7a00007a-0000-47a0-8007-a00007a00007&eid=7a00007a-0000-47a0-8007-a00007a00007&a=close&v=gtm_1&url=kmtx.io&ref=kmtx.io&ts=1&trk=trkid&t=img&sid=');
- name: getCookieValues and setCookie are invoked
  code: |-
    mock('sendPixel', function(url, onSuccess, onFailure) {
      if (onSuccess != null) {
        onSuccess();
      }
    });

    // Call runCode to run the template's code.
    runCode({
      aid: '1',
      event: 'visit',
      sid: ''
    });

    // Verify that the tag finished successfully.
    assertApi('gtmOnSuccess').wasCalled();

    // Verify that the URL was correctly fired
    assertApi('sendPixel').wasCalled();

    // Verify that the URL was correctly fired
    assertApi('setCookie').wasCalled();

    // Verify that the URL was correctly fired
    assertApi('getCookieValues').wasCalled();
- name: setCookie is invoked with new UUID
  code: |-
    var triggerUrl;

    mock('sendPixel', function(url, onSuccess, onFailure) {
      triggerUrl = url;
      if (onSuccess != null) {
        onSuccess();
      }
    });

    mock('getCookieValues', function(name, decode) {
        return [];
    });

    const cookie_options = {
      'max-age': 30 * 24 * 60 * 60,
      'secure': true
    };

    // Call runCode to run the template's code.
    runCode({
      aid: '1',
      event: 'visit',
      sid: ''
    });

    // Verify that the tag finished successfully.
    assertApi('gtmOnSuccess').wasCalled();

    // Verify that the URL was correctly fired
    assertApi('sendPixel').wasCalled();
    assertThat(triggerUrl).isEqualTo('https://t.kmtx.io/s?aid=1&cid=7a00007a-0000-47a0-8007-a00007a00007&eid=7a00007a-0000-47a0-8007-a00007a00007&a=visit&v=gtm_1&url=kmtx.io&ref=kmtx.io&ts=1&trk=trkid&t=img&sid=');

    // Verify that the Cookie was correctly set
    assertApi('setCookie').wasCalledWith('_km', '7a00007a-0000-47a0-8007-a00007a00007', cookie_options);
- name: setCookie is invoked with old UUID
  code: |-
    var triggerUrl;

    mock('sendPixel', function(url, onSuccess, onFailure) {
      triggerUrl = url;
      if (onSuccess != null) {
        onSuccess();
      }
    });

    mock('getCookieValues', function(name, decode) {
        return ['00000000-0000-0000-0000-000000000000'];
    });

    const cookie_options = {
      'max-age': 30 * 24 * 60 * 60,
      'secure': true
    };

    // Call runCode to run the template's code.
    runCode({
      aid: '1',
      event: 'visit',
      sid: ''
    });

    // Verify that the tag finished successfully.
    assertApi('gtmOnSuccess').wasCalled();

    // Verify that the URL was correctly fired
    assertApi('sendPixel').wasCalled();
    assertThat(triggerUrl).isEqualTo('https://t.kmtx.io/s?aid=1&cid=00000000-0000-0000-0000-000000000000&eid=7a00007a-0000-47a0-8007-a00007a00007&a=visit&v=gtm_1&url=kmtx.io&ref=kmtx.io&ts=1&trk=trkid&t=img&sid=');

    // Verify that the Cookie was correctly set
    assertApi('setCookie').wasCalledWith('_km', '00000000-0000-0000-0000-000000000000', cookie_options);
setup: |-

  // Need to be mocked to fix the UUID
  mock('generateRandom', 1);

  mock('getTimestampMillis', 1);

  mock('getUrl', 'kmtx.io');

  mock('getReferrerUrl', 'kmtx.io');

___NOTES___

Created on 6/23/2021, 12:01:30 AM


