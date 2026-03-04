# Tarea 6 - Couteau (Flutter)

Aplicacion movil para la materia **Introduccion al Desarrollo de Aplicaciones Moviles**.

## Requisitos cubiertos (8 modulos)

1. **Home - Caja de Herramientas**
   - Imagen: `assets/images/cajaherramientas01.png`
   - Texto de bienvenida y descripcion general de la app.
2. **Prediccion de Genero**
   - API: `https://api.genderize.io/?name=irma`
   - Resultado visual:
     - Masculino -> `assets/images/azul.png`
     - Femenino -> `assets/images/rosa.png`
3. **Prediccion de Edad**
   - API: `https://api.agify.io/?name=meelad`
   - Imagen: `assets/images/edad.png`
   - Clasificacion mostrada en pantalla: `Joven`, `Adulto` o `Anciano`.
4. **Universidades por Pais**
   - API: `https://adamix.net/proxy.php?country=Dominican+Republic`
   - Imagen: `assets/images/univ.png`
   - Muestra nombre, dominio y enlace web de cada universidad.
5. **Clima en Republica Dominicana**
   - API (Open-Meteo): consulta del clima actual de Santo Domingo.
   - Imagen: `assets/images/clima.png`
   - Muestra temperatura, condicion, humedad y viento.
6. **Pokemon's**
   - API: `https://pokeapi.co/api/v2/pokemon/pikachu`
   - Imagen del modulo: `assets/images/pokebola.png`
   - Muestra foto del pokemon, experiencia base, habilidades y reproduce sonido (`cries.latest`).
7. **Noticias desde WordPress**
   - Imagen: `assets/images/wordpress.png`
   - API usada para el foro: `https://wordpress.org/news/wp-json/wp/v2/posts?per_page=3`
   - Muestra 3 noticias con titulo, resumen y enlace `Visitar`.
   - Cada clic en `Cargar Noticias` avanza a otra pagina de posts; al final vuelve a la pagina 1.
8. **Contactame**
   - Imagen: `assets/images/me.png`
   - Datos de contacto y texto institucional.

## Icono de la app

El icono esta configurado con foto personal usando `flutter_launcher_icons`:

- `assets/images/profile_photo.jpg`

Si cambias la imagen, regenera iconos con:

```bash
flutter pub run flutter_launcher_icons
```

## Dependencias principales

- `http`
- `url_launcher`
- `just_audio`
- `flutter_launcher_icons` (dev)

## Prerrequisitos

- Flutter SDK instalado
- Android Studio + Android SDK
- Emulador Android configurado
- Licencias Android aceptadas:

```bash
flutter doctor --android-licenses
```

## Ejecutar en simulador Android

1. Entrar al proyecto:

```bash
cd "/Users/luiscdano/Desktop/ITLA/four-month period/2026-C1/TDS-011 Introducción al Desarrollo de Aplicaciones Móviles/Tarea 6 - Couteau"
```

2. Instalar dependencias:

```bash
flutter pub get
```

3. Ver emuladores disponibles:

```bash
flutter emulators
```

4. Iniciar uno (ejemplo):

```bash
flutter emulators --launch Pixel_7
```

5. Confirmar dispositivo:

```bash
flutter devices
```

6. Ejecutar la app:

```bash
flutter run -d emulator-5554
```

Usa el ID real que te salga en `flutter devices`.

## Navegacion de la app

- Barra superior:
  - Izquierda: icono menu (abre el drawer con todos los modulos)
  - Centro: `Home`
  - Derecha: `Contactame`
- Drawer: acceso a los 8 modulos.

## Validacion tecnica

Comandos recomendados:

```bash
flutter analyze
flutter test
```

## Troubleshooting rapido

Si no aparece el emulador en `flutter devices`:

```bash
flutter emulators --launch Pixel_7
flutter devices --device-timeout 20
```

Si aun falla, abre Android Studio y levanta el AVD desde **Device Manager**.
