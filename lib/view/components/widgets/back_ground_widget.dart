import 'package:xmovie/view/components/style.dart';
import 'package:flutter/material.dart';

class BackGroundWidget extends StatefulWidget {
  final Widget child;
  const BackGroundWidget({super.key, required this.child});

  @override
  State<BackGroundWidget> createState() => _BackGroundWidgetState();
}

class _BackGroundWidgetState extends State<BackGroundWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Style.primaryColor.withOpacity(0.8) ,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Background.png",),
              fit: BoxFit.cover
            )
          ),
          child:widget.child,
        ),
      ),
    );
  }
}
