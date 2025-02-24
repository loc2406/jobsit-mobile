import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_cubit.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_state.dart';
import 'package:jobsit_mobile/cubits/candidate/login_success_state.dart';
import 'package:jobsit_mobile/cubits/job/job_cubit.dart';
import 'package:jobsit_mobile/services/candidate_services.dart';
import 'package:jobsit_mobile/utils/validate_constants.dart';
import 'package:jobsit_mobile/utils/value_constants.dart';
import 'package:jobsit_mobile/widgets/input_field.dart';

import '../models/candidate.dart';
import '../utils/color_constants.dart';
import '../utils/text_constants.dart';
import '../utils/widget_constants.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  late Candidate _candidate;
  late CandidateCubit _cubit;
  final _formKey = GlobalKey<FormState>();
  File? _selectedImg;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dateController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedGender = TextConstants.male;
  String _selectedProvinces = '';
  late String _token;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CandidateCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text(
          TextConstants.personalInfo,
          style: WidgetConstants.mainBold16Style,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CandidateCubit, CandidateState>(
          builder: (context, state) {
            if (state is LoginSuccessState) {
              _candidate = state.candidate;
              _token = state.token;
              return _buildEditWidget();
            }

            return const Center(
              child: Text(
                TextConstants.noData,
                style: WidgetConstants.mainBold16Style,
              ),
            );
          }),
    );
  }

  Widget _buildEditWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ValueConstants.deviceWidthValue(uiValue: 25)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: _selectImgFromGallery,
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                        BorderSide(color: ColorConstants.main, width: 2))),
                child: ClipOval(
                  child: _selectedImg != null
                      ? Image.file(_selectedImg!)
                      : (_candidate.avatar != null
                      ? Image.network(
                    CandidateServices.getCandidateAvatarLink(
                        _candidate.avatar!),
                    width: 75,
                    height: 75,
                  )
                      : const Icon(
                    Icons.person_outline,
                    color: ColorConstants.main,
                    size: 75,
                  )),
                )
              ),
            ),
            Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._buildInputField(
                        title: TextConstants.firstName,
                        label: TextConstants.firstName,
                        controller: _firstNameController,
                        validateMethod: ValidateConstants.validateFirstName,
                        keyboardType: TextInputType.text),
                    ..._buildInputField(
                        title: TextConstants.lastName,
                        label: TextConstants.lastName,
                        controller: _lastNameController,
                        validateMethod: ValidateConstants.validateLastName,
                        keyboardType: TextInputType.text),
                    ..._buildInputField(
                        title: TextConstants.email,
                        label: TextConstants.email,
                        controller: _emailController,
                        validateMethod: ValidateConstants.validateEmailRegister,
                        keyboardType: TextInputType.emailAddress),
                    ..._buildTitle(TextConstants.birthdate),
                    TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "DD/MM/YYYY",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        hintStyle: const TextStyle(color: ColorConstants.grey),
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                        enabledBorder: WidgetConstants.inputFieldBorder,
                        focusedBorder: WidgetConstants.inputFieldBorder,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onTap: () => _showDatePicker(),
                    ),
                    ..._buildInputField(
                        title: TextConstants.phone,
                        label: TextConstants.phone,
                        controller: _phoneController,
                        validateMethod: ValidateConstants.validatePhone,
                        keyboardType: TextInputType.phone),
                    ..._buildSelectGenderField(),
                    ..._buildSelectCityField(),
                    SizedBox(
                      height: ValueConstants.deviceHeightValue(uiValue: 20),
                    ),
                    GestureDetector(
                      onTap: _handleUpdateInfo,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: ValueConstants.deviceHeightValue(
                                uiValue: 16),
                            horizontal: ValueConstants.deviceWidthValue(
                                uiValue: 20)),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorConstants.main,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          TextConstants.save,
                          style: WidgetConstants.whiteBold16Style,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ValueConstants.deviceHeightValue(uiValue: 10),),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Future<void> _selectImgFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImg = File(image.path);
      });
    }
  }

  List<Widget> _buildTitle(String title) {
    return [
      SizedBox(
        height: ValueConstants.deviceHeightValue(uiValue: 20),
      ),
      Text(
        title,
        style: WidgetConstants.mainBold16Style,
      ),
      SizedBox(
        height: ValueConstants.deviceHeightValue(uiValue: 10),
      ),
    ];
  }

  List<Widget> _buildInputField({required String title,
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validateMethod,
    required TextInputType keyboardType}) {
    return [
      ..._buildTitle(title),
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: ColorConstants.grey),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          enabledBorder: WidgetConstants.inputFieldBorder,
          focusedBorder: WidgetConstants.inputFieldBorder,
          errorStyle: const TextStyle(
              color: Colors.red, fontSize: 13, fontStyle: FontStyle.italic),
          errorBorder: WidgetConstants.inputFieldBorder,
          focusedErrorBorder: WidgetConstants.inputFieldBorder,
        ),
        validator: validateMethod,
        keyboardType: keyboardType,
      )
    ];
  }

  Future<void> _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text =
        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  List<Widget> _buildSelectGenderField() {
    return [
      ..._buildTitle(TextConstants.gender),
      DropdownButtonFormField<String>(
        value: _selectedGender,
        decoration: InputDecoration(
          enabledBorder: WidgetConstants.inputFieldBorder,
          focusedBorder: WidgetConstants.inputFieldBorder,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 8),
        ),
        items: const [
          DropdownMenuItem(
            value: TextConstants.male,
            child: Text(TextConstants.male,
              style: TextStyle(color: ColorConstants.grey),),
          ),
          DropdownMenuItem(
            value: TextConstants.female,
            child: Text(TextConstants.female,
                style: TextStyle(color: ColorConstants.grey)),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _selectedGender = value!;
          });
        },
        icon: const Icon(Icons.arrow_drop_down),
      )
    ];
  }

  List<Widget> _buildSelectCityField() {
    return [
      ..._buildTitle(TextConstants.city),
      DropdownButtonFormField<String>(
        value: _selectedProvinces,
        decoration: InputDecoration(
          enabledBorder: WidgetConstants.inputFieldBorder,
          focusedBorder: WidgetConstants.inputFieldBorder,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 8),
        ),
        items: [],
        onChanged: (value) {
          setState(() {
            _selectedProvinces = value!;
          });
        },
        icon: const Icon(Icons.arrow_drop_down),
      )
    ];
  }

  Future<void> _handleUpdateInfo() async {
    if ((_formKey.currentState as FormState).validate()) {
      await _cubit.updateInfo(candidateId: _candidate.id,
          token: _token,
          avatar: _selectedImg,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          birthdate: _dateController.text,
          phone: _phoneController.text,
          gender: _selectedGender);

      if (mounted){
        Navigator.pop(context);
      }
    }
  }
}
