/**
 *created by schiller
 */

import React from 'react-native'
const HostSite = 'http://m.tuniu.com/api/'

const SUPER_HOME_BASE = 'superDiy/home/baseInfo/'

const ResponseStatus ={
    success: 2000,          //请求成功
    dataNotExist: 3000,     //数据不存在
    passwordError: 3001,    //密码错误
    dataExist: 3002,        //数据已存在
    paramsError: 4000,      //参数错误
    needUpdateClient: 4010, //需要升级客户端
    siteIdError: 4020,      //站点id编号错误
    otherError: 4100,       //其它原因错误
}

function post(action, params={}, host=HostSite) {
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

function dynamicGet(params={}, host=HostSite) {
  let fetchUrl = `${host}?`
  for (let key in params) {
    fetchUrl += key + '=' + params[key] + '&'
  }
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

function normalGet(params={}, path={}) {
  let fetchUrl = `${HostSite}${path}`
  // for (let key in params) {
  //   fetchUrl += key + params[key] + '/';
  // }
  // if (fetchUrl.endsWith('/')) {
  //   fetchUrl = fetchUrl.substr(0, fetchUrl.length-1)
  // }
  fetchUrl =  HostSite + SUPER_HOME_BASE + 'c/{"cc":"3415","ct":10,"p":14588,"dt":0,"v":"8.0.5"}/d/{}'
  const requestParams = {
    method: 'GET',
       headers: {
           'Content-Type': 'application/x-www-form-urlencoded'
       },
  }
  return fetch(fetchUrl, requestParams)
         .then((response) => response.json())
         .catch((erro) => {console.log(error)})
}

export default {
  ResponseStatus,
  HostSite,
  dynamicGet,
  normalGet,
  post,
  SUPER_HOME_BASE,
}
