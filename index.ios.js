/**
*created by schiller
*/

'use strict';
import React, { AppRegistry } from 'react-native';
var domestic = require("./reactjs/modules/domestic");
var abroad = require("./reactjs/modules/abroad");
var Demos = require("./reactjs/demos");
var TuniuChannel = require("./js/modules/domestic");

AppRegistry.registerComponent('Demos', ()=> Demos);
AppRegistry.registerComponent('domestic', ()=> domestic);
AppRegistry.registerComponent('TuniuChannel', ()=> TuniuChannel);
