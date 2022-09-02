import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePrefernces {
    static SharedPreferences? _preferences;

    static const _keyUsername = 'username';
    static const _keyEmail = 'email';
    static const _keyPassword = 'password';

    static Future init() async => 
        _preferences = await SharedPreferences.getInstance();

    static Future setUsername(String username) async => 
        await _preferences?.setString(_keyUsername, username);

    static String? getUsername() => _preferences?.getString(_keyUsername);

    static Future setEmail(String email) async => 
        await _preferences?.setString(_keyEmail, email);

    static String? getEmail() => _preferences?.getString(_keyEmail);

    static Future setPassword(String password) async => 
        await _preferences?.setString(_keyPassword, password);

    static String? getPassword() => _preferences?.getString(_keyPassword);
}