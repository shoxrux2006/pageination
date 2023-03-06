part of 'texnomart_bloc.dart';

@immutable
abstract class TexnomartEvent {}

class TexnomartInitEvent extends TexnomartEvent {
  final String text;
  TexnomartInitEvent(this.text);
}

class TexnomartSearchEvent extends TexnomartEvent {
  final String text;
  TexnomartSearchEvent(this.text);
}

class TexnomartNextEvent extends TexnomartEvent {
  final String text;
  TexnomartNextEvent({this.text=""});
}

