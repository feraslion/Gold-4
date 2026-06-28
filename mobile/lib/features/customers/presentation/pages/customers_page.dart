import 'package:flutter/material.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('العملاء'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) => Card(
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text('عميل رقم ${index + 1}'),
            subtitle: const Text('رصيد: 1,500,000 ل.س'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFFFB300),
        child: const Icon(Icons.add),
      ),
    );
  }
}
