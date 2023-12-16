import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_bank/app/passbook/devices_views/passbook_viewmodel.dart';
import 'package:flutter_redux_bank/app/utils/animation_lottie/AnimationLottie.dart';
import 'package:flutter_redux_bank/common/extensions/money_format_extension.dart';
import 'package:flutter_redux_bank/common/extensions/string_extension.dart';
import 'package:flutter_redux_bank/common/types/gender_type.dart';
import 'package:flutter_redux_bank/data/models/profile/response/profile_response.dart';
import 'package:flutter_redux_bank/preferences/preferences.dart';
import 'package:flutter_redux_bank/redux/store/app/app_state.dart';
import 'package:flutter_redux_bank/redux/store/app/app_store.dart';
import 'package:flutter_redux_bank/redux/store/passbook/passbook_actions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../../../config/styles/colors_theme.dart';
import '../../utils/screen_config/ScreenConfig.dart';

class PassbookWidget extends StatelessWidget {
  PassbookWidget({super.key, required this.boxConstraints});

  final HashMap mapStoreProfile = HashMap<dynamic, dynamic>();
  final BoxConstraints boxConstraints;

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }

  Widget _buildStore() {
    return StoreConnector<AppState, PassbookViewModel>(
      distinct: true,
      onInit: (store) {
        store.dispatch(InitPassbook());
      },
      onInitialBuild: (viewModel) {
        PreferencesManager manager = PreferencesManager();
        store.dispatch(GetPassBookList(
            uid: manager.getPreferencesValue(PreferencesContents.userUid)!));
      },
      onWillChange: (oldViewModel, newViewModel) {
        if (newViewModel.passbookState.isPassbookLoaded) {
          saveProfile(newViewModel);
        }
      },
      onDidChange: (oldViewModel, newViewModel) {
        if (newViewModel.passbookState.isUserPassBookLoaded) {}
      },
      converter: (store) {
        return PassbookViewModel.fromStore(store);
      },
      builder: (BuildContext context, PassbookViewModel vm) {
        return Builder(
          builder: (BuildContext context) {
            return _buildList(vm);
          },
        );
      },
    );
  }

  Widget _buildView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 6, child: _buildStore()),
        Expanded(
          flex: 1,
          child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                  height: ScreenConfig.bottomBarColorHeight(),
                  color: ColorsTheme.bottomColor)),
        )
      ],
    );
  }

  Widget _buildList(PassbookViewModel vm) {
    if (vm.passbookState.isPassbookLoaded) {
      if (vm.passbookState.list.isNotEmpty) {
        return ListView.builder(
            itemCount: vm.passbookState.list.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  SizedBox(
                      height: boxConstraints.maxHeight * 0.15,
                      child: Row(
                        children: [
                          getImagePlaceHolder(vm, index),
                          Expanded(
                              flex: 2,
                              child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        getDisplayName(vm, index),
                                        Container(
                                          color: Colors.white,
                                          height: 1,
                                        ),
                                        getDisplayMobileNumber(vm, index),
                                        Container(
                                          color: Colors.white,
                                          height: 1,
                                        ),
                                        getDisplayEmail(vm, index),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(top: 3),
                                            child: Container(
                                              color: Colors.black45,
                                              height: 1,
                                            )),
                                        Expanded(
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 3),
                                              child: Text(
                                                  dateFormatting(vm
                                                          .passbookState
                                                          .list[index]["time"])
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                        ),
                                      ],
                                    ),
                                  ))),
                          Expanded(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child: Column(
                                    children: [
                                      Expanded(
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: Text(
                                                vm.passbookState
                                                    .list[index]["amount"]
                                                    .toString()
                                                    .amountFormat(),
                                                style: TextStyle(
                                                    color: getTransactionType(
                                                        vm, index),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))),
                                      Expanded(
                                          child: Text(
                                              vm.passbookState
                                                  .list[index]["balance"]
                                                  .toString()
                                                  .amountFormat(),
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold)))
                                    ],
                                  )))
                        ],
                      )),
                  Container(
                    height: 1,
                    color: ColorsTheme.primaryColor,
                  )
                ],
              );
            });
      }
      return passbookEmpty();
    }
    return passbookLoading();
  }

  Widget passbookLoading() {
    return Center(child: Lottie.asset(AnimationLottie.lottie_passbook_loading));
  }

  Widget passbookEmpty() {
    return Center(child: Lottie.asset(AnimationLottie.lottie_empty_passbook));
  }

  Color getTransactionType(PassbookViewModel vm, int index) {
    return vm.passbookState.list[index]["transactionType"] == "CR"
        ? Colors.green
        : Colors.redAccent;
  }

  String dateFormatting(String timeStamp) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp));
    var d24 = DateFormat('dd MMM yyyy').format(dt);
    return d24;
  }

  void saveProfile(PassbookViewModel vm) {
    int mLength = vm.passbookState.list.length;
    for (int i = 0; i < mLength; i++) {
      mapStoreProfile.putIfAbsent(vm.passbookState.list[i]["uid"], () => null);
    }
    if (mapStoreProfile.isNotEmpty) {
      store.dispatch(GetPassBookUserDetails(
          mList: mapStoreProfile, pList: vm.passbookState.list));
    }
  }

  Widget getDisplayName(PassbookViewModel vm, int index) {
    if (vm.passbookState.isPassbookLoaded) {
      if (vm.passbookState.isUserPassBookLoaded) {
        final displayNameResponse =
            mapStoreProfile[vm.passbookState.list[index]["uid"]]
                as ProfileResponse;
        String displayName =
            "${displayNameResponse.firstName.capitalize()} ${displayNameResponse.lastName.capitalize()}";
        return Text(displayName,
            style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.normal));
      }
    }
    return shimmerPlaceHolder();
  }

  Widget getDisplayEmail(PassbookViewModel vm, int index) {
    if (vm.passbookState.isPassbookLoaded) {
      if (vm.passbookState.isUserPassBookLoaded) {
        final displayNameResponse =
            mapStoreProfile[vm.passbookState.list[index]["uid"]]
                as ProfileResponse;
        String displayName = displayNameResponse.email;
        return Text(displayName,
            style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.normal));
      }
    }
    return shimmerPlaceHolder();
  }

  Widget getDisplayMobileNumber(PassbookViewModel vm, int index) {
    if (vm.passbookState.isPassbookLoaded) {
      if (vm.passbookState.isUserPassBookLoaded) {
        final displayNameResponse =
            mapStoreProfile[vm.passbookState.list[index]["uid"]]
                as ProfileResponse;
        String displayName = displayNameResponse.mobileNumber;
        return Text(
          displayName,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        );
      }
    }
    return shimmerPlaceHolder();
  }

  Widget getImagePlaceHolder(PassbookViewModel vm, int index) {
    if (vm.passbookState.isPassbookLoaded) {
      if (vm.passbookState.isUserPassBookLoaded) {
        final userGender = mapStoreProfile[vm.passbookState.list[index]["uid"]]
            as ProfileResponse;
        return userGender.gender == GenderType.MALE.name ? profileMaleImage() : profileFemaleImage();
      }
    }
    return shimmerProfilePlaceHolder();
  }

  Widget profileMaleImage() {
    return Lottie.asset(AnimationLottie.lottie_MaleIcon,
        repeat: true, reverse: true, width: 80.w, height: 80.w);
  }

  Widget profileFemaleImage() {
    return Lottie.asset(AnimationLottie.lottie_FemaleIcon,
        repeat: true, reverse: true, width: 80.w, height: 80.w);
  }

  Widget shimmerProfilePlaceHolder() {
    return Expanded(
        child: Shimmer.fromColors(
      baseColor: ColorsTheme.bottomColor,
      highlightColor: ColorsTheme.primaryColor.withOpacity(0.5),
      child: Container(
        alignment: Alignment.topLeft,
        height: 150,
        width: 50,
        color: Colors.white,
      ),
    ));
  }

  Widget shimmerPlaceHolder() {
    return Expanded(
        child: Shimmer.fromColors(
      baseColor: ColorsTheme.bottomColor,
      highlightColor: ColorsTheme.primaryColor.withOpacity(0.5),
      child: Container(
        alignment: Alignment.topLeft,
        height: 10,
        color: Colors.white,
      ),
    ));
  }
}
