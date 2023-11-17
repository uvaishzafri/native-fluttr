import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:native/config.dart';
import 'package:native/util/launcher.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

const _assetFolder = 'assets/auth';

class AuthScaffold extends StatelessWidget {
  final Widget content;
  final Config _config;

  const AuthScaffold(this.content, this._config, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: SvgPicture.asset(
              "$_assetFolder/top_banner.svg",
              fit: BoxFit.cover,
              clipBehavior: Clip.none,
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 15, left: 32, right: 32),
              child: SingleChildScrollView(
                child: content,
              )),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(TextSpan(
                        text: 'Contact Support',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.underline,
                        ),
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text(
                      'By continuing you agree to ',
                      style: TextStyle(
                          color: Color(0xff1E1E1E),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    GradientText(
                      'native.',
                      style: const TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w400),
                      colors: const [
                        Color(0xFFBE94C6),
                        Color(0xFF7BC6CC),
                      ],
                    ),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(TextSpan(
                        text: 'terms and conditions',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launcher(Uri.parse(_config.termsAndConditionsUrl));
                          },
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.underline,
                        ),
                      )),
                      const Text(
                        ' & ',
                        style: TextStyle(
                            color: Color(0xff1E1E1E),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      Text.rich(
                        TextSpan(
                          text: 'privacy policy',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launcher(Uri.parse(_config.privacyPolicyUrl));
                            },
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 26,
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
