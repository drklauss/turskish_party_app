import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:turkish_party_app/features/pass/block/block.dart';
import 'package:turkish_party_app/features/pass/block/events.dart';
import 'package:turkish_party_app/features/pass/block/state.dart';
import 'package:turkish_party_app/theme/theme.dart';

import 'questions_pool.dart';

class PassScreen extends StatefulWidget {
  const PassScreen({super.key});

  @override
  State<PassScreen> createState() => _PassScreenState();
}

class _PassScreenState extends State<PassScreen> {
  PassBloc? _passBlock;

  @override
  void initState() {
    _passBlock = GetIt.I<PassBloc>();

    if (_passBlock == null) {
      throw Exception("null bloc");
    }

    _passBlock!.add(PassLoadEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PassBloc, PassState>(
      bloc: _passBlock,
      builder: (context, state) {
        if (state is PassDoneState) {
          return QrCode(qrCode: state.score.toString());
        }

        if (state is PassQuestionsState) {
          return const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Вопросы для получения пропуска",
                      style: headlineLarge,
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Text(
                      "Отвечай без помощи - так интереснее",
                      style: bodySmall,
                    ),
                  ),
                  SizedBox(height: 16),
                  QuestionsPool()
                ],
              ),
            ),
          );
        }

        if (state is PassWaitingState) {
          return AlertDialog(
              title: const LinearProgressIndicator(),
              content: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Переживаешь?...',
                    textStyle: titleMedium,
                    speed: const Duration(milliseconds: 100),
                  ),
                  TypewriterAnimatedText(
                    'Думаешь, все верно?...',
                    textStyle: titleMedium,
                    speed: const Duration(milliseconds: 100),
                  ),
                  TypewriterAnimatedText(
                    'Ну, не знаю, не знаю...',
                    textStyle: titleMedium,
                    speed: const Duration(milliseconds: 100),
                  ),
                  TypewriterAnimatedText(
                    'Исключительно за попытку...',
                    textStyle: titleMedium,
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                totalRepeatCount: 1,
                onFinished: () => _passBlock!.add(PassDoneEvent()),
              ));
        }

        return Container();
      },
    );
  }
}

class QrCode extends StatelessWidget {
  final String qrCode;
  final String _prefix = "your_score_is:";

  const QrCode({super.key, required this.qrCode});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    String hash = md5.convert(utf8.encode(_prefix + qrCode)).toString();
    debugPrint(hash);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text("Твой пропуск на вечеринку", style: headlineLarge),
          const SizedBox(height: 8),
          Center(
            child: Text(
              "Не факт, что он идеальный, может быть со штрафом",
              style: theme.bodySmall,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Card(
              elevation: 2,
              shadowColor: Colors.grey,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: QrImageView(
                  padding: const EdgeInsets.all(16),
                  data: hash,
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
