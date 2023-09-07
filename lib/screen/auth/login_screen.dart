import 'package:cash_whiz/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  _buildTextInputData(context),
                  const SizedBox(
                    height: 12,
                  ),
                  _buildCheckRemindMe(context),
                  _buildButtonLogin(context),
                  _buildButtonRegister(context),
                ],
              ),
              const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      'Aplikasi Point of Sales versi 0.1',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextInputData(BuildContext context) {
    return Column(
      children: [
        GFTextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Masukkan username'),
        ),
        const SizedBox(
          height: 12,
        ),
        GFTextField(
          obscureText: passwordVisible,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Masukkan password',
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                  icon: Icon(passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off))),
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }

  Widget _buildCheckRemindMe(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Ingat saya'),
        GFCheckbox(
          size: 25,
          activeBgColor: GFColors.PRIMARY,
          onChanged: (value) {
            setState(() {
              isChecked = value;
            });
          },
          value: isChecked,
          inactiveIcon: null,
        )
      ],
    );
  }

  Widget _buildButtonLogin(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: GFButton(
          size: GFSize.LARGE,
          text: 'Login',
          onPressed: () {
            GoRouter.of(context).pushReplacementNamed(AppRoutes.homescreen);
          }),
    );
  }

  Widget _buildButtonRegister(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          GoRouter.of(context).push(AppRoutes.register);
        },
        child: const Text(
          'Register?',
          style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }

  void showSnackBarRegister(BuildContext context) {
    const snackbar = SnackBar(
      content: Center(child: Text('Register Form')),
      backgroundColor: GFColors.PRIMARY,
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(30),
      elevation: 30,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void showSnackBarLogin(BuildContext context) {
    const snackbar = SnackBar(
      content: Center(child: Text('Home')),
      backgroundColor: GFColors.PRIMARY,
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(30),
      elevation: 30,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
