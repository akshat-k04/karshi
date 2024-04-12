import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(), // Or any other loading indicator
            SizedBox(height: 20.0),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
