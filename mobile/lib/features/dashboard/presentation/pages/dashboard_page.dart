import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/currency_converter.dart';
import '../../../../shared/widgets/stat_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _currency = AppConstants.sypCode;

  static const Map<String, double> _stats = {
    'مبيعات اليوم':  4_500_000,
    'مصاريف اليوم':    850_000,
    'صافي الربح':    3_650_000,
    'قيمة المخزون': 92_000_000,
  };

  static const List<Map<String, dynamic>> _recentTx = [
    {'name': 'فاتورة بيع #1047', 'type': 'income',  'amount': 750_000.0, 'date': 'منذ 10 دقائق'},
    {'name': 'شراء بضاعة',       'type': 'expense', 'amount': 320_000.0, 'date': 'منذ 45 دقيقة'},
    {'name': 'فاتورة بيع #1046', 'type': 'income',  'amount': 1_200_000.0,'date': 'منذ ساعة'},
    {'name': 'دفع إيجار',        'type': 'expense', 'amount': 500_000.0, 'date': 'منذ 2 ساعة'},
  ];

  String _fmt(double syp) => _currency == AppConstants.sypCode
      ? CurrencyConverter.formatSYP(syp)
      : CurrencyConverter.formatUSD(CurrencyConverter.toUSD(syp));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => setState(() {}),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildStatsGrid(),
            const SizedBox(height: 20),
            _buildExchangeCard(),
            const SizedBox(height: 20),
            _buildChart(),
            const SizedBox(height: 20),
            _buildQuickActions(),
            const SizedBox(height: 20),
            _buildRecentTx(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('لوحة التحكم', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        Text('${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
            style: TextStyle(color: Colors.grey[600], fontSize: 13)),
      ]),
      ToggleButtons(
        isSelected: [_currency == AppConstants.sypCode, _currency == AppConstants.usdCode],
        onPressed: (i) => setState(() => _currency = i == 0 ? AppConstants.sypCode : AppConstants.usdCode),
        borderRadius: BorderRadius.circular(8),
        selectedColor: Colors.white,
        fillColor: const Color(0xFFFFB300),
        children: const [Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('ل.س')),
                         Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('\$'))],
      ),
    ],
  );

  Widget _buildStatsGrid() => GridView.count(
    crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
    crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.4,
    children: [
      StatCard(title: 'مبيعات اليوم',  value: _fmt(_stats['مبيعات اليوم']!),  icon: Icons.trending_up,   color: Colors.green),
      StatCard(title: 'مصاريف اليوم', value: _fmt(_stats['مصاريف اليوم']!), icon: Icons.trending_down,  color: Colors.red),
      StatCard(title: 'صافي الربح',   value: _fmt(_stats['صافي الربح']!),   icon: Icons.account_balance, color: Colors.blue),
      StatCard(title: 'قيمة المخزون', value: _fmt(_stats['قيمة المخزون']!), icon: Icons.inventory_2,    color: Colors.purple),
    ],
  );

  Widget _buildExchangeCard() => Card(
    color: Colors.blue[50],
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(children: [
        const Icon(Icons.currency_exchange, color: Colors.blue, size: 32),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('سعر صرف الدولار', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('1 \$ = ${AppConstants.exchangeRate.toStringAsFixed(0)} ل.س',
              style: const TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold)),
        ])),
        TextButton(onPressed: () {}, child: const Text('تحديث')),
      ]),
    ),
  );

  Widget _buildChart() => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('مبيعات الأسبوع', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: BarChart(BarChartData(
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles:  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, _) => Text(['أح','إث','ثل','أر','خم','جم','سب'][v.toInt()],
                    style: const TextStyle(fontSize: 11)),
              )),
            ),
            barGroups: [
              for (int i = 0; i < 7; i++)
                BarChartGroupData(x: i, barRods: [
                  BarChartRodData(
                    toY: [3.2, 4.5, 2.8, 5.1, 4.0, 6.2, 4.5][i],
                    color: const Color(0xFFFFB300),
                    width: 22,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ]),
            ],
          )),
        ),
      ]),
    ),
  );

  Widget _buildQuickActions() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('إجراءات سريعة', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      Row(children: [
        _QuickBtn(Icons.add_shopping_cart, 'فاتورة بيع', Colors.green),
        const SizedBox(width: 10),
        _QuickBtn(Icons.receipt_long,      'فاتورة شراء', Colors.orange),
        const SizedBox(width: 10),
        _QuickBtn(Icons.person_add,        'عميل جديد', Colors.blue),
        const SizedBox(width: 10),
        _QuickBtn(Icons.print,             'طباعة', Colors.purple),
      ]),
    ],
  );

  Widget _QuickBtn(IconData icon, String label, Color color) => Expanded(
    child: GestureDetector(
      onTap: () {},
      child: Column(children: [
        CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11), textAlign: TextAlign.center),
      ]),
    ),
  );

  Widget _buildRecentTx() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('آخر المعاملات', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        TextButton(onPressed: () {}, child: const Text('عرض الكل')),
      ]),
      ..._recentTx.map((tx) => ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor: (tx['type'] == 'income' ? Colors.green : Colors.red).withValues(alpha: 0.15),
          child: Icon(
            tx['type'] == 'income' ? Icons.arrow_downward : Icons.arrow_upward,
            color: tx['type'] == 'income' ? Colors.green : Colors.red,
            size: 20,
          ),
        ),
        title: Text(tx['name'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        subtitle: Text(tx['date'], style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        trailing: Text(
          _fmt(tx['amount']),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: tx['type'] == 'income' ? Colors.green : Colors.red,
          ),
        ),
      )),
    ],
  );
}
