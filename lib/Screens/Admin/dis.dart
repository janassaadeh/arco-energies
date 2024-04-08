import 'package:flutter/material.dart';

class CustomDismissiblePane extends StatefulWidget {

  final VoidCallback onDismissed;

  const CustomDismissiblePane({
    Key? key,
    required this.onDismissed,
  }) : super(key: key);

  @override
  _CustomDismissiblePaneState createState() => _CustomDismissiblePaneState();
}

class _CustomDismissiblePaneState extends State<CustomDismissiblePane>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _moveAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000000000),
    );
    _moveAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(-.1, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _moveAnimation,
       child: Container(
        color: Colors.red,
        width: 20,
      
      ),
    );
  }
}
