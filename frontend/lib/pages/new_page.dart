import 'package:flutter/material.dart';
import 'package:frontend/models/note.dart';
import 'package:frontend/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              addNewNote();
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
                autofocus: true,
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
