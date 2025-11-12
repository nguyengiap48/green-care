import 'package:flutter/material.dart';
import 'package:green_care/utils/dimensions.dart';
import 'package:green_care/utils/colors.dart';
import 'package:green_care/widgets/big_text.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FFF7),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Logo
                Image.asset(
                  'assets/image/logo.png',
                  height: 180,
                ),

                // Tiêu đề
                BigText(
                  text: 'Tạo tài khoản mới',
                  size: Dimensions.font20*1.5,
                  color: AppColors.mainColor2,
                ),
                const SizedBox(height: 30),

                // Họ tên
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Họ và tên',
                    prefixIcon:
                     Icon(Icons.person_outline, color: AppColors.mainColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Vui lòng nhập họ và tên' : null,
                ),
                const SizedBox(height: 20),

                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon:
                     Icon(Icons.email_outlined, color: AppColors.mainColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Vui lòng nhập email' : null,
                ),
                const SizedBox(height: 20),

                // Mật khẩu
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    prefixIcon:
                     Icon(Icons.lock_outline, color: AppColors.mainColor),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.mainColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Vui lòng nhập mật khẩu' : null,
                ),
                const SizedBox(height: 20),

                // Xác nhận mật khẩu
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirm,
                  decoration: InputDecoration(
                    labelText: 'Xác nhận mật khẩu',
                    prefixIcon:
                     Icon(Icons.lock_outline, color: AppColors.mainColor),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirm
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.mainColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirm = !_obscureConfirm;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập lại mật khẩu';
                    } else if (value != _passwordController.text) {
                      return 'Mật khẩu không khớp';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // Nút đăng ký
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColor2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO: Xử lý đăng ký tài khoản
                      }
                    },
                    child: const Text(
                      'Đăng ký',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Chuyển sang đăng nhập
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Đã có tài khoản? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Đăng nhập',
                        style: TextStyle(
                          color: AppColors.mainColor2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
