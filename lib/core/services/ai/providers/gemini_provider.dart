import 'package:dio/dio.dart';
import 'package:octafit/core/network/api_client.dart';
import 'package:octafit/core/services/ai/ai_provider.dart';

class GeminiProvider implements AiProvider {
  final ApiClient _apiClient;
  final String _apiKey;

  GeminiProvider(this._apiClient, this._apiKey);

  @override
  Future<String> generateResponse({
    required String systemPrompt,
    required String userPrompt,
    double temperature = 0.7,
    int maxTokens = 2048,
  }) async {
    final response = await _apiClient.post(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent',
      data: {
        'contents': [
          {
            'role': 'user',
            'parts': [
              {'text': '$systemPrompt\n\n$userPrompt'},
            ],
          },
        ],
        'generationConfig': {
          'temperature': temperature,
          'maxOutputTokens': maxTokens,
        },
      },
      options: Options(
        headers: {
          'x-goog-api-key': _apiKey,
        },
      ),
    );
    return response.data['candidates'][0]['content']['parts'][0]['text']
        as String;
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
      'https://generativelanguage.googleapis.com/v1beta/models/embedding-001:embedContent',
      data: {
        'model': 'models/embedding-001',
        'content': {
          'parts': [
            {'text': text},
          ],
        },
      },
      options: Options(
        headers: {
          'x-goog-api-key': _apiKey,
        },
      ),
    );
    return (response.data['embedding'] as List).cast<String>();
  }

  @override
  Future<Map<String, dynamic>> analyzeImage({
    required String imagePath,
    required String prompt,
  }) async {
    final response = await _apiClient.post(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro-vision:generateContent',
      data: {
        'contents': [
          {
            'parts': [
              {'text': prompt},
              {
                'inlineData': {
                  'mimeType': 'image/jpeg',
                  'data': imagePath,
                },
              },
            ],
          },
        ],
      },
      options: Options(
        headers: {
          'x-goog-api-key': _apiKey,
        },
      ),
    );
    return response.data as Map<String, dynamic>;
  }
}

