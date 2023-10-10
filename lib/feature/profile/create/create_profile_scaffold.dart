// import 'package:flutter/material.dart';
// import 'package:native/widget/native_button.dart';
// import 'package:native/widget/text/native_medium_title_text.dart';

// class CreateProfileScaffold extends StatelessWidget {
//   final Widget content;
//   const CreateProfileScaffold(this.content, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//             centerTitle: true,
//             title: NativeMediumTitleText(
//               'Create your profile',
//             ),
//             bottom: PreferredSize(
//                 preferredSize: Size(double.infinity, 10),
//                 child: LinearProgressIndicator(
//                   value: 0,
//                 ))
//             // flexibleSpace: const LinearProgressIndicator(),
//             ),
//         body: Column(
//           children: [
//             Expanded(
//               child: CustomScrollView(
//                 slivers: [
//                   SliverList(
//                     delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
//                       return Container(
//                           margin: const EdgeInsets.only(top: 15, left: 32, right: 32),
//                           child: SingleChildScrollView(
//                             child: content,
//                           ));
//                     }, childCount: 1),
//                   ),
//                 ],
//               ),
//             ),
//             // const Spacer(),
//             NativeButton(
//               isEnabled: false,
//               text: 'Next',
//               onPressed: () {},
//             ),
//           ],
//         ));
//   }
// }
