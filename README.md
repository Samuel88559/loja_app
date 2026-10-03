# loja_app

Exercício LojaApp (Flutter + Provider).

## Como rodar

Esta pasta contém `lib/`, `test/` e `pubspec.yaml`. Para gerar as pastas de
plataforma (android, web, windows...), rode dentro desta pasta:

    flutter create .
    flutter pub get
    flutter run -d chrome
    flutter test

(`flutter create .` não sobrescreve os arquivos existentes em `lib/` e `test/`.)

Se existir `test/widget_test.dart` depois do `flutter create .`, apague-o.
