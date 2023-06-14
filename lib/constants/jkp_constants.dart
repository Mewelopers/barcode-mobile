const apiUrl = 'https://barcode-api.homa-server.eu';
const apiBaseUrl = '$apiUrl/api/v1';
const oidcDiscoveryUrl = 'https://yermakovich.com/identity/.well-known/openid-configuration';
const oidcClientId = 'jkp';
const oidcRedirectUrl = 'com.barcode-mobile:/oauthredirect';
const oidcPostLogoutRedirectUrl = 'com.barcode-mobile:/';
const oidcScopes = <String>['openid', 'profile', 'email', 'offline_access', 'jkp-api', 'roles'];
