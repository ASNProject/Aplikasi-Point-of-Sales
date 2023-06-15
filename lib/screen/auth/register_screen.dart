import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/text_field/gf_text_field.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  _buildTextInputData(context),
                  const SizedBox(height: 20,),
                  _buildButtonRegister(context),
                  _buildButtonLogin(context),
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
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Masukkan email',
          ),
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
        const SizedBox(height: 12,),
        GFTextField(
          obscureText: passwordVisible,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Ulangi password',
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

  Widget _buildButtonRegister(BuildContext context) {
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: GFButton(size: GFSize.LARGE, text: 'Register', onPressed: () {
        showSnackBarLogin(context);
      }),
    );
  }

  Widget _buildButtonLogin(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          GoRouter.of(context).pop();
        },
        child: const Text(
          'Login?',
          style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }

  void showSnackBarRegister(BuildContext context) {
    const snackbar = SnackBar(
      content: Center(child: Text('Login Form')),
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
      content: Center(child: Text('Register approval')),
      backgroundColor: GFColors.PRIMARY,
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(30),
      elevation: 30,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
