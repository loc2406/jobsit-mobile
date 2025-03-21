// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SaveImageScreen(),
//     );
//   }
// }
//
// class SaveImageScreen extends StatefulWidget {
//   const SaveImageScreen({super.key});
//
//   @override
//   _SaveImageScreenState createState() => _SaveImageScreenState();
// }
//
// class _SaveImageScreenState extends State<SaveImageScreen> {
//   TextEditingController _urlController = TextEditingController();
//   String? _imageUrl;
//   String? _savedPath;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Tải & Lưu Ảnh")),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _urlController,
//               decoration: InputDecoration(
//                 labelText: "Nhập link ảnh từ mạng",
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.check),
//                   onPressed: () {
//                     setState(() {
//                       _imageUrl = _urlController.text.trim();
//                     });
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//
//             // Hiển thị ảnh nếu có URL hợp lệ
//             _imageUrl != null && _imageUrl!.isNotEmpty
//                 ? Image.network(_imageUrl!, height: 200, width: 200, fit: BoxFit.cover)
//                 : Text("Nhập URL ảnh và nhấn nút để xem"),
//
//             SizedBox(height: 20),
//
//             // Nút lưu ảnh vào bộ nhớ
//             ElevatedButton(
//               onPressed: _imageUrl != null ? _saveImage : null,
//               child: Text("Lưu Ảnh Vào Thiết Bị"),
//             ),
//
//             SizedBox(height: 20),
//
//             // Hiển thị thông báo đường dẫn ảnh đã lưu
//             _savedPath != null
//                 ? Text("Ảnh đã lưu: $_savedPath", style: TextStyle(fontSize: 14, color: Colors.green))
//                 : Container(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// 🖼️ Hàm tải và lưu ảnh vào thư viện ảnh
//   Future<void> _saveImage() async {
//     try {
//       // Yêu cầu quyền lưu trữ
//       if (await Permission.storage.request().isGranted) {
//         // Tải ảnh về dạng bytes
//         var response = await Dio().get(_imageUrl!, options: Options(responseType: ResponseType.bytes));
//
//         // Lưu vào thư viện ảnh
//         final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
//
//         setState(() {
//           _savedPath = result['filePath'];
//         });
//
//         print("Ảnh đã lưu tại: $_savedPath");
//       } else {
//         print("Chưa cấp quyền lưu ảnh!");
//       }
//     } catch (e) {
//       print("Lỗi khi tải ảnh: $e");
//     }
//   }
// }
