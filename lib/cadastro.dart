import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vality/model/usuario.dart';
import 'package:vality/model/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Home.dart';

class cadastro extends StatefulWidget {
  const cadastro({super.key});

  @override
  State<cadastro> createState() => _cadastroState();
}

class _cadastroState extends State<cadastro> {
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerPront = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerLoja = TextEditingController();
  String _mensagemErro = "";

  _validarCampos() {
    String nome = _controllerNome.text;
    String pront = _controllerPront.text;
    String prontEmail = '${pront}@gmail.com';
    String senha = _controllerSenha.text;
    String loja = _controllerLoja.text;

    if (nome.isNotEmpty) {
      if (pront.isNotEmpty) {
        if (senha.isNotEmpty && senha.length > 6) {
          if(loja.isNotEmpty) {
            setState(() {
              _mensagemErro = "";
            });

            Usuario usuario = Usuario();
            usuario.loja = loja;
            usuario.pront = pront;
            usuario.nome = nome;
            usuario.prontEmail = prontEmail;
            usuario.senha = senha;

            _cadastrarUsuario(usuario);
          }else{
            setState(() {
              _mensagemErro =
              "O campo senha deve ser preenchido, use mais de 6 caracteres";
            });
          }
        } else {
          setState(() {
            _mensagemErro =
                "O campo senha deve ser preenchido, use mais de 6 caracteres";
          });
        }
      } else {
        setState(() {
          _mensagemErro = "O campo prontuário deve ser preenchido";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "O campo nome deve ser preenchido";
      });
    }
  }

  _cadastrarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .createUserWithEmailAndPassword(
            email: usuario.prontEmail, password: usuario.senha)
        .then((firebaseUser) {
      String uid = firebaseUser.user!.uid;
          //salvar nome e prontuário
      FirebaseFirestore db = FirebaseFirestore.instance;
      String pront = _controllerPront.text;
      db.collection("Usuarios")
      .doc(uid)
      .set(usuario.toMap());


      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Home(),
          )
      );
    }).catchError((error) {
      print("erro app: " + error.toString() );
      setState(() {
        _mensagemErro =
            "erro ao registrar, verifique os campos e tente novamente";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REGISTRO DE USUÁRIO"),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(32),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerNome,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Nome",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerPront,
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
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerLoja,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Loja",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerSenha,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Senha",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16))),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        _validarCampos();
                      },
                      child: Text(
                        "Registrar",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black26,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      ),
                    )),
                Center(
                  child: Text(_mensagemErro,
                      style: TextStyle(color: Colors.red, fontSize: 20)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
