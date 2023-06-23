import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:turkish_party_app/features/pass/block/block.dart';
import 'package:turkish_party_app/features/pass/block/events.dart';
import 'package:turkish_party_app/theme/theme.dart';

import 'models/questions.dart';

class QuestionsPool extends StatefulWidget {
  String get text => '';
  const QuestionsPool({super.key});

  @override
  State<QuestionsPool> createState() => _QuestionsPoolState();
}

class _QuestionsPoolState extends State<QuestionsPool> {
  _QuestionsPoolState() : super();
  PassBloc? _passBlock;
  List<Question> randomQuestions = [];
  List<int> questionsNum = [];

  bool _q1t1 = false;
  bool _q1t2 = false;
  bool _q1t3 = false;

  bool _q2t1 = false;
  bool _q2t2 = false;
  bool _q2t3 = false;

  bool _q3t1 = false;
  bool _q3t2 = false;
  bool _q3t3 = false;

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

  // Renders questions page of List<Widget>
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

  // Generates random questions and save its indexes for answer checking
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

  // Checks whether answers were correct or not. Operates on questions list
  // and its stored indexes
  _checkAnswers(List<List<bool>> results) {
    int goal = 0;
    int correct = 0;
    for (int i = 0; i < results.length; i++) {
      List<bool> result = results[i];
      int qI = questionsNum[i];
      Question question = questionsList[qI];
      for (int k = 0; k < result.length; k++) {
        if (question.answers[k]) {
          correct++;
        }
        if (result[k] && result[k] == question.answers[k]) {
          goal++;
        }
      }
    }
    int accuracy = ((goal / correct) * 100).round();

    _passBlock!.add(PassHandlingEvent(accuracy: accuracy, qNums: questionsNum));
  }
}
