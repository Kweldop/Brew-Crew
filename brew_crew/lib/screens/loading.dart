import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
     color: Colors.brown[100],
      child: Center(
        child: SpinKitFadingCircle(
          color: Colors.brown[400],
          size: 50,
        ),
      ),
    );
  }
}

