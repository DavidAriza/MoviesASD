import 'package:movies_asd/core/utils/movie_utils.dart';
import 'package:movies_asd/domain/entities/actor.dart';

class ActorModel extends Actor {
  ActorModel({
    required super.name,
    required super.profilePath,
    required super.character,
  });

  factory ActorModel.fromJson(Map<String, dynamic> json) {
    return ActorModel(
        name: json['name'],
        profilePath: getActorImage(json),
        character: json['character']);
  }
}
