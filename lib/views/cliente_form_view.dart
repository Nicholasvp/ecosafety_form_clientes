import 'package:ecosafety_form_clientes/controllers/cliente_controller.dart';
import 'package:flutter/material.dart';

class ClienteFormView extends StatefulWidget {
  const ClienteFormView({super.key});

  @override
  State<ClienteFormView> createState() => _ClienteFormViewState();
}

class _ClienteFormViewState extends State<ClienteFormView> {
  late final ClienteController clienteController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    clienteController = ClienteController();
    clienteController.getCustomFields();
  }

  @override
  void dispose() {
    clienteController.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Cliente')),
      body: ValueListenableBuilder(
        valueListenable: clienteController.customFields,
        builder: (context, data, child) {
          if (data.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          /// Ordena os campos: obrigatórios primeiro
          final sortedFields = [...data]..sort((a, b) {
            if (a.required == b.required) return 0;
            return a.required ? -1 : 1;
          });

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Preencha os dados do cliente',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),

                    /// Campos dinâmicos
                    ...sortedFields.map(
                      (field) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          controller: clienteController.customFieldControllers[field.id],
                          decoration: InputDecoration(labelText: field.name, border: const OutlineInputBorder()),
                          validator: (value) {
                            if (field.required && (value == null || value.trim().isEmpty)) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),

      /// BottomNavigator fixo com botão
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ValueListenableBuilder(
              valueListenable: clienteController.customFields,
              builder: (context, data, child) {
                final isLoading = data.isEmpty;
                return ElevatedButton(
                  onPressed:
                      isLoading
                          ? null
                          : () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              await clienteController.createClientTask();
                              if (mounted) {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(const SnackBar(content: Text('Task criada com sucesso!')));
                              }
                            } else {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(const SnackBar(content: Text('Preencha todos os campos obrigatórios')));
                            }
                          },
                  child: const Text('Salvar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
