
class Usuario {
  String _nome = "";
  String _prontEmail = "";
  String _senha = "";
  String _pront = "";
  String _loja = "";

  Usuario();

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "nome" : this.nome,
      "pront" : this.pront,
      "loja" :this.loja
    };
    return map;
  }

  String get loja => _loja;

  set loja(String value) {
    _loja = value;
  }

  String get pront => _pront;

  set pront(String value) {
    _pront = value;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get prontEmail => _prontEmail;

  set prontEmail(String value) {
    _prontEmail = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }
}