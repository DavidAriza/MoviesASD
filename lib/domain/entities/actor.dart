import 'package:equatable/equatable.dart';

class Actor extends Equatable {
  final String? name;
  final String? profilePath;
  final String? character;

  Actor({
    this.name,
    this.character,
    this.profilePath,
  });

  @override
  List<Object?> get props => [name, profilePath, character];
}
