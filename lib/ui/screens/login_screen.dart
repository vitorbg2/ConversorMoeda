import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:in8/ui/screens/conversao_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20);

  // Login na aplicação, faz a rota para a página inicial do app
  _login() {
    Navigator.pushReplacement(context, MaterialPageRoute<void>(
      builder: (context) {
        return ConversaoScreen();
      }
    ));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextField(
                  style: style,
                  // autofocus: true,
                  decoration: InputDecoration(hintText: "Username or Email"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextField(
                  style: style,
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Password"),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Material(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.purple,
                  child: MaterialButton(
                    onPressed: () {
                      // Inserir implementações de autenticação e segurança
                      _login();
                    },
                    minWidth: width,
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Or login with social media",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),

              Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  width: width,
                  height: 50,
                  child: SignInButton(
                    Buttons.Facebook,
                    onPressed: () {
                      // Chamada da api de rede social
                      _login();
                    },
                    text: 'LOGIN WITH FACEBOOK',
                  )),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 3),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: width,
                height: 50,
                child: SignInButton(
                  Buttons.Twitter,
                  onPressed: () {
                    // Chamada da api de rede social
                      _login();
                    },
                  text: 'LOGIN WITH TWITTER',
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 3),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: width,
                height: 50,
                child: SignInButton(
                  Buttons.Google,
                  onPressed: () {
                    // Chamada da api de rede social
                      _login();
                    },
                  text: 'LOGIN WITH GOOGLE',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
