import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/app/profile/devices_views/profile_viewModel.dart';
import 'package:flutter_redux_bank/app/utils/profile_view/profile_view_utils.dart';
import 'package:flutter_redux_bank/common/types/gender_type.dart';
import 'package:flutter_redux_bank/common/extensions/money_format_extension.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:flutter_redux_bank/preferences/preferences.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/services/balance_service.dart';
import 'package:flutter_redux_bank/utils/app_localization.dart';
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
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
                          width: 150.0,
                          height: 150.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                  _profileViewUtils.profileName(
                                      vm.profileState.firstName,
                                      vm.profileState.lastName),
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
              style: const TextStyle(
                  color: ColorsTheme.secondColor,
                  fontFamily: 'Roboto Light',
                  fontSize: 20,
                  fontWeight: FontWeight.bold));
        });
  }
}
