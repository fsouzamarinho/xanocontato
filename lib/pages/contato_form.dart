import 'package:flutter/material.dart';
import 'package:xanocontato/models/contato_model.dart';
import 'package:xanocontato/services/contato_service.dart';

class ContatoForm extends StatefulWidget {
  const ContatoForm({super.key});

  @override
  State<ContatoForm> createState() => _ContatoFormState();
}

class _ContatoFormState extends State<ContatoForm> {
  final nomeController = TextEditingController();
  final telefoneController = TextEditingController();
  final emailController = TextEditingController();

  final ContatoService servico = ContatoService();

  bool carregando = false;

  Future<void> salvarContato() async {
    setState(() {
      carregando = true;
    });

    final contato = Contato(
      id: 0,
      nome: nomeController.text,
      telefone: telefoneController.text,
      email: emailController.text,
    );

    final resultado = await servico.adicionar(contato);
    final menssager = ScaffoldMessenger.of(context);

    if (resultado != null) {
      if (!mounted) return;
      menssager.showSnackBar(
        const SnackBar(content: Text('Contato salvo com sucesso')),
      );
      Navigator.of(context).pop(true);
    } else {
      if (!mounted) return;
      menssager.showSnackBar(
        const SnackBar(content: Text('Erro ao salvar contato')),
      );
    }

    setState(() {
      carregando = false;
    });
  }

@override
  void dispose() {
    nomeController.dispose();
    telefoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Contato')),
      body: Form(
        child: Column(
          children: [
            TextFormField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),

            TextFormField(
              controller: telefoneController,
              decoration: const InputDecoration(labelText: 'Telefone'),
            ),

            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),

            SizedBox(height: 16),

            carregando
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: salvarContato,
                    child: Text('Salvar'),
                  ),
          ],
        ),
      ),
    );
  }
}
