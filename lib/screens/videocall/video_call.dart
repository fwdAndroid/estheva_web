// import 'package:flutter/material.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'dart:math' as math;

// class VideoCall extends StatefulWidget {
//   String friendName;
//   String callingid;
//   VideoCall({super.key, required this.friendName, required this.callingid});

//   @override
//   State<VideoCall> createState() => _VideoCallState();
// }

// class _VideoCallState extends State<VideoCall> {
//   final String localUserID = math.Random().nextInt(10000).toString();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: ZegoUIKitPrebuiltCall(
//             callID: widget.callingid,
//             appID: 789354463,
//             appSign:
//                 "1002055a33ee160a0d05cd3d9e5e8858d1ce46c33dc3e101b14ae11a7c306203",
//             userID: localUserID,
//             userName: widget.friendName + '$localUserID',
//             config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
//               ..layout = ZegoLayout.pictureInPicture(
//                 isSmallViewDraggable: true,
//                 switchLargeOrSmallViewByClick: true,
//               )));
//   }
// }
