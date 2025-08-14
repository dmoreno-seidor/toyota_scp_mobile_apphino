# Hino App

## Dependencias

1. Instalarse Visual Studio Code
2. Instalar Flutter
3. Instalar los siguientes Pluggins en Visual Studio

## Getting Started

flutter clean : Sirve para limpiar el proyecto
En visual studio se debe seguir los siguientes pasos :

1. Control + Shift + P (Windows) || Command + Shift + P
2. Select Devide (iOs o Android)
3. Una vez seleccionado el dispositivo presionar F5 y disfrutar del App.

## Documentación Flutter

- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Despligues Android

- [Preparando para release una app Android](https://flutter-es.io/docs/deployment/android)

Para realizar los despliegues del App de Android crear un archivo key.properties dentro de la carpeta android. Una vez creado dicho archivo lo rellenamos con los siguientes valores :

storePassword=123456789\
keyPassword=123456789\
keyAlias=key\
storeFile=/Users/guillermoeduardonarvaezmuggi/key.jks

Nota : Recuerda que el archivo key.jks ubicado en la ruta : Certificados/android/LlaveFirmarApp/key.jks tiene que guardarse dentro de tus documentos. Una vez guardado dicho archivo localizamos la ruta y la sobreescribimos en el storeFile del archivo android/key.properties

## Generar APKs a instalar en dispositivos Físicos

- [To split the APKs per ABI](https://developer.android.com/studio/build/configure-apk-splits#configure-abi-split)

To split the APKs per ABI, run:
flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi
Learn more on: https://developer.android.com/studio/build/configure-apk-splits#configure-abi-split

## Generar App Bundle para Google Plat Console - TIENDA

- [To generate an app bundle](https://developer.android.com/guide/app-bundle)

To generate an app bundle, run:
flutter build appbundle --target-platform android-arm,android-arm64,android-x64
Learn more on: https://developer.android.com/guide/app-bundle
