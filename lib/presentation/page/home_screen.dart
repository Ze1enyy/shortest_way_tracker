import 'package:best_way_tracker/presentation/page/process_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();

  bool _isUrlValid = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _isUrlValid = Uri.parse(_controller.text).isAbsolute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
      ),
      body: Column(
        children: [
          const Text('Set valid API base url in order to continue'),
          TextField(
            controller: _controller,
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              !_isUrlValid
                  ? showAboutDialog(
                      context: context,
                      children: [const Text('Error')],
                    )
                  : Navigator.push(
                      context,
                      MaterialPageRoute<ProcessScreen>(
                        builder: (context) {
                          return ProcessScreen(
                            url: _controller.text,
                          );
                        },
                      ),
                    );
            },
            child: const Text('Start counting process'),
          ),
        ],
      ),
    );
  }
}
