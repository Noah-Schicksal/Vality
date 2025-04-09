import 'package:flutter/material.dart';

class test extends StatefulWidget {
  @override
  State<test> createState() => _HomeState();
}

class _HomeState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        child: SingleChildScrollView(
              padding: EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Termos de uso.",
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("1. Responsabilidade do Usuário",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("Este aplicativo é uma ferramenta não oficial e sem fins lucrativos."
                      " Todas as datas de validade e informações inseridas são de responsabilidade"
                      " exclusiva do usuário. O aplicativo não se responsabiliza por erros de inserção,"
                      " falta de atualização ou qualquer outra inconsistência nas datas de validade."),

                  SizedBox(height: 16),
                  Text("2. Notificação de Validade",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("O aplicativo tem como objetivo principal notificar o usuário "
                      "sobre possíveis riscos relacionados a itens com validade expirada."
                      " Contudo, não garante a precisão absoluta das informações,"
                      " e a responsabilidade pela verificação das datas de validade permanece com o usuário."),

                  SizedBox(height: 16),
                  Text("3. Itens com Validade Expirada",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("Este aplicativo não se responsabiliza por itens com validade expirada,"
                      " sendo sua função limitada a fornecer alertas e notificações."
                      " É importante que o usuário realize o acompanhamento das datas de"
                      " validade dos produtos manualmente, garantindo sua segurança."),

                  SizedBox(height: 16),
                  Text("4. Notificações de Alerta",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("O aplicativo não se responsabiliza por falta de alertas de validade,"
                      " pois as notificações de alerta enviadas podem ser restringidas pelo usuário."
                      " O sistema de notificações pode ser desativado ou configurado pelo usuário,"
                      " e o aplicativo não tem controle sobre essas configurações no dispositivo."),

                  SizedBox(height: 16),
                  Text("5. Desativação do Aplicativo",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("Este aplicativo é não oficial e pode ser desativado a qualquer momento sem aviso prévio."
                      " Não há compromisso com a continuidade dos serviços, sendo um meio gratuito e sem fins lucrativos."),

                  SizedBox(height: 16),
                  Text("5-2. Desativação do Aplicativo",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("As informações fornecidas pelo usuário ao aplicativo estão armazenadas na base de dados fornecida "
                      "gratuitamente pelo _FireBase_, apartir do momento da desativação do aplicativo ou de seu banco de dados, "
                      "todas as informações disponiveis para consulta serão deletadas sem possibilidade de recuperação."),

                  SizedBox(height: 16),
                  Text("Ao realizar o uso desse aplicativo, o usuário concorda com os termos descritos a cima "
                      "e assume total responsabilidade sobre seu uso",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),

      )
    );
  }
}
