import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_cubit.dart';
import 'package:jobsit_mobile/cubits/candidate/candidate_state.dart';
import 'package:jobsit_mobile/cubits/candidate/error_state.dart';
import 'package:jobsit_mobile/cubits/candidate/loading_state.dart';
import 'package:jobsit_mobile/cubits/candidate/login_success_state.dart';
import 'package:jobsit_mobile/cubits/candidate/no_logged_in_state.dart';
import 'package:jobsit_mobile/screens/edit_account_screen.dart';
import 'package:jobsit_mobile/screens/login_screen.dart';
import 'package:jobsit_mobile/services/base_services.dart';
import 'package:jobsit_mobile/services/candidate_services.dart';
import 'package:jobsit_mobile/utils/asset_constants.dart';
import 'package:jobsit_mobile/utils/color_constants.dart';
import 'package:jobsit_mobile/utils/text_constants.dart';
import 'package:jobsit_mobile/utils/value_constants.dart';
import 'package:jobsit_mobile/utils/widget_constants.dart';

import '../models/candidate.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _isAllowedSearch = false;
  bool _onReceiveEmail = false;
  late CandidateCubit _cubit;
  late Candidate _candidate;
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          TextConstants.profile,
          style: WidgetConstants.mainBold16Style,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CandidateCubit, CandidateState>(
          builder: (context, state) {
        if (state is NoLoggedInState) {
          return _buildNoLoggedInWidget();
        } else if (state is LoadingState) {
          return const Center(
            child: WidgetConstants.circularProgress,
          );
        } else if (state is ErrorState) {
          return Center(
            child: Text(state.errMessage),
          );
        } else if (state is LoginSuccessState) {
          _candidate = state.candidate;
          _token = state.token;
          _isAllowedSearch = state.candidate.searchable;
          _onReceiveEmail = state.candidate.mailReceive;
          return _buildProfile();
        } else {
          return const SizedBox();
        }
      }),
    );
  }

  Widget _buildNoLoggedInWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: double.infinity,
          child: Text(
            TextConstants.dontLoggedIn,
            style: WidgetConstants.blackBold16Style,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: ValueConstants.deviceHeightValue(uiValue: 10),
        ),
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ColorConstants.main),
            child: const Text(
              TextConstants.login,
              style: WidgetConstants.whiteBold16Style,
              textAlign: TextAlign.center,
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
        )
      ],
    );
  }

  Widget _buildProfile() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ValueConstants.deviceWidthValue(uiValue: 25),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 10),
            ),
            Container(
              width: ValueConstants.screenWidth * 0.25,
              height: ValueConstants.screenWidth * 0.25,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: ColorConstants.main, width: 2),
              ),
              child: ClipOval(
                child: _candidate.avatar != null
                    ? Image.network(
                        CandidateServices.getCandidateAvatarLink(
                            _candidate.avatar!),
                        width: ValueConstants.screenWidth * 0.25,
                        height: ValueConstants.screenWidth * 0.25,
                        errorBuilder: (context, object, stacktrace) =>
                            WidgetConstants.buildDefaultCandidateAvatar(),
                      )
                    : WidgetConstants.buildDefaultCandidateAvatar(),
              ),
            ),
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 15),
            ),
            Text(
              '${_candidate.firstName} ${_candidate.lastName}',
              style: WidgetConstants.userNameStyle,
            ),
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: const Icon(
                          Icons.person_outline_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ValueConstants.deviceHeightValue(uiValue: 5),
                    ),
                    const Text(
                      TextConstants.applied,
                      style: WidgetConstants.main11Style,
                    ),
                    SizedBox(
                      height: ValueConstants.deviceHeightValue(uiValue: 5),
                    ),
                    const Text(
                      '0',
                      style: WidgetConstants.blackBold12Style,
                    ),
                  ],
                ),
                SizedBox(
                  width: ValueConstants.deviceWidthValue(uiValue: 50),
                ),
                Column(
                  children: [
                    GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: const Icon(
                          Icons.home_repair_service_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ValueConstants.deviceHeightValue(uiValue: 5),
                    ),
                    const Text(
                      TextConstants.saved,
                      style: WidgetConstants.main11Style,
                    ),
                    SizedBox(
                      height: ValueConstants.deviceHeightValue(uiValue: 5),
                    ),
                    const Text(
                      '0',
                      style: WidgetConstants.blackBold12Style,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 10),
            ),
            SwitchListTile(
              value: _isAllowedSearch,
              onChanged: (value) {
                setState(() {
                  // _isAllowedSearch = !_isAllowedSearch;
                });
              },
              title: const Text(
                TextConstants.allowToSearch,
                style: WidgetConstants.black12Style,
              ),
              controlAffinity: ListTileControlAffinity.leading,
              thumbColor: const WidgetStatePropertyAll(Colors.white),
              trackColor: WidgetStatePropertyAll(
                  _isAllowedSearch ? ColorConstants.main : ColorConstants.grey),
              contentPadding: const EdgeInsets.all(0),
            ),
            SwitchListTile(
              value: _onReceiveEmail,
              onChanged: (value) {
                setState(() {
                  // _onReceiveEmail = !_onReceiveEmail;
                });
              },
              title: const Text(
                TextConstants.emailNotification,
                style: WidgetConstants.black12Style,
              ),
              controlAffinity: ListTileControlAffinity.leading,
              thumbColor: const WidgetStatePropertyAll(Colors.white),
              trackColor: WidgetStatePropertyAll(
                  _onReceiveEmail ? ColorConstants.main : ColorConstants.grey),
              contentPadding: const EdgeInsets.all(0),
            ),
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 20),
            ),
            ..._buildPersonalInfo(),
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 20),
            ),
            ..._buildJobInfo(),
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 20),
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: ValueConstants.deviceHeightValue(uiValue: 16),
                    horizontal: ValueConstants.deviceWidthValue(uiValue: 20)),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: const Border.fromBorderSide(
                      BorderSide(color: ColorConstants.main)),
                ),
                child: const Text(
                  TextConstants.changePassword,
                  style: WidgetConstants.mainBold16Style,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 10),
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: ValueConstants.deviceHeightValue(uiValue: 16),
                    horizontal: ValueConstants.deviceWidthValue(uiValue: 20)),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorConstants.main,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  TextConstants.logout,
                  style: WidgetConstants.whiteBold16Style,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 10),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPersonalInfo() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            TextConstants.personalInfo,
            style: WidgetConstants.mainBold16Style,
          ),
          GestureDetector(
            child: SvgPicture.asset(
              AssetConstants.iconEdit,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditAccountScreen(),
                    settings: RouteSettings(arguments: {
                      TextConstants.candidate: _candidate,
                      TextConstants.token: _token,
                    })),
              );
            },
          )
        ],
      ),
      SizedBox(
        height: ValueConstants.deviceHeightValue(uiValue: 10),
      ),
      Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            _buildPersonalInfoItem(
                AssetConstants.iconMessage, _candidate.email),
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 10),
            ),
            _buildPersonalInfoItem(AssetConstants.iconCall, _candidate.phone),
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 10),
            ),
            _buildPersonalInfoItem(AssetConstants.iconLocation,
                _candidate.location ?? TextConstants.noData),
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 10),
            ),
            _buildPersonalInfoItem(
                AssetConstants.iconHome,
                _candidate.university != null
                    ? (_candidate.university![CandidateServices.nameKey] ??
                        TextConstants.noData)
                    : TextConstants.noData),
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 10),
            ),
            _buildPersonalInfoItem(AssetConstants.iconCalendar,
                _candidate.birthdate ?? TextConstants.noData),
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 10),
            ),
            _buildPersonalInfoItem(AssetConstants.iconProfile,
                _candidate.gender != null ? (_candidate.gender == true ? TextConstants.male : TextConstants.female) : TextConstants.noData)
          ],
        ),
      )
    ];
  }

  Widget _buildPersonalInfoItem(String asset, String info) {
    return Row(
      children: [
        SvgPicture.asset(asset),
        SizedBox(
          width: ValueConstants.deviceWidthValue(uiValue: 10),
        ),
        Expanded(
            child: Text(
          info,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ))
      ],
    );
  }

  List<Widget> _buildJobInfo() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            TextConstants.jobInfo,
            style: WidgetConstants.mainBold16Style,
          ),
          GestureDetector(
              child: SvgPicture.asset(
            AssetConstants.iconEdit,
          ))
        ],
      ),
      SizedBox(
        height: ValueConstants.deviceHeightValue(uiValue: 10),
      ),
      Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              TextConstants.jobWanted,
              style: WidgetConstants.blackBold16Style,
            ),
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 5),
            ),
            const Text(
              TextConstants.noData,
            ),
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 10),
            ),
            ..._buildJobInfoItem(
                TextConstants.jobPosition, TextConstants.noData),
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 10),
            ),
            ..._buildJobInfoItem(TextConstants.major, TextConstants.noData),
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 10),
            ),
            ..._buildJobInfoItem(
                TextConstants.jobSchedule, TextConstants.noData),
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 10),
            ),
            const Text(
              TextConstants.jobLocation,
              style: WidgetConstants.blackBold16Style,
            ),
            Row(
              children: [
                SvgPicture.asset(AssetConstants.iconLocation),
                SizedBox(
                  width: ValueConstants.deviceWidthValue(uiValue: 10),
                ),
                const Text(TextConstants.noData),
              ],
            ),
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 10),
            ),
            const Text(
              TextConstants.cv,
              style: WidgetConstants.blackBold16Style,
            ),
            _candidate.cv != null
                ? Image.asset(
                    AssetConstants.exCV,
                    width: double.infinity,
                  )
                : const Text(TextConstants.noData),
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 10),
            ),
            const Text(
              TextConstants.coverLetter,
              style: WidgetConstants.blackBold16Style,
            ),
            SizedBox(
              height: ValueConstants.deviceHeightValue(uiValue: 5),
            ),
            const Text(TextConstants.noData),
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildJobInfoItem(String title, String content) {
    return [
      Text(
        title,
        style: WidgetConstants.blackBold16Style,
      ),
      SizedBox(
        height: ValueConstants.deviceHeightValue(uiValue: 5),
      ),
      Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: ColorConstants.main),
        child: Text(
          content,
          style: WidgetConstants.white12Style,
        ),
      )
    ];
  }
}
