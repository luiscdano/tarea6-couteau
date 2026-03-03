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

## Prerrequisitos

- Flutter SDK instalado (`flutter --version`).
- Android Studio instalado.
- Android SDK + Android Emulator configurados.
- Licencias aceptadas:

```bash
flutter doctor --android-licenses
```

## Ejecutar en emulador Android (paso a paso)

1. Entrar al proyecto:

```bash
cd "/Users/luiscdano/Desktop/ITLA/four-month period/2026-C1/TDS-011 Introducción al Desarrollo de Aplicaciones Móviles/Tarea 6 - Couteau"
```

2. Descargar dependencias:

```bash
flutter pub get
```

3. (Opcional, si cambias la foto del icono) regenerar iconos:

```bash
flutter pub run flutter_launcher_icons
```

4. Ver emuladores disponibles:

```bash
flutter emulators
```

5. Iniciar un emulador Android (ejemplo del proyecto):

```bash
flutter emulators --launch Pixel_7
```

6. Confirmar que el emulador aparezca conectado:

```bash
flutter devices
```

Debe aparecer algo como `emulator-5554`.

7. Ejecutar la app en Android:

```bash
flutter run -d emulator-5554
```

Tambien puedes usar el id exacto que te salga en `flutter devices`.

## Como revisar visualmente la tarea

Cuando la app abra en el emulador, usa las pestañas superiores:

- `Caja`
- `Genero`
- `Edad`
- `Universidades`
- `Clima RD`
- `Pokemon`
- `WordPress`
- `Acerca de`

Asi validas los 8 requerimientos de forma visual.

## Troubleshooting rapido

Si `flutter devices` no muestra el emulador:

```bash
flutter emulators --launch Pixel_7
flutter devices --device-timeout 20
```

Si aun no aparece, abrir Android Studio y arrancar el AVD desde **Device Manager**.

## Validacion ejecutada en este proyecto

```bash
flutter analyze
flutter test
```

Sin errores de analisis y pruebas basicas pasando.
