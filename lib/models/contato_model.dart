class Contato {
  final int id;
  final String nome;
  final String telefone;
  final String email;

  Contato({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.email,
  });

  factory Contato.fromJson(Map<String, dynamic> json) {
    return Contato(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      nome: json['nome']?.toString() ?? '',
      telefone: json['telefone']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "nome": nome,
      "telefone": telefone,
      "email": email,
    };
  }
}