import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class UserSelection {
  bool isSelected;
  UserSelection({this.isSelected = false});
}

class UserBox extends StatefulWidget {
  final int userid;
  final String name;
  final String surname;
  final String imageUrl;
  final bool selectable;
  final bool isSelected;
  final bool deletable;

  UserBox({
    super.key,
    required this.userid,
    required this.name,
    required this.surname,
    required this.imageUrl,
    this.selectable = false,
    this.isSelected = false,
    this.deletable = false,
  });

  @override
  State<UserBox> createState() => _UserBoxState();
}

class _UserBoxState extends State<UserBox> {
  void unsetSelected() {
    setState(() {
      edge = unselectedEdge;
      color = unselectedColor;
    });
  }

  final List<Color> unselectedEdge = [
    Color(0x9000DADA),
    Color(0x909747FF),
  ];

  final List<Color> selectedEdge = [
    Color(0x9000DADA),
    Color(0x909747FF),
  ];

  final Color unselectedColor = Color.fromARGB(0x0A, 0, 0xDA, 0xDA);
  final Color selectedColor = Color.fromARGB(0x1A, 0, 0xDA, 0xDA);

  Color color = Color.fromARGB(0x0A, 0, 0xDA, 0xDA);

  List<Color> edge = [
    Color(0x9000DADA),
    Color(0x909747FF),
  ];

  @override
  Widget build(BuildContext context) {
    Widget selectedIcon = widget.selectable
        ? (widget.isSelected
            ? Icon(
                Icons.check_box_outlined,
                color: Color.fromARGB(0x90, 0x97, 0x47, 0xFF),
              )
            : Icon(Icons.check_box_outline_blank_outlined,
                color: Color.fromARGB(
                  0x90,
                  0x97,
                  0x47,
                  0xFF,
                )))
        : SizedBox();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: color,
            border: GradientBoxBorder(
              gradient: LinearGradient(
                colors: edge,
              ),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  widget.imageUrl,
                ),
              ),
              const SizedBox(width: 6),
              Text(widget.name),
              const SizedBox(width: 3),
              Text(widget.surname),
              Expanded(child: SizedBox()),
              selectedIcon,
              widget.deletable
                  ? IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                    )
                  : SizedBox(),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
