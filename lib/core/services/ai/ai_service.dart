import 'package:octafit/core/services/ai/ai_provider.dart';
import 'package:octafit/core/services/logger_service.dart';

class AiService {
  final Map<AiProviderType, AiProvider> _providers;
  AiProviderType _activeProvider;
  final LoggerService _logger;

  AiService({
    required Map<AiProviderType, AiProvider> providers,
    AiProviderType activeProvider = AiProviderType.openAI,
    required LoggerService logger,
  })  : _providers = providers,
        _activeProvider = activeProvider,
        _logger = logger;

  AiProvider get activeProvider => _providers[_activeProvider]!;

  void switchProvider(AiProviderType type) {
    if (_providers.containsKey(type)) {
      _activeProvider = type;
      _logger.info('Switched AI provider to: $type');
    } else {
      _logger.warning('AI provider $type not registered');
    }
  }

  void registerProvider(AiProviderType type, AiProvider provider) {
    _providers[type] = provider;
  }

  void removeProvider(AiProviderType type) {
    _providers.remove(type);
  }

  Future<String> generateResponse({
    required String systemPrompt,
    required String userPrompt,
    double temperature = 0.7,
    int maxTokens = 2048,
  }) async {
    _logger.debug('AI Request: $userPrompt');
    try {
      final response = await activeProvider.generateResponse(
        systemPrompt: systemPrompt,
        userPrompt: userPrompt,
        temperature: temperature,
        maxTokens: maxTokens,
      );
      _logger.debug('AI Response: $response');
      return response;
    } catch (e) {
      _logger.error('AI Service error', e);
      rethrow;
    }
  }

  Future<Stream<String>> generateStreamingResponse({
    required String systemPrompt,
    required String userPrompt,
    double temperature = 0.7,
    int maxTokens = 2048,
  }) {
    return activeProvider.generateStreamingResponse(
      systemPrompt: systemPrompt,
      userPrompt: userPrompt,
      temperature: temperature,
      maxTokens: maxTokens,
    );
  }

  Future<List<String>> generateEmbeddings({required String text}) {
    return activeProvider.generateEmbeddings(text: text);
  }

  Future<Map<String, dynamic>> analyzeImage({
    required String imagePath,
    required String prompt,
  }) {
    return activeProvider.analyzeImage(imagePath: imagePath, prompt: prompt);
  }
}

