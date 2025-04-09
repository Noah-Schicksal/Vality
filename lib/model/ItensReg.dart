import 'package:cloud_firestore/cloud_firestore.dart';

class ItensReg {
  String _EAN;
  String _Descricao;
  String _Validade;
  String _DataReg;

  ItensReg(this._EAN, this._Descricao, this._Validade, this._DataReg);

  // Getters e Setters
  String get EAN => _EAN;
  set EAN(String value) {
    _EAN = value;
  }

  String get Descricao => _Descricao;
  set Descricao(String value) {
    _Descricao = value;
  }

  String get Validade => _Validade;
  set Validae(String value) {
    _Validade = value;
  }

  String get DataReg => _DataReg;
  set DataReg(String value) {
    _DataReg = value;
  }

  // Converte um documento do Firestore para um objeto ItensReg
  factory ItensReg.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data != null) {
      return ItensReg(
        data['EAN'] ?? '',
        data['Descricao'] ?? '',
        data['Validae'] ?? '',
        data['DataReg'] ?? '',
      );
    } else {
      throw Exception('Documento não encontrado');
    }
  }

  // Converte um objeto ItensReg para um Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'EAN': _EAN,
      'Descricao': _Descricao,
      'Validae': _Validade,
      'DataReg': _DataReg,
    };
  }
}
