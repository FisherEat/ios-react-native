/**
*created by schiller
*/

'use strict';
import React, { AppRegistry } from 'react-native';
var domestic = require("./js/modules/domestic");
var abroad = require("./js/modules/abroad");

AppRegistry.registerComponent('domestic', ()=> domestic);
AppRegistry.registerComponent('abroad', ()=> abroad);
