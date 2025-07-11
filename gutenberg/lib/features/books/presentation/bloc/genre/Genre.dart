import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final String name;
  final String icon;

  const Genre({required this.name, required this.icon});

  @override
  List<Object?> get props => [name, icon];
}
