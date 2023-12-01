import 'package:flutter/material.dart';
import 'package:flutter_redux_bank/config/styles/colors_theme.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: Center(
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
                                    //set border radius more than 50% of height and width to make circle
                                  ),
                                ))),
                        SizedBox(
                          child: Center(
                              child: Image.asset(
                            'assets/image/female-profile-holder.png',
                            width: 145,
                            height: 145,
                            fit: BoxFit.cover,
                          )),
                        )
                      ],
                    ))),
                    const Expanded(
                        child: SizedBox(
                            width: 150.0,
                            height: 150.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Tushar Kauhsik",
                                    style: TextStyle(
                                      fontFamily: 'Roboto Regular',
                                      fontSize: 20,
                                    )),
                                Text("9958208726",
                                    style: TextStyle(
                                      fontFamily: 'Roboto Light',
                                      fontSize: 18,
                                    )),
                                Spacer(),
                                Text(
                                  "Balance",
                                  style: TextStyle(
                                    color: ColorsTheme.secondColor,
                                    fontSize: 20,
                                  ),
                                ),
                                Text("₹ 17,5260",
                                    style: TextStyle(
                                        color: ColorsTheme.secondColor,
                                        fontFamily: 'Roboto Regular',
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold))
                              ],
                            )))
                  ])),
          Padding(
              padding: const EdgeInsets.only(top: 30),
              child: QrImageView(
                eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: ColorsTheme.primaryColor),
                foregroundColor: ColorsTheme.secondColor,
                backgroundColor: Colors.white,
                data: 'I love you priyanka',
                version: QrVersions.auto,
                size: constraints.maxHeight / 2,
              )),
        ],
      );
    });
  }
}
