import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';
import 'package:radish_app/constants/common_size.dart';
import 'package:radish_app/states/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'intro_page.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

const duration = Duration(milliseconds: 300);

class _AuthPageState extends State<AuthPage> {
  final inputBorder = OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));

  TextEditingController _textEditingController = TextEditingController(text: "010");

  TextEditingController _verifiNumberController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  VerificationStatus _verificationStatus = VerificationStatus.none;

  double getVerificationHeight(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.none:
        return 0;
      case VerificationStatus.codeSent:
      case VerificationStatus.verifying:
      case VerificationStatus.verificationDone:
        return 60 + common_sm_padding;
    }
  }

  double getVerificationBtnHeight(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.none:
        return 0;
      case VerificationStatus.codeSent:
      case VerificationStatus.verifying:
      case VerificationStatus.verificationDone:
        return 48;
    }
  }

  void attemptVerify(BuildContext context) async {
    setState(() {
      _verificationStatus = VerificationStatus.verifying;
    });

    await Future.delayed(Duration(seconds: 3));

    setState(() {
      _verificationStatus = VerificationStatus.verificationDone;
    });

    context.read<UserProvider>().setUserAuth(true);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _verifiNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      Size size = MediaQuery.of(context).size;

      return IgnorePointer(
        ignoring: _verificationStatus == VerificationStatus.verifying,
        child: Form(
          key: _formKey,
          child: Scaffold(
            appBar: AppBar(
                title: Text(
                  '로그인 하기',
                  style: Theme.of(context).textTheme.headline5,
                ),
                elevation: Theme.of(context).appBarTheme.elevation),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Padding(
                padding: EdgeInsets.all(common_bg_padding),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ExtendedImage.asset(
                          'assets/images/security.png',
                          width: size.width * 0.25,
                          height: size.width * 0.25,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text(
                            '무마켓은 전화번호로 가입합니다. 여러분의 개인정보는 안전히 보관되며 외부에 노출되지 않습니다.',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: common_sm_padding,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _textEditingController,
                      inputFormatters: [MaskedInputFormatter("000-0000-0000")],
                      decoration: InputDecoration(
                        border: inputBorder,
                        focusedBorder: inputBorder,
                      ),
                      validator: (phoneNumber) {
                        if (phoneNumber != null && phoneNumber.length == 13) {
                          return null;
                        } else {
                          return '올바른 전화번호를 입력하세요.';
                        }
                      },
                    ),
                    SizedBox(
                      height: common_sm_padding,
                    ),
                    Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                      TextButton(
                        onPressed: () {
                          _getAddress();
                          if (_formKey.currentState != null) {
                            bool passed = _formKey.currentState!.validate();

                            if (passed) {
                              setState(() {
                                _verificationStatus = VerificationStatus.codeSent;
                              });
                            }
                          }
                        },
                        child: Text("인증 문자 발송"),
                        style: Theme.of(context).textButtonTheme.style,
                      )
                    ]),
                    SizedBox(
                      height: common_sm_padding,
                    ),
                    AnimatedOpacity(
                      duration: duration,
                      opacity: _verificationStatus == VerificationStatus.none ? 0 : 1,
                      child: AnimatedContainer(
                        duration: duration,
                        curve: Curves.easeInOut,
                        height: getVerificationHeight(_verificationStatus),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _verifiNumberController,
                          inputFormatters: [MaskedInputFormatter("000000")],
                          decoration: InputDecoration(
                            border: inputBorder,
                            focusedBorder: inputBorder,
                          ),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: duration,
                      height: getVerificationBtnHeight(_verificationStatus),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                        TextButton(
                          onPressed: () {
                            attemptVerify(context);
                          },
                          child: (_verificationStatus == VerificationStatus.verifying)
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text("인증 하기"),
                          style: Theme.of(context).textButtonTheme.style,
                        )
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  _getAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String address = preferences.getString("address") ?? "";
    logger.d("address from shared Pref - $address");
  }
}

enum VerificationStatus { none, codeSent, verifying, verificationDone }
