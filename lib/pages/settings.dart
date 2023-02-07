// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_ai_tester/models/openai_variables_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var openAiVariablesModel = GetIt.I.get<OpenAiVariablesModel>();

  String firstPrompt = "";
  TextEditingController apiKeyController = TextEditingController();
  double temperatureController = 0.0;
  int maxTokensController = 0;
  double topPController = 0.0;
  double frequencyPenaltyController = 0.0;
  double presencePenaltyController = 0.0;

  OpenAiModels selectedModel = OpenAiModels.textDavinci003;

  var scrollController = ScrollController();

  @override
  void initState() {
    firstPrompt = openAiVariablesModel.firstPrompt;
    apiKeyController.text = openAiVariablesModel.token;
    temperatureController = openAiVariablesModel.temperature;
    maxTokensController = openAiVariablesModel.maxTokens;
    topPController = openAiVariablesModel.topP;
    frequencyPenaltyController = openAiVariablesModel.frequencyPenalty;
    presencePenaltyController = openAiVariablesModel.presencePenalty;
    selectedModel = OpenAiModels.fromString(openAiVariablesModel.model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () async {
                try {
                  openAiVariablesModel.token = apiKeyController.text;
                  openAiVariablesModel.model = selectedModel.value;
                  openAiVariablesModel.temperature = temperatureController;
                  openAiVariablesModel.maxTokens = maxTokensController;
                  openAiVariablesModel.topP = topPController;
                  openAiVariablesModel.frequencyPenalty =
                      frequencyPenaltyController;
                  openAiVariablesModel.presencePenalty =
                      presencePenaltyController;
                  openAiVariablesModel.firstPrompt = firstPrompt;

                  var localStorage = GetIt.I.get<SharedPreferences>();
                  await localStorage.setString("openAiVariables",
                      jsonEncode(openAiVariablesModel.toJson()));

                  setState(() {});

                  // show snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Saved'),
                    ),
                  );
                } catch (e) {
                  // show snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error saving'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        // Page to edit OpenAI variables
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scrollbar(
            thumbVisibility: true,
            trackVisibility: true,
            controller: scrollController,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('OpenAI Variables'),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: apiKeyController,
                      decoration: const InputDecoration(
                        hintText: 'Enter API Key',
                        label: Text('API Key'),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Model'),
                    DropdownButton<OpenAiModels>(
                      value: selectedModel,
                      items: OpenAiModels.values
                          .map(
                            (e) => DropdownMenuItem<OpenAiModels>(
                              value: e,
                              child: Text(e.value),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedModel = value!;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Text('Temperature (Default 0.7)'),
                    Slider(
                      value: temperatureController,
                      min: 0.0,
                      max: 1.0,
                      divisions: 10,
                      label: temperatureController.toString(),
                      onChanged: (value) {
                        setState(() {
                          temperatureController = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Text('Maximum length (tokens)'),
                    Slider(
                      value: maxTokensController.toDouble(),
                      min: 0,
                      max: 4000,
                      divisions: 20,
                      label: maxTokensController.toString(),
                      onChanged: (value) {
                        setState(() {
                          maxTokensController = value.toInt();
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Text('Top P (Default 1)'),
                    Slider(
                      value: topPController,
                      min: 0.0,
                      max: 1.0,
                      divisions: 10,
                      label: topPController.toString(),
                      onChanged: (value) {
                        setState(() {
                          topPController = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Text('Frequency Penalty (Default 0)'),
                    Slider(
                      value: frequencyPenaltyController,
                      min: 0.0,
                      max: 1.0,
                      divisions: 10,
                      label: frequencyPenaltyController.toString(),
                      onChanged: (value) {
                        setState(() {
                          frequencyPenaltyController = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Text('Presence Penalty (Default 0)'),
                    Slider(
                      value: presencePenaltyController,
                      min: 0.0,
                      max: 1.0,
                      divisions: 10,
                      label: presencePenaltyController.toString(),
                      onChanged: (value) {
                        setState(() {
                          presencePenaltyController = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Text('Topic (This will be used to set the model context)'),
                    SizedBox(height: 5),
                    TextFormField(
                      initialValue: firstPrompt,
                      maxLines: 8,
                      onChanged: (value) {
                        firstPrompt = value;
                      },
                      decoration: const InputDecoration(
                        hintText:
                            "Example: 'I am a teacher. I teach kids how to read and write. I also teach them how to play sports.'",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
