import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:beautygovn/core/services/auth_service.dart';

enum ScreenId { welcome, login, register, roleSelection, profile, createShop }

class LoginScreen extends StatefulWidget {
  final ScreenId currentScreen;
  final Function(ScreenId) onNavigate;
  final Function(String userName, String userRole) onUserUpdate;

  const LoginScreen({
    super.key,
    required this.currentScreen,
    required this.onNavigate,
    required this.onUserUpdate,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();

  bool showPassword = false;
  bool showConfirmPassword = false;
  bool isSubmitting = false;
  String successMsg = '';

  final AuthService _authService = AuthService();

  String? emailError;
  String? matchError;

  String? selectedRole; // 'enthusiast' or 'professional'

  @override
  void dispose() {
    usernameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.dispose();
  }

  // ===================== LOGIN =====================
  // ===================== LOGIN =====================
  Future<void> _handleLogin() async {
    final email = emailCtrl.text.trim();
    final password = passwordCtrl.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Vui lòng nhập email')));
      return;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Vui lòng nhập mật khẩu')));
      return;
    }

    try {
      setState(() {
        isSubmitting = true;
      });

      final authUser = await _authService.login(
        email: email,
        password: password,
      );

      if (authUser != null) {
        if (!mounted) return;

        print('Đăng nhập thành công');
        print(authUser);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Xin chào ${authUser.fullName}')),
        );

        /// update user local state
        widget.onUserUpdate(authUser.username, authUser.role);

        /// navigate
        widget.onNavigate(ScreenId.profile);
      }
    } on AuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
    } finally {
      if (!mounted) return;

      setState(() {
        isSubmitting = false;
      });
    }
  }

  // ===================== REGISTER =====================
  void _handleRegister() async {
    if (passwordCtrl.text != confirmPasswordCtrl.text) {
      setState(() => matchError = 'Mật khẩu không khớp');
      return;
    }

    setState(() => isSubmitting = true);
    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      isSubmitting = false;
      successMsg = 'Account Created! ✨';
    });

    widget.onUserUpdate(
      usernameCtrl.text.isNotEmpty ? usernameCtrl.text : 'Beauty Enthusiast',
      'enthusiast',
    );

    await Future.delayed(const Duration(seconds: 1));
    widget.onNavigate(ScreenId.roleSelection);
    setState(() => successMsg = '');
  }

  // ===================== ROLE SELECTION =====================
  void _handleRoleContinue() async {
    if (selectedRole == null) return;

    setState(() => isSubmitting = true);
    await Future.delayed(const Duration(milliseconds: 1200));

    widget.onUserUpdate(
      usernameCtrl.text.isNotEmpty ? usernameCtrl.text : 'Beauty Enthusiast',
      selectedRole!,
    );

    if (selectedRole == 'professional') {
      widget.onNavigate(ScreenId.createShop);
    } else {
      widget.onNavigate(ScreenId.profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.currentScreen) {
      case ScreenId.login:
        return _buildLoginScreen();
      case ScreenId.register:
        return _buildRegisterScreen();
      case ScreenId.roleSelection:
        return _buildRoleSelectionScreen();
      default:
        return const SizedBox();
    }
  }

  // ================== LOGIN SCREEN ==================
  Widget _buildLoginScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2ED),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(onBack: () => widget.onNavigate(ScreenId.welcome)),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Khu Vực Thành Viên",
                      style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFCC7A00),
                      ),
                    ),
                    const Text(
                      "Đăng Nhập",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Vui lòng đăng nhập để tiếp tục hành trình làm đẹp tinh xảo cùng BeautyGo.",
                      style: TextStyle(
                        fontSize: 13.5,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 32),

                    _buildTextField(
                      controller: emailCtrl,
                      label: "Email hoặc Số điện thoại",
                      hint: "Nhập email hoặc sđt",
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 20),
                    _buildPasswordField(
                      controller: passwordCtrl,
                      label: "Mật khẩu",
                      showPassword: showPassword,
                      onToggle:
                          () => setState(() => showPassword = !showPassword),
                    ),

                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: false, onChanged: (_) {}),
                            const Text("Ghi nhớ"),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Quên mật khẩu?"),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    _buildPrimaryButton(
                      text: "ĐĂNG NHẬP NGAY",
                      onPressed: _handleLogin,
                      isLoading: isSubmitting,
                    ),

                    const SizedBox(height: 28),
                    _buildDivider("Hoặc đăng nhập bằng"),
                    const SizedBox(height: 16),
                    _buildGoogleButton(() {
                      widget.onUserUpdate("Google Guest", "enthusiast");
                      widget.onNavigate(ScreenId.profile);
                    }),
                  ],
                ),
              ),
            ),
            _buildFooter(
              () => widget.onNavigate(ScreenId.register),
              isLogin: true,
            ),
          ],
        ),
      ),
    );
  }

  // ================== REGISTER SCREEN ==================
  Widget _buildRegisterScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2ED),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(onBack: () => widget.onNavigate(ScreenId.welcome)),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text(
                      "Gia Nhập Cộng Đồng",
                      style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFCC7A00),
                      ),
                    ),
                    const Text(
                      "Đăng Ký",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Gặp gỡ hàng triệu chuyên gia & học viên xuất sắc.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.5,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 32),

                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        children: [
                          _buildTextField(
                            controller: usernameCtrl,
                            label: "Tên học viên",
                            hint: "Ví dụ: thanh_lan",
                            icon: Icons.person,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: emailCtrl,
                            label: "Địa chỉ Email",
                            hint: "your@email.com",
                            icon: Icons.email,
                            errorText: emailError,
                          ),
                          const SizedBox(height: 16),
                          _buildPasswordField(
                            controller: passwordCtrl,
                            label: "Mật khẩu",
                            showPassword: showPassword,
                            onToggle:
                                () => setState(
                                  () => showPassword = !showPassword,
                                ),
                          ),
                          const SizedBox(height: 16),
                          _buildPasswordField(
                            controller: confirmPasswordCtrl,
                            label: "Xác nhận mật khẩu",
                            showPassword: showConfirmPassword,
                            onToggle:
                                () => setState(
                                  () =>
                                      showConfirmPassword =
                                          !showConfirmPassword,
                                ),
                            errorText: matchError,
                          ),
                          const SizedBox(height: 24),
                          _buildPrimaryButton(
                            text:
                                successMsg.isNotEmpty
                                    ? successMsg
                                    : "TẠO TÀI KHOẢN MỚI",
                            onPressed: _handleRegister,
                            isLoading: isSubmitting,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                    _buildDivider("Hoặc đăng ký với"),
                    const SizedBox(height: 16),
                    _buildGoogleSmallButton(() {
                      widget.onUserUpdate("Google Lover", "enthusiast");
                      widget.onNavigate(ScreenId.roleSelection);
                    }),
                  ],
                ),
              ),
            ),
            _buildFooter(
              () => widget.onNavigate(ScreenId.login),
              isLogin: false,
            ),
          ],
        ),
      ),
    );
  }

  // ================== ROLE SELECTION SCREEN ==================
  Widget _buildRoleSelectionScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2ED),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(
              onBack: () => widget.onNavigate(ScreenId.register),
              showRightSpacer: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Xác định phong cách",
                      style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFCC7A00),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Bạn truy cập\nvới vai trò nào?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Lựa chọn tư cách thành viên phù hợp nhất với trải nghiệm của bạn.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.5,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 32),

                    _buildRoleCard(
                      title: "HỌC VIÊN / KHÁCH HÀNG",
                      desc:
                          "Khám phá xu hướng dưỡng nhan, xem video hướng dẫn từ các chuyên gia, đặt dịch vụ chăm sóc.",
                      imageUrl:
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuBR5EiiaP26UjlkfQ20FbO6QU8MEvK9-rr_Jx0PaeqZA--gxKSWMP3Dgrmh36-FcAuodcu1p8FMN8Nr-PogsYCH5yjab16vhqHOKVeaBjj0ri4TUZwtchEXJfvnlUWLKz3hnnGDNiBlPlWL9VtftI1jTSFfVTMZHDSRRsyDPjNb7npsJQ7ssp7DQb1P_QLGEp8Y7mdZVPATpitwoB6NIax0Ymn1khkknnXN_ZSIE2pOm9xX-Ge8KgZ8jVukvGpVDgYG_r6WDrhvOGs",
                      isSelected: selectedRole == 'enthusiast',
                      onTap: () => setState(() => selectedRole = 'enthusiast'),
                    ),
                    const SizedBox(height: 16),
                    _buildRoleCard(
                      title: "CHUYÊN GIA / SALON",
                      desc:
                          "Quản lý tiệm làm đẹp, đăng tải bộ sưu tập phong cách, hướng dẫn học viên trực tuyến chất lượng cao.",
                      imageUrl:
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuD7kbeoU7_uaRmeGOr-CxDpfr2VXkt0LveGPt9uewQru_qmcfG3e5T637fLZTUNsNSGgGIx2u_GbtYdx1M5Y4ueI6_RC4TfznukUHI9HgrXUhWpGSUikPwxnY9wx9EG6hTgWRswYU1Ls5mczvYk5hLo93K9lnOjFfeqb0CsZrm5lWRBVWWS9CAg5_Nr29AXc3_TwxDqzyFB793p4MFr-RVx4VoZEMOdDmQPHOWHdE9KWK68P24z3xuwQtsWKbYOc5iJlul9OzcvN4o",
                      isSelected: selectedRole == 'professional',
                      onTap:
                          () => setState(() => selectedRole = 'professional'),
                    ),

                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.15),
                        border: Border.all(
                          color: Colors.amber.withOpacity(0.3),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info, color: Colors.amber, size: 20),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Bạn luôn có thể chuyển quyền hạn hoặc kích hoạt chế độ đối tác chuyên gia tại phần quản trị cá nhân bất cứ lúc nào.",
                              style: TextStyle(
                                fontSize: 12.5,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: _buildPrimaryButton(
                text: "TIẾP TỤC",
                onPressed: _handleRoleContinue,
                isLoading: isSubmitting,
                enabled: selectedRole != null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================== REUSABLE WIDGETS ==================
  Widget _buildHeader({
    required VoidCallback onBack,
    bool showRightSpacer = false,
  }) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.arrow_back), onPressed: onBack),
          const Text(
            "Học Viện BeautyGo",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 13.5,
              letterSpacing: 2,
            ),
          ),
          if (showRightSpacer) const Spacer(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey),
            hintText: hint,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFCC7A00)),
            ),
            errorText: errorText,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool showPassword,
    required VoidCallback onToggle,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: !showPassword,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock, color: Colors.grey),
            suffixIcon: IconButton(
              icon: Icon(
                showPassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: onToggle,
            ),
            hintText: "Nhập mật khẩu",
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFCC7A00)),
            ),
            errorText: errorText,
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    bool enabled = true,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A1A1A),
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          elevation: 0,
          minimumSize: const Size(double.infinity, 55),
        ),
        child:
            isLoading
                ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
                : Text(
                  text,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    fontSize: 13,
                  ),
                ),
      ),
    );
  }

  Widget _buildGoogleButton(VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.black12),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://www.google.com/images/branding/googleg/1x/googleg_standard_color_128dp.png",
              height: 22,
            ),
            const SizedBox(width: 10),
            const Text(
              "Tài khoản Google",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleSmallButton(VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black12),
        ),
        child: const Center(
          child: Text(
            "G",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(String text) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            text,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildFooter(VoidCallback onSwitch, {required bool isLogin}) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text.rich(
        TextSpan(
          text: isLogin ? "Chưa có tài khoản? " : "Đã có tài khoản? ",
          children: [
            WidgetSpan(
              child: GestureDetector(
                onTap: onSwitch,
                child: Text(
                  isLogin ? "Đăng ký ngay" : "Đăng nhập ngay",
                  style: const TextStyle(
                    color: Color(0xFFCC7A00),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildRoleCard({
    required String title,
    required String desc,
    required String imageUrl,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? Colors.white
                  : const Color(0xFFEBE7E0).withOpacity(0.6),
          border: Border.all(
            color: isSelected ? const Color(0xFFCC7A00) : Colors.black12,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                imageUrl,
                width: 68,
                height: 68,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFFCC7A00),
                          size: 22,
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    desc,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: Colors.grey,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
