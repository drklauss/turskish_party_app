import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Text(
                "Поздравляем, вы приглашены!",
                style: theme.headlineLarge,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                "Поверьте, далеко не все удостоились такой чести",
                style: theme.bodySmall,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shadowColor: Colors.grey,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.asset("assets/images/party.jpg"),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                "На вечеринке вас ожидает:",
                style: theme.headlineLarge,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              shadowColor: Colors.grey,
              child: ListTile(
                leading: const Icon(Icons.group),
                title: Text('Отличная компания', style: theme.titleMedium),
                subtitle: Text(
                  'Forbs даже стыдно писать о них',
                  style: theme.bodySmall,
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.qr_code_scanner_outlined),
                title: const Text('Вход только для VIP'),
                subtitle: Text(
                  'За неправильный QR-код будет штраф',
                  style: theme.bodySmall,
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.sports_esports_outlined),
                title: const Text('Интересные игры'),
                subtitle: Text(
                  'Ну, как интересные...Бывает и поинтереснее',
                  style: theme.bodySmall,
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.dining_outlined),
                title: const Text('Восточная кухня'),
                subtitle: Text(
                  'Разумеется многие придут просто поесть',
                  style: theme.bodySmall,
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.liquor_outlined),
                title: const Text('Алкогольные напитки'),
                subtitle: Text(
                  'Наконец-то дошли до самого важного пункта',
                  style: theme.bodySmall,
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.auto_awesome),
                title: const Text('Возможно еще что-то...'),
                subtitle: Text(
                  'Будем импровизировать на ходу',
                  style: theme.bodySmall,
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.block),
                title: const Text('Хватит скроллить!'),
                subtitle: Text(
                  'Не наглей! И так много всего интересного!',
                  style: theme.bodySmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
