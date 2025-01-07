import 'package:flutter/material.dart';
import 'package:quizz/components/card.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<StatefulWidget> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map<String, dynamic>> list = [
    {
      'id': 18,
      'quiz': "What's your country name?",
      'options': [
        "Dhaka is the biggest city of Bangladesh",
        "Bangladesh",
        "Gaibandha",
        "Gazipur"
      ],
      'ans': "Bangladesh"
    },
    {
      'id': 19,
      'quiz': "What is the capital of Bangladesh?",
      'options': ["Dhaka", "Chittagong", "Sylhet", "Rajshahi"],
      'ans': "Dhaka"
    },
    {
      'id': 20,
      'quiz': "Which continent is Bangladesh in?",
      'options': ["Asia", "Africa", "Europe", "Australia"],
      'ans': "Asia"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            setState(() {
              list = [
                {
                  'id': 21,
                  'quiz': "What is the national language of Bangladesh?",
                  'options': ["Hindi", "Bengali", "English", "Urdu"],
                  'ans': "Bengali"
                },
                {
                  'id': 22,
                  'quiz': "What is the national animal of Bangladesh?",
                  'options': ["Tiger", "Elephant", "Cow", "Goat"],
                  'ans': "Tiger"
                },
                {
                  'id': 23,
                  'quiz': "Which river is the longest in Bangladesh?",
                  'options': ["Padma", "Jamuna", "Meghna", "Sundarbans"],
                  'ans': "Padma"
                },
              ];
            });
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("No more")));
          },
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 16, 139, 155)),
        ),
        title: const Text(
          "Quiz",
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                list = [
                  {
                    'id': 18,
                    'quiz': "What's your country name?",
                    'options': [
                      "Dhaka is the biggest city of Bangladesh",
                      "Bangladesh",
                      "Gaibandha",
                      "Gazipur"
                    ],
                    'ans': "Bangladesh"
                  },
                  {
                    'id': 19,
                    'quiz': "What is the capital of Bangladesh?",
                    'options': ["Dhaka", "Chittagong", "Sylhet", "Rajshahi"],
                    'ans': "Dhaka"
                  },
                  {
                    'id': 20,
                    'quiz': "Which continent is Bangladesh in?",
                    'options': ["Asia", "Africa", "Europe", "Australia"],
                    'ans': "Asia"
                  },
                ];
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("No more")));
            },
            icon: const Icon(Icons.arrow_forward,
                color: Color.fromARGB(255, 16, 139, 155)),
          ),
        ],
      ),
      body: Center(
        child: list.isEmpty
            ? const Text(
                "No data found or Internet off",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final quiz = list[index];
                  return QuizCard(
                    id: quiz['id'],
                    question: quiz['quiz'],
                    options: quiz['options'],
                    answer: quiz['ans'],
                  );
                },
              ),
      ),
    );
  }
}
