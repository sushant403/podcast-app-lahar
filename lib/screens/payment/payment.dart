import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:songapp/Api/Networkutils.dart';
import 'package:songapp/appconfi.dart';
import 'package:songapp/screens/payment/sucesspayment.dart';

// ignore: must_be_immutable
class Payment extends StatefulWidget {
  String userid, pkgid, totlprice;

  Payment(this.userid, this.pkgid, this.totlprice);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  String selectedUrl =
      'http://appiconmakers.com/demoMusicPlayer/API/getStripePaymentScreen';

  final _history = [];
  // ignore: unused_field
  StreamSubscription<String> _onUrlChanged;
  @override
  void initState() {
    super.initState();
    widget.totlprice = widget.totlprice.replaceAll("\$", "");

    selectedUrl = Networkutils.BASEURL +
        "getStripePaymentScreen?user_id=" +
        widget.userid +
        "/&package_id=" +
        widget.pkgid +
        "/&total_package_price=" +
        widget.totlprice;
    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen(
      (String url) {
        if (mounted) {
          setState(() {
            _history.add('onUrlChanged: $url');
            if (url == "http://appiconmakers.com/demoMusicPlayer/stripePost") {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => SucessPayment(),
                ),
              );
            }
          });
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    flutterWebViewPlugin.dispose();
  }

  AppConfig _appConfig;
  @override
  Widget build(BuildContext context) {
    _appConfig = AppConfig(context);
    return WebviewScaffold(
      url: selectedUrl,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Payment',
                style: TextStyle(
                  fontSize: _appConfig.rHP(3),
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ),
      withZoom: true,
      withLocalStorage: true,
      withJavascript: true,
      hidden: false,
      initialChild: Container(
        child: const Center(
          child: Text('Waiting.....'),
        ),
      ),
    );
  }
}
