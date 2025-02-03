
import 'package:flutter/material.dart';
import 'package:quizz/admob/admobHelper.dart';

class QuizCard extends StatelessWidget {
  final int id;
  final String question;
  final List<String> options;
  final String answer;

  final AdmobHelper helper;

  const QuizCard(
      {super.key,
      required this.id,
      required this.question,
      required this.options,
      required this.answer,
      required this.helper});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$id. $question',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: options.map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${String.fromCharCode(65 + options.indexOf(option))}. ',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          option,
                          style: const TextStyle(fontSize: 16),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                helper.showAd();

                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return  AlertDialog(
                        title: const Text("Correct Answer"),
                        content: Text(answer),
                        actions: [
                          TextButton(onPressed: ()=>{
                            Navigator.of(context).pop()
                          }, child: const Text("Cancel"))
                        ],
                      );
                    });
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(content: Text('Correct Answer: $answer')),
                // );
              },
              child: const Text(
                'Show Answer',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
