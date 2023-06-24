import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(children: [
        Center(
          child: Text(
            "Место проведения",
            style: theme.headlineLarge,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            "Если вы вдруг забыли или никогда не помнили",
            style: theme.bodySmall,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          constraints: const BoxConstraints(maxHeight: 300, maxWidth: 400),
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: PhotoView(
              minScale: 0.25,
              maxScale: 1.0,
              imageProvider: const AssetImage("assets/images/address.jpg"),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            "Время: 01.07.2023 18:00",
            style: theme.headlineLarge,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            "Можно раньше, позже - нельзя",
            style: theme.bodySmall,
          ),
        ),
        Card(
          elevation: 2,
          shadowColor: Colors.grey,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.asset("assets/images/zhdun.jpg"),
          ),
        ),
      ]),
    );
  }
}
