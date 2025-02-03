import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quizz/admob/admobHelper.dart';
import 'package:quizz/components/card.dart';
import 'package:quizz/getx/apiRequest.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<StatefulWidget> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  AdRequest adRequest = const AdRequest();
  var adManage = AdmobHelper();
  var apiRequest = ApiRequest();
  bool isLoading  = false;

  List<QuizModel> list = [];

  @override
  void initState() {
    super.initState();
    adManage.loadAds(adRequest);
    callApi(false, 0);
  }

  void callApi(bool isClick, int pageNum) async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int page = sharedPreferences.getInt("page") ?? 1;
    if(isClick){
      page = page + (1 * pageNum);
    }

    // Fetch quizzes from the API
    ApiResponse response = await apiRequest.fetchQuizzes(page);

    if (response.error) {
      setState(() {
        isLoading = false;
      });
      if (!mounted) return; // Prevent calling setState if widget is disposed
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Problem"),
            content: Text(response.message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
            ],
          );
        },
      );

      return;
    }

    List<QuizModel> list1 = response.data;

    if (list1.isNotEmpty) {
      var data = list1[0];
      int pageNumber = (data.id % 100).floor();
      pageNumber = pageNumber == 0 ? 1 : pageNumber;
      sharedPreferences.setInt("page", pageNumber);
    }

    // Safely update the state if widget is still mounted
    if (mounted) {
      setState(() {
        isLoading = false;
        list = list1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if(list.isNotEmpty) callApi(true, -1);
            // Add action if needed
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
              if(list.isNotEmpty) callApi(true, 1);
              // Add action if needed
            },
            icon: const Icon(Icons.arrow_forward,
                color: Color.fromARGB(255, 16, 139, 155)),
          ),
        ],
      ),
      body: Center(
        child: isLoading ?  const CircularProgressIndicator() : list.isEmpty
            ? const Text(
          "No data found or Internet off",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
            : ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final quiz = list[index];
            return QuizCard(
              id: quiz.id,
              question: quiz.question,
              options: quiz.options,
              answer: quiz.ans,
              helper: adManage,
            );
          },
        ),
      ),
    );
  }
}
