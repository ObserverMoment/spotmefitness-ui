import 'package:flutter/cupertino.dart';

class UnAuthedLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoPageScaffold(
          backgroundColor: CupertinoColors.white,
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Stack(alignment: Alignment.center, children: [
                    PageView(
                      children: [
                        SizedBox.expand(
                            child: Container(
                          color: CupertinoColors.activeBlue,
                        )),
                        SizedBox.expand(
                            child: Container(
                          color: CupertinoColors.activeGreen,
                        )),
                        SizedBox.expand(
                            child: Container(
                          color: CupertinoColors.systemYellow,
                        )),
                      ],
                    ),
                    Container(
                      height: 400,
                      child: CupertinoFormSection(children: [
                        CupertinoFormRow(
                            child: CupertinoTextFormFieldRow(
                          initialValue: 'Hello',
                        )),
                        CupertinoFormRow(
                            child: CupertinoTextFormFieldRow(
                          initialValue: 'There',
                        )),
                        CupertinoFormRow(
                            child: CupertinoTextFormFieldRow(
                          initialValue: 'World',
                        ))
                      ]),
                    )
                  ]),
                ),
              ],
            ),
          )),
    );
  }
}
