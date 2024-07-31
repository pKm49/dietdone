import 'dart:developer';

import 'package:diet_diet_done/auth/sign_up/view/otp_succuss_screen.dart';
import 'package:diet_diet_done/core/api/const_api_endpoints.dart';
import 'package:diet_diet_done/profile_config/api_service/create_subscription_service.dart';
import 'package:diet_diet_done/profile_config/controller/subscription_plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class PaymentGatewayWebview extends StatefulWidget {
  const PaymentGatewayWebview({super.key});

  @override
  State<PaymentGatewayWebview> createState() => PaymentGatewayWebviewState();
}

double _progress = 0;
late InAppWebViewController inAppWebViewController;

class PaymentGatewayWebviewState extends State<PaymentGatewayWebview> {
  final subscriptionPlanController = Get.find<SubscriptionPlanController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                  url: WebUri(subscriptionPlanController.transactionUrl.value)),
              onReceivedServerTrustAuthRequest: (controller, challenge) async {
                return ServerTrustAuthResponse(
                    action: ServerTrustAuthResponseAction.PROCEED);
              },
              onWebViewCreated: (controller) {
                inAppWebViewController = controller;
              },
              onProgressChanged: (controller, progress) {
                setState(() {
                  _progress = progress / 100;
                });
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                final uri = navigationAction.request.url;
                if (uri.toString() ==
                    "${ApiConfig.baseUrl}/subscription/payment/status") {
                   Get.back();
                  return NavigationActionPolicy.CANCEL;
                }
              },
            ),
            _progress < 1
                ? Container(
                    child: LinearProgressIndicator(
                      value: _progress,
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
