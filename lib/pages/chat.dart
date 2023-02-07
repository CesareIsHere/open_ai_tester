// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_ai_tester/client/openai.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  OpenAi openAi = OpenAi();

  bool isLoading = false;

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            onPressed: () async {
              openAi.resetChat();
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : openAi.chat.length == 1
                    ? Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.settings,
                                size: 100,
                                color: Colors.grey.shade400,
                              ),
                              Text(
                                "Hi! Welcome in OpenAI API tester!",
                                style: TextStyle(color: Colors.grey.shade400),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "First of all you need to set your API key and others settings in settings page. Then you can start to chat with the bot!",
                                style: TextStyle(color: Colors.grey.shade400),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "You can also reset the chat and change the settings at any time.",
                                style: TextStyle(color: Colors.grey.shade400),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Enjoy!",
                                style: TextStyle(color: Colors.grey.shade400),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: openAi.chat.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          var isTopic = false;
                          var isBot = index % 2 == 0;
                          if (index == openAi.chat.length - 1) {
                            isTopic = false;
                          }
                          List<String> chat = openAi.chat.reversed.toList();
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        isTopic
                                            ? "Topic"
                                            : (isBot ? "Bot" : "Me"),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      chat[index].trim(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Message',
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ),
              IconButton(
                onPressed: isLoading || textController.text.isEmpty
                    ? null
                    : () async {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          // show snack bar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                  "The request will take a few seconds..., just be patient!"),
                              duration: const Duration(seconds: 1),
                            ),
                          );

                          await openAi.addNewMessage(textController.text);
                          textController.clear();
                        } on DioError catch (e) {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  icon: const Icon(Icons.error),
                                  title: const Text("Connection Error"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Error code: ${e.response?.statusCode.toString() ?? "Unknown"}"),
                                      Text(
                                          "Error message: ${e.response!.data["error"]["message"] ?? "Unknown"}"),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Ok"),
                                    )
                                  ],
                                );
                              });
                        } catch (e) {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Error"),
                                  content: Text(e.toString()),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Ok"),
                                    )
                                  ],
                                );
                              });
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                icon: const Icon(Icons.send),
              ),
            ],
          )
        ],
      ),
    );
  }
}
