class NewsApiConfig {
  String apiKey;
  String q;
  String from;
  String sortBy;

  NewsApiConfig({
    required this.apiKey,
    required this.q,
    required this.from,
    required this.sortBy,
  });

  Map<String, String> toMap() {
    return {'q': q, 'from': from, 'sortBy': sortBy, 'apiKey': apiKey};
  }
}
