import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chatgpt/shared/component/Constants.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class ChatgptLayoutScreen extends StatefulWidget {
  const ChatgptLayoutScreen({super.key});

  @override
  State<ChatgptLayoutScreen> createState() => _ChatgptLayoutScreenState();
}

class _ChatgptLayoutScreenState extends State<ChatgptLayoutScreen> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final List<ChatUser> _typingUsers = <ChatUser>[];

  final ChatUser _currentUser = ChatUser(id: '1', firstName: 'Abdelrahman', lastName: 'Ashraf');
  final ChatUser _chatgptUser = ChatUser(id: '2', firstName: 'Chat', lastName: 'GPT');


  final _openAI = OpenAI.instance.build(
      token: openAI_API_Key,
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 15)),
      enableLog: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'ChatGPT',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: DashChat(
          currentUser: _currentUser,
          typingUsers: _typingUsers,
          messageOptions: const MessageOptions(),
          onSend: (ChatMessage m) {
            getChatResponse(m);
          },
          messages: _messages),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async{
    setState(() {
      _messages.insert(0, m);
      _typingUsers.add(_chatgptUser);
    });
    List<Messages> messagesHistory = _messages.reversed.map((m) {
      if ( m.user == _currentUser) {
        return Messages(role: Role.user, content: m.text);
      } else {
        return Messages(role: Role.assistant, content: m.text);
      }
    }).toList();
    final request = ChatCompleteText(
        model: GptTurbo0301ChatModel(),
        messages: messagesHistory,
        maxToken: 500);
    final response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          _messages.insert(
            0,
            ChatMessage(
                user: _chatgptUser,
                createdAt: DateTime.now(),
                text: element.message!.content),
          );
        });
      }
    }
    setState(() {
      _typingUsers.remove(_chatgptUser);
    });
  }
}
