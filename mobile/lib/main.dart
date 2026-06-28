import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/constants/app_constants.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';
import 'features/sales/presentation/pages/sales_page.dart';
import 'features/inventory/presentation/pages/inventory_page.dart';
import 'features/reports/presentation/pages/reports_page.dart';
import 'features/settings/presentation/pages/settings_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/customers/presentation/pages/customers_page.dart';
import 'features/pos/presentation/pages/pos_page.dart';
import 'shared/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const Gold4App());
}

class Gold4App extends StatelessWidget {
  const Gold4App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ar', 'SY'), Locale('en', 'US')],
      locale: const Locale('ar', 'SY'),
      builder: (ctx, child) =>
          Directionality(textDirection: TextDirection.rtl, child: child!),
      initialRoute: '/login',
      routes: {
        '/': (context) => const AppShell(),
        '/login': (context) => const LoginPage(),
        '/customers': (context) => const CustomersPage(),
        '/pos': (context) => const POSPage(),
      },
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _idx = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const _pages = [
    DashboardPage(), SalesPage(), InventoryPage(), ReportsPage(), SettingsPage(), POSPage(), CustomersPage(),
  ];
  static const _titles = ['لوحة التحكم', 'المبيعات', 'المخزون', 'التقارير', 'الإعدادات', 'نقطة البيع', 'العملاء'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titles[_idx]),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      drawer: _AppDrawer(onNav: (i) { setState(() => _idx = i); Navigator.pop(context); }),
      body: IndexedStack(index: _idx, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _idx > 4 ? 0 : _idx,
        onTap: (i) => setState(() => _idx = i),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined),    activeIcon: Icon(Icons.dashboard),    label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined),  activeIcon: Icon(Icons.receipt_long), label: 'المبيعات'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined),   activeIcon: Icon(Icons.inventory_2),  label: 'المخزون'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined),     activeIcon: Icon(Icons.bar_chart),    label: 'التقارير'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined),      activeIcon: Icon(Icons.settings),     label: 'الإعدادات'),
        ],
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  final void Function(int) onNav;
  const _AppDrawer({required this.onNav});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFB300), Color(0xFFFFA000)],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: 64, height: 64,
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
              child: const Icon(Icons.diamond, color: Colors.white, size: 36),
            ),
            const SizedBox(height: 10),
            Text(AppConstants.appName,
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const Text('نظام المحاسبة الذهبي', style: TextStyle(color: Colors.white70, fontSize: 12)),
          ]),
        ),
        _tile(context, Icons.dashboard_outlined,          'الرئيسية',           () => onNav(0)),
        _tile(context, Icons.receipt_long_outlined,        'المبيعات',           () => onNav(1)),
        _tile(context, Icons.inventory_2_outlined,         'المخزون',            () => onNav(2)),
        _tile(context, Icons.bar_chart_outlined,           'التقارير',           () => onNav(3)),
        _tile(context, Icons.people_outline,               'العملاء',            () => onNav(6)),
        _tile(context, Icons.point_of_sale_outlined,       'نقطة البيع (POS)',  () => onNav(5)),
        const Divider(),
        _tile(context, Icons.settings_outlined,            'الإعدادات',         () => onNav(4)),
        _tile(context, Icons.logout,                       'تسجيل الخروج',      () => Navigator.pushReplacementNamed(context, '/login'), danger: true),
      ]),
    );
  }

  Widget _tile(BuildContext ctx, IconData icon, String label, VoidCallback onTap, {bool danger = false}) =>
      ListTile(
        leading: Icon(icon, color: danger ? Colors.red : const Color(0xFF795548), size: 22),
        title: Text(label, style: TextStyle(color: danger ? Colors.red : null, fontSize: 14)),
        onTap: onTap,
      );
}
