import 'package:awesome_app/src/features/authentication/presentation/appbar_shape.dart';
import 'package:awesome_app/src/utils/app_constants.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final decorationImage = const AssetImage(AssetConstants.loadingImg);

  @override
  void didChangeDependencies() {
    precacheImage(decorationImage, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(image: DecorationImage(image: decorationImage)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: Container(
          color: ColorConstants.primaryAlternative2,
          height: AppConstants.getSize(context).height * 0.35,
          width: AppConstants.getSize(context).width,
          child: ClipPath(
            clipper: BottomShapeLoading(),
            child: Container(
              height: AppConstants.getSize(context).height * 0.30,
              color: ColorConstants.primaryAlternative,
            ),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: AppConstants.getSize(context).height * 0.40,
          flexibleSpace: ClipPath(
            clipper: AppbarShape(),
            child: Container(
              color: ColorConstants.primaryContainer,
            ),
          ),
        ),
      ),
    ));
  }
}

class BottomShapeLoading extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    Path path = Path();
    path.lineTo(0, height - 200);
    path.quadraticBezierTo(100, height - 250, width * 0.50, height - 150);
    path.quadraticBezierTo(width * 0.60, height - 100, width, height - 150);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
