import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile(
      {required this.onTap,
      required this.title,
      required this.imageUrl,
      this.imageAlignment = Alignment.center,
      Key? key})
      : super(key: key);
  final String title;
  final String imageUrl;
  final Function onTap;

  /// Which part of the image to prefer
  final Alignment imageAlignment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "",
              color: Colors.grey.shade600,
              colorBlendMode: BlendMode.darken,
              alignment: imageAlignment,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.blueGrey.shade50,
                      fontWeight: FontWeight.bold,
                      fontSize: 36
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
