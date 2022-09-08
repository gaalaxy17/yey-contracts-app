import 'package:flutter/material.dart';
import 'package:teste/service/AuthService.dart';

import '../model/login/LoginForm.dart';
import 'home.dart';

/// This is the stateful widget that the main application instantiates.
class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _LoginWidgetState extends State<LoginWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginForm _form = new LoginForm();

  String test = "teste";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image.network(
                'https://i.imgur.com/ZpaxaX4_d.webp?maxwidth=760&fidelity=grand'),
            Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.account_circle),
                          hintText: 'Insira seu nome de usuário',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (value) =>
                            setState(() => this._form.username = value),
                      ),
                      TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.pin),
                            hintText: 'Insira sua senha',
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onChanged: (value) =>
                              setState(() => this._form.password = value)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: MaterialButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  await AuthService.login(_form);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeWidget()));
                                } catch (e) {
                                  print(e);
                                }
                              }
                            },
                            child: Text('Enviar'),
                            minWidth: double.infinity,
                            textColor: Colors.white,
                            color: Colors.indigo),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
