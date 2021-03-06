import 'package:flutter/material.dart';
import 'package:practise/notes/notes_list_view.dart';
import 'package:practise/services/auth_service.dart';
import 'package:practise/services/crud/notes_service.dart';
import '../constants/routes.dart';
import '../enums/menu_action.dart';
import '../utilities/dialog/logout_dialog.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final NotesService _notesService;
  String get userEmail => AuthService.firebase().currentUser!.email!;

  @override
  void initState() {
    _notesService = NotesService();
    _notesService.open();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
          },
              icon: const Icon(Icons.add),
          ),
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (_) => false,
                    );
                  }
                //  devtools.log(shouldLogout.toString());
                //   break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _notesService.getOrCreateUser(email: userEmail),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return StreamBuilder(
                stream: _notesService.allNotes,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      if(snapshot.hasData){
                        final allNotes=snapshot.data as List<DatabaseNote>;
                               return NotesListView(
                                   notes: allNotes,
                                   onDeleteNote:(note) async {
                  await _notesService.deleteNote(id: note.id);
                        },
                                 onTap:(note) { //async should be used

                                 Navigator.of(context).pushNamed(createOrUpdateNoteRoute,
                                     arguments: note,
                                 );
                               },
                               );
                                   }else
                                   {
                        return const CircularProgressIndicator();
                      }

                    default:
                      return const CircularProgressIndicator();
                  }
                },
              );
            default:
              return const CircularProgressIndicator();
                        }
        },
      ),
    );
  }
}


