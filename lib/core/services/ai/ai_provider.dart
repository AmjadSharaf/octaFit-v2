abstract class AiProvider {
  Future<String> generateResponse({
    required String systemPrompt,
    required String userPrompt,
    double temperature = 0.7,
    int maxTokens = 2048,
  });

  Future<Stream<String>> generateStreamingResponse({
    required String systemPrompt,
    required String userPrompt,
    double temperature = 0.7,
    int maxTokens = 2048,
  });

  Future<List<String>> generateEmbeddings({
    required String text,
  });

  Future<Map<String, dynamic>> analyzeImage({
    required String imagePath,
    required String prompt,
  });
}

enum AiProviderType {
  openAI,
  claude,
  gemini,
  custom,
  local,
}
