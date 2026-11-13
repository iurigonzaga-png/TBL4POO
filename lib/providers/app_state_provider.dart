import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateProvider extends ChangeNotifier with WidgetsBindingObserver {
  static const String _lastBackgroundKey = 'last_background_time';

  AppLifecycleState _currentState = AppLifecycleState.resumed;
  DateTime? _lastBackgroundTime;

  AppLifecycleState get currentState => _currentState;
  DateTime? get lastBackgroundTime => _lastBackgroundTime;

  AppStateProvider() {
    WidgetsBinding.instance.addObserver(this);
    _loadLastBackgroundTime();
  }

  Future<void> _loadLastBackgroundTime() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_lastBackgroundKey);
    if (value != null && value.isNotEmpty) {
      _lastBackgroundTime = DateTime.tryParse(value);
      notifyListeners();
    }
  }

  Future<void> setLifecycleState(AppLifecycleState state) async {
    _currentState = state;

    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      _lastBackgroundTime = DateTime.now();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_lastBackgroundKey, _lastBackgroundTime!.toIso8601String());
    }

    notifyListeners();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
