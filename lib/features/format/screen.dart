import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FormatScreen extends StatelessWidget {
  const FormatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ListView(children: [
            Center(
              child: Text(
                "Формат мероприятия",
                style: theme.headlineLarge,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                "У нас серьезная контора, не эти ваши мошенники из Сбербанка",
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
            const SizedBox(height: 16),
            Center(
              child: Text(
                "Мы рассчитываем, что:",
                style: theme.headlineLarge,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              shadowColor: Colors.grey,
              child: ListTile(
                leading: Image.asset(
                  "assets/icons/hookah.png",
                  width: 32,
                  height: 32,
                  color: Colors.grey,
                ),
                title: Text('Будет кальян', style: theme.titleMedium),
                subtitle: Text(
                  'Турки любят кальяны - они такие красивые',
                  style: theme.bodySmall,
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: SvgPicture.asset(
                  "assets/icons/styler.svg",
                  width: 32,
                  height: 32,
                  colorFilter: const ColorFilter.mode(
                    Colors.grey,
                    BlendMode.difference,
                  ),
                ),
                title: const Text('Шельвар, гемлек, ючетек, йелес'),
                subtitle: Text(
                  'Для вас не просто слова',
                  style: theme.bodySmall,
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.celebration_outlined),
                title: const Text('Вы настроены веселиться'),
                subtitle: Text(
                  'Ругаться будете дома',
                  style: theme.bodySmall,
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.local_taxi_outlined),
                title: const Text('Такси сегодня при деньгах'),
                subtitle: Text(
                  'Веселье стоит дороже 199р - веселись',
                  style: theme.bodySmall,
                ),
              ),
            ),
          ]),
        ));
  }
}
