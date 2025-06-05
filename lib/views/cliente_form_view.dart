import 'package:ecosafety_form_clientes/controllers/cliente_controller.dart';
import 'package:flutter/material.dart';

class ClienteFormView extends StatelessWidget {
  const ClienteFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final clienteController = ClienteController();
    return Scaffold(
      appBar: AppBar(title: const Text('Clientes')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Cadastro',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Nome do Cliente',
                      ),
                      controller: clienteController.nomeController,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      controller: clienteController.emailController,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Telefone'),
                      controller: clienteController.telefoneController,
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        // clienteController.createClientTask(
                        //   name: clienteController.nomeController.text,
                        //   email: clienteController.emailController.text,
                        //   telefone: clienteController.telefoneController.text,
                        // );
                        clienteController.getClientes();
                      },
                      child: const Text('Enviar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
