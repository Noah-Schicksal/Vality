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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Calcula a altura do cabeçalho do Drawer como uma porcentagem da altura da tela
    double headerHeight = screenHeight * 0.25;  // 25% da altura da tela
    //isso foi usado por questão de desing, pois usar o list não me permitiu usar a cor como plano de fundo, ficando cortada

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("VALITY"),
        backgroundColor: Colors.red,
      ),
      drawer: Drawer(
        child: Column(
          children: [
           
            Container(
              width: double.infinity, 
              height: headerHeight,  
              decoration: BoxDecoration(
                color: Colors.red,  
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, screenHeight * 0.05, 16, 0), 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VALITY',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,  
                      ),
                    ),
                    Spacer(), 
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text(
                        'Desenvolvido por Michael Jhonathan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,  
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
