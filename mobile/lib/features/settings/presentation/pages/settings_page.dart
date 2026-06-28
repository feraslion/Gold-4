import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _rateCtrl = TextEditingController(text: AppConstants.exchangeRate.toStringAsFixed(0));
  bool _darkMode = false;
  bool _notifications = true;
  bool _autoBackup = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _Section('العملة وسعر الصرف', [
          _TilePad(ListTile(
            leading: const Icon(Icons.currency_exchange, color: Color(0xFFFFB300)),
            title: const Text('سعر صرف الدولار (ل.س)'),
            subtitle: Text('الحالي: ${AppConstants.exchangeRate.toStringAsFixed(0)} ل.س'),
            trailing: SizedBox(
              width: 120,
              child: TextField(
                controller: _rateCtrl,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(isDense: true, contentPadding: EdgeInsets.all(8)),
                onSubmitted: (v) {
                  final rate = double.tryParse(v);
                  if (rate != null && rate > 0) {
                    setState(() => AppConstants.exchangeRate = rate);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('✅ تم تحديث سعر الصرف'), backgroundColor: Colors.green));
                  }
                },
              ),
            ),
          )),
        ]),
        _Section('التطبيق', [
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text('الوضع الليلي'),
            value: _darkMode,
            onChanged: (v) => setState(() => _darkMode = v),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text('الإشعارات'),
            value: _notifications,
            onChanged: (v) => setState(() => _notifications = v),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.backup),
            title: const Text('النسخ الاحتياطي التلقائي'),
            subtitle: const Text('يومياً عند منتصف الليل'),
            value: _autoBackup,
            onChanged: (v) => setState(() => _autoBackup = v),
          ),
        ]),
        _Section('البيانات', [
          ListTile(
            leading: const Icon(Icons.cloud_upload),
            title: const Text('نسخة احتياطية الآن'),
            trailing: const Icon(Icons.chevron_left),
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم حفظ النسخة الاحتياطية ✅'))),
          ),
          ListTile(
            leading: const Icon(Icons.cloud_download),
            title: const Text('استعادة البيانات'),
            trailing: const Icon(Icons.chevron_left),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text('مسح جميع البيانات', style: TextStyle(color: Colors.red)),
            trailing: const Icon(Icons.chevron_left, color: Colors.red),
            onTap: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('تحذير'),
                content: const Text('هل تريد مسح جميع البيانات؟ لا يمكن التراجع.'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('مسح'),
                  ),
                ],
              ),
            ),
          ),
        ]),
        _Section('حول التطبيق', [
          ListTile(leading: const Icon(Icons.info), title: const Text('الإصدار'), trailing: Text(AppConstants.appVersion)),
          ListTile(leading: const Icon(Icons.person), title: const Text('المطور'), trailing: const Text('feraslion')),
        ]),
      ],
    );
  }

  Widget _Section(String title, List<Widget> children) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
        child: Text(title, style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold, fontSize: 13))),
      Card(child: Column(children: children)),
      const SizedBox(height: 4),
    ],
  );

  Widget _TilePad(Widget w) => w;
}
