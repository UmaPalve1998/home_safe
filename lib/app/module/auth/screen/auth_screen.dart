import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login.dart';

class SafeHomeLoginScreen extends StatelessWidget {
  const SafeHomeLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(60.0),
                        child: Image.asset(
                          "assets/Logo.png", // replace with your building image
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
          
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    children: [
          
                          Positioned(
                            bottom:((MediaQuery.of(context).size.height/3)-55),
                            left: 0,
                            right: 0,
                            child:     Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.asset(
                                  "assets/guard.png", // replace with your guard image
                                  height: 180,
                                ),
                                Image.asset(
                                  "assets/building.png", // replace with your building image
                                  height: 300,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ClipPath(
                              clipper: DiagonalClipper(),
                              child: Container(
                                height: MediaQuery.of(context).size.height/3,
                                color: const Color(0xFFC60013),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: (){
                                      Get.to(login());
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 220,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Sign in",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFFC60013),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}

/// Custom Clipper for Diagonal Shape
class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 60);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
