import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_care/routes/router_helper.dart';
import 'package:green_care/utils/dimensions.dart';
import 'package:green_care/utils/colors.dart';
import 'package:green_care/widgets/big_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/image/logo.png',
                  height: 180,
                ),

                // Tên ứng dụng
                BigText(text:
                  'GreenCare',
                  size: Dimensions.font20*1.5,
                  color: AppColors.mainColor2,

                ),
                const SizedBox(height: 40),

                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined, color: AppColors.mainColor),
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

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    prefixIcon: Icon(Icons.lock_outline, color: AppColors.mainColor),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.mainColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
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
                const SizedBox(height: 30),

                // Nút đăng nhập
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
                        // TODO: xử lý đăng nhập ở đêy
                        Get.toNamed(RouterHelper.farms);
                      }
                    },
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Đăng ký / Quên mật khẩu
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Chưa có tài khoản? "),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouterHelper.signup);
                      },
                      child: Text(
                        'Đăng ký',
                        style: TextStyle(
                          color: AppColors.mainColor2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    // TODO: xử lý quên mật khẩu
                  },
                  child: const Text(
                    'Quên mật khẩu?',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
