List<String> generateKeywords(String text) {
  final List<String> progressiveSubstrings = [];
  for (int i = 1; i <= text.length; i++) {
    progressiveSubstrings.add(text.substring(0, i));
  }
  return progressiveSubstrings;
}
