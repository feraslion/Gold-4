import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/constants/app_constants.dart';
import 'core/utils/currency_converter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Gold4App());
}

class Gold4App extends StatelessWidget {
  const Gold4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
        fontFamily: 'Cairo',
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'SY'),
        Locale('en', 'US'),
      ],
      locale: const Locale('ar', 'SY'),
      home: const MainDashboard(),
    );
  }
}

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    DashboardOverview(),
    PlaceholderWidget(title: 'المبيعات'),
    PlaceholderWidget(title: 'المخازن'),
    PlaceholderWidget(title: 'التقارير'),
    PlaceholderWidget(title: 'الإعدادات'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.amber,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'المبيعات'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'المخازن'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'التقارير'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادات'),
        ],
      ),
      drawer: const AppDrawer(),
    );
  }
}

class DashboardOverview extends StatelessWidget {
  const DashboardOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'نظرة عامة',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildStatCard('إجمالي المبيعات', 5000000, Colors.green)),
              const SizedBox(width: 10),
              Expanded(child: _buildStatCard('إجمالي المصاريف', 1200000, Colors.red)),
            ],
          ),
          const SizedBox(height: 20),
          _buildExchangeRateCard(),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, double amount, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text(
              CurrencyConverter.formatSYP(amount),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
            ),
            Text(
              CurrencyConverter.formatUSD(CurrencyConverter.toUSD(amount)),
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExchangeRateCard() {
    return Card(
      color: Colors.blueGrey[50],
      child: ListTile(
        leading: const Icon(Icons.currency_exchange, color: Colors.blue),
        title: const Text('سعر صرف الدولار اليوم'),
        trailing: Text(
          '${AppConstants.currentExchangeRate} SYP',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.amber),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(radius: 30, backgroundColor: Colors.white, child: Icon(Icons.person, size: 40)),
                SizedBox(height: 10),
                Text('مدير النظام', style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
          ),
          ListTile(leading: const Icon(Icons.people), title: const Text('العملاء'), onTap: () {}),
          ListTile(leading: const Icon(Icons.local_shipping), title: const Text('الموردون'), onTap: () {}),
          ListTile(leading: const Icon(Icons.account_balance), title: const Text('الحسابات القيود'), onTap: () {}),
          ListTile(leading: const Icon(Icons.backup), title: const Text('نسخة احتياطية'), onTap: () {}),
          const Divider(),
          ListTile(leading: const Icon(Icons.logout), title: const Text('تسجيل الخروج'), onTap: () {}),
        ],
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String title;
  const PlaceholderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('صفحة $title قيد التطوير', style: const TextStyle(fontSize: 20)));
  }
}
