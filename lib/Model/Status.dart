class Status {
  int id;
  int status;
  String dataAbertura;
  Null dataConclusao;
  Documento documento;
  Aluno aluno;
  Cursos curso;

  Status(
      {this.id,
      this.status,
      this.dataAbertura,
      this.dataConclusao,
      this.documento,
      this.aluno,
      this.curso});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    dataAbertura = json['data_abertura'];
    dataConclusao = json['data_conclusao'];
    documento = json['documento'] != null
        ? new Documento.fromJson(json['documento'])
        : null;
    aluno = json['aluno'] != null ? new Aluno.fromJson(json['aluno']) : null;
    curso = json['curso'] != null ? new Cursos.fromJson(json['curso']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['data_abertura'] = this.dataAbertura;
    data['data_conclusao'] = this.dataConclusao;
    if (this.documento != null) {
      data['documento'] = this.documento.toJson();
    }
    if (this.aluno != null) {
      data['aluno'] = this.aluno.toJson();
    }
    if (this.curso != null) {
      data['curso'] = this.curso.toJson();
    }
    return data;
  }
}

class Documento {
  int id;
  String nome;
  String descricao;

  Documento({this.id, this.nome, this.descricao});

  Documento.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    return data;
  }
}

class Aluno {
  int id;
  String nome;
  int matricula;
  String rg;
  String cpf;
  String dataNasc;
  String email;
  String tipo;
  Usuario usuario;
  List<Cursos> cursos;

  Aluno(
      {this.id,
      this.nome,
      this.matricula,
      this.rg,
      this.cpf,
      this.dataNasc,
      this.email,
      this.tipo,
      this.usuario,
      this.cursos});

  Aluno.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    matricula = json['matricula'];
    rg = json['rg'];
    cpf = json['cpf'];
    dataNasc = json['data_nasc'];
    email = json['email'];
    tipo = json['tipo'];
    usuario =
        json['usuario'] != null ? new Usuario.fromJson(json['usuario']) : null;
    if (json['cursos'] != null) {
      cursos = new List<Cursos>();
      json['cursos'].forEach((v) {
        cursos.add(new Cursos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['matricula'] = this.matricula;
    data['rg'] = this.rg;
    data['cpf'] = this.cpf;
    data['data_nasc'] = this.dataNasc;
    data['email'] = this.email;
    data['tipo'] = this.tipo;
    if (this.usuario != null) {
      data['usuario'] = this.usuario.toJson();
    }
    if (this.cursos != null) {
      data['cursos'] = this.cursos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Usuario {
  int id;
  String email;
  String perfil;

  Usuario({this.id, this.email, this.perfil});

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    perfil = json['perfil'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['perfil'] = this.perfil;
    return data;
  }
}

class Cursos {
  int id;
  String nome;
  String descricao;
  int status;
  String codigo;

  Cursos({this.id, this.nome, this.descricao, this.status, this.codigo});

  Cursos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    status = json['status'];
    codigo = json['codigo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['status'] = this.status;
    data['codigo'] = this.codigo;
    return data;
  }
}
