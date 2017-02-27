/**
 * created by schiller
 */
import React from 'react-native'

const WMHostSite = 'http://api.vanimg.com'
const TNHostSite = 'http://m.tuniu.com/api/'
const ResponseStatus = {
    success: 2000,          //请求成功
    dataNotExist: 300,      //数据不存在
    passwordError: 3001,    //密码错误
    dataExist: 3002,        //数据已存在
    paramsError: 4000,      //参数错误
    needUpdateClient: 4010, //需要升级客户端
    siteIdError: 4020,      //站点id编号错误
    otherError: 4100,       //其它原因错误
}
const HTTPMETHOD = {
    post: 'POST',
    get: 'GET',
}

function post(action, param={}, host=HostSite) {
    const fetchUrl = host + '/' + action

   let body = ''
   for (let key in params) {
       body += key + '=' + params[key] + '&'
   }
   const requestParams = {
       method: 'POST',
       headers: {
           'Content-Type': 'application/x-www-form-urlencoded'
       },
       body: body
   }
   return fetch(fetchUrl, requestParams)
         .then((response) => response.json())
         .catch((error)=>{console.log(error)})
}

function specialGet(host, params={}) {
    let fetchUrl = `${host}/`
    for (let key in params) {
        fetchUrl += params[key] + '/'
    }
    if (fetchUrl.endsWith('/')) {
        fetchUrl = fetchUrl.substr(0, fetchUrl.length - 1)
    }
    console.log(fetchUrl);
    const requestParams = {
        method: 'GET',
       headers: {
           'Content-Type': 'application/x-www-form-urlencoded'
       },
    }
    return fetch(fetchUrl, requestParams)
           .then((response) => response.json())
           .catch((error) => {console.log(error)})
}

function get(host, path ,params={}) {
    let fetchUrl = `${host+path}?`
    for (let key in params) {
        fetchUrl += key + '=' + param[key] + '&'
    }
    console.log(fetchUrl)
    const requestParams = {
        method: 'GET',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
    }
    return fetch(fetchUrl, requestParams)
           .then((response) => response.json())
           .catch((error) => {console.log(error)})
}

export default {
    ResponseStatus,
    TNHostSite,
    WMHostSite,
    get,
    post,
    HTTPMETHOD,
    specialGet,
}
