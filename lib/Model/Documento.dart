class Documento {
  int id;
  String nome;
  String descricao;

  Documento({this.id, this.nome, this.descricao});

  factory Documento.fromJson(Map<String, dynamic> json) {
    return Documento(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "descricao": descricao,
      };
}