import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'dart:math' as math;

class VideoCall extends StatefulWidget {
  String friendName;
  String callingid;
  VideoCall({super.key, required this.friendName, required this.callingid});

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  final String localUserID = math.Random().nextInt(10000).toString();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ZegoUIKitPrebuiltCall(
            callID: widget.callingid,
            appID: 93970586,
            appSign:
                "a75d9205a92fd5b46b16e6c17f23cc8566c207c6a4397b4848926977e1f2f273",
            userID: localUserID,
            userName: widget.friendName + '$localUserID',
            config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
              ..layout = ZegoLayout.pictureInPicture(
                isSmallViewDraggable: true,
                switchLargeOrSmallViewByClick: true,
              )));
  }
}
