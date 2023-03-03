# movies

Projecto hecho en Flutter basado en peliculas.

## Installation

Para la instalación de este proyecto se debe estar autenticado en MovieDB(<https://developers.themoviedb.org/3/getting-started/introduction>), de este sitio web, se obtiene la API Key, y esta debe registrarse en un archivo ![.env.development].

El archivo .env debe ubicarse en la raíz del proyecto, como muestra la imagen:

![Imagen](/assets/images/instruction_one.png)

Luego se agregan los campos que son necesarios para el consumo de la API

![Imagen](/assets/images/instruction_two.png)

## Usage

Versión del proyecto: 

**Flutter version 3.7.5 - channel stable**
**Dart version 2.19.2**

Para su uso es necesario los siguientes comandos
```dart
flutter clean
```

```dart
flutter pub get
```

```dart
flutter pub run build_runner build --delete-conflicting-outputs
```


# DEMO

![Imagen](/assets/clips/movie_clip.gif)

## Contributing

Se aceptan pull requests. Para cambios mayores, por favor abra un issue primero, para discutir el cambio.

Asegúrese de actualizar las pruebas según corresponda.

## License

[MIT](https://choosealicense.com/licenses/mit/)
