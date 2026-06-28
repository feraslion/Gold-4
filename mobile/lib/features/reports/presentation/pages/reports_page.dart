import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/utils/currency_converter.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});
  @override State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> with SingleTickerProviderStateMixin {
  late TabController _tabs;
  @override void initState() { super.initState(); _tabs = TabController(length: 3, vsync: this); }
  @override void dispose() { _tabs.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TabBar(
          controller: _tabs,
          labelColor: const Color(0xFFFFB300),
          indicatorColor: const Color(0xFFFFB300),
          tabs: const [Tab(text: 'مالي'), Tab(text: 'مخزون'), Tab(text: 'عملاء')],
        ),
        Expanded(child: TabBarView(controller: _tabs, children: [
          _FinancialReport(),
          _InventoryReport(),
          _CustomersReport(),
        ])),
      ]),
    );
  }
}

class _FinancialReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final months = ['يناير','فبراير','مارس','أبريل','مايو','يونيو'];
    final sales   = [12.0, 18.0, 15.0, 22.0, 19.0, 27.0];
    final expenses = [5.0,  8.0,  7.0,  9.0,  8.0, 11.0];

    return ListView(padding: const EdgeInsets.all(16), children: [
      _ReportCard('ملخص الشهر الحالي', [
        _Row('إجمالي المبيعات',  CurrencyConverter.formatSYP(27_000_000), Colors.green),
        _Row('إجمالي المصاريف', CurrencyConverter.formatSYP(11_000_000), Colors.red),
        _Row('صافي الربح',       CurrencyConverter.formatSYP(16_000_000), Colors.blue),
        _Row('هامش الربح',       '59%', Colors.purple),
      ]),
      const SizedBox(height: 16),
      Card(child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('المبيعات مقابل المصاريف', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: LineChart(LineChartData(
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: true, drawVerticalLine: false),
              titlesData: FlTitlesData(
                leftTitles:  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:   const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (v, _) => Text(months[v.toInt() % 6], style: const TextStyle(fontSize: 10)),
                )),
              ),
              lineBarsData: [
                LineChartBarData(spots: [for (int i=0;i<6;i++) FlSpot(i.toDouble(), sales[i])],
                  isCurved: true, color: Colors.green, barWidth: 2.5,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(show: true, color: Colors.green.withOpacity(.08))),
                LineChartBarData(spots: [for (int i=0;i<6;i++) FlSpot(i.toDouble(), expenses[i])],
                  isCurved: true, color: Colors.red, barWidth: 2.5,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(show: true, color: Colors.red.withOpacity(.08))),
              ],
            )),
          ),
          const SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _Legend(Colors.green, 'المبيعات'),
            const SizedBox(width: 16),
            _Legend(Colors.red, 'المصاريف'),
          ]),
        ]),
      )),
    ]);
  }
}

class _InventoryReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = ['ذهب', 'فضة', 'مجوهرات', 'أحجار كريمة'];
    final values     = [45.0, 20.0, 25.0, 10.0];
    final colors     = [const Color(0xFFFFB300), Colors.grey, Colors.purple, Colors.blue];
    return ListView(padding: const EdgeInsets.all(16), children: [
      Card(child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('توزيع المخزون', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: PieChart(PieChartData(
              sections: [for (int i=0;i<4;i++)
                PieChartSectionData(value: values[i], color: colors[i], title: '${values[i].toInt()}%',
                  titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white))],
              sectionsSpace: 2, centerSpaceRadius: 40,
            )),
          ),
          const SizedBox(height: 16),
          Wrap(spacing: 16, runSpacing: 8, children: [
            for (int i=0;i<4;i++) _Legend(colors[i], categories[i]),
          ]),
        ]),
      )),
    ]);
  }
}

class _CustomersReport extends StatelessWidget {
  final List<Map<String, dynamic>> _top = const [
    {'name': 'شركة النور للذهب',    'total': 15_000_000.0, 'invoices': 12},
    {'name': 'محمد العلي',           'total': 8_500_000.0,  'invoices': 7},
    {'name': 'مؤسسة الأمل',         'total': 6_200_000.0,  'invoices': 5},
    {'name': 'أحمد خليل',           'total': 4_800_000.0,  'invoices': 9},
    {'name': 'هدى السعيد',          'total': 3_100_000.0,  'invoices': 4},
  ];

  const _CustomersReport();

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text('أفضل العملاء', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 12),
      ..._top.mapIndexed((i, c) => Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xFFFFB300),
            child: Text('${i+1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          title: Text(c['name'], style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text('${c['invoices']} فاتورة'),
          trailing: Text(CurrencyConverter.formatSYP(c['total']),
              style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFFB300))),
        ),
      )),
    ]);
  }
}

extension _IE<T> on List<T> {
  Iterable<R> mapIndexed<R>(R Function(int, T) f) => asMap().entries.map((e) => f(e.key, e.value));
}

Widget _ReportCard(String title, List<Widget> rows) => Card(
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const Divider(height: 20),
      ...rows,
    ]),
  ),
);

Widget _Row(String label, String value, Color color) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 6),
  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(label, style: const TextStyle(fontSize: 14)),
    Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 14)),
  ]),
);

Widget _Legend(Color color, String label) => Row(mainAxisSize: MainAxisSize.min, children: [
  Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
  const SizedBox(width: 4),
  Text(label, style: const TextStyle(fontSize: 12)),
]);
