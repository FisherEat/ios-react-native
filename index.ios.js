/**
*created by schiller
*/

'use strict';
import React, { AppRegistry } from 'react-native';
var domestic = require("./reactjs/modules/domestic");
var abroad = require("./reactjs/modules/abroad");
var Demos = require("./reactjs/demos");

AppRegistry.registerComponent('Demos', ()=> Demos);
AppRegistry.registerComponent('domestic', ()=> domestic);
//AppRegistry.registerComponent('abroad', ()=> abroad);
