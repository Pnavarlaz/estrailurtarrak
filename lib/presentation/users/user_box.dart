import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class UserBox extends StatelessWidget {
  final String name;
  final String surname;
  final String imageUrl;

  const UserBox({super.key, 
    required this.name,
    required this.surname,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: const Color.fromARGB(0x0A , 0, 0xDA, 0xDA),
            border: const GradientBoxBorder(
              gradient: LinearGradient(
                  colors: [Color(0x9000DADA), Color(0x909747FF),],
              ),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  imageUrl,
                ),
              ),
              const SizedBox(width: 6),
              Text(name),
              const SizedBox(width: 3),
              Text(surname),
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
