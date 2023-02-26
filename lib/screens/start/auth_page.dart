import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';
import 'package:radish_app/constants/common_size.dart';
import 'package:radish_app/states/user_provider.dart';
import 'package:radish_app/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/shared_pref_keys.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

const duration = Duration(milliseconds: 300);

class _AuthPageState extends State<AuthPage> {
  final inputBorder = OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));

  TextEditingController _phoneNumberController = TextEditingController(text: "010");

  TextEditingController _codeController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  VerificationStatus _verificationStatus = VerificationStatus.none;

  String? _verificationId;
  int? _forceResendingToken;


  @override
  void dispose() {
    _phoneNumberController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      Size size = MediaQuery.of(context).size;

      return IgnorePointer(
        ignoring: _verificationStatus == VerificationStatus.verifying, // true  이면 자신과 하위가 invisible(눌러도 변화없음)
        child: Form(
          key: _formKey,
          child: Scaffold(
            appBar: AppBar(
                title: Text(
                  '로그인 하기',
                  style: Theme.of(context).textTheme.headline5,
                ),
                elevation: Theme.of(context).appBarTheme.elevation),
            body: InkWell(
              onTap: () {
                FocusScope.of(context).unfocus(); // 화면 터치시 키보드 unfocus 만들기
              },
              child: Padding(
                padding: EdgeInsets.all(common_bg_padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Image.asset(
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
                      controller: _phoneNumberController,
                      inputFormatters: [MaskedInputFormatter("000 0000 0000")],
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
                    TextButton(
                      onPressed: () async {
                        if (_verificationStatus == VerificationStatus.codeSending) {
                          return;
                        }
                        // _getAddress();
                        if (_formKey.currentState != null) {
                          bool passed = _formKey.currentState!.validate();

                          if (passed) {
                            String phoneNum = _phoneNumberController.text;
                            phoneNum = phoneNum.replaceAll(' ', '');
                            phoneNum = phoneNum.replaceFirst('0', '');

                            FirebaseAuth auth = FirebaseAuth.instance;

                            setState(() {
                              _verificationStatus = VerificationStatus.codeSending;
                            });

                            await auth.verifyPhoneNumber(
                              phoneNumber: '+82$phoneNum',
                              forceResendingToken: _forceResendingToken,
                              codeSent: (String verificationId, int? forceResendingToken) async {
                                setState(() {
                                  _verificationStatus = VerificationStatus.codeSent;
                                });

                                _verificationId = verificationId;
                                _forceResendingToken = forceResendingToken;
                              },
                              codeAutoRetrievalTimeout: (String verificationId) {},
                              verificationCompleted: (PhoneAuthCredential credential) async {
                                logger.d('인증완료 ${credential}');
                                await auth.signInWithCredential(credential);
                              },
                              verificationFailed: (FirebaseAuthException error) {
                                setState(() {
                                  _verificationStatus = VerificationStatus.none;
                                });
                                logger.d(error.message);
                              },
                            );
                          }
                        }
                      },
                      child: _verificationStatus == VerificationStatus.codeSending
                          ? SizedBox(
                              height: 26,
                              width: 26,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text("인증 문자 발송"),
                      style: Theme.of(context).textButtonTheme.style,
                    ),
                    SizedBox(
                      height: common_sm_padding,
                    ),
                    AnimatedOpacity( // none 이면 안보였다가 none 이 아니면 천천히 보이게 하기
                      duration: duration,
                      opacity: _verificationStatus == VerificationStatus.none ? 0 : 1,
                      child: AnimatedContainer(
                        duration: duration,
                        curve: Curves.easeInOut,
                        height: getVerificationHeight(_verificationStatus),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _codeController,
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
                      child: TextButton(
                        onPressed: () {
                          attemptVerify(context);
                        },
                        child: (_verificationStatus == VerificationStatus.verifying)
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text("인증 하기"),
                        style: Theme.of(context).textButtonTheme.style,
                      ),
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
    String address = preferences.getString(SHARED_ADDRESS) ?? "";
    double lat = preferences.getDouble(SHARED_LAT) ?? 0;
    double lon = preferences.getDouble(SHARED_LON) ?? 0;
    logger.d("address from shared Pref - $address");
  }

  double getVerificationHeight(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.none:
        return 0;
      case VerificationStatus.codeSending:
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
      case VerificationStatus.codeSending:
      case VerificationStatus.verifying:
      case VerificationStatus.verificationDone:
        return 48;
    }
  }

  void attemptVerify(BuildContext context) async {
    setState(() {
      _verificationStatus = VerificationStatus.verifying;
    });

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: _codeController.text);
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      logger.d('이증실패!');
      SnackBar snackBar = SnackBar(content: Text('잘못된 인증코드입니다.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    setState(() {
      _verificationStatus = VerificationStatus.verificationDone;
    });
  }
}

enum VerificationStatus { none, codeSending, codeSent, verifying, verificationDone }
