import 'package:flutter/material.dart';
import 'package:turkish_party_app/main.dart';

class QuestionsPool extends StatefulWidget {
  const QuestionsPool({super.key});

  @override
  State<QuestionsPool> createState() => _QuestionsPoolState();
}

class _QuestionsPoolState extends State<QuestionsPool> {
  bool? _q1t1;
  bool _q1t2 = false;
  bool _q1t3 = false;

  bool _q2t1 = false;
  bool _q2t2 = false;
  bool _q2t3 = false;

  bool _q3t1 = false;
  bool _q3t2 = false;
  bool _q3t3 = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: renderQuestions([
        [
          Switch.adaptive(
            value: _q1t1 ?? false,
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
      ]),
    );
  }
}

class QuestionActions extends Question {
  List<Switch> switches = [];

  QuestionActions(Question question, this.switches)
      : super(
            question: question.question,
            variants: question.variants,
            answers: question.answers);

  factory QuestionActions.create(Question question, List<Switch> switches) {
    if (question.variants.length != switches.length) {
      throw Exception("variants.length != switches.length");
    }

    return QuestionActions(question, switches);
  }
}

class Question {
  String question;
  List<String> variants = [];
  List<int> answers = [];

  Question({
    required this.question,
    required this.variants,
    required this.answers,
  });
}

List<QuestionActions> getQuestions(List<List<Switch>> switchesList) {
  List<Question> list = [
    Question(
      question: "Какие блюда являются турецкими?",
      variants: ["Рахат-лукум", "Пельмени", "Пахлава"],
      answers: [0, 2],
    ),
    Question(
      question: "Какие известные города в Турции?",
      variants: ["Стамбул", "Москва", "Сиде"],
      answers: [0, 1],
    ),
    Question(
      question: "Выберите известных людей Турции",
      variants: ["Ахмед", "Эрдоган", "Мамай"],
      answers: [1],
    ),
  ];

  List<QuestionActions> result = [];

  for (var i = 0; i < switchesList.length; i++) {
    Question q = list[i];
    QuestionActions qa = QuestionActions.create(q, switchesList[i]);
    result.add(qa);
  }

  return result;
}

List<Widget> renderQuestions(List<List<Switch>> switchesList) {
  List<Widget> list = [];
  List<QuestionActions> questions = getQuestions(switchesList);
  if (questions.isEmpty) {
    return [const Text("no questions")];
  }

  // cardRow - question <==> answer switchers
  List<Widget> children = [];
  for (var one in questions) {
    children.addAll([
      Text(one.question, style: titleMedium),
      Divider(color: Colors.red[200])
    ]);

    for (int i = 0; i < one.variants.length; i++) {
      children.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(one.variants[i], style: bodyMedium), one.switches[i]],
        ),
      );
    }

    list.add(Card(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: children))));
    children = [];
  }

  return list;
}
