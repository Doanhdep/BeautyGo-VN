import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController(
    text: 'abhishekpatelXXX@gmail.com',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: '**********',
  );

  bool _isLoginTab = true;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF151B36);
    const border = Color(0xFFB6B6B6);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              SizedBox(
                height: 190,
                child: Image.network(
                  'https://images.unsplash.com/photo-1600585154526-990dced4db0d?auto=format&fit=crop&w=1200&q=80',
                  fit: BoxFit.contain,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: border),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.home_work_outlined,
                          size: 72,
                          color: navy,
                        ),
                      ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Welcome Back',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: navy,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _AuthTabButton(
                      label: 'Login',
                      selected: _isLoginTab,
                      onTap: () => setState(() => _isLoginTab = true),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _AuthTabButton(
                      label: 'Sign Up',
                      selected: !_isLoginTab,
                      onTap: () => setState(() => _isLoginTab = false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              _LabeledInput(
                label: 'Email Address',
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _LabeledInput(
                label: 'Password',
                child: TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: navy,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: navy,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: navy,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 26),
              Row(
                children: const [
                  Expanded(child: Divider(color: border, thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Or',
                      style: TextStyle(
                        color: navy,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: border, thickness: 1)),
                ],
              ),
              const SizedBox(height: 20),
              _SocialButton(
                icon: Icons.g_mobiledata_rounded,
                iconColor: Color(0xFF4285F4),
                label: 'Google',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _SocialButton(
                icon: Icons.apple,
                iconColor: navy,
                label: 'Apple',
                onTap: () {},
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthTabButton extends StatelessWidget {
  const _AuthTabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF151B36);
    const border = Color(0xFFB6B6B6);

    return SizedBox(
      height: 46,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: selected ? navy : Colors.transparent,
          foregroundColor: selected ? Colors.white : navy,
          side: const BorderSide(color: border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _LabeledInput extends StatelessWidget {
  const _LabeledInput({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const border = Color(0xFFB6B6B6);
    const navy = Color(0xFF151B36);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: border),
            color: Colors.transparent,
          ),
          child: child,
        ),
        Positioned(
          top: -10,
          left: 18,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            color: const Color(0xFFF3F3F3),
            child: Text(
              label,
              style: const TextStyle(
                color: navy,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const border = Color(0xFFB6B6B6);
    const navy = Color(0xFF151B36);

    return SizedBox(
      height: 48,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: iconColor, size: 28),
        label: Text(
          label,
          style: const TextStyle(
            color: navy,
            fontWeight: FontWeight.w500,
            fontSize: 26,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
