import 'package:flutter/material.dart';

import '../utils/color_constants.dart';

class SingleSelectDropdown extends StatefulWidget {
  final String title;
  final List<String> options;

  const SingleSelectDropdown({
    Key? key,
    required this.title,
    required this.options,
  }) : super(key: key);

  @override
  _SingleSelectDropdownState createState() => _SingleSelectDropdownState();
}

class _SingleSelectDropdownState extends State<SingleSelectDropdown> {
  String? selectedOption; // Chỉ lưu một giá trị
  bool isDropdownOpen = false;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _key = GlobalKey();

  @override
  void dispose() {
    _hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Text(
                " *",
                style: TextStyle(
                    color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(height: 6),
          CompositedTransformTarget(
            link: _layerLink,
            child: Container(
              key: _key,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: ColorConstants.main),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: selectedOption == null
                        ? const Text(
                      "Ho Chi Minh city",
                      style: TextStyle(color: Colors.grey),
                    )
                        : Align( // Căn trái nội dung
                      alignment: Alignment.centerLeft,
                      child: Chip(
                        label: Text(selectedOption!),
                        onDeleted: () {
                          setState(() {
                            selectedOption = null;
                          });
                        },
                      ),
                    ),
                  ),

                  IconButton(
                    icon: !isDropdownOpen ? const Icon(Icons.keyboard_arrow_down) : const Icon(Icons.keyboard_arrow_up),
                    onPressed: () {
                      setState(() {
                        isDropdownOpen = !isDropdownOpen;
                      });
                      if (isDropdownOpen) {
                        _showOverlay();
                      } else {
                        _hideOverlay();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final boxSize = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: boxSize.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, boxSize.height + 5),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: boxSize.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.options.map((option) {
                  return ListTile(
                    title: Text(option),
                    onTap: () {
                      setState(() {
                        selectedOption = option; // Cập nhật lựa chọn
                        isDropdownOpen = false;
                        _hideOverlay();
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
    overlay?.insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      isDropdownOpen = false;
    });
  }
}