import 'package:dio/dio.dart';
import 'package:octafit/core/network/api_client.dart';
import 'package:octafit/core/services/ai/ai_provider.dart';

class ClaudeProvider implements AiProvider {
  final ApiClient _apiClient;
  final String _apiKey;

  ClaudeProvider(this._apiClient, this._apiKey);

  @override
  Future<String> generateResponse({
    required String systemPrompt,
    required String userPrompt,
    double temperature = 0.7,
    int maxTokens = 2048,
  }) async {
    final response = await _apiClient.post(
      'https://api.anthropic.com/v1/messages',
      data: {
        'model': 'claude-3-opus-20240229',
        'max_tokens': maxTokens,
        'system': systemPrompt,
        'messages': [
          {'role': 'user', 'content': userPrompt},
        ],
        'temperature': temperature,
      },
      options: Options(
        headers: {
          'x-api-key': _apiKey,
          'anthropic-version': '2023-06-01',
        },
      ),
    );
    return response.data['content'][0]['text'] as String;
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
    throw UnimplementedError('Claude embeddings not implemented');
  }

  @override
  Future<Map<String, dynamic>> analyzeImage({
    required String imagePath,
    required String prompt,
  }) async {
    final response = await _apiClient.post(
      'https://api.anthropic.com/v1/messages',
      data: {
        'model': 'claude-3-opus-20240229',
        'max_tokens': 1024,
        'messages': [
          {
            'role': 'user',
            'content': [
              {'type': 'text', 'text': prompt},
              {
                'type': 'image',
                'source': {
                  'type': 'base64',
                  'media_type': 'image/jpeg',
                  'data': imagePath,
                },
              },
            ],
          },
        ],
      },
      options: Options(
        headers: {
          'x-api-key': _apiKey,
          'anthropic-version': '2023-06-01',
        },
      ),
    );
    return response.data as Map<String, dynamic>;
  }
}

