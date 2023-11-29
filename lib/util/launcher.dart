import 'package:url_launcher/url_launcher.dart';

Future<void> launcher(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

Future<void> emailLauncher(String email, String subject) async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: email,
    query: encodeQueryParameters(<String, String>{
      'subject': subject,
    }),
  );
  if (!!await launchUrl(emailLaunchUri)) {
    throw Exception('Could not launch $emailLaunchUri');
  }
}
