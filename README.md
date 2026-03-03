# Tarea 6 - Couteau (Flutter)

Aplicacion movil desarrollada para la materia **Introduccion al Desarrollo de Aplicaciones Moviles**.

## Requisitos implementados

1. Vista con foto de caja de herramientas (`cajaherramientas01.png` y `cajaherramientas02.png`).
2. Prediccion de genero por nombre con Genderize (`https://api.genderize.io/?name=irma`).
   - Masculino: se muestra imagen azul.
   - De lo contrario: se muestra imagen rosa.
3. Prediccion de edad por nombre con Agify (`https://api.agify.io/?name=meelad`).
   - Clasifica en joven, adulto o anciano.
   - Muestra edad numerica e imagen relacionada.
4. Consulta de universidades por pais con Adamix Proxy (`https://adamix.net/proxy.php?country=Dominican+Republic`).
   - Muestra nombre, dominio y enlace web.
5. Clima en RD (Santo Domingo) para el dia actual con Open-Meteo.
6. Consulta de Pokemon con PokeAPI (`https://pokeapi.co/api/v2/pokemon/pikachu`).
   - Muestra foto, experiencia base, habilidades y sonido (campo `cries.latest`).
7. Noticias WordPress: logo + ultimas 3 publicaciones con resumen y enlace original.
   - API usada (publicada para foro): `https://wordpress.org/news/wp-json/wp/v2/posts?per_page=3`
8. Vista "Acerca de" con foto y datos de contacto.

## Icono de la app

El icono esta configurado con foto personal usando `flutter_launcher_icons` desde:

- `assets/images/profile_photo.jpg`

## Dependencias principales

- `http`
- `url_launcher`
- `just_audio`
- `flutter_launcher_icons` (dev)

## Ejecutar el proyecto

```bash
flutter pub get
flutter pub run flutter_launcher_icons
flutter run
```

## Validacion ejecutada

```bash
flutter analyze
flutter test
```

Sin errores de analisis y pruebas basicas pasando.
