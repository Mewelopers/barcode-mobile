import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../constants/jkp_constants.dart';

@singleton
class AuthService {
  final FlutterAppAuth _appAuth = const FlutterAppAuth();
  final _secureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  final refreshTokenKey = 'refreshToken';

  String? _idToken;
  String? _accessToken;
  DateTime? _accessTokenExpirationDate;
  String? _refreshToken;

  @PostConstruct()
  Future<void> tryRefreshPreviousSession() async {
    _refreshToken = await _secureStorage.read(key: refreshTokenKey);

    if (_refreshToken != null) {
      await _refresh();
    }
  }

  bool get signedIn =>
      _accessToken != null && _accessTokenExpirationDate != null && _accessTokenExpirationDate!.isAfter(DateTime.now());

  Future<String> get accessToken async {
    if (_accessToken == null) {
      await _signIn();
    }

    if (_accessTokenExpirationDate!.isBefore(DateTime.now())) {
      await _refresh();
    }

    return _accessToken!;
  }

  Future<void> _signIn() async {
    final tokenRequest =
        AuthorizationTokenRequest(oidcClientId, oidcRedirectUrl, scopes: oidcScopes, discoveryUrl: oidcDiscoveryUrl);

    final result = await _appAuth.authorizeAndExchangeCode(tokenRequest);

    if (result == null) {
      throw Exception('No AuthorizationTokenResponse was returned');
    }

    await _processTokenResponse(result);
  }

  Future<void> _refresh() async {
    final tokenRequest = TokenRequest(oidcClientId, oidcRedirectUrl,
        scopes: oidcScopes, discoveryUrl: oidcDiscoveryUrl, refreshToken: _refreshToken);

    final result = await _appAuth.token(tokenRequest);

    if (result == null) {
      throw Exception('No AuthorizationTokenResponse was returned');
    }

    await _processTokenResponse(result);
  }

  Future<void> signOut() async {
    await _appAuth.endSession(EndSessionRequest(
        idTokenHint: _idToken, postLogoutRedirectUrl: oidcPostLogoutRedirectUrl, discoveryUrl: oidcDiscoveryUrl));

    _idToken = _accessToken = _refreshToken = _accessTokenExpirationDate = null;
  }

  Future<void> _processTokenResponse(TokenResponse response) async {
    _idToken = response.idToken;
    _accessToken = response.accessToken;
    _refreshToken = response.refreshToken;
    _accessTokenExpirationDate = response.accessTokenExpirationDateTime;

    await _secureStorage.write(key: refreshTokenKey, value: _refreshToken);
  }
}
