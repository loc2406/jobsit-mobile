import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../utils/text_constants.dart';

import 'package:firebase_auth/firebase_auth.dart';
void main() async {
  //WidgetsFlutterBinding.ensureInitialized(); // Đảm bảo Flutter đã khởi tạo
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Khởi tạo Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ForgotPasswordScreen(),
    );
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Lấy chiều rộng màn hình

    return Scaffold(
      backgroundColor: Colors.grey[100], // Màu nền nhẹ
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Row(
          children: [
            Image.asset(
              TextConstants.splashLogoAsset,
              height: 30, // Logo nhỏ lại
            ),
            const Spacer(),
            Row(
              children: [
                Image.asset(TextConstants.vn, width: 24),
                const Icon(Icons.arrow_drop_down, color: Colors.black),
              ],
            ),
            const SizedBox(width: 10),
            TextButton(
              onPressed: () {},
              child: const Text("Đăng ký", style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Đăng nhập", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          width: screenWidth * 0.9, // Responsive theo màn hình
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Quên mật khẩu",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Xin vui lòng nhập địa chỉ email để lấy lại mật khẩu.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text("Nhập Email*", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  hintText: "Vui lòng nhập email...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Lấy lại mật khẩu", style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Quay về trang đăng nhập",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// class ForgotPasswordScreen extends StatefulWidget {
//   @override
//   _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
// }
//
// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   final TextEditingController _emailController = TextEditingController();
//
//   Future<void> _resetPassword() async {
//     try {
//       await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Email đặt lại mật khẩu đã được gửi!")),
//       );
//     } catch (e) {
//       print("Lỗiiiii: ${e.toString()}");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Lỗi: ${e.toString()}")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Quên mật khẩu")),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             const Text(
//               "Nhập email để nhận liên kết đặt lại mật khẩu:",
//               style: TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: _emailController,
//               keyboardType: TextInputType.emailAddress,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "Nhập email của bạn",
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _resetPassword,
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
//               child: const Text("Lấy lại mật khẩu"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
