import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

const String kN8nWebhookUrl = 'https://sangam-chat.onrender.com/webhook/sangam_chatbot';
const String kSessionId = 'flutter-user-session-001';

class ChatMessage {
  final String text;
  final bool isUserMessage;

  ChatMessage({required this.text, required this.isUserMessage});
}

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _messages.add(ChatMessage(
      text: 'Namaste! I am Sangam Sathi. How can I help you plan your Ujjain yatra?',
      isUserMessage: false,
    ));
  }

  Future<void> _handleSubmitted(String text) async {
    if (text.trim().isEmpty) return;
    _textController.clear();
    setState(() {
      _messages.insert(0, ChatMessage(text: text.trim(), isUserMessage: true));
      _isLoading = true;
    });

    try {
      final Uri baseUri = Uri.parse(kN8nWebhookUrl);
      final Uri altUri = Uri.parse(kN8nWebhookUrl.endsWith('/') ? kN8nWebhookUrl : '$kN8nWebhookUrl/');

      Future<http.Response> post(Uri u) => http
          .post(
            u,
            headers: <String, String>{'Content-Type': 'application/json'},
            // CORRECT
            body: json.encode({
            'sessionId': kSessionId,
            'text': text,            
            }),
          )
          .timeout(const Duration(seconds: 20));

      Future<http.Response> get(Uri u) => http
        .get(
        u.replace(queryParameters: {
            'sessionId': kSessionId,
            'output': text,
        }),
        )
        .timeout(const Duration(seconds: 100));

      http.Response response = await post(baseUri);
      if (response.statusCode == 404) {
        response = await post(altUri);
      }
      if (response.statusCode == 404) {
        response = await get(baseUri);
      }
      if (response.statusCode == 404) {
        response = await get(altUri);
      }

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        String botReply = 'Sorry, I could not understand that.';

        botReply=responseData[0]['output'] as String;
        print(botReply);
        print(responseData);
        setState(() {
          _messages.insert(0, ChatMessage(text: botReply, isUserMessage: false));
        });
      } else {
        final String trimmed = response.body.toString();
        _showError('Could not reach Shipra Sathi (${response.statusCode}). Path: ${response.request?.url}\n$trimmed');
      }
    } catch (e) {
      _showError('Network error. ${e.runtimeType}');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showError(String message) {
    setState(() {
      _messages.insert(0, ChatMessage(text: message, isUserMessage: false));
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sangam Sathi',
          style: GoogleFonts.rajdhani(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(12.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) {
                final ChatMessage message = _messages[index];
                return _buildMessageBubble(message, primary);
              },
            ),
          ),
          if (_isLoading) const LinearProgressIndicator(minHeight: 2),
          const Divider(height: 1),
          Container(
            color: Theme.of(context).cardColor,
            child: _buildComposer(primary),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message, Color primary) {
    final bool isUser = message.isUserMessage;
    final Color bg = isUser ? primary.withOpacity(0.12) : Colors.grey.shade200;
    final Color border = isUser ? primary.withOpacity(0.35) : Colors.grey.shade300;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: border),
              ),
              child: Text(
                message.text,
                style: GoogleFonts.openSans(fontSize: 14, color: Colors.black87, height: 1.4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComposer(Color primary) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration(
                  hintText: 'Ask a question...'
                      ,
                  hintStyle: GoogleFonts.openSans(color: Colors.grey.shade600),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primary),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
            SizedBox(
              height: 44,
              width: 44,
              child: ElevatedButton(
                onPressed: () => _handleSubmitted(_textController.text),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                ),
                child: const Icon(Icons.send, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


