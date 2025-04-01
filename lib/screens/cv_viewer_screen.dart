// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
//
// class CVViewerScreen extends StatelessWidget {
//   final String path;
//   final bool isOnline; // Thêm biến xác định file từ server hay local
//
//   const CVViewerScreen({super.key, required this.path, this.isOnline = false});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Xem CV (PDF)"),
//         backgroundColor: Colors.white,
//       ),
//       body: isOnline
//           ? WebView( // Nếu là file từ server, dùng WebView để hiển thị
//         initialUrl: path,
//         javascriptMode: JavascriptMode.unrestricted,
//       )
//           : PDFView( // Nếu là file cục bộ, dùng PDFView
//         filePath: path,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
class CVViewerScreen extends StatefulWidget {
  final String path;
  final bool isOnline;

  const CVViewerScreen({Key? key, required this.path, this.isOnline = false}) : super(key: key);

  @override
  _CVViewerScreenState createState() => _CVViewerScreenState();
}

class _CVViewerScreenState extends State<CVViewerScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.isOnline) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(widget.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Xem CV (PDF)"), backgroundColor: Colors.white),
      body: widget.isOnline
          ?  PDF().cachedFromUrl(widget.path)
          : PDFView( // Nếu là file cục bộ, dùng PDFView
         filePath: widget.path,
       ),
    );
  }
}
