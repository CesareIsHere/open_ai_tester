class CompletitionResponse {
  String text;
  double score;

  CompletitionResponse({required this.text, required this.score});

  factory CompletitionResponse.fromJson(Map<String, dynamic> json) {
    return CompletitionResponse(
      text: json['text'],
      score: json['score'] ?? 0.0,
    );
  }
}

class CompletitionResponseList {
  List<CompletitionResponse> completitionResponseList;

  CompletitionResponseList({required this.completitionResponseList});

  factory CompletitionResponseList.fromJson(Map<String, dynamic> json) {
    return CompletitionResponseList(
      completitionResponseList: (json["choices"] as List)
          .map((completitionResponse) =>
              CompletitionResponse.fromJson(completitionResponse))
          .toList(),
    );
  }
}
