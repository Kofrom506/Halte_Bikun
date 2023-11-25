import 'package:flutter/material.dart';

class GalleryCard extends StatelessWidget {
  const GalleryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: widget.event.type == TenantType.Tenant
      //     ? Colors.lightBlue[100]
      //     : widget.event.type == TenantType.Jurusan
      //     ? Colors.lightGreen[100]
      //     : widget.event.type == TenantType.Kedutaan
      //     ? Colors.red[100]
      //     : Colors.yellow[100],
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 20.0,
          top: 20.0,
          left: 15.0,
          right: 15.0,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ABC",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    " WIB",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "WIB",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "widget.event.room",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "widget.event.name" ?? "",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                // color: widget.event.type == TenantType.Tenant
                //     ? Colors.lightBlue[200]
                //     : widget.event.type == TenantType.Jurusan
                //     ? Colors.lightGreen[200]
                //     : widget.event.type == TenantType.Kedutaan
                //     ? Colors.red[200]
                //     : Colors.yellow[200],
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              // child: ClipRRect(
              //   clipBehavior: Clip.hardEdge,
              //   borderRadius: const BorderRadius.all(Radius.circular(10)),
              //   child: PictureFactory.build(
              //     widget.image ?? "",
              //     placeholder: Image.asset(
              //       "assets/logo.png",
              //       fit: BoxFit.contain,
              //     ),
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
