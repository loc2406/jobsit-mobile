import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:jobsit_mobile/services/job_services.dart';
import 'package:jobsit_mobile/utils/color_constants.dart';
import 'package:jobsit_mobile/utils/convert_constants.dart';
import 'package:jobsit_mobile/utils/text_constants.dart';
import 'package:jobsit_mobile/utils/value_constants.dart';

class FilterBottomSheet extends StatefulWidget {
  FilterBottomSheet(
      {super.key,
      required this.selectedLocation,
      required this.selectedScheduleId,
      required this.selectedPositionId,
      required this.selectedMajorId,
      required this.provinces,
      required this.onApply});

  late String selectedLocation;
  late int selectedScheduleId;
  late int selectedPositionId;
  late int selectedMajorId;
  late List<String> provinces;
  late void Function(String, String, String, String) onApply;

  @override
  State<StatefulWidget> createState() => FilterBottomSheetState();
}

class FilterBottomSheetState extends State<FilterBottomSheet> {
  late String _selectedLocation;
  late int _selectedScheduleId;
  late int _selectedPositionId;
  late int _selectedMajorId;
  late List<String> _provinces;
  late void Function(String, String, String, String) _onApply;

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.selectedLocation;
    _selectedScheduleId = widget.selectedScheduleId;
    _selectedPositionId = widget.selectedPositionId;
    _selectedMajorId = widget.selectedMajorId;
    _provinces = widget.provinces;
    _onApply = widget.onApply;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: ValueConstants.deviceHeightValue(uiValue: 30),
          horizontal: ValueConstants.deviceWidthValue(uiValue: 25)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: ColorConstants.main,
              ),
              Text(
                TextConstants.location,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.main),
              )
            ],
          ),
          SizedBox(
            height: ValueConstants.deviceHeightValue(uiValue: 15),
          ),
          DropdownButton<String>(
            menuMaxHeight: ValueConstants.screenHeight * 0.15,
            isExpanded: true,
            items: _buildListProvinces(),
            value:  _selectedLocation,
            onChanged: (String? value) {
              setState(() {
                _selectedLocation = value!;
              });
            },
          ),
          SizedBox(
            height: ValueConstants.deviceHeightValue(uiValue: 15),
          ),
          ...buildFilterSection(TextConstants.jobSchedule,
              ValueConstants.schedules, _selectedScheduleId, (id) {
            setState(() {
              _selectedScheduleId = id;
            });
          }),
          SizedBox(
            height: ValueConstants.deviceHeightValue(uiValue: 15),
          ),
          ...buildFilterSection(TextConstants.jobPosition,
              ValueConstants.positions, _selectedPositionId, (id) {
            setState(() {
              _selectedPositionId = id;
            });
          }),
          SizedBox(
            height: ValueConstants.deviceHeightValue(uiValue: 15),
          ),
          ...buildFilterSection(
              TextConstants.major, ValueConstants.majors, _selectedMajorId,
              (id) {
            setState(() {
              _selectedMajorId = id;
            });
          }),
          SizedBox(
            height: ValueConstants.deviceHeightValue(uiValue: 30),
          ),
          GestureDetector(
            onTap: handleApplyFilter,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  vertical: ValueConstants.deviceHeightValue(uiValue: 16),
                  horizontal: ValueConstants.deviceWidthValue(uiValue: 20)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: ColorConstants.main),
              child: const Text(
                textAlign: TextAlign.center,
                TextConstants.applyFilter,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildListProvinces(){
    return [
      const DropdownMenuItem(
        value: '',
        child: Text(TextConstants.selectLocation),
      ),
      ..._provinces
          .map((province) => DropdownMenuItem(
        value: province,
        child: Text(province),
      ))
    ];
  }

  List<Widget> buildFilterSection(
      String title,
      List<Map<String, dynamic>> options,
      int selectedId,
      void Function(int id) onSelectedItem) {
    return [
      Text(
        title,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: ColorConstants.main),
      ),
      SizedBox(
        height: ValueConstants.deviceHeightValue(uiValue: 5),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filterItem(options, selectedId, onSelectedItem),
        ),
      )
    ];
  }

  List<Widget> filterItem(List<Map<String, dynamic>> options, int selectedId,
      void Function(int id) onSelectedItem) {
    return options
        .map((item) => GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.only(
                    right: ValueConstants.deviceWidthValue(uiValue: 10)),
                decoration: BoxDecoration(
                    color: item[JobServices.idKey] == selectedId
                        ? ColorConstants.main
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: const Border.fromBorderSide(
                        BorderSide(color: ColorConstants.main))),
                child: Text(
                  item[JobServices.nameKey].toString(),
                  style: TextStyle(
                      color: item[JobServices.nameKey] == selectedId
                          ? Colors.white
                          : Colors.black,
                      fontSize: 13),
                ),
              ),
              onTap: () => onSelectedItem(item[JobServices.idKey]),
            ))
        .toList();
  }

  void handleApplyFilter() {
    String scheduleName = ConvertConstants.getNameById(ValueConstants.schedules, _selectedScheduleId);
    String positionName = ConvertConstants.getNameById(ValueConstants.positions, _selectedPositionId);
    String majorName = ConvertConstants.getNameById(ValueConstants.majors, _selectedMajorId);
    debugPrint("$_selectedLocation ---$scheduleName --- $positionName --- $majorName");
    Navigator.pop(context);
    _onApply(_selectedLocation, scheduleName, positionName, majorName);
  }
}
