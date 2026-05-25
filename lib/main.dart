import 'package:flutter/material.dart';
import 'package:beautygovn/features/auth/presentation/screens/SplashActive.dart'
    as splash;
import 'package:beautygovn/features/auth/presentation/screens/login_screen.dart'
    as login;

void main() {
  runApp(const BeautyGoApp());
}

class BeautyGoApp extends StatelessWidget {
  const BeautyGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BeautyGo VN',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF151B36)),
        useMaterial3: true,
      ),
      home: const _AuthFlowHost(),
    );
  }
}

class _AuthFlowHost extends StatefulWidget {
  const _AuthFlowHost();

  @override
  State<_AuthFlowHost> createState() => _AuthFlowHostState();
}

class _AuthFlowHostState extends State<_AuthFlowHost> {
  bool _showSplash = true;
  login.ScreenId _currentScreen = login.ScreenId.login;
  String _userName = 'Beauty Lover';
  String _userRole = 'enthusiast';

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _showSplash = false;
        _currentScreen = login.ScreenId.login;
      });
    });
  }

  void _handleNavigate(login.ScreenId screen) {
    setState(() => _currentScreen = screen);
  }

  void _handleSplashNavigate(splash.ScreenId screen) {
    if (screen == splash.ScreenId.login || screen == splash.ScreenId.register) {
      setState(() {
        _showSplash = false;
        _currentScreen =
            screen == splash.ScreenId.login
                ? login.ScreenId.login
                : login.ScreenId.register;
      });
      return;
    }

    if (screen == splash.ScreenId.profile ||
        screen == splash.ScreenId.createShop ||
        screen == splash.ScreenId.welcome) {
      setState(() {
        _showSplash = false;
        _currentScreen = login.ScreenId.login;
      });
    }
  }

  void _handleUserUpdate(String userName, String userRole) {
    setState(() {
      _userName = userName;
      _userRole = userRole;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return splash.SplashActive(
        currentScreen: splash.ScreenId.splash,
        onNavigate: _handleSplashNavigate,
      );
    }

    final bool isUnhandledScreen =
        _currentScreen == login.ScreenId.welcome ||
        _currentScreen == login.ScreenId.profile ||
        _currentScreen == login.ScreenId.createShop;

    if (isUnhandledScreen) {
      return Scaffold(
        appBar: AppBar(title: const Text('BeautyGo VN')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Xin chào $_userName ($_userRole)'),
              const SizedBox(height: 12),
              Text('Màn hiện tại: ${_currentScreen.name}'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _handleNavigate(login.ScreenId.login),
                child: const Text('Quay về đăng nhập'),
              ),
            ],
          ),
        ),
      );
    }

    return login.LoginScreen(
      currentScreen: _currentScreen,
      onNavigate: _handleNavigate,
      onUserUpdate: _handleUserUpdate,
    );
  }
}
