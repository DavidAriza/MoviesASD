import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        childCount: 1,
      ),
    );
  }
}
