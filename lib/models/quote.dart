class Quote {
  String author;
  String quote;

  Quote({required this.author, required this.quote});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(author: json['author'], quote: json['content']);
  }
}
