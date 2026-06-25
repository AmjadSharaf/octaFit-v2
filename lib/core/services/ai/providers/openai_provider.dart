import 'package:dio/dio.dart';
import 'package:octafit/core/network/api_client.dart';
import 'package:octafit/core/services/ai/ai_provider.dart';

class OpenAiProvider implements AiProvider {
  final ApiClient _apiClient;
  final String _apiKey;

  OpenAiProvider(this._apiClient, this._apiKey);

  @override
  Future<String> generateResponse({
    required String systemPrompt,
    required String userPrompt,
    double temperature = 0.7,
    int maxTokens = 2048,
  }) async {
    final response = await _apiClient.post(
      'https://api.openai.com/v1/chat/completions',
      data: {
        'model': 'gpt-4',
        'messages': [
          {'role': 'system', 'content': systemPrompt},
          {'role': 'user', 'content': userPrompt},
        ],
        'temperature': temperature,
        'max_tokens': maxTokens,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $_apiKey',
        },
      ),
    );
    return response.data['choices'][0]['message']['content'] as String;
  }

  @override
  Future<Stream<String>> generateStreamingResponse({
    required String systemPrompt,
    required String userPrompt,
    double temperature = 0.7,
    int maxTokens = 2048,
  }) async {
    throw UnimplementedError('Streaming not implemented yet');
  }

  @override
  Future<List<String>> generateEmbeddings({required String text}) async {
    final response = await _apiClient.post(
      'https://api.openai.com/v1/embeddings',
      data: {
        'model': 'text-embedding-3-small',
        'input': text,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $_apiKey',
        },
      ),
    );
    final data = response.data['data'] as List;
    final embedding = data[0]['embedding'] as List;
    return embedding.cast<String>();
  }

  @override
  Future<Map<String, dynamic>> analyzeImage({
    required String imagePath,
    required String prompt,
  }) async {
    final response = await _apiClient.post(
      'https://api.openai.com/v1/chat/completions',
      data: {
        'model': 'gpt-4-vision-preview',
        'messages': [
          {'role': 'user', 'content': [
            {'type': 'text', 'text': prompt},
            {'type': 'image_url', 'image_url': {'url': imagePath}},
          ]},
        ],
        'max_tokens': 1024,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $_apiKey',
        },
      ),
    );
    return response.data as Map<String, dynamic>;
  }
}

