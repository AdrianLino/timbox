import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

// --------------------------------------------------
// Controlador principal para el Layout
// --------------------------------------------------
class LayoutController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollKey = GlobalKey();

  // Maneja si la barra izquierda está condensada o no
  bool leftBarCondensed = false;
  void toggleLeftBarCondensed() {
    leftBarCondensed = !leftBarCondensed;
    update();
  }
}

// --------------------------------------------------
// Responsive Helper (equivalente a tu MyResponsive)
// --------------------------------------------------
typedef ResponsiveBuilder = Widget Function(
    BuildContext context,
    BoxConstraints constraints,
    _ScreenSizeInfo info,
    );

class MyResponsive extends StatelessWidget {
  final ResponsiveBuilder builder;

  const MyResponsive({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      // Aquí puedes establecer tus "breakpoints"
      bool isMobile = width < 600;
      return builder(
        context,
        constraints,
        _ScreenSizeInfo(isMobile: isMobile),
      );
    });
  }
}

class _ScreenSizeInfo {
  final bool isMobile;
  _ScreenSizeInfo({required this.isMobile});
}

// --------------------------------------------------
// Layout principal que envuelve tu contenido
// --------------------------------------------------
class Layout extends StatelessWidget {
  final Widget? child;
  final LayoutController controller = Get.put(LayoutController());

  Layout({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return MyResponsive(
      builder: (BuildContext context, _, screenMT) {
        return GetBuilder<LayoutController>(
          builder: (controller) {
            // Si es móvil, construye la versión mobile; si no, la grande
            return screenMT.isMobile ? _mobileScreen(context) : _largeScreen();
          },
        );
      },
    );
  }

  // ---------------------
  // Versión para pantallas móviles
  // ---------------------
  Widget _mobileScreen(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        title: const Text("Mi App"),
        elevation: 0,
        actions: [
          // Botón para abrir el RightBar desde mobile
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              controller.scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      // Drawer izquierdo en mobile
      drawer: LeftBar(isCondensed: false),
      // Drawer derecho en mobile
      endDrawer: const RightBar(),
      body: SingleChildScrollView(
        key: controller.scrollKey,
        child: child,
      ),
    );
  }

  // ---------------------
  // Versión para pantallas grandes
  // ---------------------
  Widget _largeScreen() {
    return Scaffold(
      key: controller.scaffoldKey,
      endDrawer: const RightBar(),
      body: Row(
        children: [
          // Barra izquierda con posible modo condensado
          LeftBar(isCondensed: controller.leftBarCondensed),

          // Contenido principal
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    key: controller.scrollKey,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: child,
                    ),
                  ),
                ),
                // TopBar fijo arriba
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
  }
}

// --------------------------------------------------
// LeftBar (barra de navegación lateral izquierda)
// --------------------------------------------------
class LeftBar extends StatefulWidget {
  final bool isCondensed;
  const LeftBar({super.key, this.isCondensed = false});

