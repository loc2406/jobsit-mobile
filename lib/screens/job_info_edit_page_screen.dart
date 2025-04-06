import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsit_mobile/models/province.dart';
import 'package:jobsit_mobile/screens/single_select_drop_down_screen.dart';

import '../cubits/job/job_cubit.dart';
import '../utils/color_constants.dart';
import '../utils/value_constants.dart';
import 'multi_select_dropdown_screen.dart';

class JobInfoEditPageScreen extends StatefulWidget {
  const JobInfoEditPageScreen({super.key});
  @override
  _JobInfoEditPageScreenState createState() => _JobInfoEditPageScreenState();
}

class _JobInfoEditPageScreenState extends State<JobInfoEditPageScreen> {
  final TextEditingController jobWantedController = TextEditingController();
  final TextEditingController cvController = TextEditingController();
  final TextEditingController coverLetterController = TextEditingController();
  late final JobCubit _cubit;

  final List<String> positionOptions =
  ValueConstants.positions.map((e) => e["name"] as String).toList();
  final List<String> majorOptions =
  ValueConstants.majors.map((e) => e["name"] as String).toList();
  final List<String> jobTypeOptions =
  ValueConstants.schedules.map((e) => e["name"] as String).toList();

  List<Province> _provinces = [];

  @override
  void initState() {
    super.initState();
    _cubit = context.read<JobCubit>();
    _getProvinces();
  }

  Future<void> _getProvinces() async {
    final provinces = await _cubit.getProvinces();
    setState(() {
      _provinces = provinces;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.main,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Job Information',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            _buildLabel("Job Wanted"),
            _buildTextField(jobWantedController, "Flutter Developer"),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 100,
              // Đặt chiều cao mong muốn
              child: MultiSelectDropdownScreen(
                  title: 'Position',
                  options: positionOptions,
                  selectedOptions: []),
            ),
            SizedBox(
              height: 100,
              // Đặt chiều cao mong muốn
              child: MultiSelectDropdownScreen(
                title: 'Major',
                options: majorOptions,
                selectedOptions: [],
              ),
            ),
            SizedBox(
              height: 110,
              child: MultiSelectDropdownScreen(
                title: 'Job Type',
                options: jobTypeOptions,
                selectedOptions: [],
              ),
            ),
            SizedBox(
              height: 100,
              child: SingleSelectDropdown(
                title: 'Location',
                options: _provinces.map((province) => province.name).toList(),
              ),
            ),
            _buildLabel("CV"),
            _buildTextField(cvController, "CV Placeholder"),
            _buildLabel("Cover Letter"),
            _buildMultilineTextField(coverLetterController,
                "Write a brief introduction about yourself"),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  print("Saved!");
                },
                child: const Text("Save",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String placeholder) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          // Viền mặc định (màu vàng nhạt)
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.amber.shade300, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          // Viền khi nhập (màu vàng đậm)
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.amber.shade700, width: 2),
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      ),
    );
  }

  Widget _buildMultilineTextField(
      TextEditingController controller, String placeholder) {
    return TextField(
      controller: controller,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          // Viền mặc định (màu vàng nhạt)
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.amber.shade300, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          // Viền khi nhập (màu vàng đậm)
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.amber.shade700, width: 2),
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Text(
            " *",
            style: TextStyle(
                color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}