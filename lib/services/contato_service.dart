import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xanocontato/models/contato_model.dart';

class ContatoService {
  final String baseUrl = 'https://x8ki-letl-twmt.n7.xano.io/api:2IV_pZQE/contato';

  Future<List<Contato>> listar() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Contato.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar contatos');
    }

  }

  Future adicionar(Contato contato) async {
    final url = Uri.parse(baseUrl);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(contato.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Contato.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao adicionar contato');
    }
  }

  Future deletar(int id) async {
    final url = Uri.parse('$baseUrl/$id');

    final response = await http.delete(url);

    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Falha ao deletar contato');
    }
  }
}
