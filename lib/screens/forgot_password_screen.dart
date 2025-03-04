// import 'package:flutter/material.dart';
// import 'package:jobsit_mobile/utils/asset_constants.dart';
// import '../utils/text_constants.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ForgotPasswordScreen(),
//     );
//   }
// }
//
// class ForgotPasswordScreen extends StatefulWidget {
//   @override
//   _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
// }
//
// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   final TextEditingController _emailController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 2,
//         title: Row(
//           children: [
//             Image.asset(
//               TextConstants.splashLogoAsset,
//               height: 30,
//             ),
//             const Spacer(),
//             Row(
//               children: [
//                 Image.asset(AssetConstants.iconVN, width: 24),
//                 const Icon(Icons.arrow_drop_down, color: Colors.black),
//               ],
//             ),
//             const SizedBox(width: 10),
//             TextButton(
//               onPressed: () {},
//               child: const Text("Đăng ký", style: TextStyle(color: Colors.black)),
//             ),
//             TextButton(
//               onPressed: () {},
//               child: const Text("Đăng nhập", style: TextStyle(color: Colors.black)),
//             ),
//           ],
//         ),
//       ),
//       body: Center(
//         child: Container(
//           width: screenWidth * 0.9,
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 5,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 "Quên mật khẩu",
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 "Xin vui lòng nhập địa chỉ email để lấy lại mật khẩu.",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//               const SizedBox(height: 20),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: const Text("Nhập Email*", style: TextStyle(fontWeight: FontWeight.bold)),
//               ),
//               const SizedBox(height: 5),
//               TextField(
//                 controller: _emailController, // Gán controller cho TextField
//                 decoration: InputDecoration(
//                   hintText: "Vui lòng nhập email...",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.amber,
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   onPressed: () {
//                     String email = _emailController.text;
//                     if (email.isNotEmpty) {
//                       print("Gửi yêu cầu đặt lại mật khẩu cho: $email");
//                       // Ở đây bạn có thể gọi API gửi email đặt lại mật khẩu
//                     } else {
//                       print("Vui lòng nhập email.");
//                     }
//                   },
//                   child: const Text("Lấy lại mật khẩu", style: TextStyle(fontSize: 16)),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   "Quay về trang đăng nhập",
//                   style: TextStyle(color: Colors.blue),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jobsit_mobile/utils/asset_constants.dart';
import '../cubits/candidate/candidate_cubit.dart';

import '../utils/text_constants.dart';
import 'change_password_by_otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  late final CandidateCubit _cubit;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubit = context.read<CandidateCubit>();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Row(
          children: [
            Image.asset(
              TextConstants.splashLogoAsset,
              height: 30,
            ),
            const Spacer(),
            Row(
              children: [
                Image.asset(AssetConstants.iconVN, width: 24),
                const Icon(Icons.arrow_drop_down, color: Colors.black),
              ],
            ),
            const SizedBox(width: 10),
            TextButton(
              onPressed: () {},
              child:
                  const Text("Đăng ký", style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Đăng nhập",
                  style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          width: screenWidth * 0.9,
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
                child: const Text("Nhập Email*",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: _emailController, // Gán controller cho TextField
                decoration: InputDecoration(
                  hintText: "Vui lòng nhập email...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
                  onPressed: handleBtnForgotPasswordClicked,
                  child: const Text("Lấy lại mật khẩu",
                      style: TextStyle(fontSize: 16)),
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

  Future<void> handleBtnForgotPasswordClicked() async {
    String email = _emailController.text.trim();
    if (email.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Yêu cầu đặt lại mật khẩu đã gửi đến $email"),
          backgroundColor: Colors.green,
        ),
      );
      await _cubit.sendEmailForgotPassWord(email);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ChangePasswordByOtpScreen(
                    email: _emailController.text,
                  )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Vui lòng nhập email"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
