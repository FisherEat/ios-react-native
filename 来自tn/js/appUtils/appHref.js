/**
 * Created by sheldon on 5/24/16.
 */
import React, {
    NativeModules
} from 'react-native';

export default function appHref(appUrl, mUrl){
    appUrl = decodeURIComponent(appUrl);
    mUrl = decodeURIComponent(mUrl);
    NativeModules.TNReactNativeUtil.rn_parseUrl(appUrl, mUrl, function () {
        console.log('ok')
    });
}