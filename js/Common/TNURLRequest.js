/**
 * created by schiller
 **/

 import React from 'react-native';
 var HostSite = 'http://m.tuniu.com';
 const ResponseStatus = {
   success: 71000, //请求成功
 }

 function get(path,params={}) {
  // let fetchUrl = `${host}?`
  var url = 'http://m.tuniu.com';
   for (let key in params) {
    url += key + '=' + params[key] + '&'
   }

   const requestParams = {
     method: 'GET',
     header: {
       'Content-Type': 'application/x-www-form-urlencoded'
     }
   }
     return fetch(url, requestParams)
            .then((response) => response.json())
            .catch((error) => {console.log(error)})
 }

 function post(action, params={}, host=HostSite) {
     let fetchUrl = host + '/' + action;
     let body = '';
     for (let key in params) {
        fetchUrl += key + '=' + params[key] + '&';
     }
     var requestParams = {
         method: 'POST',
         headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
         }
     }
 }

 export default {
   ResponseStatus,
   HostSite,
   get,
   post,
 }
