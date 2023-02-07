class OpenAiVariablesModel {
  String token;
  String model;
  double temperature;
  int maxTokens;
  double topP;
  double frequencyPenalty;
  double presencePenalty;
  String firstPrompt;

  OpenAiVariablesModel({
    this.token = "sk-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
    this.model = "text-davinci-003",
    this.temperature = 0.7,
    this.maxTokens = 500,
    this.topP = 1,
    this.frequencyPenalty = 0,
    this.presencePenalty = 0,
    this.firstPrompt = "",
  });

  Map<String, dynamic> toJson() {
    return {
      "token": token,
      "model": model,
      "temperature": temperature,
      "max_tokens": maxTokens,
      "top_p": topP,
      "frequency_penalty": frequencyPenalty,
      "presence_penalty": presencePenalty,
      "first_prompt": firstPrompt,
    };
  }

  factory OpenAiVariablesModel.fromJson(Map<String, dynamic> json) {
    return OpenAiVariablesModel(
      token: json['token'] ?? "sk-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
      model: json['model'] ?? "text-davinci-003",
      temperature: json['temperature'] ?? 0.7,
      maxTokens: json['max_tokens'] ?? 400,
      topP: json['top_p'] ?? 1,
      frequencyPenalty: json['frequency_penalty'] ?? 0,
      presencePenalty: json['presence_penalty'] ?? 0,
      firstPrompt: json['first_prompt'] ?? "",
    );
  }
}

enum OpenAiModels {
  textDavinci003,
  textCurie001,
  textBabbage001,
  textAda001;

  String get value {
    switch (this) {
      case OpenAiModels.textDavinci003:
        return "text-davinci-003";
      case OpenAiModels.textCurie001:
        return "text-curie-001";
      case OpenAiModels.textBabbage001:
        return "text-babbage-001";
      case OpenAiModels.textAda001:
        return "text-ada-001";
    }
  }

  static OpenAiModels fromString(String model) {
    switch (model) {
      case "text-davinci-003":
        return OpenAiModels.textDavinci003;
      case "text-curie-001":
        return OpenAiModels.textCurie001;
      case "text-babbage-001":
        return OpenAiModels.textBabbage001;
      case "text-ada-001":
        return OpenAiModels.textAda001;
      default:
        return OpenAiModels.textDavinci003;
    }
  }
}
