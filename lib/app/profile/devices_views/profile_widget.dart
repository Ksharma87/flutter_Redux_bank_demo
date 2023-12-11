import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/app/profile/devices_views/profile_viewModel.dart';
import 'package:flutter_redux_bank/app/utils/screen_config/ScreenConfig.dart';
import 'package:flutter_redux_bank/app/utils/view/profile_view/profile_view_utils.dart';
import 'package:flutter_redux_bank/common/types/gender_type.dart';
import 'package:flutter_redux_bank/common/extensions/money_format_extension.dart';
import 'package:flutter_redux_bank/config/font/font_type.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/preferences/preferences.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/services/balance_service.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileWidget extends StatelessWidget {
  ProfileWidget({super.key, required this.boxConstraints});

  final BoxConstraints boxConstraints;
  final String? uid =
      PreferencesManager().getPreferencesValue(PreferencesContents.userUid);
  final ProfileViewUtils _profileViewUtils = ProfileViewUtils();
  final Stream<String> updateBalance =
      BalanceUpdateService().updateBalanceStream();
  final PreferencesManager manager = PreferencesManager();

  @override
  Widget build(BuildContext context) {
    return _body(boxConstraints);
  }

  Widget _body(BoxConstraints constraints) {
    return _buildStore();
  }

  Widget _buildStore() {
    return StoreConnector<AppState, ProfileViewModel>(
        distinct: true,
        onInit: (store) {},
        onWillChange: (oldVm, newVm) {},
        onDidChange: (oldVm, newVm) {},
        onInitialBuild: (profileViewModel) {},
        converter: (store) {
          return ProfileViewModel.fromStore(store);
        },
        builder: (BuildContext context, ProfileViewModel vm) {
          return Builder(builder: (BuildContext context) {
            return _buildView(vm);
          });
        });
  }

  Widget _buildView(ProfileViewModel vm) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: Stack(
                    children: [
                      Center(
                          child: SizedBox(
                              width: 120.h,
                              height: 120.h,
                              child: Card(
                                color: ColorsTheme.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all((const Radius.circular(15).w)),
                                ),
                              ))),
                      SizedBox(
                        child: Center(
                            child: _profileViewUtils.profileImageHolder(
                                vm.profileState.mobileNumber,
                                vm.profileState.isMale)),
                      )
                    ],
                  )),
                  Expanded(
                      child: SizedBox(
                          height: 120.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                  _profileViewUtils.profileName(
                                      vm.profileState.firstName,
                                      vm.profileState.lastName),
                                  style: TextStyle(
                                    fontFamily: FontType.fontRobotoRegular,
                                    fontSize: 18.sp,
                                  )),
                              Text(vm.profileState.mobileNumber,
                                  style: TextStyle(
                                    fontFamily: FontType.fontRobotoLight,
                                    fontSize: 16.sp,
                                  )),
                              const Spacer(),
                              Text(
                                AppLocalization.localizations!.balance,
                                style: TextStyle(
                                  fontFamily: FontType.fontRobotoRegular,
                                  color: ColorsTheme.secondColor,
                                  fontSize: 23.sp,
                                ),
                              ),
                              balanceUpdate(vm)
                            ],
                          )))
                ])),
        getQRImage(vm, boxConstraints),
        Expanded(
          flex: 2,
          child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipPath(
                    clipper: DirectionalWaveClipper(
                        verticalPosition: VerticalPosition.top,
                        horizontalPosition: HorizontalPosition.right),
                    child: Container(
                        height: 85.h,
                        padding: const EdgeInsets.only(bottom: 0),
                        color: ColorsTheme.secondColor,
                        alignment: FractionalOffset.bottomCenter),
                  ),
                  Container(
                      height: ScreenConfig.bottomBarColorHeight(),
                      color: ColorsTheme.bottomColor)
                ],
              )),
        )
      ],
    );
  }

  Widget getQRImage(ProfileViewModel vm, BoxConstraints constraints) {
    if (vm.profileState.mobileNumber.isNotEmpty) {
      return SizedBox(
          height: constraints.maxHeight / 2,
          child: Center(
              child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: QrImageView(
                    eyeStyle: QrEyeStyle(
                        eyeShape: vm.profileState.isMale == GenderType.MALE.name
                            ? QrEyeShape.square
                            : QrEyeShape.circle,
                        color: ColorsTheme.primaryColor),
                    foregroundColor: ColorsTheme.secondColor,
                    backgroundColor: Colors.white,
                    data: manager
                        .getPreferencesValue(PreferencesContents.userUid)!,
                    version: QrVersions.auto,
                    size: 2 * (constraints.maxWidth) / 3,
                  ))));
    } else {
      return const SizedBox();
    }
  }

  Widget balanceUpdate(ProfileViewModel viewModel) {
    PreferencesManager manager = PreferencesManager();
    String balance =
        manager.getPreferencesValue(PreferencesContents.balance) ?? '';
    return StreamBuilder(
        initialData: balance,
        stream: updateBalance,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          bool isData = snapshot.hasData;
          if (isData) {
            manager.saveBalance(snapshot.data!);
          }
          String? value = isData ? snapshot.data : balance;
          return Text((value!).amountFormat(),
              style: TextStyle(
                  color: ColorsTheme.secondColor,
                  fontFamily: FontType.fontRobotoLight,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold));
        });
  }
}
