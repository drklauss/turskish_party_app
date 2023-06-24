import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:turkish_party_app/features/pass/block/block.dart';
import 'package:turkish_party_app/features/pass/repository/score.dart';
import 'package:turkish_party_app/theme/theme.dart';

import 'block/events.dart';
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
  List<int> questionsNum = []; // List of indx random questions

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
          onPressed: () => _checkAnswers(),
          icon: const Icon(Icons.send_sharp),
          label: const Text("Отправить"),
        )
      ],
    ));
    return Column(
      children: form,
    );
  }

  // Renders questions page of List<Widget>
  List<Widget> _render(List<List<Switch>> switchesList) {
    if (questionsNum.isEmpty || randomQuestions.isEmpty) {
      List<int> savedQNums = GetIt.I<HiveRepository>().getQNums();
      Map<int, Question> m = Question.get(savedQNums);
      m.forEach((key, value) {
        questionsNum.add(key);
        randomQuestions.add(value);
      });
    }
    debugPrint(questionsNum.toString());

    GetIt.I<HiveRepository>().setQNums(questionsNum);

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

  void _checkAnswers() {
    int accuracy = Question.checkAnswers(
      [
        [_q1t1, _q1t2, _q1t3],
        [_q2t1, _q2t2, _q2t3],
        [_q3t1, _q3t2, _q3t3],
      ],
      questionsNum,
    );

    _passBlock!.add(PassHandlingEvent(accuracy: accuracy));
  }
}
