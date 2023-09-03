import 'package:flutter/material.dart';

class ListProductCard extends StatelessWidget {
  final String? name;
  final String? price;
  final String? description;
  final String? category;
  final String? image;
  final VoidCallback? editPressed;
  final VoidCallback? deletePressed;
  const ListProductCard({
    super.key,
    this.name,
    this.description,
    this.price,
    this.category,
    this.image,
    this.editPressed,
    this.deletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            image!.isNotEmpty
                ? Image.network(
                    image ?? '-',
                    width: MediaQuery.of(context).size.width * .05,
                    height: MediaQuery.of(context).size.width * .05,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        );
                      }
                    },
                  )
                : const Icon(
                    Icons.image,
                    size: 70,
                  ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? '-',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(price ?? '-'),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(description ?? '-'),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(category ?? '-'),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(image ?? '-'),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: editPressed,
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: deletePressed,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
