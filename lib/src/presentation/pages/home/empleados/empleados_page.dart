import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timbox/src/presentation/pages/home/empleados/widget/empleado_content.dart';
import 'package:timbox/src/presentation/pages/home/empleados/widget/empleado_editar.dart';
import '../../../../domain/models/colaborador_data.dart';
import '../layouts/layout.dart';
import 'empleados_viewmodel.dart';

class EmpleadosPage extends StatefulWidget {
  const EmpleadosPage({Key? key}) : super(key: key);

  @override
  State<EmpleadosPage> createState() => _EmpleadosPageState();
}

class _EmpleadosPageState extends State<EmpleadosPage> {
  late EmpleadosViewmodel _viewModel;

  /// Lista completa de colaboradores cargados.
  List<ColaboradorData> _colaboradores = [];

  /// Controlador de texto para buscar por nombre, RFC, CURP.
  final TextEditingController _searchController = TextEditingController();

  /// Fecha seleccionada para filtrar por fecha de inicio (null => sin filtro).
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<EmpleadosViewmodel>(context, listen: false);
    _cargarColaboradores();
  }

  /// Llama al ViewModel para cargar la lista de colaboradores.
  Future<void> _cargarColaboradores() async {
    try {
      final lista = await _viewModel.obtenerArchivos();
      setState(() {
        _colaboradores = lista;
      });
    } catch (e) {
      debugPrint("Error al cargar colaboradores: $e");
    }
  }

  /// Aplica los filtros locales: texto (nombre, rfc, curp) y fecha.
  List<ColaboradorData> _aplicarFiltros() {
    final query = _searchController.text.trim().toLowerCase();
    final dateFilter = _selectedDate;

    return _colaboradores.where((col) {
      // Coincidencia con texto
      final matchQuery = col.nombre.toLowerCase().contains(query) ||
          col.rfc.toLowerCase().contains(query) ||
          col.curp.toLowerCase().contains(query);

      // Coincidencia con fecha (día/mes/año)
      bool matchDate = true;
      if (dateFilter != null) {
        final fechaCol = col.fechaInicio;
        matchDate = (fechaCol.year == dateFilter.year &&
            fechaCol.month == dateFilter.month &&
            fechaCol.day == dateFilter.day);
      }

      return matchQuery && matchDate;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Buscador
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: "Buscar (Nombre, RFC, CURP)",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),

              // Filtro por Fecha
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          setState(() {
                            _selectedDate = picked;
                          });
                        }
                      },
                      child: const Text("Filtrar Fecha"),
                    ),
                    if (_selectedDate != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _selectedDate = null;
                            });
                          },
                        ),
                      ),
                  ],
                ),
              ),

              // Tabla con scroll horizontal
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text("Nombre")),
                    DataColumn(label: Text("CURP")),
                    DataColumn(label: Text("RFC")),
                    DataColumn(label: Text("Fecha de inicio")),
                    DataColumn(label: Text("Acciones")),
                  ],
                  rows: _aplicarFiltros().map((col) {
                    return DataRow(
                      cells: [
                        DataCell(Text(col.nombre)),
                        DataCell(Text(col.curp)),
                        DataCell(Text(col.rfc)),
                        DataCell(Text(col.fechaInicio.toString())),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  // Navegar a la página de edición
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EmpleadoContent(
                                          _viewModel, col
                                      ),
                                    ),
                                  );
                                }
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _viewModel.deleteColaborador(col.id, context);
                                }
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
        ),
      ),
    );
  }
}
