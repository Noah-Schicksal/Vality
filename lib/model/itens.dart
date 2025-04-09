import 'package:cloud_firestore/cloud_firestore.dart';


class Item {
  String id = ""; 
  String _Validade = "";
  String _RegistradoEm = "";
  String _Descricao = "";
  String _EAN = "";

  Item();

  // Modifiquei o construtor para incluir o id
  Item.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.id; // Atribuindo o id do documento
    _Validade = snapshot["Valido até"];
    _RegistradoEm = snapshot["Data de resgistro"];
    _Descricao = snapshot["Descrição"];
    _EAN = snapshot["EAN"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "Descrição": this.Descricao,
      "EAN": this.EAN,
      "Data de resgistro": this.RegistradoEm,
      "Valido até": this.Validade,
    };
    return map;
  }

  String get EAN => _EAN;

  set EAN(String value) {
    _EAN = value;
  }

  String get Descricao => _Descricao;

  set Descricao(String value) {
    _Descricao = value;
  }

  String get RegistradoEm => _RegistradoEm;

  set RegistradoEm(String value) {
    _RegistradoEm = value;
  }

  String get Validade => _Validade;

  set Validade(String value) {
    _Validade = value;
  }

  // Getter para o campo id
  String get Id => id;  
}
