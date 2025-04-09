import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'model/itens.dart';
import 'dart:async';

import 'model/notify/notifications_service.dart'; // Importando o serviço de notificação

class InicioPage extends StatefulWidget {
  @override
  _InicioPageState createState() => _InicioPageState(); // Criando o estado do widget
}

class _InicioPageState extends State<InicioPage> {
  // Lista de itens
  List<Item> _itens = [];

  // Função para recuperar os itens do Firestore
  Future<void> _recuperarItens() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await db.collection("Itens").get();

    // Usando o Item.fromSnapshot para mapear os documentos
    List<Item> itens = querySnapshot.docs.map((doc) {
      return Item.fromSnapshot(doc); // Atualizado para Item
    }).toList();

    // Ordenar a lista pela data de validade (da mais próxima para a mais distante)
    itens.sort((a, b) {
      // Formatar a data para DateTime usando o formato correto
      DateFormat dateFormat = DateFormat("dd/MM/yyyy");
      DateTime validadeA = dateFormat.parse(a.Validade); // Convertendo para DateTime
      DateTime validadeB = dateFormat.parse(b.Validade); // Convertendo para DateTime
      return validadeA.compareTo(validadeB); // Ordenando da mais próxima para a mais distante
    });

    setState(() {
      _itens = itens; // Atualizando a lista de itens no estado
    });

    // Verificar e excluir itens com validade expirada
    _verificarEEnviarNotificacoes();
  }

  // Função para excluir o item do Firestore
  Future<void> _excluirItem(String documentId) async {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      // A referência do documento é agora baseada no documentId
      DocumentReference documentReference = db.collection('Itens').doc(documentId);

      // Excluindo o documento
      await documentReference.delete();

      // Removendo o item da lista local
      setState(() {
        _itens.removeWhere((item) => item.Id == documentId);
      });

      // Mostrando uma mensagem de sucesso
      print("Item excluído com sucesso!");
    } catch (e) {
      print("Erro ao excluir item: $e");
    }
  }

  // Função para verificar a data de validade e enviar notificações
  void _verificarEEnviarNotificacoes() {
    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    DateTime now = DateTime.now();

    for (var item in _itens) {
      DateTime validade = dateFormat.parse(item.Validade);
      int diasRestantes = validade.difference(now).inDays;

      // Enviar notificações de acordo com a proximidade da validade
      if (diasRestantes == 30 || diasRestantes == 15 || diasRestantes == 7) {
        // Enviar a notificação
        NotificationService.showNotification(
          item.Id.hashCode, // Usando o hash do ID do item como identificador único
          'Aviso de validade!',
          'O item "${item.Descricao}" vai vencer em $diasRestantes dias.',
        );
      }

      // Verificando se o item expirou (vencido há mais de 5 dias) e excluir
      if (validade.isBefore(now.subtract(Duration(days: 5)))) {
        _excluirItem(item.id);
      }
    }
  }

  // Verificar itens expirados a cada 24 horas
  @override
  void initState() {
    super.initState();
    _recuperarItens(); // Carregar os itens ao iniciar a página
    Timer.periodic(Duration(hours: 24), (timer) {
      _verificarEEnviarNotificacoes(); // Verificar e enviar notificações a cada 24 horas
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Itens'),
      ),
      body: _itens.isEmpty
          ? Center(child: CircularProgressIndicator()) // Se não houver itens
          : ListView.builder(
        itemCount: _itens.length,
        itemBuilder: (context, index) {
          Item item = _itens[index];

          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                title: Text(
                  item.Descricao,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Row(
                  children: [
                    // Primeira coluna (EAN)
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'EAN: ${item.EAN}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Registrado em: ${item.RegistradoEm}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Segunda coluna (Validade e botão)
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Valido até: ${item.Validade}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 4),
                          ElevatedButton(
                            onPressed: () async {
                              await _excluirItem(item.id); // Exclui o item usando o documentId
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Item excluído com sucesso!"),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            child: Text("Excluir"),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              textStyle: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Divider para separar os itens
              Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 15,
                endIndent: 15,
              ),
            ],
          );
        },
      ),
    );
  }
}
