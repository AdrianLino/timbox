import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../domain/models/archivos_data.dart';
import '../../../../domain/models/colaborador_data.dart';
import '../layouts/layout.dart';
import 'package:url_launcher/url_launcher.dart';

import 'empleados_viewmodel.dart';

class EmpleadosPage extends StatefulWidget {
  const EmpleadosPage({Key? key}) : super(key: key);

  @override
  _CargaArchivosPageState createState() => _CargaArchivosPageState();
}

class _CargaArchivosPageState extends State<EmpleadosPage> {
  late EmpleadosViewmodel _viewModel;
  List<ColaboradorData> _archivos = [];

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<EmpleadosViewmodel>(context, listen: false);
    _cargarArchivos();
  }



  Future<void> _cargarArchivos() async {
    try {
      final listaArchivos = await _viewModel.obtenerArchivos();
      setState(() {
        _archivos = listaArchivos;
      });
    } catch (e) {
      debugPrint("Error al cargar archivos: $e");
    }
  }




  Future<void> _eliminarArchivo(ColaboradorData archivo) async {
    try {
      /*final ok = await _viewModel.eliminarArchivo(archivo.id);
      if (ok) {
        await _cargarArchivos();
      }*/
    } catch (e) {
      debugPrint("Error al eliminar archivo: $e");
    }
  }

  Future<void> _editarNombre(ColaboradorData archivo) async {
    final controller = TextEditingController(text: archivo.nombre);
    await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Editar nombre"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: "Nuevo nombre"),
          ),
          actions: [
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
            TextButton(
              child: const Text("Guardar"),
              onPressed: () async {
                final nuevoNombre = controller.text.trim();
                if (nuevoNombre.isNotEmpty) {
                  try {
                    /*final ok = await _viewModel.editarNombreArchivo(archivo.id, nuevoNombre);
                    if (ok) {
                      await _cargarArchivos();
                    }*/
                  } catch (e) {
                    debugPrint("Error al editar nombre: $e");
                  }
                }
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Column(
        children: [
          // Tabla con los archivos
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text("Nombre")),
                DataColumn(label: Text("curp")),
                DataColumn(label: Text("rfc")),
                DataColumn(label: Text("Fecha de inicio")),
                DataColumn(label: Text("Acciones")),
              ],
              rows: _archivos.map((archivo) {
                return DataRow(
                  cells: [
                    DataCell(Text(archivo.nombre)),
                    DataCell(Text(archivo.curp)),
                    DataCell(Text(archivo.rfc)),
                    DataCell(Text(archivo.fechaInicio.toString())),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _editarNombre(archivo),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _eliminarArchivo(archivo),
                          ),

                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
