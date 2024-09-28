import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:record/record.dart'; // For recording audio
import 'package:audioplayers/audioplayers.dart'; // For audio playback
import 'package:audio_waveforms/audio_waveforms.dart'; // For waveform visualization

class ConversationPage extends StatefulWidget {
  const ConversationPage({super.key});

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _messages = [];

  final AudioRecorder _record = AudioRecorder(); // Concrete class for recording
  final AudioPlayer _audioPlayer =
      AudioPlayer(); // Concrete class for audio playback

  bool _isRecording = false;
  RecorderController _recorderController =
      RecorderController(); // Controller for waveform visualization

  @override
  void initState() {
    super.initState();
    _recorderController = RecorderController();
  }

  void _sendMessage({
    required String message,
    required bool isVoiceMessage,
    String? voicePath,
  }) {
    if (message.isNotEmpty || (isVoiceMessage && voicePath != null)) {
      setState(() {
        _messages.add({
          'message': message,
          'timestamp': DateTime.now(),
          'isSender': true,
          'isVoiceMessage': isVoiceMessage,
          'voicePath': voicePath,
        });
        _messageController.clear();
      });
      _scrollToBottom();
    }
  }

  Future<void> _startRecording() async {
    setState(() {
      _isRecording = true;
    });

    // Start recording and display waveform
    // await _record.start(const RecordConfig(), path: 'aFullPath/myFile.m4a');
  }

  Future<void> _stopRecording() async {
    setState(() {
      _isRecording = false;
    });
  }

  Future<void> _playRecording(String path) async {
    await _audioPlayer.play(DeviceFileSource(path));
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 28, 118, 235),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final messageData = _messages[index];
                return _buildMessageBubble(
                  messageData['message'],
                  messageData['timestamp'],
                  messageData['isSender'],
                  messageData['isVoiceMessage'],
                  messageData['voicePath'],
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(
    String message,
    DateTime timestamp,
    bool isSender,
    bool isVoiceMessage,
    String? voicePath,
  ) {
    final time = DateFormat('h:mm a').format(timestamp);
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 28, 118, 235),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft:
                isSender ? const Radius.circular(15) : const Radius.circular(0),
            bottomRight:
                isSender ? const Radius.circular(0) : const Radius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isVoiceMessage && voicePath != null
                ? IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () => _playRecording(voicePath),
                  )
                : Text(
                    message,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                time,
                style: const TextStyle(
                    fontSize: 12, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Text input field
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type a message',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // Send text message button
          IconButton(
            icon: const Icon(
              Icons.send,
              color: Color.fromARGB(255, 28, 118, 235),
            ),
            onPressed: () => _sendMessage(
              message: _messageController.text,
              isVoiceMessage: false,
            ),
          ),
          // Record voice message button
          IconButton(
            icon: Icon(
              _isRecording ? Icons.stop : Icons.mic,
              color: _isRecording
                  ? Colors.red
                  : const Color.fromARGB(255, 28, 118, 235),
            ),
            onPressed: _isRecording ? _stopRecording : _startRecording,
          ),
        ],
      ),
    );
  }
}
