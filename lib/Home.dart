import 'package:flutter/material.dart';
import 'registro.dart';
import 'datas.dart';
import 'inicio.dart';
import 'test.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

Widget _currentPage = test();

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // Obtém as dimensões da tela
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Calcula a altura do cabeçalho do Drawer como uma porcentagem da altura da tela
    double headerHeight = screenHeight * 0.25;  // 25% da altura da tela

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("VALITY"),
        backgroundColor: Colors.red,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            // Cabeçalho do Drawer
            Container(
              width: double.infinity, // Garante que o container ocupe toda a largura disponível
              height: headerHeight,  // Usa a altura dinâmica
              decoration: BoxDecoration(
                color: Colors.red,  // Cor de fundo vermelha
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, screenHeight * 0.05, 16, 0), // Ajuste do padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VALITY',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,  // Tamanho fixo da fonte
                      ),
                    ),
                    Spacer(), // Espaço que empurra o texto para a parte inferior
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text(
                        'Desenvolvido por Michael Jhonathan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,  // Tamanho fixo da fonte
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Itens do Drawer
            ListTile(
              leading: Icon(Icons.home),
              title: Text('PVPS'),
              onTap: () {
                setState(() {
                  _currentPage = InicioPage();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Registro'),
              onTap: () {
                setState(() {
                  _currentPage = RegistroPage();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text('Datas Próximas'),
              onTap: () {
                setState(() {
                  _currentPage = DatasPage();
                });
                Navigator.pop(context);
              },
            ),

            // Spacer que empurra o item abaixo para o final
            Spacer(),

            // Item fixado no fundo
            ListTile(
              leading: Icon(Icons.list_alt),
              title: Text('Termos de uso'),
              onTap: () {
                setState(() {
                  _currentPage = test();
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _currentPage,
    );
  }
}
