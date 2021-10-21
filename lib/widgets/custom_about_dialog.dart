import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:picture_of_the_day/constants.dart';
import 'package:url_launcher/url_launcher.dart';

const TextStyle linkStyle = const TextStyle(
  color: Colors.blue,
  decoration: TextDecoration.underline,
  decorationColor: Colors.blue,
  fontWeight: FontWeight.normal,
);

class CustomAboutDialog extends StatelessWidget {
  const CustomAboutDialog({
    Key? key,
    required this.packageInfo,
  }) : super(key: key);

  final PackageInfo packageInfo;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DialogHeader(),
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                  right: 18.0,
                  top: 24.0,
                ),
                child: Column(
                  children: [
                    DialogContent(packageInfo: packageInfo),
                    DialogFooter(packageInfo: packageInfo),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DialogHeader extends StatelessWidget {
  const DialogHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const cornerRadii = const Radius.circular(4.0);
    return Container(
      padding: const EdgeInsets.all(18.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        // border radius is used to match the radius of the dialog corners
        borderRadius: BorderRadius.only(
          topLeft: cornerRadii,
          topRight: cornerRadii,
        ),
      ),
      child: Text(
        customDialogTitle,
        style: TextStyle(
          fontSize: 24,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class DialogContent extends StatelessWidget {
  const DialogContent({
    Key? key,
    required this.packageInfo,
  }) : super(key: key);
  final PackageInfo packageInfo;

  @override
  Widget build(BuildContext context) {
    Color richTextColor =
        Theme.of(context).primaryTextTheme.bodyText1?.color ?? Colors.black;
    const _fontSize = 16.0;
    return Column(
      children: [
        Text(
          myLegalese,
          style: TextStyle(
            fontSize: _fontSize,
          ),
        ),
        SizedBox(height: 18.0),
        RichText(
          overflow: TextOverflow.visible,
          text: TextSpan(
            children: [
              TextSpan(
                text: mailToLaunchStartStr,
                style: TextStyle(
                  color: richTextColor,
                  fontSize: _fontSize,
                ),
              ),
              TextSpan(
                text: supportEmailAddress,
                style: linkStyle.copyWith(
                    decoration: TextDecoration.none, fontSize: _fontSize),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launch(
                        '$mailToLaunchStr\nVersion number: ${packageInfo.version}\nBuild number: ${packageInfo.buildNumber}\n\n');
                  },
              ),
              TextSpan(
                text: mailToLaunchEndStr,
                style: TextStyle(
                  color: richTextColor,
                  fontSize: _fontSize,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DialogFooter extends StatelessWidget {
  const DialogFooter({Key? key, required this.packageInfo}) : super(key: key);
  final PackageInfo packageInfo;

  @override
  Widget build(BuildContext context) {
    launchLegalPage(String url) async {
      await launch(
        url,
        forceWebView: true,
        forceSafariVC: true,
        enableJavaScript: true,
      );
    }

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 12.0),
          Text('version: ${packageInfo.version}'),
          Text('build number: ${packageInfo.buildNumber}'),
          SizedBox(
            height: 12.0,
          ),
          TextButton(
            onPressed: () => launchLegalPage(privacyPolicyLink),
            child: Text(
              'Privacy Policy',
              style: linkStyle,
            ),
            style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent)),
          ),
          TextButton(
            onPressed: () => launchLegalPage(termsAndConditionsLink),
            child: Text(
              'Terms and Conditions',
              style: linkStyle,
            ),
            style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent)),
          ),
          SizedBox(height: 18.0),
        ],
      ),
    );
  }
}
