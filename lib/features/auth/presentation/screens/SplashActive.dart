import 'package:flutter/material.dart';

enum ScreenId {
  splash,
  welcome,
  login,
  register,
  roleSelection,
  profile,
  createShop,
}

class SplashActive extends StatelessWidget {
  final ScreenId currentScreen;
  final Function(ScreenId) onNavigate;

  const SplashActive({
    super.key,
    required this.currentScreen,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    if (currentScreen == ScreenId.splash) {
      return _buildSplashScreen();
    }
    return _buildWelcomeScreen();
  }

  // ================== SPLASH SCREEN ==================
  Widget _buildSplashScreen() {
    return GestureDetector(
      onTap: () => onNavigate(ScreenId.welcome),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F2ED),
        body: SafeArea(
          child: Stack(
            children: [
              // Background decorative elements
              Positioned(
                bottom: 48,
                right: -60,
                child: Container(
                  width: 180,
                  height: 240,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCC7A00).withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(999),
                      topRight: Radius.circular(999),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 48,
                left: -50,
                child: Container(
                  width: 130,
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCC7A00).withOpacity(0.05),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(999),
                      bottomRight: Radius.circular(999),
                    ),
                  ),
                ),
              ),

              // Main Content
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 40,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top Brand
                    const Text(
                      "BIÊN NIÊN GIÁM 2026",
                      style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 3,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFCC7A00),
                      ),
                    ),

                    // Center Logo & Text
                    Column(
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            color: const Color(0xFFCC7A00).withOpacity(0.1),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFCC7A00).withOpacity(0.2),
                              width: 1.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.auto_awesome,
                            size: 42,
                            color: Color(0xFFCC7A00),
                          ),
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          "BEAUTYGO",
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -2,
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: 48,
                          height: 1.5,
                          color: const Color(0xFFCC7A00).withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "KIỆT TÁC DƯỠNG NHAN & HỌC VIỆN CHUYÊN NGHIỆP",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            letterSpacing: 2.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          "Nơi hội tụ di sản dưỡng nhan truyền thống và ngôn ngữ thiết kế của tương lai.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF555555),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),

                    // Bottom Indicator
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            _AnimatedDot(delay: 0),
                            SizedBox(width: 6),
                            _AnimatedDot(delay: 300),
                            SizedBox(width: 6),
                            _AnimatedDot(delay: 600),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "CHẠM ĐỂ BẮT ĐẦU TRẢI NGHIỆM",
                          style: TextStyle(
                            fontSize: 10,
                            letterSpacing: 2.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFCC7A00),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================== WELCOME SCREEN ==================
  Widget _buildWelcomeScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.45,
              child: Image.network(
                "https://lh3.googleusercontent.com/aida-public/AB6AXuCCLEqntrglw7slfpl7V0sxOG6TI5elN_5FAmKkoet9uP6__a2326d6VtBJuPj5S0Y3wjCaqBWEOGsHvAElYsYB1dn-7k7s5ZYDVUadTl9NY0S-AASU_tcW_VpcGmxtkRWDLNVjITcDC1J4KwBMLXZ5C8Hp_WO8n9u11TDesoet4qQpTnrOtf9VWyTh2-L8xeJiRKXnwK9ry7A3R86-5hQJ4PT2K47wAZrtJj8nL4CynaPRkEuSxBEaBMOyqPzg0qACvRyWMIsk-28",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black12, Colors.transparent, Colors.black87],
                ),
              ),
            ),
          ),

          // Decorative Circle
          const Positioned(
            top: -60,
            right: -60,
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.transparent,
              child: CircleAvatar(
                radius: 78,
                backgroundColor: Colors.transparent,
                child: CircleAvatar(
                  radius: 76,
                  backgroundColor: Colors.white10,
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  const Text(
                    "LUVITÀ / BEAUTYGO",
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFCC7A00),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "DI SẢN\nVÀ THIẾT KỶ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 38,
                      height: 1.05,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 48,
                    height: 2,
                    color: const Color(0xFFCC7A00).withOpacity(0.4),
                  ),
                  const Spacer(),

                  // Buttons
                  _buildButton(
                    text: "ĐĂNG NHẬP",
                    isPrimary: true,
                    onTap: () => onNavigate(ScreenId.login),
                  ),
                  const SizedBox(height: 12),
                  _buildButton(
                    text: "ĐĂNG KÝ TÀI KHOẢN MỚI",
                    isPrimary: false,
                    onTap: () => onNavigate(ScreenId.register),
                  ),

                  const SizedBox(height: 24),
                  Row(
                    children: const [
                      Expanded(child: Divider(color: Colors.white24)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "HOẶC",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white38,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.white24)),
                    ],
                  ),

                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => onNavigate(ScreenId.profile),
                    child: const Text(
                      "VÀO XEM VỚI TƯ CÁCH KHÁCH",
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                    ),
                  ),

                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.language, size: 16, color: Colors.white54),
                      SizedBox(width: 6),
                      Text(
                        "VIỆT NAM / HÀ NỘI / HỒ CHÍ MINH",
                        style: TextStyle(
                          fontSize: 9,
                          letterSpacing: 1.5,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? Colors.white : Colors.transparent,
          foregroundColor: isPrimary ? Colors.black : const Color(0xFFCC7A00),
          side:
              isPrimary
                  ? null
                  : const BorderSide(color: Color(0xFFCC7A00), width: 1.2),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}

// Animated Dot for Splash
class _AnimatedDot extends StatefulWidget {
  final int delay;
  const _AnimatedDot({required this.delay});

  @override
  State<_AnimatedDot> createState() => _AnimatedDotState();
}

class _AnimatedDotState extends State<_AnimatedDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Opacity(
          opacity: 0.2 + 0.8 * (1 - (_controller.value * 2 % 1)),
          child: Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFFCC7A00),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
