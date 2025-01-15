import 'package:flutter/material.dart';
import 'package:get/get.dart'; // si lo usas
import 'package:lucide_icons/lucide_icons.dart';

import '../../utils/base_color.dart';

// --------------------------------------------------
// Controlador principal para el Layout
// --------------------------------------------------
class LayoutController extends GetxController {
  // Elimina scaffoldKey si no es imprescindible
  // final scaffoldKey = GlobalKey<ScaffoldState>();

  bool leftBarCondensed = false;
  void toggleLeftBarCondensed() {
    leftBarCondensed = !leftBarCondensed;
    update();
  }
}

// --------------------------------------------------
// Layout principal con UN solo Scaffold
// --------------------------------------------------
class Layout extends StatelessWidget {
  final Widget? child;
  final LayoutController controller = Get.put(LayoutController());

  Layout({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    // Ejemplo de un breakpoint
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return GetBuilder<LayoutController>(
      builder: (controller) {
        return Scaffold(
          // key: controller.scaffoldKey, // Comenta si no es necesario
          appBar: isMobile
              ? AppBar(
            title: const Text("Mi App"),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  // Si quieres abrir endDrawer:
                  Scaffold.of(context).openEndDrawer();
                  // O si realmente necesitas la key:
                  // controller.scaffoldKey.currentState?.openEndDrawer();
                },
              ),
            ],
          )
              : null,
          drawer: isMobile ? const LeftBar(isCondensed: false) : null,
          endDrawer: const RightBar(),
          body: Row(
            children: [
              if (!isMobile)
                LeftBar(isCondensed: controller.leftBarCondensed),
              Expanded(
                child: Stack(
                  children: [
                    // Contenido con scroll
                    Positioned.fill(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(top: isMobile ? 0 : 60.0),
                          child: child,
                        ),
                      ),
                    ),
                    // TopBar fijo para escritorio
                    if (!isMobile)
                      const Positioned(
                        top: 0, left: 0, right: 0,
                        height: 60,
                        child: TopBar(),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// --------------------------------------------------
// LeftBar (barra de navegación lateral izquierda)
// --------------------------------------------------
class LeftBar extends StatelessWidget {
  final bool isCondensed;
  const LeftBar({super.key, this.isCondensed = false});

  @override
  Widget build(BuildContext context) {
    final width = isCondensed ? 70.0 : 260.0;

    return Container(
      width: width,
      color: Colors.grey.shade200,
      child: Column(
        children: [
          SizedBox(
            height: 70,
            child: Center(
              child: isCondensed
                  ? const Icon(Icons.ac_unit)
                  : const Text("Timbox", style: TextStyle(fontSize: 32, color: BASE_COLOR)),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  NavigationItem(
                    iconData: LucideIcons.home,
                    title: "Home",
                    route: "cargaArchivos",
                    isCondensed: isCondensed,
                  ),
                  NavigationItem(
                    iconData: LucideIcons.baggageClaim,
                    title: "Colaborador",
                    route: "colaborador",
                    isCondensed: isCondensed,
                  ),
                  // Más items
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// RightBar
// --------------------------------------------------
class RightBar extends StatelessWidget {
  const RightBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: Colors.grey.shade50,
      child: Column(
        children: [
          Container(
            height: 60,
            color: Colors.grey.shade300,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Expanded(child: Text("Settings")),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close, size: 18, color: BASE_COLOR),
                )
              ],
            ),
          ),
          const Expanded(
            child: Center(
              child: Text("Más ajustes"),
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// TopBar (para escritorio)
// --------------------------------------------------
class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final LayoutController controller = Get.find<LayoutController>();
    return Container(
      color: Colors.grey.shade200,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: BASE_COLOR),
            onPressed: controller.toggleLeftBarCondensed,
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.settings, color: BASE_COLOR,),
            onPressed: () {
              // Si no usas scaffoldKey, abre endDrawer con:
              Scaffold.of(context).openEndDrawer();
              // O, si tuvieras un globalKey:
              // controller.scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// NavigationItem
// --------------------------------------------------
class NavigationItem extends StatefulWidget {
  final IconData iconData;
  final String title;
  final bool isCondensed;
  final String route;

  const NavigationItem({
    super.key,
    required this.iconData,
    required this.title,
    required this.route,
    this.isCondensed = false,
  });

  @override
  State<NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    bool isActive = false; // Ajusta según tu lógica de ruta actual

    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(widget.route),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (isActive || isHover)
                ? BASE_COLOR.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Icon(
                widget.iconData,
                color: (isActive || isHover) ? Colors.blue : Colors.black,
              ),
              if (!widget.isCondensed) const SizedBox(width: 8),
              if (!widget.isCondensed)
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: (isActive || isHover) ? Colors.blue : Colors.black,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
