// ignore_for_file: constant_identifier_names

import 'dart:io';

const oauthredirect = 'home';

const REFRESH_TOKEN_KEY = 'refresh_token';
const BACKEND_TOKEN_KEY = 'backend_token';
const GOOGLE_ISSUER = 'https://accounts.google.com';
const GOOGLE_CLIENT_ID_IOS =
    '707888038435-h1jtdkqat3punrqqpcv39vbltr9ai2rj.apps.googleusercontent.com';
const GOOGLE_REDIRECT_URI_IOS =
    'com.googleusercontent.apps.$GOOGLE_CLIENT_ID_IOS:/oauthredirect';
const GOOGLE_CLIENT_ID_ANDROID =
    '707888038435-9vuvrq33uammvdvjq62fa8jk7bjc5bh5.apps.googleusercontent.com';
const GOOGLE_REDIRECT_URI_ANDROID = 'com.fleetowner.drivn:/oauthredirect';

String clientID() {
  if (Platform.isAndroid) {
    return GOOGLE_CLIENT_ID_ANDROID;
  } else if (Platform.isIOS) {
    return GOOGLE_CLIENT_ID_IOS;
  }
  return '';
}

String redirectUrl() {
  if (Platform.isAndroid) {
    return GOOGLE_REDIRECT_URI_ANDROID;
  } else if (Platform.isIOS) {
    return GOOGLE_REDIRECT_URI_IOS;
  }
  return '';
}
