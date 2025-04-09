import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/itens.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  TextEditingController _preenchimentoValidade = TextEditingController();
  TextEditingController _preenchimentoDescricao = TextEditingController();
  TextEditingController _data_Hoje = TextEditingController();
  TextEditingController _EAN = TextEditingController();
  String _menssagemErro = "";
  DateTime diaHoje = DateTime.now();

  // Método para validar os campos antes de salvar no banco
  _validarCampos() async {
    String Validade = _preenchimentoValidade.text;
    String data = _data_Hoje.text;
    String descricao = _preenchimentoDescricao.text;
    String ean = _EAN.text;

    if (descricao.isNotEmpty) {
      if (Validade.isNotEmpty) {
        if (ean.isNotEmpty) {
          // Valida a validade no formato dd/mm/aaaa
          setState(() {
            _menssagemErro = "";
          });

          Item item = Item();
          item.Descricao = descricao;
          item.Validade = Validade;
          item.EAN = ean;
          item.RegistradoEm = diaHoje.toString();

          // Cadastrar o item e mostrar a Snackbar
          await _cadastrarItem(item);
        } else {
          setState(() {
            _menssagemErro = "Preencha o código EAN";
          });
        }
      } else {
        setState(() {
          _menssagemErro = "Validade inválida, preencher no formato dd/mm/aaaa";
        });
      }
    } else {
      setState(() {
        _menssagemErro = "Digite a descrição do item";
      });
    }
  }

  // Método para cadastrar o item no Firestore
  _cadastrarItem(Item item) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    try {
      // Registra o item no Firestore
      await db.collection("Itens").doc().set(item.toMap());

      // Exibe a Snackbar de sucesso após o cadastro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Item registrado com sucesso!'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Caso ocorra algum erro, exibe a Snackbar de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao registrar o item!'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  TextEditingController validadeController = TextEditingController();
  TextEditingController diasRestantesController = TextEditingController();

  // Função para calcular os dias restantes para o produto vencer
  void calcularDiasRestantes(String validade) {
    try {
      // Obter a data de validade a partir da string inserida no campo
      DateTime validadeDate = DateFormat('dd/MM/yyyy').parse(validade);

      // Obter a data de hoje
      DateTime hoje = DateTime.now();

      // Calcular a diferença entre as datas
      int diferenca = validadeDate.difference(hoje).inDays;

      // Atualizar o estado para mostrar a diferença na tela
      setState(() {
        if (diferenca > 0) {
          diasRestantesController.text = '$diferenca dias';
        } else if (diferenca == 0) {
          diasRestantesController.text = 'já venceu!';
        } else {
          diasRestantesController.text = 'já venceu!';
        }
      });
    } catch (e) {
      // Caso a data não seja válida, não faz nada ou pode exibir um erro
      setState(() {
        diasRestantesController.text = 'Data inválida';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String dataHoje = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
              child: Row(
                children: [
                  // Campo de Descrição
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Descrição",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          TextField(
                            controller:
                            _preenchimentoDescricao, // Usando o controlador correto
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                              labelText: "Descrição",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        32,
                        16,
                        32,
                        16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "EAN",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextField(
                            controller: _EAN,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(8, 18, 8, 18),
                              labelText: "Cód: EAN",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(4, 16, 32, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Validade",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: _preenchimentoValidade,
                          keyboardType: TextInputType.datetime,
                          style: TextStyle(fontSize: 16),
                          onChanged: (validade) {
                            // Chama a função para calcular os dias restantes
                            calcularDiasRestantes(validade);
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                            labelText: "AA/MM/AAAA",
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                // Campo de Data
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(32, 16, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hoje",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: TextEditingController(text: dataHoje),
                          enabled: false,
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                            labelText: "Data",
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Campo de Dias Restantes
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 32, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Status da validade",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 12),
                        TextField(
                          controller: diasRestantesController,
                          enabled: false, // O campo não é editável
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(24, 16, 32, 16),
                            labelText: "Dias restantes",
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                _validarCampos();
              },
              child: Text("Enviar"),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(_menssagemErro,
                  style: TextStyle(color: Colors.red, fontSize: 20)),
            )
          ],
        ),
      ),
    );
  }
}
