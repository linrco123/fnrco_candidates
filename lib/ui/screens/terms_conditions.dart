import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_urls.dart';
import '../../core/functions/translate.dart';
import '../widgets/return_btn.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  WebViewController? _webViewController;
  double webProgress = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _webViewController = WebViewController()
        ..loadRequest(Uri.parse(AppLinks.terms_conditions))
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(NavigationDelegate(
          onProgress: (progress) {
            setState(() {
              //this.webProgress = progress / 100;
            });
          },
          onPageFinished: (url) {
            this.webProgress = 10.0;
          },
        ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            translateLang(context, "terms_conditions"),
            style: TextStyle(
              color: AppColors.primary,
            ),
          ),
          centerTitle: true,
          leading: ReturnButton(),
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: Column(
          children: [
            this.webProgress < 1
                ? LinearProgressIndicator(
                    color: AppColors.primary,
                    backgroundColor: AppColors.black,
                  )
                : const SizedBox.shrink(),
            Expanded(child: WebViewWidget(controller: _webViewController!)),
            const SizedBox(
              height: 20.0,
            )
          ],
        ));
  }
}
