import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/models/note.dart';
import 'package:frontend/pages/new_page.dart';
import 'package:frontend/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
            child: (notesProvider.notes.isNotEmpty) ? GridView.builder(
          itemCount: notesProvider.notes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            Note currNote = notesProvider.notes[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(
                  builder: (context) => AddPage(isUpdate: true, note: currNote,),
                ));
              },
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Delete Note"),
                        content: const Text(
                            "Are you sure you want to delete this note?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              notesProvider.deleteNote(currNote);
                              Navigator.of(context).pop();
                            },
                            child: const Text("Delete"),
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(4, 4),
                          color: Color.fromARGB(255, 73, 70, 70),
                          blurRadius: 15,
                          spreadRadius: 1),
                      BoxShadow(
                        offset: Offset(-4, -4),
                        color: Colors.white,
                        blurRadius: 15,
                        spreadRadius: 1,
                      )
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromARGB(255, 159, 121, 209)),
                margin: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currNote.title!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      currNote.content!,
                      style: TextStyle(fontSize: 15, color: Colors.grey[300]),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            );
          },
        ) : const Center(
          child: Text("No notes here"),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => const AddPage(isUpdate: false, note: null),
                  fullscreenDialog: true));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
