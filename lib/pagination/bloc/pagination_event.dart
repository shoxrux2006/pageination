part of 'pagination_bloc.dart';

@immutable
abstract class PaginationEvent {}

class PaginationInitEvent extends PaginationEvent {}

class PaginationSearchEvent extends PaginationEvent {
  final String text;

  PaginationSearchEvent(this.text);
}

class PaginationNextEvent extends PaginationEvent {
  final String text;
  PaginationNextEvent({this.text=""});
}
