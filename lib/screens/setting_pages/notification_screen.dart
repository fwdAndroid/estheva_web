import 'package:flutter/material.dart';
import 'package:estheva_web/uitls/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(
              height: 120,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/logo.png",
                          height: 90,
                          width: 90,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Mohammad Quasi",
                                  style: TextStyle(
                                      fontFamily: 'Futura',
                                      fontSize: 16,
                                      color: appColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Container(
                                  width: 80,
                                  height: 24,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: contColor),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Center(
                                    child: Text(
                                      "Upcoming",
                                      style: TextStyle(
                                          fontFamily: 'Futura',
                                          fontSize: 12,
                                          color: mainColor),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "+82312412414424",
                              style: TextStyle(
                                  fontFamily: 'Futura',
                                  fontSize: 14,
                                  color: appColor,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "23 Sept 2023",
                                  style: TextStyle(
                                      fontFamily: 'Futura',
                                      color: dateColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "|",
                                  style: TextStyle(
                                      fontFamily: 'Futura',
                                      color: dateColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "12:30 AM",
                                  style: TextStyle(
                                      fontFamily: 'Futura',
                                      color: dateColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: dividerColor,
              ),
            )
          ],
        );
      }),
    );
  }
}
