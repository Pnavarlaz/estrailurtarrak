import 'package:estrailurtarrak/helpers/api_calls.dart';
import 'package:flutter/material.dart';

class AddNewUser extends StatefulWidget {
  const AddNewUser({super.key});

  @override
  State<AddNewUser> createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  final _nameKey = GlobalKey<FormState>();
  final _surnameKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameTextController = TextEditingController();
    TextEditingController _surnameTextController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Erabiltzailea sortu'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Expanded(
                child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Izena jarri";
                    }
                    return null;
                  },
                  key: _nameKey,
                  controller: _nameTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Erabiltzaile izena',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Abizena jarri";
                    }
                    return null;
                  },
                  key: _surnameKey,
                  controller: _surnameTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Erabiltzaile abizena',
                  ),
                ),
              ],
            )),
            Row(
              children: [
                Expanded(child: SizedBox()),
                ElevatedButton(
                    onPressed: () {
                      if (_nameTextController.text.isNotEmpty &&
                          _surnameTextController.text.isNotEmpty) {
                        ApiService().addNewUser(
                            _nameTextController.text,
                            _surnameTextController.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    child: const Text('Erabiltzailea gehitu'))
              ],
            )
          ],
        ),
      )),
    );
  }
}
