import 'package:estrailurtarrak/helpers/api_calls.dart';
import 'package:estrailurtarrak/presentation/providers/screens/users/add_new_user.dart';
import 'package:estrailurtarrak/presentation/users/user_box.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  late List<GetUsers> _users = [];
  late List<GetUsers> users = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    _users = (await ApiService().getUsers())!;
    setState(() {
      users = _users;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _userScrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Erabiltzaileak'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            users.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                        controller: _userScrollController,
                        itemCount: users.length,
                        itemBuilder: ((context, index) {
                          return (UserBox(
                              userid: users[index].colUserId,
                              name: users[index].colErabiltzaileIzena,
                              surname: users[index].colErabiltzaileAbizena,
                              imageUrl:
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxaMAuDlm9OC8CXkmZfYjYsICTL_nQ-f7wIw&usqp=CAU'));
                        })),
                  ),
            UserListButtons(),
          ],
        ),
      )),
    );
  }
}

class UserListButtons extends StatelessWidget {
  const UserListButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ))),
              child: Row(
                children: [
                  Icon(Icons.calendar_month_rounded),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Ekitaldiak')
                ],
              )),
        ),
        Expanded(child: SizedBox()),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ))),
              onPressed: () async {
                bool? result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddNewUser()));
                if(result != null && result)
                {

                }
              },
              child: Icon(Icons.person_add_alt_1)),
        ),
      ],
    );
  }
}
