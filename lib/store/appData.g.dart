// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appData.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppData on _AppData, Store {
  late final _$isDarkAtom = Atom(name: '_AppData.isDark', context: context);

  @override
  bool get isDark {
    _$isDarkAtom.reportRead();
    return super.isDark;
  }

  @override
  set isDark(bool value) {
    _$isDarkAtom.reportWrite(value, super.isDark, () {
      super.isDark = value;
    });
  }

  late final _$modeAtom = Atom(name: '_AppData.mode', context: context);

  @override
  ThemeMode get mode {
    _$modeAtom.reportRead();
    return super.mode;
  }

  @override
  set mode(ThemeMode value) {
    _$modeAtom.reportWrite(value, super.mode, () {
      super.mode = value;
    });
  }

  late final _$_AppDataActionController =
      ActionController(name: '_AppData', context: context);

  @override
  void toggle() {
    final _$actionInfo =
        _$_AppDataActionController.startAction(name: '_AppData.toggle');
    try {
      return super.toggle();
    } finally {
      _$_AppDataActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDark: ${isDark},
mode: ${mode}
    ''';
  }
}
