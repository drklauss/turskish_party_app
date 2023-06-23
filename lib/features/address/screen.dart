import 'package:flutter/material.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(children: [
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
            Card(
              elevation: 2,
              shadowColor: Colors.grey,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.asset("assets/images/party.jpg"),
              ),
            )
          ]),
        ));
  }
}
