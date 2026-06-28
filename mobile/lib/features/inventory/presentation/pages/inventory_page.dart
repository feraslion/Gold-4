import 'package:flutter/material.dart';
import '../../../../core/utils/currency_converter.dart';
import '../../../../shared/widgets/empty_state.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});
  @override State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final _search = TextEditingController();
  String _query = '';

  final List<Map<String, dynamic>> _products = [
    {'id': 1, 'name': 'ذهب 21 قيراط - غرام',   'barcode': '123456', 'priceSYP': 85_000.0,  'stock': 150, 'category': 'ذهب'},
    {'id': 2, 'name': 'خاتم ذهب نسائي',           'barcode': '123457', 'priceSYP': 500_000.0, 'stock': 25,  'category': 'مجوهرات'},
    {'id': 3, 'name': 'سلسلة فضة 925',            'barcode': '123458', 'priceSYP': 120_000.0, 'stock': 40,  'category': 'فضة'},
    {'id': 4, 'name': 'أسورة ذهب بالياقوت',       'barcode': '123459', 'priceSYP': 1_800_000.0,'stock': 5,  'category': 'مجوهرات'},
    {'id': 5, 'name': 'دبلة زفاف ذهب',            'barcode': '123460', 'priceSYP': 750_000.0, 'stock': 30,  'category': 'ذهب'},
  ];

  List<Map<String, dynamic>> get _filtered => _query.isEmpty
      ? _products
      : _products.where((p) =>
          p['name'].toString().contains(_query) ||
          p['barcode'].toString().contains(_query)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        _buildSearchBar(),
        _buildSummaryRow(),
        Expanded(
          child: _filtered.isEmpty
              ? const EmptyState(icon: Icons.inventory_2, title: 'لا توجد منتجات', message: 'أضف منتجات للمخزون')
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _filtered.length,
                  itemBuilder: (_, i) => _buildProductCard(_filtered[i]),
                ),
        ),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addProduct,
        icon: const Icon(Icons.add),
        label: const Text('منتج جديد'),
      ),
    );
  }

  Widget _buildSearchBar() => Padding(
    padding: const EdgeInsets.all(12),
    child: TextField(
      controller: _search,
      onChanged: (v) => setState(() => _query = v),
      decoration: InputDecoration(
        hintText: 'بحث بالاسم أو الباركود...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _query.isNotEmpty
            ? IconButton(icon: const Icon(Icons.clear), onPressed: () { _search.clear(); setState(() => _query = ''); })
            : null,
      ),
    ),
  );

  Widget _buildSummaryRow() => Container(
    color: Colors.grey[100],
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(children: [
      Text('${_products.length} منتج', style: const TextStyle(fontWeight: FontWeight.bold)),
      const Spacer(),
      Text('إجمالي المخزون: ${CurrencyConverter.formatSYP(_products.fold(0, (s, p) => s + (p['priceSYP'] as double) * (p['stock'] as int)))}',
          style: const TextStyle(fontSize: 12, color: Colors.grey)),
    ]),
  );

  Widget _buildProductCard(Map<String, dynamic> p) {
    final isLow = (p['stock'] as int) < 10;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFFFB300).withOpacity(.15),
          child: const Icon(Icons.diamond, color: Color(0xFFFFB300)),
        ),
        title: Text(p['name'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('باركود: ${p['barcode']}', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          Text(CurrencyConverter.formatSYP(p['priceSYP']),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFFFFB300))),
        ]),
        trailing: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isLow ? Colors.red[50] : Colors.green[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isLow ? Colors.red : Colors.green, width: .5),
            ),
            child: Text('${p['stock']} قطعة',
                style: TextStyle(color: isLow ? Colors.red : Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          if (isLow) const Text('مخزون منخفض', style: TextStyle(fontSize: 10, color: Colors.red)),
        ]),
        onTap: () {},
      ),
    );
  }

  void _addProduct() {
    showModalBottomSheet(
      context: context, isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 24),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('إضافة منتج جديد', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const TextField(decoration: InputDecoration(labelText: 'اسم المنتج', prefixIcon: Icon(Icons.diamond))),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'الباركود', prefixIcon: Icon(Icons.qr_code))),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'السعر (ل.س)', prefixIcon: Icon(Icons.monetization_on)), keyboardType: TextInputType.number),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'الكمية', prefixIcon: Icon(Icons.inventory)), keyboardType: TextInputType.number),
          const SizedBox(height: 24),
          ElevatedButton.icon(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.save), label: const Text('حفظ')),
          const SizedBox(height: 24),
        ]),
      ),
    );
  }
}
