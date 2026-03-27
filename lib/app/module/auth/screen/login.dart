import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/difenece_colors.dart';
import '../../../utils/helpers/globals.dart';
import '../../../utils/widgets/global_widgets.dart';
import '../../dashboard/screen/user_dashboard.dart';
import '../controllers/auth_controller.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  LoginController loginController = Get.put(LoginController());
  var obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:  SafeArea(
          bottom: false,
          child:  Column(
            children: [

              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [

                      Align(
                        alignment: Alignment.topCenter,
                            child:     Container(
                              height: MediaQuery.of(context).size.height * 0.30,
                              child: Row(
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
                          ),
                          Positioned(
                            top:  (MediaQuery.of(context).size.height * 0.30 - 55 ),
                            child: ClipPath(
                              clipper: DiagonalClipper(),
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color: const Color(0xFFC60013),
                                padding: EdgeInsets.only(top: 32,right: 32,left: 32),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 100,),

                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          authTextFieldRounded(
                                            hint: "Email",
                                            controller: emailController,
                                            icon: Icons.email_outlined,

                                          ),
                                          authTextFieldRounded(
                                            hint: "Password",
                                            controller: passwordController,
                                            isPassword: true,
                                            icon: Icons.lock_outline,
                                            isSuffix: true,
                                            obscureText: obscureText,
                                            sufixOnTap: () {
                                              print('herer');
                                              obscureText = !obscureText;
                                              setState(() {

                                              });
                                            },
                                          ),
                                          SizedBox(height: 10,),
                                          GestureDetector(
                                            onTap: (){
                                              if(emailController.text.isEmpty){
                                                getxSnackBar(title: 'Error', message: 'Please Enter email ID');
                                              }else if(passwordController.text.isEmpty){
                                                getxSnackBar(title: 'Error', message: 'Please Enter password');
                                              }
                                              // else if(!isValidEmail(emailController.text)){
                                              //   getxSnackBar(title: 'Error', message: 'Please Enter valied email formate');
                                              // }
                                              else{
                                                // Get.to(UserDashboard());
                                                loginController.login(emailController.text, passwordController.text,context);
                                              }

                                            },
                                            child: Container(
                                              height: 50,
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
                                          SizedBox(height: 8,),

                                          Text(
                                            "Forgot Password?",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: DifeneceColors.WhiteColor,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),

                                        ],
                                      ),
                                      SizedBox(height: 40,),

                                      Padding(
                                        padding: const EdgeInsets.all(60.0),
                                        child: Image.asset(
                                          "assets/Logo_white.png", // replace with your building image
                                          height: 50,
                                          fit: BoxFit.contain,
                                        ),
                                      ),

                                    ],
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
