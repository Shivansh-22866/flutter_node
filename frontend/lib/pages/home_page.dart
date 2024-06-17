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
            child: GridView.builder(
          itemCount: notesProvider.notes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            Note currNote = notesProvider.notes[index];
            return Container(
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
                  Text(currNote.title!, style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,),
                  Text(currNote.content!, style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[300]
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,)
                ],
              ),
            );
          },
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => const AddPage(),
                  fullscreenDialog: true));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
