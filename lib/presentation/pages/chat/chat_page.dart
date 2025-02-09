import 'package:chatgpt/domain/repository/app_repository.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final AppRepository _openAIRepository = AppRepository();
  final List<ChatMessage> _messages = <ChatMessage>[];
  final List<ChatUser> _typingUsers = <ChatUser>[];

  final ChatUser _currentUser = ChatUser(
    id: '1',
    firstName: 'Praful',
    lastName: 'Korat',
  );
  final ChatUser _assistantUser = ChatUser(
    id: '2',
    firstName: 'Chat',
    lastName: 'GPT',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1c1b20),
        title: const Text(
          'ChatGPT',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF1c1b20),
      body: Stack(children: [
        if (_messages.isEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 56),
            child: Center(
              child: Image.asset('assets/images/ic_gpt.png',
                  width: 60, height: 60, color: Colors.white),
            ),
          ),
        DashChat(
            messageListOptions: const MessageListOptions(
              scrollPhysics: BouncingScrollPhysics(),
            ),
            typingUsers: _typingUsers,
            messageOptions: const MessageOptions(
              currentUserContainerColor: Colors.black,
              containerColor: Color(0xFF333237),
              textColor: Colors.white,
            ),
            currentUser: _currentUser,
            onSend: (ChatMessage m) {
              getChatResponse(m);
            },
            messages: _messages)
      ]),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0, m);
      _typingUsers.add(_assistantUser);
    });

    try {
      List<ChatMessage> responseMessages =
          await _openAIRepository.getChatResponse(_messages);
      setState(() {
        _messages.insertAll(0, responseMessages);
      });
      setState(() {
        _typingUsers.remove(_assistantUser);
      });
    } catch (e) {
      print('Error: $e');
    }
  }
}
