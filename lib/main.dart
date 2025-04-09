import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vality/login.dart';
import 'package:vality/Home.dart'; // Sua página inicial
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'model/notify/notifications_service.dart';

void main() async {
  // Garantir que a inicialização do Firebase seja feita corretamente
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vality App',  // Nome do seu app
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.black38,  // Cor primária
          secondary: Colors.green,  // Cor secundária
        ),
      ),
      home: AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Aqui verificamos se o usuário está autenticado
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),  // Verifica o estado de autenticação
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Carregando enquanto verifica a autenticação
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          // Se o usuário estiver autenticado, redireciona para a Home
          return Home();
        } else {
          // Se não, redireciona para a tela de login
          return Login();
        }
      },
    );
  }
}
