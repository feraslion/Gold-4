import 'package:flutter/material.dart';

class POSPage extends StatelessWidget {
  const POSPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('نقطة البيع (POS)')),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: 12,
              itemBuilder: (context, index) => Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.inventory_2, size: 32, color: Colors.blue),
                    const SizedBox(height: 8),
                    Text('منتج ${index + 1}', style: const TextStyle(fontSize: 12)),
                    const Text('50,000 ل.س', style: TextStyle(fontSize: 10, color: Colors.green)),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('الإجمالي', style: TextStyle(color: Colors.grey)),
                    Text('600,000 ل.س', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: const Text('دفع'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
