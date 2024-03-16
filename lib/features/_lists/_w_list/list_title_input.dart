import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_config/styling/styler.dart';
import '../../notes/_state/task_input_provider.dart';

class BoardListTitleTextForm extends StatefulWidget {
  const BoardListTitleTextForm({super.key, required this.isNewTask});

  final bool isNewTask;

  @override
  State<BoardListTitleTextForm> createState() => _BoardListTitleTextFormState();
}

class _BoardListTitleTextFormState extends State<BoardListTitleTextForm> {
  final TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    if (!widget.isNewTask) {
      setState(() {
        titleController.text = Provider.of<TaskInputProvider>(context, listen: false).taskInputData['t'];
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskInputProvider>(builder: (context, inputProvider, child) {
      return TextFormField(
        onChanged: (value) {
          inputProvider.addToTaskInputData('t', value);
        },
        controller: titleController,
        minLines: 1,
        maxLines: null,
        textInputAction: TextInputAction.next,
        style: TextStyle(fontSize: textSizeTitle, fontWeight: FontWeight.w400, color: styler.textColor()),
        decoration: InputDecoration(hintText: 'Title', hintStyle: TextStyle(fontSize: textSizeTitle, fontWeight: FontWeight.w400), border: InputBorder.none),
      );
    });
  }
}
