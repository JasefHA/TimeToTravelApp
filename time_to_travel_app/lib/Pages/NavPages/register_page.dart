import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:time_to_travel_app/Colors/colors.dart';
import 'package:time_to_travel_app/Pages/NavPages/register_page.dart';
import 'package:time_to_travel_app/config.dart';
import 'package:time_to_travel_app/model/register_request_model.dart';
import 'package:time_to_travel_app/services/api_services.dart';

class RegisterPage extends StatefulWidget {
  
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isAPIcallprocess = false;
  bool hidePassword = true;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
  String? password;
  String? email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#283B71"),
        body: ProgressHUD(
          child: Form(
            key: globalFormKey, 
            child: _registerUI(context)
          ),
          inAsyncCall: isAPIcallprocess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }


  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.white]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/logo.png",
                    width: 250,
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 20,
              bottom: 30,
              top: 50,
            ),
            child: Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          FormHelper.inputFieldWidget(context, "username", "Username",
              (onValideVal) {
            if (onValideVal.isEmpty) {
              return "Username can\t be empty";
            }
            return null;
          }, (onSavedVal) {
            username = onSavedVal;
          },
              prefixIcon: const Icon(Icons.person),
              borderColor: Colors.white,
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: FormHelper.inputFieldWidget(context, "password", "Password",
                (onValideVal) {
              if (onValideVal.isEmpty) {
                return "Password can\t be empty";
              }
              return null;
            }, (onSavedVal) {
              password = onSavedVal;
            },
                prefixIcon: const Icon(Icons.person),
                borderColor: Colors.white,
                borderFocusColor: Colors.white,
                prefixIconColor: Colors.white,
                textColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.7),
                borderRadius: 10,
                obscureText: hidePassword,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    color: Colors.white.withOpacity(0.7),
                    icon: Icon(hidePassword
                        ? Icons.visibility_off
                        : Icons.visibility))),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: FormHelper.inputFieldWidget(context, "email", "Email",
                (onValideVal) {
              if (onValideVal.isEmpty) {
                return "Email can\t be empty";
              }
              return null;
            }, (onSavedVal) {
              email = onSavedVal;
            },
                prefixIcon: const Icon(Icons.person),
                borderColor: Colors.white,
                borderFocusColor: Colors.white,
                prefixIconColor: Colors.white,
                textColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.7),
                borderRadius: 10),
          ),
          const SizedBox(height: 20),
          Center(
            child: FormHelper.submitButton("Register", () {
              if (validateAndSave()) {
                setState(() {
                  isAPIcallprocess = true;
                });

                RegisterRequestModel model =
                    RegisterRequestModel(
                      username: username, 
                      password: password,
                      email: email);

                APIService.register(model).then((response) {

                  setState(() {
                    isAPIcallprocess = false;
                  });

                  if (response.data != null) {

                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config.appName,
                      "Se registró de manera correcta. Por favor ingrese a su cuenta.",
                      "OK",
                      () {
                        Navigator.of(context).pop();
                      },
                    );

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    );
                  } else {
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config.appName,
                      response.message,
                      "OK",
                      () {
                        Navigator.of(context).pop();
                      },
                    );
                  }
                });
              }
            },
                btnColor: AppColors.mainColor,
                borderColor: Colors.white,
                txtColor: Colors.white,
                borderRadius: 10),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              "OR",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 25, top: 10),
                child: RichText(
                  text: TextSpan(
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                      children: <TextSpan>[
                        const TextSpan(text: "Ya tienes una cuenta ?"),
                        TextSpan(
                            text: 'Ingresa',
                            style: const TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, "/login");
                              }),
                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}