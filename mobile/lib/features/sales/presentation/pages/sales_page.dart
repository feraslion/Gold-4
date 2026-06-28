import 'package:flutter/material.dart';
import '../../../../core/utils/currency_converter.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});
  @override State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  final List<Map<String, dynamic>> _invoices = [
    {'id': 1047, 'customer': 'محمد العلي',     'total': 750_000.0,   'date': '2024-01-15', 'status': 'paid'},
    {'id': 1046, 'customer': 'شركة النور',     'total': 1_200_000.0, 'date': '2024-01-15', 'status': 'paid'},
    {'id': 1045, 'customer': 'أحمد خليل',      'total': 450_000.0,   'date': '2024-01-14', 'status': 'pending'},
    {'id': 1044, 'customer': 'مؤسسة الأمل',    'total': 2_100_000.0, 'date': '2024-01-14', 'status': 'paid'},
    {'id': 1043, 'customer': 'خالد المحمود',   'total': 380_000.0,   'date': '2024-01-13', 'status': 'cancelled'},
  ];

  String _filter = 'all';

  List<Map<String, dynamic>> get _filtered => _filter == 'all'
      ? _invoices
      : _invoices.where((i) => i['status'] == _filter).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        _buildSummary(),
        _buildFilters(),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _filtered.length,
            itemBuilder: (_, i) => _buildInvoiceCard(_filtered[i]),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showNewInvoiceDialog,
        icon: const Icon(Icons.add),
        label: const Text('فاتورة جديدة'),
      ),
    );
  }

  Widget _buildSummary() => Container(
    color: const Color(0xFFFFB300),
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
    child: Row(children: [
      _SumItem('الإجمالي',   CurrencyConverter.formatSYP(_invoices.fold(0, (s, i) => s + (i['total'] as double)))),
      const SizedBox(width: 16),
      _SumItem('مدفوعة',    _invoices.where((i) => i['status'] == 'paid').length.toString()),
      const SizedBox(width: 16),
      _SumItem('معلقة',     _invoices.where((i) => i['status'] == 'pending').length.toString()),
    ]),
  );

  Widget _SumItem(String label, String value) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
    ],
  );

  Widget _buildFilters() => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.all(12),
    child: Row(children: [
      for (final f in [('all', 'الكل'), ('paid', 'مدفوعة'), ('pending', 'معلقة'), ('cancelled', 'ملغية')])
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: FilterChip(
            label: Text(f.$2),
            selected: _filter == f.$1,
            onSelected: (_) => setState(() => _filter = f.$1),
          ),
        ),
    ]),
  );

  Widget _buildInvoiceCard(Map<String, dynamic> inv) {
    final statusColors = {'paid': Colors.green, 'pending': Colors.orange, 'cancelled': Colors.red};
    final statusLabels = {'paid': 'مدفوعة', 'pending': 'معلقة', 'cancelled': 'ملغية'};
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFFFB300).withOpacity(.15),
          child: Text('#${inv['id']}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFFFFB300))),
        ),
        title: Text(inv['customer'], style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(inv['date'], style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        trailing: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(CurrencyConverter.formatSYP(inv['total']),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: statusColors[inv['status']]!.withOpacity(.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(statusLabels[inv['status']]!, style: TextStyle(color: statusColors[inv['status']], fontSize: 11)),
          ),
        ]),
        onTap: () => _showInvoiceDetail(inv),
      ),
    );
  }

  void _showNewInvoiceDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: .9, maxChildSize: .95, minChildSize: .5, expand: false,
        builder: (_, ctrl) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('فاتورة بيع جديدة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'العميل', prefixIcon: Icon(Icons.person))),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: 'البضاعة / الخدمة', prefixIcon: Icon(Icons.inventory))),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: 'المبلغ (ل.س)', prefixIcon: Icon(Icons.attach_money)), keyboardType: TextInputType.number),
            const SizedBox(height: 24),
            ElevatedButton.icon(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.save), label: const Text('حفظ الفاتورة')),
          ]),
        ),
      ),
    );
  }

  void _showInvoiceDetail(Map<String, dynamic> inv) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('فاتورة #${inv['id']}'),
        content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          _row('العميل', inv['customer']),
          _row('التاريخ', inv['date']),
          _row('المبلغ', CurrencyConverter.formatSYP(inv['total'])),
          _row('بالدولار', CurrencyConverter.formatUSD(CurrencyConverter.toUSD(inv['total']))),
        ]),
        actions: [
          TextButton.icon(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.print), label: const Text('طباعة')),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إغلاق')),
        ],
      ),
    );
  }

  Widget _row(String k, String v) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [
      Text('$k: ', style: const TextStyle(fontWeight: FontWeight.bold)),
      Text(v),
    ]),
  );
}
