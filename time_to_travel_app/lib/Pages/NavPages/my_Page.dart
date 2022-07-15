import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:time_to_travel_app/Colors/colors.dart';
import 'package:time_to_travel_app/Pages/NavPages/register_page.dart';
import 'package:time_to_travel_app/bloc/usuario/usuario_cubit.dart';
import 'package:time_to_travel_app/config.dart';
import 'package:time_to_travel_app/cubit/app_cubits.dart';
import 'package:time_to_travel_app/model/login_request_model.dart';
import 'package:time_to_travel_app/model/user_model.dart';
import 'package:time_to_travel_app/services/api_services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class MyPage extends StatefulWidget {
  MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPage();
}

class _MyPage extends State<MyPage> {
  bool isAPIcallprocess = false;
  bool hidePassword = true;

  final baseUrl = 'http://10.0.2.2:3000';
  final headers = {'Content-Type': 'application/json;charset=UTF-8'};

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('#283B71'),
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: loginUI(context),
          ),
          inAsyncCall: isAPIcallprocess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5.2,
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
                    'assets/logo.png',
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
              'Iniciar sesión',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          //email
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: FormHelper.inputFieldWidget(
              context,
              "email",
              "email",
              (onValidate) {
                if (onValidate.isEmpty) {
                  return "Campo obligatorio";
                }
                String pattern = r'\w+@\w+\.\w+';
                if (!RegExp(pattern).hasMatch(onValidate)) {
                  return "Email invalido";
                }
                //email = onValideVal;
                return null;
              },
              (onSaved) => {email = onSaved},
              initialValue: "",
              obscureText: false,
              prefixIcon: const Icon(Icons.person),
              borderColor: Colors.white,
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
            ),
          ),
          //password
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: FormHelper.inputFieldWidget(
              context,
              "password",
              "Password",
              (onValidate) {
                if (onValidate.isEmpty) {
                  return "El campo es obligatorio";
                }
                //password = onValideVal;
                return null;
              },
              (onSaved) => {password = onSaved},
              //(onSavedVal) => {username = onSavedVal}
              initialValue: "",
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
                  setState(
                    () {
                      hidePassword = !hidePassword;
                    },
                  );
                },
                color: Colors.white.withOpacity(0.7),
                icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility),
              ),
            ),
          ),
          //
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 25, top: 10),
                child: RichText(
                  text: TextSpan(
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Olvidaste la contraseña ?',
                            style: const TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()..onTap = () {}),
                      ]),
                ),
              ),
            ),
          ),
          // btn iniciar
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Center(
              child: FormHelper.submitButton(
                'Ingresar',
                () {
                  if (validateAndSave()) {
                    setState(() {
                      isAPIcallprocess = true;
                    });
                    login();
                  }
                },
                btnColor: AppColors.mainColor,
                borderColor: Colors.white,
                txtColor: Colors.white,
                borderRadius: 10,
              ),
            ),
          ),

          const Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                'Ó',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 25, top: 10),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                      children: <TextSpan>[
                        const TextSpan(text: 'No tienes una cuenta ?'),
                        TextSpan(
                          text: 'Regístrate',
                          style: const TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/register');
                            },
                        ),
                      ],
                    ),
                  ),
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

  void login() async {
    final user = {
      'email': email,
      'password': password,
    };
    Response res = await post(
      Uri.parse(baseUrl + '/api/login'),
      headers: headers,
      body: jsonEncode(user),
    );

    setState(() {
      isAPIcallprocess = false;
    });
    if (res.statusCode == 200) {
      //Navigator.pushNamed(context, '/home');
      print(res.body);
      // ++++++++++++++++++++++++++++++++++++++++++
      print(jsonDecode(res.body));
      Map<String, dynamic> registro = Map.from(jsonDecode(res.body));
      final UserModel usuarioLogin = UserModel.fromJson(registro);
      BlocProvider.of<UsuarioCubit>(context).seleccionarUsuario(usuarioLogin);
      //print('que tipo es');
      //print(res.runtimeType);
      print('usuario');
      print(res);
      print(usuarioLogin.runtimeType);
      print('usuario-nombre');
      print(usuarioLogin.nombre);
      //context.bloc<UsuarioCubit>().seleccionarUsuario();
      //BlocProvider.of<UsuarioCubit>(context);
      // ++++++++++++++++++++++++++++++++++++++++++
    } else {
      msgUserNoCreate();
    }
  }

  void msgUserNoCreate() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error al iniciar sesión'),
          content: const Text('Email / password no valido'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Regresar'),
            ),
          ],
        );
      },
    );
  }
}
