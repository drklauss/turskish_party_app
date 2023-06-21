import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:turkish_party_app/main.dart';
import 'questions_pool.dart';
// import 'package:qr_flutter/qr_flutter.dart';

class PassScreen extends StatefulWidget {
  const PassScreen({super.key});

  @override
  State<PassScreen> createState() => _PassScreenState();
}

class _PassScreenState extends State<PassScreen> {
  String _qrCode = '';

  @override
  Widget build(BuildContext context) {
    // _qrCode = 'кодированный пропуск';
    return _qrCode.isNotEmpty
        ? QrCode(qrCode: _qrCode)
        : const SingleChildScrollView(
            child:
                Padding(padding: EdgeInsets.all(16), child: QuestionsPool()));
  }
}

class QrCode extends StatelessWidget {
  final String qrCode;

  const QrCode({super.key, required this.qrCode});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text("Твой пропуск на вечеринку", style: headlineLarge),
          const SizedBox(height: 8),
          Center(
            child: Text("Не факт, что он идеальный, может быть со штрафом",
                style: theme.bodySmall),
          ),
          const SizedBox(height: 16),
          Center(
            child: Card(
              elevation: 2,
              shadowColor: Colors.grey,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: QrImageView(
                  data: qrCode,
                  version: QrVersions.auto,
                  size: 320,
                  gapless: false,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
