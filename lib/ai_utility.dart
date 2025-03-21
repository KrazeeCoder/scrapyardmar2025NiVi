import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

final String apiKey = "[insert api key here]";


final safetySettings = [
  SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
  SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
  SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none),
  SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none),
];

final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: apiKey,
    safetySettings: safetySettings
);


Future<String?> generateAnswerResponse(String request, String name, BuildContext context) async {
  print(request);
  try {
    // Define the prompt
    String prompt = '''
      Based on what the user's (who is a high school student) request for what to do, generate a text message response from their parent giving them permission to do their request. This is supposed to be a fake text message of approval from the parent to mimic a real one. Make it sound like a text message. Give me ONLY ONE message that is ready to go, nothing else. It shouldn't be a question, it should just be a message of approval. Use an emoji sometimes (randomly). Vary the structure of the messages so they don't sound the same everytime.
      Here is the user's request: $request
      Feel free to incorporate the user's name, $name, to make it more personal. 
    ''';
    // Generate content
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    return response.text;
  } catch (e) {
    print("Error generating response: $e");
    return null;
  }
}

