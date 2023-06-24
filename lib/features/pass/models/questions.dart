import 'dart:math';

import 'package:flutter/material.dart';

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

  // Generates questions and save its indexes for answer checking
  // if qNum is not sent - returns random questions
  static Map<int, Question> get(List<int> qNum) {
    if (qNum.isEmpty) {
      Set<int> qn = {};
      while (qn.length < 3) {
        int rnd =
            Random(DateTime.now().microsecond).nextInt(questionsList.length);
        qn.add(rnd);
      }
      qNum = qn.toList();
    }

    Map<int, Question> randomQuestions = {};
    for (int indx in qNum) {
      randomQuestions[indx] = (questionsList[indx]);
    }

    return randomQuestions;
  }

  // Checks whether answers were correct or not. Operates on questions list
  // and its stored indexes
  static int checkAnswers(List<List<bool>> results, List<int> qNum) {
    int goal = 0;
    int correct = 0;
    for (int i = 0; i < results.length; i++) {
      List<bool> result = results[i];
      int qI = qNum[i];
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

    return ((goal / correct) * 100).round();
  }
}

List<Question> questionsList = [
  Question(
    question: "Какие блюда являются турецкими?",
    variants: ["Рахат-лукум", "Пельмени", "Пахлава"],
    answers: [true, false, true],
  ),
  Question(
    question: "Известные города Турции",
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
  Question(
    question: "Какие чудеса света находятся в Турции?",
    variants: ["Висячие сады Семирамиды", "Мавзолей", "Храм Артемиды"],
    answers: [false, true, true],
  ),
  Question(
    question: "Какие фестивали проходят в Турции каждый год?",
    variants: ["Тюльпанов", "Воздушных шаров", "Масляной борьбы"],
    answers: [true, false, true],
  ),
  Question(
    question: "Какие алкогольные напитки самые популярные?",
    variants: ["Граппа", "Пиво 'Эфес'", "Ракы"],
    answers: [false, true, true],
  ),
];
