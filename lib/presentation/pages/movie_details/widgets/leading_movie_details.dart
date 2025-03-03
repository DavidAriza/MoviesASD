import 'package:flutter/material.dart';

class LeadingMovieDetails extends StatelessWidget {
  const LeadingMovieDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Theme.of(context).scaffoldBackgroundColor,
          size: 20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
