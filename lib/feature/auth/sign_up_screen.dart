import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:native/config.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/feature/app/bloc/app_cubit.dart';
import 'package:native/feature/auth/auth_scaffold.dart';
import 'package:native/feature/auth/bloc/auth_cubit.dart';
import 'package:native/theme/theme.dart';
import 'package:native/util/string_ext.dart';
import 'package:native/widget/native_text_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sprintf/sprintf.dart';

const _assetFolder = 'assets/auth';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final Logger logger = getIt<Logger>();
  final String _initialCountry = 'IN';
  PhoneNumber _number = PhoneNumber(isoCode: 'IN');
  bool _isEnabledSubmitPhoneButton = false;
  static const int initialTimerValue = 30;
  final Config _config = getIt<Config>();

  Timer? _timer;
  Timer? _checkEmailVerifiedTimer;
  int _start = initialTimerValue;

  StreamController<ErrorAnimationType>? errorController;
  bool _isInputCompleted = false;
  String _otp = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (errorController?.isClosed == false) {
      errorController?.close();
    }

    _controller.dispose();
    _emailController.dispose();

    _timer?.cancel();
    _checkEmailVerifiedTimer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _start = initialTimerValue;
    });
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void _backToEditPhoneNumber(AuthCubit bloc) {
    bloc.initial();
    errorController?.close();
    _timer?.cancel();
  }

  void _goToSignInScreen() {
    context.router.replace(SignInRoute());
  }

  _updateSystemUi() {
    updateSystemUi(context, Theme.of(context).colorScheme.primaryContainer,
        Theme.of(context).colorScheme.primary);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<AuthCubit>(),
        child: BlocConsumer<AuthCubit, AuthState>(
          buildWhen: (p, c) => p != c && c is! AuthLoadingState,
          builder: (context, state) {
            _updateSystemUi();
            final bloc = BlocProvider.of<AuthCubit>(context);
            if (state is AuthInputPincodeState ||
                state is AuthErrorPincodeState) {
              return AuthScaffold(
                  _inputPincode(
                      context, bloc, _number.phoneNumber ?? "", state),
                  _config);
            } else if (state is AuthInputEmailState ||
                state is AuthEmailSendFailedState ||
                state is AuthEmailVerificationSentState ||
                state is AuthEmailVerificationCompleteState) {
              return AuthScaffold(
                  _inputEmail(context, bloc, _number.phoneNumber ?? "", state),
                  _config);
            } else {
              return AuthScaffold(_inputPhone(context, bloc), _config);
            }
          },
          listener: (BuildContext context, AuthState state) {
            if (state is AuthLoadingState) {
              if (!context.loaderOverlay.visible) {
                context.loaderOverlay.show();
              }
            }
            if (state is AuthInputPincodeState) {
              if (context.loaderOverlay.visible) {
                context.loaderOverlay.hide();
              }
              _startTimer();
              errorController = StreamController();
            }
            if (state is AuthErrorPincodeState) {
              if (context.loaderOverlay.visible) {
                context.loaderOverlay.hide();
              }
              errorController!.add(ErrorAnimationType.shake);
            }
            if (state is AuthErrorState) {
              if (context.loaderOverlay.visible) {
                context.loaderOverlay.hide();
              }
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.exception.message)));
            }
            if (state is AuthInputEmailState) {
              if (context.loaderOverlay.visible) {
                context.loaderOverlay.hide();
              }
            }
            if (state is AuthEmailSendFailedState) {
              if (context.loaderOverlay.visible) {
                context.loaderOverlay.hide();
              }
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.exception.message)));
            }
            // if (state is AuthEmailVerificationCompleteState) {
            //   if (context.loaderOverlay.visible) {
            //     context.loaderOverlay.hide();
            //   }
            //   _checkEmailVerifiedTimer?.cancel();
            //   // Navigator.pop(context);
            //   _showEmailVerifiedDialog(context);
            // }
            if (state is AuthEmailVerificationSentState) {
              if (context.loaderOverlay.visible) {
                context.loaderOverlay.hide();
              }
              _checkEmailVerifiedTimer =
                  Timer.periodic(const Duration(seconds: 3), (_) {
                final bloc = BlocProvider.of<AuthCubit>(context);
                bloc.emailVerified();
              });
              _showSentVerificationEmailDialog(_emailController.text);
            }
          },
        ));
  }

  Widget _inputPincode(
      BuildContext context, AuthCubit bloc, String phone, AuthState state) {
    Color borderColor = state is AuthErrorPincodeState
        ? const Color(0xFFFF0000)
        : Colors.transparent;
    Color fillColor = state is AuthErrorPincodeState
        ? const Color(0x0DFF0000)
        : const Color(0x0d7B7B7B);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text(
          'Enter confirmation code',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Color(0xff1E1E1E),
              fontSize: 22,
              fontWeight: FontWeight.w500),
        ),
        Text(
          "Enter confirmation code sent to $phone",
          textAlign: TextAlign.start,
          style: const TextStyle(
              color: Color(0xff7B7B7B),
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        Text.rich(TextSpan(
          text: 'Edit number',
          style: TextStyle(
            color: const Color(0xFFBE94C6),
            fontSize: 14,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.underline,
            decorationColor: Theme.of(context).colorScheme.primary,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              _backToEditPhoneNumber(bloc);
            },
        )),
        const SizedBox(height: 10),
        PinCodeTextField(
          appContext: context,
          pastedTextStyle: TextStyle(
            color: Colors.green.shade600,
            fontWeight: FontWeight.bold,
          ),
          length: 6,
          obscureText: false,
          blinkWhenObscuring: false,
          animationType: AnimationType.fade,
          validator: (v) {
            if (v!.length < 6) {
              return null;
            } else {
              return null;
            }
          },
          textStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xff1E1E1E),
            fontWeight: FontWeight.normal,
          ),
          backgroundColor: Colors.transparent,
          cursorColor: Theme.of(context).colorScheme.primary,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 56,
            fieldWidth: 45,
            activeFillColor: fillColor,
            inactiveColor: fillColor,
            selectedColor: fillColor,
            activeColor: fillColor,
            selectedFillColor: fillColor,
            inactiveFillColor: fillColor,
            errorBorderColor: borderColor,
          ),
          animationDuration: const Duration(milliseconds: 200),
          enableActiveFill: true,
          errorAnimationController: errorController,
          keyboardType: TextInputType.number,
          onCompleted: (value) {
            // debugPrint("Completed");
            _otp = value;
          },
          // onTap: () {
          //   print("Pressed");
          // },
          onChanged: (value) {
            debugPrint(value);
            // bloc.inputPincode(value);

            if (value.length == 6) {
              setState(() {
                _isInputCompleted = true;
                _otp = value;
              });
            } else {
              setState(() {
                _isInputCompleted = false;
              });
            }
          },
          beforeTextPaste: (text) {
            debugPrint("Allowing to paste $text");
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
        ),
        const SizedBox(height: 30),
        Container(
          height: 56.0,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x19616161),
                  offset: Offset(10, 10),
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                ),
              ],
              gradient: LinearGradient(
                colors: [
                  _isInputCompleted
                      ? const Color(0xB2BE94C6)
                      : const Color(0x55BE94C6),
                  _isInputCompleted
                      ? const Color(0xB2BE94C6)
                      : const Color(0x55BE94C6),
                  _isInputCompleted
                      ? const Color(0xB27BC6CC)
                      : const Color(0x557BC6CC),
                ],
              )),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.transparent,
              disabledForegroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              disabledBackgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: !_isInputCompleted
                ? null
                : () {
                    setState(() {
                      _isInputCompleted = false;
                    });
                    FocusManager.instance.primaryFocus?.unfocus();
                    bloc.inputPincode(_otp);
                  },
            child: const Text(
              'Next',
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: state is AuthErrorPincodeState ? 20 : 38),
        Column(
          children: state is AuthErrorPincodeState
              ? [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(TextSpan(
                        text: 'Incorrect OTP entered',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFFFF0000)),
                      )),
                    ],
                  ),
                  const SizedBox(height: 27),
                ]
              : [],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Didn't receive OTP? ",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff1E1E1E),
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(
              width: _start == 0 ? 60 : 120,
              child: Text.rich(TextSpan(
                text: _start == 0
                    ? 'Resend'
                    : sprintf("Resend in 0:%02d", [_start]),
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.normal,
                  decoration: _start == 0
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  decorationColor: Theme.of(context).colorScheme.primary,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    if (_start == 0) {
                      bloc.submitPhoneNumber(_number.phoneNumber ?? '', true);
                      _startTimer();
                    }
                  },
              )),
            ),
          ],
        ),
        const SizedBox(height: 11),
      ],
    );
  }

  Widget _inputPhone(
    BuildContext context,
    AuthCubit bloc,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Sign up",
            style: TextStyle(
                color: Color(0xffBE94C6),
                fontSize: 22,
                fontWeight: FontWeight.w400),
          ),
        ]),
        const SizedBox(height: 40),
        const Text(
          'Enter your mobile number',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Color(0xff1E1E1E),
              fontSize: 22,
              fontWeight: FontWeight.w500),
        ),
        const Text(
          'We will send you a confirmation code',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Color(0xff7B7B7B),
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 32),
        InternationalPhoneNumberInput(
          spaceBetweenSelectorAndTextField: 0,
          onInputChanged: (PhoneNumber number) {
            setState(() {
              _number = number;
            });

            logger.d("Phone number: ${_number.phoneNumber}");
          },
          onInputValidated: (bool value) {
            setState(() {
              _isEnabledSubmitPhoneButton = value;
            });
            // isEnabledButton = value;
            logger.d("Phone validation: $value");
          },
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.DROPDOWN,
          ),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
          selectorTextStyle: const TextStyle(
            color: Color(0xff1E1E1E),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          // initialValue: number,
          textFieldController: _controller,
          formatInput: true,
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
          // inputBorder: const OutlineInputBorder(),
          inputDecoration: const InputDecoration(
            // fillColor: Colors.transparent,
            // border: OutlineInputBorder(borderSide: BorderSide()),
            filled: false,
            labelStyle: TextStyle(
                color: Color(0xff1E1E1E),
                fontSize: 14,
                fontWeight: FontWeight.w500),
            hintStyle: TextStyle(
                color: Color(0x807B7B7B),
                fontSize: 14,
                fontWeight: FontWeight.w500),
            hintText: "Mobile number",
          ),

          onSaved: (PhoneNumber number) {
            logger.d("On Saved: $number");
          },
          // initialValue: _number,
          countries: [_initialCountry],
        ),
        const SizedBox(height: 30),
        Container(
          height: 56.0,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x19616161),
                  offset: Offset(10, 10),
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                ),
              ],
              gradient: LinearGradient(
                colors: [
                  _isEnabledSubmitPhoneButton
                      ? const Color(0xB2BE94C6)
                      : const Color(0x55BE94C6),
                  _isEnabledSubmitPhoneButton
                      ? const Color(0xB2BE94C6)
                      : const Color(0x55BE94C6),
                  _isEnabledSubmitPhoneButton
                      ? const Color(0xB27BC6CC)
                      : const Color(0x557BC6CC),
                ],
              )),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.transparent,
              disabledForegroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              disabledBackgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: !_isEnabledSubmitPhoneButton
                ? null
                : () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    bloc.submitPhoneNumber(_number.phoneNumber ?? '', true);
                  },
            child: const Text(
              'Get OTP',
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Already have an account? ",
              style: TextStyle(
                  color: Color(0xff1E1E1E),
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            Text.rich(TextSpan(
              text: 'Sign in',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.underline,
                decorationColor: Theme.of(context).colorScheme.primary,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _goToSignInScreen();
                },
            )),
          ],
        ),
      ],
    );
  }

  Future<void> _showSentVerificationEmailDialog(String email) async {
    await showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // Future.delayed(const Duration(seconds: 10), () {
          //   // TODO: This is for DEMO
          //   // Navigator.pop(context);
          //   // _showEmailVerifiedDialog();
          // });

          return WillPopScope(
              onWillPop: () => Future.value(false),
              child: SimpleDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 38, horizontal: 21),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            "$_assetFolder/ic_send_email_verification.svg"),
                        const SizedBox(height: 28),
                        const Text(
                          "Verify your Email ID",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xff1E1E1E),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Please click on the link sent to your email address $email to verify",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Color(0xff1E1E1E),
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 14),
                        Text.rich(TextSpan(
                          text: 'Edit Email',
                          style: TextStyle(
                            color: const Color(0xFFBE94C6),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                            },
                        )),
                      ],
                    ),
                  ),
                ],
              ));
        });
  }

  Future<void> _showEmailVerifiedDialog(BuildContext ctx) async {
    await showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(const Duration(seconds: 3), () {
            if (context.mounted) {
              Navigator.pop(context);
              BlocProvider.of<AppCubit>(context).logout();
            }
            // var authBloc = getIt<AuthCubit>();
            // authBloc.initial();
            if (ctx.mounted) {
              BlocProvider.of<AuthCubit>(ctx).initial();
            }
          });
          return WillPopScope(
              onWillPop: () => Future.value(false),
              child: SimpleDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 42, horizontal: 42),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset("$_assetFolder/ic_verified.svg"),
                        const SizedBox(height: 28),
                        const Text(
                          "Successfully verified",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xff1E1E1E),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        });
  }

  Widget _inputEmail(
      BuildContext context, AuthCubit bloc, String phone, AuthState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text(
          'Enter your Email ID',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Color(0xff1E1E1E),
              fontSize: 22,
              fontWeight: FontWeight.w500),
        ),
        const Text(
          "Please enter your Email ID to verify account",
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Color(0xff7B7B7B),
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 32),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: NativeTextField(
              _emailController,
              hintText: 'Email ID',
              onChanged: (value) {
                setState(() {
                  _isInputCompleted = value.isValidEmail();
                });
              },
            )),
        const SizedBox(height: 30),
        Container(
          height: 56.0,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x19616161),
                  offset: Offset(10, 10),
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                ),
              ],
              gradient: LinearGradient(
                colors: [
                  _isInputCompleted
                      ? const Color(0xB2BE94C6)
                      : const Color(0x55BE94C6),
                  _isInputCompleted
                      ? const Color(0xB2BE94C6)
                      : const Color(0x55BE94C6),
                  _isInputCompleted
                      ? const Color(0xB27BC6CC)
                      : const Color(0x557BC6CC),
                ],
              )),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.transparent,
              disabledForegroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              disabledBackgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: !_isInputCompleted
                ? null
                : () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    bloc.verifyEmail(_emailController.text);
                    // _showSentVerificationEmailDialog(_emailController.text);
                  },
            child: const Text(
              'Verify Email',
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
