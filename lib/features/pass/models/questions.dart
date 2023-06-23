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
