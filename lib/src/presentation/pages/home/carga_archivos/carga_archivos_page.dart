import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../domain/models/archivos_data.dart';
import 'carga_archivos_viewmodel.dart';
import '../layouts/layout.dart';
import 'package:url_launcher/url_launcher.dart';

class CargaArchivosPage extends StatefulWidget {
  const CargaArchivosPage({Key? key}) : super(key: key);

  @override
  _CargaArchivosPageState createState() => _CargaArchivosPageState();
}

class _CargaArchivosPageState extends State<CargaArchivosPage> {
  late ArchivosViewModel _viewModel;
  List<ArchivosData> _archivos = [];

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<ArchivosViewModel>(context, listen: false);
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

  Future<void> _subirArchivo() async {
    try {
      final controller = TextEditingController();

      // Importante: usar showDialog para mostrar el AlertDialog
      await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Nombre del archivo"),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Ingresa un nombre para el archivo",
              ),
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
                    // Llamas la función del ViewModel
                    await _viewModel.subirArchivo(nuevoNombre);
                    // Recargas la tabla
                    await _cargarArchivos();
                  }
                  // Cierra el diálogo
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      debugPrint("Error al subir archivo: $e");
    }
  }



  Future<void> _eliminarArchivo(ArchivosData archivo) async {
    try {
      /*final ok = await _viewModel.eliminarArchivo(archivo.id);
      if (ok) {
        await _cargarArchivos();
      }*/
    } catch (e) {
      debugPrint("Error al eliminar archivo: $e");
    }
  }

  Future<void> _editarNombre(ArchivosData archivo) async {
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

  void _descargarArchivo(ArchivosData archivo) async{
    final url = archivo.link;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
    // Abre el enlace en el navegador o visor correspondiente
    await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
    debugPrint("No se pudo abrir la URL: $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Column(
        children: [
          // Botón para subir archivo
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text("Subir Archivo"),
              onPressed:() {
                _subirArchivo();
              },
            ),
          ),

          // Tabla con los archivos
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text("Nombre")),
                DataColumn(label: Text("Extensión")),
                DataColumn(label: Text("Fecha de creación")),
                DataColumn(label: Text("Acciones")),
              ],
              rows: _archivos.map((archivo) {
                return DataRow(
                  cells: [
                    DataCell(Text(archivo.nombre)),
                    DataCell(Text(archivo.extension)),
                    DataCell(Text(archivo.fechaCreacion)),
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
                          IconButton(
                            icon: const Icon(Icons.download),
                            onPressed: () => _descargarArchivo(archivo),
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
