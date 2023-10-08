import 'package:flutter/material.dart';

import 'package:flutter_klarna_payment/flutter_klarna_payment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = KlarnaPaymentController();
  String text = '';
  @override
  void initState() {
    super.initState();
    controller.stateStream.listen((event) {
      setState(() {
        text = event.state;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Column(
            children: [
              Expanded(
                child: KlarnaPaymentView(
                  controller: controller,
                  request: KlarnaPaymentRequest(
                    clientToken: token,
                    returnUrl: 'https://example.flutter_klarna_payment',
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.pay();
                  },
                  child: Text('Pay ${text}'))
            ],
          )),
    );
  }
}

const token =
    'eyJhbGciOiJSUzI1NiIsImtpZCI6IjgyMzA1ZWJjLWI4MTEtMzYzNy1hYTRjLTY2ZWNhMTg3NGYzZCJ9.eyJzZXNzaW9uX2lkIjoiOGViMmFmYzctNzIxMi01NjRiLTgwYmUtNDE5MWFlYjU0MGE5IiwiYmFzZV91cmwiOiJodHRwczovL2pzLnBsYXlncm91bmQua2xhcm5hLmNvbS9ldS9rcCIsImRlc2lnbiI6ImtsYXJuYSIsImxhbmd1YWdlIjoiZW4iLCJwdXJjaGFzZV9jb3VudHJ5IjoiR0IiLCJlbnZpcm9ubWVudCI6InBsYXlncm91bmQiLCJtZXJjaGFudF9uYW1lIjoiWW91ciBidXNpbmVzcyBuYW1lIiwic2Vzc2lvbl90eXBlIjoiUEFZTUVOVFMiLCJjbGllbnRfZXZlbnRfYmFzZV91cmwiOiJodHRwczovL2V1LnBsYXlncm91bmQua2xhcm5hZXZ0LmNvbSIsInNjaGVtZSI6dHJ1ZSwiZXhwZXJpbWVudHMiOlt7Im5hbWUiOiJrcGMtMWstc2VydmljZSIsInZhcmlhdGUiOiJ2YXJpYXRlLTEifSx7Im5hbWUiOiJrcGMtUFNFTC0zMDk5IiwidmFyaWF0ZSI6InZhcmlhdGUtMSJ9LHsibmFtZSI6ImtwLWNsaWVudC11dG9waWEtcG9wdXAtcmV0cmlhYmxlIiwidmFyaWF0ZSI6InZhcmlhdGUtMSJ9LHsibmFtZSI6ImtwLWNsaWVudC11dG9waWEtc3RhdGljLXdpZGdldCIsInZhcmlhdGUiOiJpbmRleCIsInBhcmFtZXRlcnMiOnsiZHluYW1pYyI6InRydWUifX0seyJuYW1lIjoia3AtY2xpZW50LXV0b3BpYS1mbG93IiwidmFyaWF0ZSI6InZhcmlhdGUtMSJ9LHsibmFtZSI6ImtwLWNsaWVudC1vbmUtcHVyY2hhc2UtZmxvdyIsInZhcmlhdGUiOiJ2YXJpYXRlLTEifSx7Im5hbWUiOiJpbi1hcHAtc2RrLW5ldy1pbnRlcm5hbC1icm93c2VyIiwicGFyYW1ldGVycyI6eyJ2YXJpYXRlX2lkIjoibmV3LWludGVybmFsLWJyb3dzZXItZW5hYmxlIn19LHsibmFtZSI6ImtwLWNsaWVudC11dG9waWEtc2RrLWZsb3ciLCJ2YXJpYXRlIjoidmFyaWF0ZS0xIn0seyJuYW1lIjoia3AtY2xpZW50LXV0b3BpYS13ZWJ2aWV3LWZsb3ciLCJ2YXJpYXRlIjoidmFyaWF0ZS0xIn0seyJuYW1lIjoiaW4tYXBwLXNkay1jYXJkLXNjYW5uaW5nIiwicGFyYW1ldGVycyI6eyJ2YXJpYXRlX2lkIjoiY2FyZC1zY2FubmluZy1lbmFibGUifX1dLCJyZWdpb24iOiJldSIsIm9yZGVyX2Ftb3VudCI6MTAsIm9mZmVyaW5nX29wdHMiOjAsIm9vIjoiN3MiLCJ2ZXJzaW9uIjoidjEuMTAuMC0xNTkwLWczZWJjMzkwNyJ9.YPIMf9Vr-_sBd7dDJcDcOP3I0t_WsumqEp1iWQGgM0qCkDmhhy9Z6PoCSlqs6-tg4WaQmEgUiH2BoCi8gt0IlqJ7oAUjhzjaYqTt_WavNIWLuV0vRT5LEhJU6ngHjlTp3oquqVyC5dXQAWkQ1MuWgPbIIArzP_dBZ2jHxu9rOYmlUa3XzZdktfymohVBjYImV6JeXa2NsYUFZVJyE5yNhP9b_pJdnPKKMM86QAd8QaLsJ0_DvofhUWcIYffa_kEt0ydmOdekxfFkUzLHHRVqRbfW9EYwYw94z62asrkGFmz6p_0y3WfHJ1vLq-Pbo3E0j92cLKpdhm6RQ24DZJx2Uw';
