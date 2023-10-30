import 'dart:convert';

import 'package:flutter_manga_app_test/constants/openai_api.dart';
import 'package:flutter_manga_app_test/constants/urls.dart';
import 'package:flutter_manga_app_test/models/openai_models/openai_model.dart';
import 'package:http/http.dart' as http;

class RecommendationService {
  static Future<GptData> getRecommendations({
    required String mangaList,
  }) async {
    Urls urls = Urls();

    late GptData gptData = GptData(
      id: '',
      object: '',
      created: 0,
      model: '',
      choices: [],
      usage: Usage(promptTokens: 0, completionTokens: 0, totalTokens: 0),
    );

    try {
      var url = Uri.parse("${urls.openaiBaseUrl}v1/completions");

      Map<String, String> headers = {
        "Content-Type": "application/json;charset=UTF-8",
        "Charset": "utf-8",
        "Authorization": "Bearer $apiKey",
      };

      String promptData =
          "Hello there! Recently, I read a couple manga books, and I really like them. I especially enjoyed the titles $mangaList. Could you suggest eight mangas that are similar for me to read next? Please don't bring up any mangas I've read. Kindly reply to me in a compact one-lined csv string format only, indicating the manga titles you think are worth reading and with no any other responses such as opening and closing sentences. Thank you!";

      final data = jsonEncode({
        "model": "text-davinci-003",
        "prompt": promptData,
        "temperature": 0.4,
        "max_tokens": 64,
        "top_p": 1,
        "frequency_penalty": 0,
        "presence_penalty": 0
      });

      var response = await http.post(url, headers: headers, body: data);

      if (response.statusCode == 200) {
        gptData = gptDataFromJson(response.body);
      }
    } catch (_) {
      rethrow;
    }

    return gptData;
  }
}
