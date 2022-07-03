import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:time_to_travel_app/Colors/colors.dart';
import 'package:time_to_travel_app/cubit/app_cubit_states.dart';
import 'package:time_to_travel_app/model/user_model.dart';
import 'package:time_to_travel_app/services/user_services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  bool isAPIcallprocess = false;
  bool hidePassword = true;

  final baseUrl = 'http://10.0.2.2:3000';
  final headers = {'Content-Type': 'application/json;charset=UTF-8'};

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? nombre;
  String? apellido;
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
            child: _registerUI(context),
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
              'Registrarse',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          //nombre
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: FormHelper.inputFieldWidget(
              context,
              'nombre',
              'Nombre',
              (onValidate) {
                if (onValidate.isEmpty) {
                  return 'El campo es obligatorio';
                }
              },
              (onSaved) => {nombre = onSaved},
              initialValue: '',
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
          //apellido
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: FormHelper.inputFieldWidget(
              context,
              'apellido',
              'Apellido',
              (onValidate) {
                if (onValidate.isEmpty) {
                  return 'El campo es obligatorio';
                }
              },
              (onSaved) => {apellido = onSaved},
              initialValue: '',
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

          //email
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: FormHelper.inputFieldWidget(
              context,
              'email',
              'email',
              (onValidate) {
                if (onValidate.isEmpty) {
                  return 'Campo obligatorio';
                }
                String pattern = r'\w+@\w+\.\w+';
                if (!RegExp(pattern).hasMatch(onValidate)) {
                  return 'Email invalido';
                }
                //email = onValideVal;
                return null;
              },
              (onSaved) => {email = onSaved},
              initialValue: '',
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
              'password',
              'Password',
              (onValidate) {
                if (onValidate.isEmpty) {
                  return 'El campo es obligatorio';
                }
                return null;
              },
              (onSaved) => {password = onSaved},
              initialValue: '',
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
          //olvidante tu contraseña
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 25,
                  top: 10,
                ),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Olvidaste tu contraseña?',
                        style: const TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // btn crear cuenta
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: FormHelper.submitButton(
                'Crear cuenta',
                () {
                  if (validateAndSave()) {
                    setState(() {
                      isAPIcallprocess = true;
                    });
                    crearUsuario();
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

          //
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
                        const TextSpan(text: 'Ya tienes una cuenta?  '),
                        TextSpan(
                          text: 'Aqui',
                          style: const TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/login');
                            },
                        ),
                      ],
                    ),
                  ),
                  //
                ),
              ),
            ),
          ),
          //
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

  void crearUsuario() async {
    final user = {
      'nombre': nombre,
      'apellido': apellido,
      'email': email,
      'password': password,
    };
    Response res = await post(
      Uri.parse(baseUrl + '/api/usuarios'),
      headers: headers,
      body: jsonEncode(user),
    );

    setState(() {
      isAPIcallprocess = false;
    });
    if (res.statusCode == 200) {
      Navigator.pushNamed(context, '/login');
    } else {
      msgUserNoCreate();
    }
  }

  void msgUserNoCreate() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cuenta no creada'),
          content: const Text('El email ingresado ya se encuentra registrado'),
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
