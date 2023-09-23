import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:telegram_v1/providers/theme_provider.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({super.key});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  TextEditingController _controller = TextEditingController();
  bool isVisible = true;

  void currentText() {
    print(isVisible);
    setState(() {
      isVisible = _controller.text.trim().length == 0 ? true : false;
    });
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _controller.addListener(currentText);
  }

  @override
  Widget build(BuildContext context) {
    final tp = Provider.of<ThemeProvider>(context, listen: true);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(FontAwesomeIcons.faceSmile,
              color: tp.colors["secondaryTextColor"]),
        ),
        Expanded(
          child: TextField(
            controller: _controller,
            style: TextStyle(
              color: tp.colors["textColor"],
              fontSize: 17,
            ),
            decoration: InputDecoration(
              hintText: "Message",
              hintStyle: TextStyle(
                color: tp.colors["secondaryTextColor"],
                fontSize: 17,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        Visibility(
          visible: isVisible,
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.attach_file_outlined,
              color: tp.colors["secondaryTextColor"],
              size: 30,
            ),
          ),
        ),
        isVisible
            ? IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.mic_none_outlined,
                  color: tp.colors["secondaryTextColor"],
                  size: 30,
                ),
              )
            : IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.send,
                  color: Colors.green,
                  size: 25,
                )),
      ],
    );
  }
}
