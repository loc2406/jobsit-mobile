import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobsit_mobile/utils/color_constants.dart';
import 'package:jobsit_mobile/utils/text_constants.dart';
import 'package:jobsit_mobile/utils/value_constants.dart';
import 'package:jobsit_mobile/utils/widget_constants.dart';
import 'package:path/path.dart' as path;

class ApplyBottomSheet extends StatefulWidget {
  const ApplyBottomSheet({super.key});

  @override
  State<ApplyBottomSheet> createState() => _ApplyBottomSheetState();
}

class _ApplyBottomSheetState extends State<ApplyBottomSheet> {

  File? _selectedCV;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text(TextConstants.attachedCV, style: WidgetConstants.mainBold16Style),
          SizedBox(height: ValueConstants.deviceHeightValue(uiValue: 20),),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorConstants.main),
                borderRadius: BorderRadius.circular(8)
              ),
              alignment: Alignment.center,
              child: _selectedCV != null ? Text(path.basename(_selectedCV!.path), style: WidgetConstants.blackBold16Style,) : const Text(TextConstants.addNewCV, style: WidgetConstants.blackBold16Style,),
            ),
          ),
          SizedBox(height: ValueConstants.deviceHeightValue(uiValue: 47),),
          const Text(TextConstants.coverLetter, style: WidgetConstants.mainBold16Style),
          SizedBox(height: ValueConstants.deviceHeightValue(uiValue: 20),),
          TextField(
            controller: _controller,
            minLines: 5,
            decoration: const InputDecoration(
              hintText: TextConstants.coverLetterHint,
              hintStyle: WidgetConstants.gray12Style
            )
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                color: ColorConstants.main,
                borderRadius: BorderRadius.circular(16)
              ),
              alignment: Alignment.center,
              child: const Text(TextConstants.submit, style: WidgetConstants.whiteBold16Style,),
            ),
          )
        ],
      ),
    );
  }
}
