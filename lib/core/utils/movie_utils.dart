import 'package:movies_asd/core/constants/api_constants.dart';

String getPosterUrl(String? path) {
  if (path != null) {
    return ApiConstants.basePosterUrl + path;
  } else {
    return ApiConstants.moviePlaceHolder;
  }
}

String getBackdropUrl(String? path) {
  if (path != null) {
    return ApiConstants.baseBackdropUrl + path;
  } else {
    return ApiConstants.moviePlaceHolder;
  }
}

String getDate(String? date) {
  if (date == null || date.isEmpty) {
    return '';
  }

  final vals = date.split('-');
  String year = vals[0];
  int monthNb = int.parse(vals[1]);
  String day = vals[2];

  String month = '';

  switch (monthNb) {
    case 1:
      month = 'Jan';
      break;
    case 2:
      month = 'Feb';
      break;
    case 3:
      month = 'Mar';
      break;
    case 4:
      month = 'Apr';
      break;
    case 5:
      month = 'May';
      break;
    case 6:
      month = 'Jun';
      break;
    case 7:
      month = 'Jul';
      break;
    case 8:
      month = 'Aug';
      break;
    case 9:
      month = 'Sep';
      break;
    case 10:
      month = 'Oct';
      break;
    case 11:
      month = 'Nov';
      break;
    case 12:
      month = 'Dec';
      break;
    default:
      break;
  }

  return '$month $day, $year';
}

String getActorImage(Map<String, dynamic> json) {
  if (json['profile_path'] != null) {
    return ApiConstants.baseProfileUrl + json['profile_path'];
  } else {
    return ApiConstants.castPlaceHolder;
  }
}

String getVotesCount(int voteCount) {
  if (voteCount < 1000) {
    return '($voteCount)';
  }
  return '(${voteCount ~/ 1000}k)';
}

String getLength(int? runtime) {
  if (runtime == null || runtime == 0) {
    return '';
  }
  if (runtime < 60) {
    return '${runtime}m';
  }
  if (runtime % 60 == 0) {
    return '${runtime ~/ 60}h';
  }
  return '${runtime ~/ 60}h ${runtime % 60}m';
}

String getGenres(List<dynamic> genres) {
  if (genres.isNotEmpty) {
    return genres.first['name'];
  } else {
    return '';
  }
}
