import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timbox/src/presentation/pages/home/layouts/layout.dart';
import 'package:timbox/src/presentation/pages/home/servicios/servicios_viewmodel.dart';

class ServiciosPage extends StatelessWidget {
  const ServiciosPage({super.key});

  @override
  Widget build(BuildContext context) {

    ServiciosViewmodel vm = Provider.of<ServiciosViewmodel>(context); //Se debe instanciar el viewmodel


    return Scaffold(
      body: Layout(
        child: Consumer<ServiciosViewmodel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Lista de Servicios",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: viewModel.posts.length,
                  itemBuilder: (context, index) {
                    final post = viewModel.posts[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        leading: Text(post.id.toString()),
                        title: Text(post.title),
                        subtitle: Text(post.body),
                        trailing: Wrap(
                          spacing: 8, // Espacio entre botones
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              tooltip: "Editar",
                              onPressed: () {
                                // Lógica para editar
                                _showEditDialog(context, post, vm);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              tooltip: "Eliminar",
                              onPressed: () {
                                // Confirmación de eliminación
                                _showDeleteConfirmation(context, vm, post);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateDialog(context, vm);
          //viewModel.addPost();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Método para mostrar un diálogo de edición
  void _showEditDialog(BuildContext context, dynamic post, ServiciosViewmodel vm) {
    TextEditingController titleController =
    TextEditingController(text: post.title);
    TextEditingController bodyController =
    TextEditingController(text: post.body);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Editar Servicio"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Título"),
              ),
              TextField(
                controller: bodyController,
                decoration: const InputDecoration(labelText: "Descripción"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () async{
                await vm.editPosts(post.id, titleController.text, bodyController.text, context);
                Navigator.of(context).pop();
                // Actualiza el ViewModel si es necesario
              },
              child: const Text("Guardar"),
            ),
          ],
        );
      },
    );
  }

  // Método para mostrar una confirmación de eliminación
  void _showDeleteConfirmation(
      BuildContext context, ServiciosViewmodel viewModel, dynamic post) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Eliminar Servicio"),
          content: const Text(
              "¿Estás seguro de que deseas eliminar este servicio?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () async{
                await viewModel.deletePosts(post.id, context);
                Navigator.of(context).pop();
              },
              child: const Text("Eliminar"),
            ),
          ],
        );
      },
    );
  }



  void _showCreateDialog(BuildContext context, ServiciosViewmodel vm) {
    TextEditingController titleController =
    TextEditingController();
    TextEditingController bodyController =
    TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Editar Servicio"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Título"),
              ),
              TextField(
                controller: bodyController,
                decoration: const InputDecoration(labelText: "Descripción"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () async{
                await vm.createPosts(context, titleController.text, bodyController.text);
                Navigator.of(context).pop();
                // Actualiza el ViewModel si es necesario
              },
              child: const Text("Guardar"),
            ),
          ],
        );
      },
    );
  }
}
