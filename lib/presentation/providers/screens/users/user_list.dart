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
  late List<GetUsers>? _users = [];
  late List<UserBox> _userBox = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }


  void _convertToUserBox(List<GetUsers>? users) {
    if (users == null || users.isEmpty) {
      _userBox = [];
    } else {
      for (int i = 0; i < users.length; i++) {
        _userBox.add(UserBox(
            userid: users[i].colUserId,
            name: users[i].colErabiltzaileIzena,
            surname: users[i].colErabiltzaileAbizena,
            imageUrl:
                'https://upload.wikimedia.org/wikipedia/commons/6/60/Scarlett_Johansson_by_Gage_Skidmore_2_%28cropped%29.jpg',
                ));
      }
    }
  }

  Future<void> _getData() async {
    _users = (await ApiService().getUsers())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          _convertToUserBox(_users);
        }));
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
            _userBox.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                        controller: _userScrollController,
                        itemCount: _userBox.length,
                        itemBuilder: ((context, index) {
                          return Row(
                            children: 
                            [
                              (_userBox[index]),
                            ],
                          );
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
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddNewUser()));
              },
              child: Icon(Icons.person_add_alt_1)),
        ),
      ],
    );
  }
}
