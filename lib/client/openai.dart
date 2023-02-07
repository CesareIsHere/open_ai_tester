import 'package:get_it/get_it.dart';
import 'package:open_ai_tester/api/request.dart';
import 'package:open_ai_tester/models/completition_response.dart';
import 'package:open_ai_tester/models/openai_variables_model.dart';

class OpenAi {
  List<String> chat = [];

  OpenAi() {
    chat.add(GetIt.I.get<OpenAiVariablesModel>().firstPrompt);
  }

  Future<String> completition(String lastUserMessage) async {
    String url = 'https://api.openai.com/v1/completions';
    var datas = GetIt.I.get<OpenAiVariablesModel>();

    // Prepare chat string for prompt, by separing each sentence with a new line.
    try {
      // Add the user message to the chat list.
      chat.add(lastUserMessage);

      // Do request
      var response = await handlePost(
        url: url,
        payload: {
          "prompt": chat.join("\n"),
          "model": datas.model,
          "temperature": datas.temperature,
          "max_tokens": datas.maxTokens,
          "top_p": datas.topP,
          "frequency_penalty": datas.frequencyPenalty,
          "presence_penalty": datas.presencePenalty,
          "stop": "####",
        },
      );

      if (response.statusCode == 200) {
        CompletitionResponseList data =
            CompletitionResponseList.fromJson(response.data);

        var betterResponse = data.completitionResponseList[0];

        // Add the new message to the chat list.
        if (betterResponse.text != "") {
          chat.add(betterResponse.text);
        } else {
          chat.add("I don't know what to say.");
        }

        return betterResponse.text;
      } else {
        throw Exception('Failed to load completition');
      }
    } catch (e) {
      chat.removeLast();
      rethrow;
    }
  }

  Future<String> addNewMessage(String message) async {
    await completition(message);

    return message;
  }

  void resetChat() async {
    var datas = GetIt.I.get<OpenAiVariablesModel>();

    chat = [
      datas.firstPrompt,
    ];

    return;
  }

  // Future<void> stopChat() async {
  //   chat.add("####");
  //   await completition();

  //   return;
  // }
}
