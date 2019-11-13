var OFF = 0;
var WARN = 1;
var ERROR = 2;

var config = {
  "root": true,
  "parserOptions": {
    "ecmaVersion": 5
  },
  "env": {
    "browser": true,
    "jquery": true,
    "node": true
  },
  "globals": {
  },
  "extends": [
    "eslint:recommended"
  ],
  "rules": {
  }
};

module.exports = config;