  @override
  State<LeftBar> createState() => _LeftBarState();
}

class _LeftBarState extends State<LeftBar> {
  String path = "/"; // Aquí podrías usar tu lógica de rutas
  // Observers para el menú (si los necesitas)
  static Map<String, Function(String)> observers = {};
  static attachListener(String key, Function(String) fn) => observers[key] = fn;
  static detachListener(String key) => observers.remove(key);
  static notifyAll(String key) {
    for (var fn in observers.values) {
      fn(key);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: widget.isCondensed ? 70 : 260,
      color: colorScheme.surface,
      child: Column(
        children: [
          // Logo o título
          SizedBox(
            height: 70,
            child: Center(
              child: widget.isCondensed
                  ? const Icon(Icons.home)
                  : const Text(
                "Mi App",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ejemplo de etiqueta
                  if (!widget.isCondensed)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        "Menú".toUpperCase(),
                        style: TextStyle(
                          color: colorScheme.onSurface.withOpacity(0.6),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  // Items de navegación
                  NavigationItem(
                    iconData: LucideIcons.home,
                    title: "Home",
                    route: "/home",
                    isCondensed: widget.isCondensed,
                  ),
                  NavigationItem(
                    iconData: LucideIcons.bookOpen,
                    title: "Courses",
                    route: "/courses",
                    isCondensed: widget.isCondensed,
                  ),
                  NavigationItem(
                    iconData: LucideIcons.baggageClaim,
                    title: "Cart",
                    route: "/cart",
                    isCondensed: widget.isCondensed,
                  ),
                  // Ejemplo de submenú
                  MenuWidget(
                    iconData: LucideIcons.graduationCap,
                    title: "Students",
                    isCondensed: widget.isCondensed,
                    children: const [
                      MenuItem(title: "List", route: "/admin/students/list"),
                      MenuItem(title: "Detail", route: "/admin/students/detail"),
                      MenuItem(title: "Add", route: "/admin/students/add"),
                      MenuItem(title: "Edit", route: "/admin/students/edit"),
                    ],
                  ),
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
// RightBar (barra lateral de ajustes, etc.)
// --------------------------------------------------
class RightBar extends StatefulWidget {
  const RightBar({super.key});

  @override
  State<RightBar> createState() => _RightBarState();
}

class _RightBarState extends State<RightBar> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 280,
      color: colorScheme.surface,
      child: Column(
        children: [
          Container(
            height: 60,
            color: colorScheme.primaryContainer,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Settings",
                    style: TextStyle(color: colorScheme.onPrimaryContainer),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: colorScheme.onPrimaryContainer,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: const Text(
                "Aquí podrías poner más ajustes o secciones de configuración.",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// TopBar (barra superior)
// --------------------------------------------------
class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final LayoutController controller = Get.find<LayoutController>();
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.surface,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: controller.toggleLeftBarCondensed,
          ),
          const Spacer(),
          // Botón para abrir endDrawer (right bar) en escritorio
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              controller.scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// Widgets de Menú y Navegación
// --------------------------------------------------

// Ítem de navegación simple (sin hijos)
class NavigationItem extends StatefulWidget {
  final IconData? iconData;
  final String title;
  final String? route;
  final bool isCondensed;

  const NavigationItem({
    super.key,
    this.iconData,
    required this.title,
    this.route,
    this.isCondensed = false,
  });

  @override
  State<NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    // Lógica simple: verifica si la ruta actual coincide
    // (ajusta a tu manera)
    bool isActive = false;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: GestureDetector(
        onTap: () {
          if (widget.route != null) {
            // Navegación con Get
            Get.toNamed(widget.route!);
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (isActive || isHover)
                ? Colors.grey.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              if (widget.iconData != null)
                Icon(
                  widget.iconData,
                  color: (isActive || isHover) ? Colors.blue : Colors.black87,
                  size: 20,
                ),
              if (!widget.isCondensed) const SizedBox(width: 8),
              if (!widget.isCondensed)
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: (isActive || isHover)
                          ? Colors.blue
                          : Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Menú que contiene subitems
class MenuWidget extends StatefulWidget {
  final IconData iconData;
  final String title;
  final List<MenuItem> children;
  final bool isCondensed;

  const MenuWidget({
    super.key,
    required this.iconData,
    required this.title,
    this.children = const [],
    this.isCondensed = false,
  });

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget>
    with SingleTickerProviderStateMixin {
  bool isHover = false;
  bool isOpen = false;
  late AnimationController _controller;
  late Animation<double> _iconTurns;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _iconTurns = _controller.drive(
      Tween(begin: 0.0, end: 0.5).chain(CurveTween(curve: Curves.easeIn)),
    );
  }

  void _toggle() {
    setState(() => isOpen = !isOpen);
    if (isOpen) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Si está condensado, podrías convertirlo en popup (si gustas),
    // de momento lo dejamos simple:
    if (widget.isCondensed) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isHover ? Colors.grey.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(
            widget.iconData,
            color: isHover ? Colors.blue : Colors.black87,
            size: 20,
          ),
        ),
      );
    } else {
      return Column(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            onHover: (_) => setState(() => isHover = true),
            onExit: (_) => setState(() => isHover = false),
            child: GestureDetector(
              onTap: _toggle,
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isHover ? Colors.grey.withOpacity(0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Icon(
                      widget.iconData,
                      color: isHover || isOpen ? Colors.blue : Colors.black87,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          color: isHover || isOpen ? Colors.blue : Colors.black87,
                        ),
                      ),
                    ),
                    RotationTransition(
                      turns: _iconTurns,
                      child: Icon(
                        LucideIcons.chevronDown,
                        size: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Sub-items (colapsables)
          if (isOpen)
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Column(children: widget.children),
            ),
        ],
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Subitem dentro de un menú
class MenuItem extends StatefulWidget {
  final String title;
  final String? route;
  const MenuItem({
    super.key,
    required this.title,
    this.route,
  });

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    bool isActive = false; // Ajusta según tu lógica de rutas
    return GestureDetector(
      onTap: () {
        if (widget.route != null) {
          Get.toNamed(widget.route!);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isActive || isHover ? Colors.grey.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            "- ${widget.title}",
            style: TextStyle(
              color: isHover || isActive ? Colors.blue : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
