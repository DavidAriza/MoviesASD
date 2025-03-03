import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_asd/domain/entities/actor.dart';
import 'package:shimmer/shimmer.dart';

class Cast extends StatelessWidget {
  final List<Actor> cast;
  const Cast({
    super.key,
    required this.cast,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Cast',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: size.height * 0.25,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cast.length,
              itemBuilder: (BuildContext context, int index) {
                final actor = cast[index];
                return Container(
                  width: 120,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: actor.profilePath!,
                          height: size.height * 0.2,
                          fit: BoxFit.fitWidth,
                          placeholder: (_, __) => Shimmer.fromColors(
                            baseColor: Colors.grey[400]!,
                            highlightColor: Colors.grey[200]!,
                            child: Container(
                              height: (size.height * 0.2) * 0.75,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Flexible(child: Text(actor.character!)),
                      Flexible(child: Text(actor.name!)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
