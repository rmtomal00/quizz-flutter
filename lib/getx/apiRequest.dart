import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiRequest{
  String baseUrl = "https://quizz.team71.link";

  Future<ApiResponse> fetchQuizzes(int page) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/v1/get-quize-list/$page'));
      var jsonData = json.decode(response.body);
      var apiResponse = ApiResponse.fromJson(jsonData);
      return apiResponse;
    } catch (e) {
      print('Error: $e');
      return  ApiResponse(message: "Please check your internet connection", data: [], statusCode: 1000, error: true);
    }
  }
}

class QuizModel {
  final int id;
  final String question;
  final String? exam;
  final String subject;
  final List<String> options;
  final int uid;
  final String ans;

  QuizModel({
    required this.id,
    required this.question,
    this.exam,
    required this.subject,
    required this.options,
    required this.uid,
    required this.ans,
  });

  // Factory constructor to create an instance from a JSON map
  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'],
      question: json['question'],
      exam: json['exam'],
      subject: json['subject'],
      options: List<String>.from(json['options']),
      uid: json['uid'],
      ans: json['ans'],
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'exam': exam,
      'subject': subject,
      'options': options,
      'uid': uid,
      'ans': ans,
    };
  }
}

class ApiResponse {
  final String message;
  final List<QuizModel> data;
  final int statusCode;
  final bool error;

  ApiResponse({
    required this.message,
    required this.data,
    required this.statusCode,
    required this.error,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['message'],
      data: json['data'] == null ? List<QuizModel>.from([].map((x) => QuizModel.fromJson(x))): List<QuizModel>.from(json['data'].map((x) => QuizModel.fromJson(x))),
      statusCode: json['statusCode'],
      error: json['error'],
    );
  }
}