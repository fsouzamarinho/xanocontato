import 'package:flutter/material.dart';
import 'package:xanocontato/models/contato_model.dart';
import 'package:xanocontato/services/contato_service.dart';

class ContatoList extends StatefulWidget {
  const ContatoList({super.key});

  @override
  State<ContatoList> createState() => _ContatoListState();
}

class _ContatoListState extends State<ContatoList> {
  final servico = ContatoService();
  bool carregando = false;
  List<Contato> contatos = [];

  @override
  void initState() {
    super.initState();
    carregarContatos();
  }

  Future<void> carregarContatos() async {
    setState(() {
      carregando = true;
    });

    try {
      final lista = await servico.listar();
      setState(() {
        contatos = lista;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao carregar contatos: $e')));
    } finally {
      setState(() {
        carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
      ),
      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: contatos.length,
              itemBuilder: (context, index) {
                final contato = contatos[index];
                return ListTile(
                  title: Text(contato.nome),
                  subtitle: Text(contato.telefone),
                );
              },
            ),
    );
  }
}
