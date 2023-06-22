import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:turkish_party_app/features/pass/block/block.dart';
import 'package:turkish_party_app/features/pass/block/events.dart';
import 'package:turkish_party_app/theme/theme.dart';

class QuestionsPool extends StatefulWidget {
  const QuestionsPool({super.key});

  @override
  State<QuestionsPool> createState() => _QuestionsPoolState();
}

class _QuestionsPoolState extends State<QuestionsPool> {
  bool _q1t1 = false;
  bool _q1t2 = false;
  bool _q1t3 = false;

  bool _q2t1 = false;
  bool _q2t2 = false;
  bool _q2t3 = false;

  bool _q3t1 = false;
  bool _q3t2 = false;
  bool _q3t3 = false;
  PassBloc? _passBlock;
  List<Question> randomQuestions = [];
  List<int> questionsNum = [];

  @override
  void initState() {
    _passBlock = GetIt.I<PassBloc>();

    if (_passBlock == null) {
      throw Exception("null bloc");
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> form = _render(
      [
        [
          Switch.adaptive(
            value: _q1t1,
            activeColor: Colors.red,
            onChanged: (val) => setState(() {
              _q1t1 = val;
            }),
          ),
          Switch.adaptive(
            value: _q1t2,
            activeColor: Colors.red,
            onChanged: (val) => setState(() {
              _q1t2 = val;
            }),
          ),
          Switch.adaptive(
            value: _q1t3,
            activeColor: Colors.red,
            onChanged: (val) => setState(() {
              _q1t3 = val;
            }),
          )
        ],
        [
          Switch.adaptive(
            value: _q2t1,
            activeColor: Colors.red,
            onChanged: (val) => setState(() {
              _q2t1 = val;
            }),
          ),
          Switch.adaptive(
            value: _q2t2,
            activeColor: Colors.red,
            onChanged: (val) => setState(() {
              _q2t2 = val;
            }),
          ),
          Switch.adaptive(
            value: _q2t3,
            activeColor: Colors.red,
            onChanged: (val) => setState(() {
              _q2t3 = val;
            }),
          )
        ],
        [
          Switch.adaptive(
            value: _q3t1,
            activeColor: Colors.red,
            onChanged: (val) => setState(() {
              _q3t1 = val;
            }),
          ),
          Switch.adaptive(
            value: _q3t2,
            activeColor: Colors.red,
            onChanged: (val) => setState(() {
              _q3t2 = val;
            }),
          ),
          Switch.adaptive(
            value: _q3t3,
            activeColor: Colors.red,
            onChanged: (val) => setState(() {
              _q3t3 = val;
            }),
          )
        ],
      ],
    );
    form.add(Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton.icon(
            onPressed: () => {
                  _checkAnswers([
                    [_q1t1, _q1t2, _q1t3],
                    [_q2t1, _q2t2, _q2t3],
                    [_q3t1, _q3t2, _q3t3],
                  ])
                },
            icon: const Icon(Icons.send_sharp),
            label: const Text("Отправить"))
      ],
    ));
    return Column(
      children: form,
    );
  }

  List<Widget> _render(List<List<Switch>> switchesList) {
    _generateRandomQuestions();
    List<Widget> list = [];
    List<Question> questionsExpanded = [];

    for (var i = 0; i < switchesList.length; i++) {
      Question q = randomQuestions[i];
      Question qa = Question.expandSwicthes(q, switchesList[i]);
      questionsExpanded.add(qa);
    }

    if (questionsExpanded.isEmpty) {
      return [const Text("no questions")];
    }

    // cardRow - question <==> answer switchers
    List<Widget> children = [];
    for (var one in questionsExpanded) {
      children.addAll([
        Text(one.question, style: titleMedium),
        Divider(color: Colors.red[200])
      ]);

      for (int i = 0; i < one.variants.length; i++) {
        children.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(one.variants[i], style: bodyMedium),
              one.switches[i]
            ],
          ),
        );
      }

      list.add(
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: children),
          ),
        ),
      );
      children = [];
    }

    return list;
  }

  _generateRandomQuestions() {
    if (randomQuestions.isNotEmpty) {
      return;
    }

    Set<int> qn = {};
    while (qn.length < 3) {
      int rnd =
          Random(DateTime.now().microsecond).nextInt(questionsList.length);
      qn.add(rnd);
    }

    questionsNum = qn.toList();

    for (int indx in questionsNum) {
      randomQuestions.add(questionsList[indx]);
    }
  }

  // Проверка ответов осуществляется на основании данных о номере вопроса и
  // принадлежащих ему переключателях
  _checkAnswers(List<List<bool>> results) {
    int score = 0;
    for (int i = 0; i < results.length; i++) {
      List<bool> result = results[i];
      int qI = questionsNum[i];
      Question question = questionsList[qI];
      for (int k = 0; k < result.length; k++) {
        if (result[k] && result[k] == question.answers[k]) {
          score++;
        }
      }
    }

    _passBlock!.add(PassWaitingEvent(score: score));
  }
}

class Question {
  String question;
  List<String> variants = [];
  List<bool> answers = [];
  List<Switch> switches = [];

  Question({
    required this.question,
    required this.variants,
    required this.answers,
  });

  factory Question.expandSwicthes(Question question, List<Switch> switches) {
    if (question.variants.length != switches.length) {
      throw Exception("variants.length != switches.length");
    }

    question.switches = switches;

    return question;
  }
}

List<Question> questionsList = [
  Question(
    question: "Какие блюда являются турецкими?",
    variants: ["Рахат-лукум", "Пельмени", "Пахлава"],
    answers: [true, false, true],
  ),
  Question(
    question: "Известные города в Турции?",
    variants: ["Стамбул", "Москва", "Сиде"],
    answers: [true, false, true],
  ),
  Question(
    question: "Известные люди Турции",
    variants: ["Гамбиджан", "Эрдоган", "Бусуман"],
    answers: [false, true, false],
  ),
  Question(
    question: "Известные сооружения Турции",
    variants: ["Топкапы", "Дабыгалы", "Деринкую"],
    answers: [true, false, true],
  ),
  Question(
    question: "Варианты приветствия на турецком",
    variants: ["Belunde", "Merhaba", "Günaydın"],
    answers: [false, true, true],
  ),
];
