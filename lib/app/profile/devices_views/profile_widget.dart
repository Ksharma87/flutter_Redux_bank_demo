import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/app/profile/devices_views/profile_viewModel.dart';
import 'package:flutter_redux_bank/app/utils/loading_view/loading_progress_dialog.dart';
import 'package:flutter_redux_bank/common/gender_type.dart';
import 'package:flutter_redux_bank/common/string_extension.dart';
import 'package:flutter_redux_bank/config/drawable/resource_constants.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/profile/profile_actions.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final LoadingProgressDialog _progressDialog = LoadingProgressDialog();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return _body(constraints);
    });
  }

  Widget _body(BoxConstraints constraints) {
    return StoreConnector<AppState, ProfileViewModel>(
        distinct: true,
        onInit: (store) {
          store.dispatch(GetUserProfile());
          print("onInit");
        },
        onWillChange: (oldVm, newVm) {
          print("onWillChange");
        },
        onDidChange: (oldVm, newVm) {
          print("onDidChange");
          if (newVm.profileState.mobileNumber.isNotEmpty) {
            _progressDialog.hideProgressDialog();
          }
        },
        onInitialBuild: (vmModel) {
          print("onInitialBuild");
          _progressDialog.showProgressDialog();
        },
        converter: (store) {
          return ProfileViewModel.fromStore(store);
        },
        builder: (BuildContext context, ProfileViewModel vm) {
          return Builder(builder: (BuildContext context) {
            print("build");
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
                                child: Center(child: profileImageHolder(vm)),
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
                                      Text(profileName(vm),
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
                                          color: ColorsTheme.secondColor,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const Text("₹ 17,5260",
                                          style: TextStyle(
                                              color: ColorsTheme.secondColor,
                                              fontFamily: 'Roboto Regular',
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  )))
                        ])),
                getQRImage(vm, constraints),
              ],
            );
          });
        });
  }

  String profileName(ProfileViewModel viewModel) {
    if (viewModel.profileState.firstName.isNotEmpty &&
        viewModel.profileState.lastName.isNotEmpty) {
      return "${viewModel.profileState.firstName.capitalize()} ${viewModel.profileState.lastName.capitalize()}";
    }
    return '';
  }

  Widget getQRImage(ProfileViewModel vm, BoxConstraints constraints) {
    if (vm.profileState.mobileNumber.isNotEmpty) {
      return Padding(
          padding: const EdgeInsets.only(top: 30),
          child: QrImageView(
            eyeStyle: QrEyeStyle(
                eyeShape: vm.profileState.isMale == GenderType.MALE.name
                    ? QrEyeShape.square
                    : QrEyeShape.circle,
                color: ColorsTheme.primaryColor),
            foregroundColor: ColorsTheme.secondColor,
            backgroundColor: Colors.white,
            data: vm.profileState.mobileNumber,
            version: QrVersions.auto,
            size: constraints.maxHeight / 2,
          ));
    } else {
      return const SizedBox();
    }
  }

  Widget profileImageHolder(ProfileViewModel vm) {
    if (vm.profileState.mobileNumber.isEmpty) {
      return const SizedBox();
    } else {
      return vm.profileState.isMale == GenderType.MALE.name.toString()
          ? profileImage(ResourceConstants.maleProfileHolder)
          : profileImage(ResourceConstants.femaleProfileHolder);
    }
  }

  Widget profileImage(String uri) {
    return Image.asset(
      uri,
      width: 145,
      height: 145,
      fit: BoxFit.cover,
    );
  }
}
