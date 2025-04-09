import 'package:flutter/material.dart';
import 'package:vality/Home.dart';
import 'package:vality/cadastro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'model/usuario.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerPront = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";

  @override
  void initState() {
    _verificacaoDeLogin();
    super.initState();
  }

  _validarCampos() {
    String pront = _controllerPront.text;
    String prontEmail = '${pront}@gmail.com';
    String senha = _controllerSenha.text;

    if (pront.isNotEmpty) {
      if (senha.isNotEmpty) {
        setState(() {
          _mensagemErro = "";
        });

        Usuario usuario = Usuario();
        usuario.prontEmail = prontEmail;
        usuario.senha = senha;

        _LogarUsuario(usuario);
      } else {
        setState(() {
          _mensagemErro = "O campo senha deve ser preenchido";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "O campo prontuário deve ser preenchido";
      });
    }
  }

  _LogarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
        email: usuario.prontEmail,
        password: usuario.senha)
        .then((firebaseUser) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          )
      );
    }).catchError((error) {
      print("erro app: " + error.toString());
      setState(() {
        _mensagemErro = error.toString();
      });
    });
  }

  Future _verificacaoDeLogin() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    User? usuarioLogado = auth.currentUser;
    if (usuarioLogado != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerPront,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Prontuário",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16))),
                  ),
                ),
                TextField(
                  controller: _controllerSenha,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Senha",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        _validarCampos();
                      },
                      child: Text(
                        "Entrar",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black26,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      ),
                    )),
                Center(
                  child: GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text("Primeiro acesso? Registre-se!",
                          style: TextStyle(
                            color: Colors.blueAccent,
                          )),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => cadastro()));
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(_mensagemErro,
                        style: TextStyle(color: Colors.red, fontSize: 20)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

