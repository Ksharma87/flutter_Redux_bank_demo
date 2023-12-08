import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/app/profile/devices_views/profile_viewModel.dart';
import 'package:flutter_redux_bank/app/utils/loading_view/loading_progress_dialog.dart';
import 'package:flutter_redux_bank/app/utils/profile_view/profile_view_utils.dart';
import 'package:flutter_redux_bank/common/gender_type.dart';
import 'package:flutter_redux_bank/common/money_format.dart';
import 'package:flutter_redux_bank/common/string_extension.dart';
import 'package:flutter_redux_bank/config/drawable/resource_constants.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/preferences/preferences_contents.dart';
import 'package:flutter_redux_bank/preferences/preferences_manager.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_bank/redux/store/profile/profile_actions.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:flutter_redux_bank/utils/global_key_holder.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileWidget extends StatelessWidget {
  ProfileWidget({super.key, required this.boxConstraints});

  final BoxConstraints boxConstraints;
  final LoadingProgressDialog _progressDialog = LoadingProgressDialog();
  final String? uid =
      PreferencesManager().getPreferencesValue(PreferencesContents.userUid);
  final ProfileViewUtils _profileViewUtils = ProfileViewUtils();


  @override
  Widget build(BuildContext context) {
    return _body(boxConstraints);
  }

  Widget _body(BoxConstraints constraints) {
    return StoreConnector<AppState, ProfileViewModel>(
        distinct: true,
        onInit: (store) {
          store.dispatch(InitUserProfile());
          print("onInit ProfileWidget");
        },
        onWillChange: (oldVm, newVm) {
          print("onWillChange ProfileWidget");
        },
        onDidChange: (oldVm, newVm) {
          print("onDidChange ProfileWidget");
          if (newVm.profileState.mobileNumber.isNotEmpty) {
            _progressDialog.hideProgressDialog();
          }
        },
        onInitialBuild: (profileViewModel) {
          print("onInitialBuild ProfileWidget");
          store.dispatch(GetUserProfile(uid: uid!));
          _progressDialog.showProgressDialog();
        },
        converter: (store) {
          return ProfileViewModel.fromStore(store);
        },
        builder: (BuildContext context, ProfileViewModel vm) {
          return Builder(builder: (BuildContext context) {
            print("build ProfileWidget");
            return Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Stack(
                            children: [
                              const Center(
                                  child: SizedBox(
                                      width: 150.0,
                                      height: 150.0,
                                      child: Card(
                                        color: ColorsTheme.primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                      ))),
                              SizedBox(
                                child: Center(child: _profileViewUtils.profileImageHolder(vm.profileState)),
                              )
                            ],
                          )),
                          Expanded(
                              child: SizedBox(
                                  width: 150.0,
                                  height: 150.0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(_profileViewUtils.profileName(vm.profileState),
                                          style: const TextStyle(
                                            fontFamily: 'Roboto Regular',
                                            fontSize: 20,
                                          )),
                                      Text(vm.profileState.mobileNumber,
                                          style: const TextStyle(
                                            fontFamily: 'Roboto Light',
                                            fontSize: 18,
                                          )),
                                      const Spacer(),
                                      Text(
                                        AppLocalization.localizations!.balance,
                                        style: const TextStyle(
                                          fontFamily: 'Roboto Regular',
                                          color: ColorsTheme.secondColor,
                                          fontSize: 28,
                                        ),
                                      ),
                                      Text(
                                          (vm.profileState.balance)
                                              .amountFormat(),
                                          style: const TextStyle(
                                              color: ColorsTheme.secondColor,
                                              fontFamily: 'Roboto Light',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  )))
                        ])),
                getQRImage(vm, constraints),
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
                                height: 100,
                                padding: const EdgeInsets.only(bottom: 0),
                                color: ColorsTheme.secondColor,
                                alignment: FractionalOffset.bottomCenter),
                          ),
                          Container(height: 45, color: ColorsTheme.bottomColor)
                        ],
                      )),
                )
              ],
            );
          });
        });
  }

  Widget getQRImage(ProfileViewModel vm, BoxConstraints constraints) {
    PreferencesManager manager = PreferencesManager();
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


}
