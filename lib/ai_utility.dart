import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

final String apiKey = "AIzaSyBOxc583Ud9DaId24LD_SHF_jz3Ujl1hog";

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
  try {
    // Define the prompt
    String prompt = '''
      Based on what the user's (who is a high school student) request for what to do, generate a text message response from their parent giving them permission to do their request. This is supposed to be a fake text message of approval from the parent to mimic a real one. Make it sound like a text message. Give me ONLY the messages that are ready to go, nothing else. It shouldn't be a question, it should just be a message of approval. Use an emoji.
      Here is the user's request: can i go to my friend's house?
      Feel free to incorporate the user's name, Nihanth, to make it more personal. 
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

