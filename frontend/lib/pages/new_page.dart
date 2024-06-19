import 'package:flutter/material.dart';
import 'package:frontend/models/note.dart';
import 'package:frontend/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddPage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddPage({super.key, required this.isUpdate, this.note});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  FocusNode noteFocus = FocusNode();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  void addNewNote() {
    Note newNote = Note(
        id: const Uuid().v1(),
        userId: "abcd@kk.com",
        title: titleController.text,
        content: contentController.text,
        createdAt: DateTime.now());

    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  void updateNote() {
    widget.note!.title = titleController.text;
    widget.note!.content = contentController.text;
    Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (widget.isUpdate) {
                updateNote();
              } else {
                addNewNote();
              }
            },
          )
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          children: [
            TextField(
                controller: titleController,
                autofocus: (widget.isUpdate == true) ? false : true,
                onSubmitted: (value) {
                  if (value != "") {
                    noteFocus.requestFocus();
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
            Expanded(
              child: TextField(
                  controller: contentController,
                  focusNode: noteFocus,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Note',
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                  )),
            ),
          ],
        ),
      )),
    );
  }
}
