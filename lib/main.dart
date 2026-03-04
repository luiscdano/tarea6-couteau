import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:url_launcher/url_launcher.dart';

const String _toolboxImage1Path = 'assets/images/cajaherramientas01.png';
const String _maleImagePath = 'assets/images/azul.png';
const String _femaleImagePath = 'assets/images/rosa.png';
const String _pokemonModuleImagePath = 'assets/images/pokebola.png';
const String _ageModuleImagePath = 'assets/images/edad.png';
const String _universitiesModuleImagePath = 'assets/images/univ.png';
const String _weatherModuleImagePath = 'assets/images/clima.png';
const String _wordpressModuleImagePath = 'assets/images/wordpress.png';
const String _aboutImagePath = 'assets/images/me.png';

const String _genderApi = 'https://api.genderize.io/';
const String _ageApi = 'https://api.agify.io/';
const String _universitiesApi = 'https://adamix.net/proxy.php';
const String _weatherApi =
    'https://api.open-meteo.com/v1/forecast?latitude=18.4861&longitude=-69.9312&current=temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m&timezone=America%2FSanto_Domingo';
const String _pokemonApi = 'https://pokeapi.co/api/v2/pokemon/';
const String _wordpressApi = 'https://wordpress.org/news/wp-json/wp/v2/posts';

void main() {
  runApp(const CouteauApp());
}

class CouteauApp extends StatelessWidget {
  const CouteauApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarea 6 - Couteau',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0D47A1),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  static const List<String> _menuTitles = [
    'Home',
    'Genero',
    'Edad',
    'Universidades',
    'Clima RD',
    'Pokemon',
    'WordPress',
    'Contactame',
  ];

  static const List<IconData> _menuIcons = [
    Icons.home,
    Icons.wc,
    Icons.cake,
    Icons.school,
    Icons.cloud,
    Icons.catching_pokemon,
    Icons.newspaper,
    Icons.person,
  ];

  static const List<Widget> _screens = [
    ToolboxScreen(),
    GenderScreen(),
    AgeScreen(),
    UniversitiesScreen(),
    WeatherScreen(),
    PokemonScreen(),
    WordpressScreen(),
    AboutScreen(),
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final appBarTitleStyle =
        Theme.of(context).appBarTheme.titleTextStyle ??
        Theme.of(context).textTheme.titleLarge;
    final appBarTextColor =
        appBarTitleStyle?.color ??
        Theme.of(context).appBarTheme.foregroundColor ??
        Theme.of(context).colorScheme.onSurface;
    final appBarIconSize = ((appBarTitleStyle?.fontSize ?? 20) + 8).toDouble();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        actionsPadding: const EdgeInsets.only(right: 28),
        leading: IconButton(
          iconSize: appBarIconSize,
          icon: Icon(Icons.menu, size: appBarIconSize),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          tooltip: 'Menu',
        ),
        title: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: appBarTextColor,
            textStyle: appBarTitleStyle,
            padding: const EdgeInsets.symmetric(horizontal: 4),
          ),
          onPressed: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
          child: const Text('Home'),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: appBarTextColor,
              textStyle: appBarTitleStyle,
              padding: const EdgeInsets.symmetric(horizontal: 4),
            ),
            onPressed: () {
              setState(() {
                _selectedIndex = 7;
              });
            },
            child: const Text('Contactame'),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 8),
              const Text(
                'Modulos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: _menuTitles.length,
                  itemBuilder: (context, index) {
                    final selected = _selectedIndex == index;
                    return ListTile(
                      leading: Icon(_menuIcons[index]),
                      title: Text(
                        _menuTitles[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: selected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      selected: selected,
                      onTap: () => _selectScreen(index),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(index: _selectedIndex, children: _screens),
    );
  }
}

class ToolboxScreen extends StatelessWidget {
  const ToolboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Home - Caja de Herramientas',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 28),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD5DCE6)),
              ),
              child: Image.asset(
                _toolboxImage1Path,
                width: double.infinity,
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 28),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD5DCE6)),
              ),
              child: Text(
                'Bienvenido a la Caja de Herramientas. Esta aplicacion reune '
                'diferentes utilidades en un solo lugar: prediccion de genero, '
                'estimacion de edad, consulta de universidades, clima en '
                'Republica Dominicana, datos de Pokemon, noticias desde '
                'WordPress y un apartado "Acerca de" con mi informacion de '
                'contacto. Selecciona un modulo para comenzar.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  final TextEditingController _nameController = TextEditingController();

  bool _isLoading = false;
  String? _error;
  GenderResult? _result;

  @override
  void initState() {
    super.initState();
    _nameController.text = 'irma';
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _predictGender() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() {
        _error = 'Escribe un nombre para predecir el genero.';
        _result = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final uri = Uri.parse(
        '$_genderApi?name=${Uri.encodeQueryComponent(name)}',
      );
      final response = await http.get(uri).timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw Exception('Error HTTP ${response.statusCode}');
      }

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final gender = GenderResult.fromJson(json);

      if (!mounted) {
        return;
      }

      setState(() {
        _result = gender;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _error = 'No se pudo consultar Genderize: $error';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = _result;
    final isMale = result?.gender.toLowerCase() == 'male';
    final color = isMale ? const Color(0xFFE3F2FD) : const Color(0xFFFCE4EC);
    final borderColor = isMale
        ? const Color(0xFF1E88E5)
        : const Color(0xFFD81B60);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Prediccion de Genero',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD5DCE6)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Este modulo permite estimar el genero de una persona a '
                    'partir de su nombre utilizando una API externa. La '
                    'aplicacion analiza el nombre ingresado y muestra el '
                    'resultado mediante un indicador visual.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 12),
                  const Text('• Bandera azul: Masculino'),
                  const SizedBox(height: 6),
                  const Text('• Bandera rosa: Femenino'),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _predictGender(),
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: _isLoading ? null : _predictGender,
                  icon: const Icon(Icons.search),
                  label: const Text('Predecir'),
                ),
              ],
            ),
            const SizedBox(height: 18),
            if (_isLoading) const LinearProgressIndicator(),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
            if (result != null) ...[
              const SizedBox(height: 22),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: borderColor, width: 1.5),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre analizado: ${result.name}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      isMale
                          ? 'Genero detectado: Masculino'
                          : 'Genero detectado: Femenino',
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Probabilidad: ${(result.probability * 100).toStringAsFixed(1)}%',
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: borderColor, width: 1.2),
                      ),
                      child: Image.asset(
                        isMale ? _maleImagePath : _femaleImagePath,
                        height: 280,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  final TextEditingController _nameController = TextEditingController();

  bool _isLoading = false;
  String? _error;
  AgeResult? _result;

  @override
  void initState() {
    super.initState();
    _nameController.text = 'meelad';
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _predictAge() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() {
        _error = 'Escribe un nombre para estimar edad.';
        _result = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final uri = Uri.parse('$_ageApi?name=${Uri.encodeQueryComponent(name)}');
      final response = await http.get(uri).timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw Exception('Error HTTP ${response.statusCode}');
      }

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final age = AgeResult.fromJson(json);

      if (!mounted) {
        return;
      }

      setState(() {
        _result = age;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _error = 'No se pudo consultar Agify: $error';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = _result;
    final stage = _stageFor(result?.age);
    final category = _labelFor(stage);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Prediccion de Edad',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD5DCE6)),
              ),
              child: Text(
                'Este modulo permite estimar la edad probable de una persona '
                'a partir de su nombre utilizando una API externa. Segun la '
                'edad estimada, la aplicacion clasifica el resultado en tres '
                'categorias: Joven, Adulto o Anciano, mostrando la etapa '
                'correspondiente de forma clara en la pantalla.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 22),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD5DCE6)),
              ),
              child: Image.asset(
                _ageModuleImagePath,
                width: double.infinity,
                height: 340,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _predictAge(),
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: _isLoading ? null : _predictAge,
                  icon: const Icon(Icons.search),
                  label: const Text('Calcular'),
                ),
              ],
            ),
            const SizedBox(height: 18),
            if (_isLoading) const LinearProgressIndicator(),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
            if (result != null) ...[
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      category,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class UniversitiesScreen extends StatefulWidget {
  const UniversitiesScreen({super.key});

  @override
  State<UniversitiesScreen> createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  final TextEditingController _countryController = TextEditingController();

  bool _isLoading = false;
  String? _error;
  List<University> _universities = const [];

  @override
  void initState() {
    super.initState();
    _countryController.text = 'Dominican Republic';
    unawaited(_fetchUniversities());
  }

  @override
  void dispose() {
    _countryController.dispose();
    super.dispose();
  }

  Future<void> _fetchUniversities() async {
    final country = _countryController.text.trim();
    if (country.isEmpty) {
      setState(() {
        _error = 'Escribe el nombre del pais en ingles.';
        _universities = const [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final uri = Uri.parse(
        '$_universitiesApi?country=${Uri.encodeQueryComponent(country)}',
      );
      final response = await http.get(uri).timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw Exception('Error HTTP ${response.statusCode}');
      }

      final json = jsonDecode(response.body);
      if (json is! List) {
        throw const FormatException('Formato inesperado');
      }

      final universities = json
          .whereType<Map<String, dynamic>>()
          .map(University.fromJson)
          .toList();

      universities.sort((a, b) => a.name.compareTo(b.name));

      if (!mounted) {
        return;
      }

      setState(() {
        _universities = universities;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _error = 'No se pudo consultar universidades: $error';
        _universities = const [];
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Universidades por Pais',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD5DCE6)),
              ),
              child: Text(
                'Este modulo permite consultar las universidades de un pais '
                'ingresando su nombre en ingles. La aplicacion utiliza una '
                'API externa para obtener la informacion y mostrar una lista '
                'de universidades registradas en ese pais.\n\n'
                'Para cada universidad se mostrara su nombre, dominio y enlace '
                'a su pagina web oficial, permitiendo al usuario acceder '
                'directamente a mas informacion.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD5DCE6)),
              ),
              child: Image.asset(
                _universitiesModuleImagePath,
                width: double.infinity,
                height: 280,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _countryController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _fetchUniversities(),
                    decoration: const InputDecoration(
                      labelText: 'Pais (en ingles)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: _isLoading ? null : _fetchUniversities,
                  icon: const Icon(Icons.search),
                  label: const Text('Buscar'),
                ),
              ],
            ),
            const SizedBox(height: 14),
            if (_isLoading) const LinearProgressIndicator(),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
            const SizedBox(height: 14),
            _buildUniversitiesBody(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUniversitiesBody(BuildContext context) {
    if (_isLoading && _universities.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_universities.isEmpty) {
      return const Center(child: Text('No hay resultados para ese pais.'));
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _universities.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final university = _universities[index];
        final domain = university.domains.isEmpty
            ? 'N/D'
            : university.domains[0];
        final website = university.webPages.isEmpty
            ? ''
            : university.webPages[0].trim();

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nombre de la universidad: ${university.name}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text('Dominio: $domain'),
                const SizedBox(height: 4),
                Text(
                  'Enlace: ${website.isEmpty ? 'N/D' : website}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton.icon(
                    onPressed: website.isEmpty
                        ? null
                        : () => launchExternal(context, website),
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Visitar'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool _isLoading = false;
  String? _error;
  WeatherResult? _weather;

  @override
  void initState() {
    super.initState();
    unawaited(_fetchWeather());
  }

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final uri = Uri.parse(_weatherApi);
      final response = await http.get(uri).timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw Exception('Error HTTP ${response.statusCode}');
      }

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final weather = WeatherResult.fromJson(json);

      if (!mounted) {
        return;
      }

      setState(() {
        _weather = weather;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _error = 'No se pudo consultar clima: $error';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final weather = _weather;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Clima en Republica Dominicana',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD5DCE6)),
              ),
              child: Text(
                'Este modulo permite consultar como estara el clima en '
                'Republica Dominicana en el dia actual. La aplicacion obtiene '
                'la informacion del clima mediante una API externa y muestra '
                'los datos principales para que el usuario pueda conocer las '
                'condiciones meteorologicas del momento.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD5DCE6)),
              ),
              child: Image.asset(
                _weatherModuleImagePath,
                width: double.infinity,
                height: 390,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _isLoading ? null : _fetchWeather,
              icon: const Icon(Icons.refresh),
              label: const Text('Consultar Clima'),
            ),
            const SizedBox(height: 14),
            if (_isLoading) const LinearProgressIndicator(),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
            if (weather != null) ...[
              const SizedBox(height: 22),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFD5DCE6)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Resultado del clima de hoy',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          weatherIcon(weather.weatherCode),
                          size: 34,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            weatherSimpleCondition(weather.weatherCode),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text('Fecha/Hora API: ${formatDateTime(weather.time)}'),
                    const SizedBox(height: 6),
                    Text(
                      'Temperatura: ${weather.temperature.toStringAsFixed(1)} C',
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Condicion: ${weatherDescription(weather.weatherCode)}',
                    ),
                    const SizedBox(height: 4),
                    Text('Humedad: ${weather.humidity}%'),
                    const SizedBox(height: 4),
                    Text(
                      'Viento: ${weather.windSpeed.toStringAsFixed(1)} km/h',
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Ubicacion usada: Santo Domingo, Republica Dominicana',
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  final TextEditingController _nameController = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();

  late final StreamSubscription<PlayerState> _audioSubscription;

  bool _isLoading = false;
  bool _isPlayingCry = false;
  String? _error;
  PokemonResult? _pokemon;

  @override
  void initState() {
    super.initState();
    _nameController.text = 'pikachu';

    _audioSubscription = _audioPlayer.playerStateStream.listen((state) {
      final ended = state.processingState == ProcessingState.completed;
      final stopped = !state.playing;

      if ((ended || stopped) && mounted && _isPlayingCry) {
        setState(() {
          _isPlayingCry = false;
        });
      }
    });

    unawaited(_fetchPokemon());
  }

  @override
  void dispose() {
    _audioSubscription.cancel();
    unawaited(_audioPlayer.dispose());
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _fetchPokemon() async {
    final name = _nameController.text.trim().toLowerCase();
    if (name.isEmpty) {
      setState(() {
        _error = 'Escribe un nombre de pokemon.';
        _pokemon = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      await _audioPlayer.stop();

      final uri = Uri.parse('$_pokemonApi$name');
      final response = await http.get(uri).timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw Exception('Pokemon no encontrado (HTTP ${response.statusCode})');
      }

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final pokemon = PokemonResult.fromJson(json);

      if (!mounted) {
        return;
      }

      setState(() {
        _pokemon = pokemon;
        _isPlayingCry = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _error = 'No se pudo consultar PokeAPI: $error';
        _pokemon = null;
        _isPlayingCry = false;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _toggleCry() async {
    final pokemon = _pokemon;
    if (pokemon == null || pokemon.cryUrl == null || pokemon.cryUrl!.isEmpty) {
      return;
    }

    try {
      if (_isPlayingCry) {
        await _audioPlayer.stop();
        if (!mounted) {
          return;
        }

        setState(() {
          _isPlayingCry = false;
        });
        return;
      }

      await _audioPlayer.setUrl(pokemon.cryUrl!);
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.play();

      if (!mounted) {
        return;
      }

      setState(() {
        _isPlayingCry = true;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isPlayingCry = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo reproducir sonido: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pokemon = _pokemon;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Pokemon's",
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD5DCE6)),
              ),
              child: Text(
                'Este modulo permite consultar informacion sobre un Pokemon '
                'ingresando su nombre. La aplicacion utiliza una API externa '
                'para obtener los datos del Pokemon solicitado.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD5DCE6)),
              ),
              child: Image.asset(
                _pokemonModuleImagePath,
                width: double.infinity,
                height: 280,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _fetchPokemon(),
                    decoration: const InputDecoration(
                      labelText: 'Nombre del Pokemon',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: _isLoading ? null : _fetchPokemon,
                  icon: const Icon(Icons.search),
                  label: const Text('Buscar'),
                ),
              ],
            ),
            const SizedBox(height: 14),
            if (_isLoading) const LinearProgressIndicator(),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
            if (pokemon != null) ...[
              const SizedBox(height: 22),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFD5DCE6)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 240,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F6FA),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: pokemon.imageUrl == null
                          ? const Icon(Icons.image_not_supported)
                          : Image.network(
                              pokemon.imageUrl!,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported),
                            ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      capitalize(pokemon.name),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Experiencia base: ${pokemon.baseExperience}'),
                    const SizedBox(height: 14),
                    const Text(
                      'Habilidades:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: pokemon.abilities
                          .map(
                            (ability) => Chip(
                              label: Text(
                                capitalize(ability.replaceAll('-', ' ')),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      onPressed: pokemon.cryUrl == null ? null : _toggleCry,
                      icon: Icon(_isPlayingCry ? Icons.stop : Icons.play_arrow),
                      label: Text(
                        _isPlayingCry ? 'Detener sonido' : 'Reproducir sonido',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class WordpressScreen extends StatefulWidget {
  const WordpressScreen({super.key});

  @override
  State<WordpressScreen> createState() => _WordpressScreenState();
}

class _WordpressScreenState extends State<WordpressScreen> {
  bool _isLoading = false;
  String? _error;
  List<WordpressPost> _posts = const [];
  int _nextPage = 1;

  Future<void> _fetchPosts() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      var pageToLoad = _nextPage;
      var response = await _fetchPostsResponse(pageToLoad);

      // Si se llega al final del paginado, vuelve al inicio (ultimas noticias).
      if (response.statusCode == 400 && pageToLoad > 1) {
        pageToLoad = 1;
        response = await _fetchPostsResponse(pageToLoad);
      }

      if (response.statusCode != 200) {
        throw Exception('Error HTTP ${response.statusCode}');
      }

      final posts = _parsePostsFromResponse(response.body);

      if (!mounted) {
        return;
      }

      setState(() {
        _posts = posts;
        _nextPage = pageToLoad + 1;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _error = 'No se pudo consultar WordPress: $error';
        _posts = const [];
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<http.Response> _fetchPostsResponse(int page) {
    final uri = Uri.parse(
      _wordpressApi,
    ).replace(queryParameters: {'per_page': '3', 'page': '$page'});
    return http.get(uri).timeout(const Duration(seconds: 15));
  }

  List<WordpressPost> _parsePostsFromResponse(String body) {
    final json = jsonDecode(body);
    if (json is! List) {
      throw const FormatException('Formato inesperado');
    }

    return json
        .whereType<Map<String, dynamic>>()
        .map(WordpressPost.fromJson)
        .take(3)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Noticias desde WordPress',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD5DCE6)),
              ),
              child: Image.asset(
                _wordpressModuleImagePath,
                height: 280,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD5DCE6)),
              ),
              child: Text(
                'Este modulo permite consultar las ultimas noticias publicadas '
                'en un sitio web desarrollado con WordPress utilizando su API. '
                'La aplicacion obtiene la informacion y muestra los tres '
                'articulos mas recientes.\n\n'
                'Para cada noticia se mostrara el titulo, un resumen del '
                'contenido y un enlace para visitar la publicacion original en '
                'la pagina web.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _isLoading ? null : _fetchPosts,
              icon: const Icon(Icons.newspaper),
              label: const Text('Cargar Noticias'),
            ),
            const SizedBox(height: 14),
            if (_isLoading) const LinearProgressIndicator(),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
            const SizedBox(height: 14),
            _buildPostsList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPostsList(BuildContext context) {
    if (_isLoading && _posts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_posts.isEmpty) {
      return const Center(child: Text('No hay noticias para mostrar.'));
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _posts.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final post = _posts[index];

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  post.excerpt,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton.icon(
                    onPressed: () => launchExternal(context, post.link),
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Visitar'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 90,
                      backgroundImage: AssetImage(_aboutImagePath),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Luis Cedano',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Matricula: 2024-0128',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ContactRow(
                      icon: Icons.email,
                      label: 'Correo personal',
                      value: 'luiscdano@gmail.com',
                      onTap: () =>
                          launchExternal(context, 'mailto:luiscdano@gmail.com'),
                    ),
                    ContactRow(
                      icon: Icons.school,
                      label: 'Correo institucional',
                      value: '20240128@itla.edu.do',
                      onTap: () => launchExternal(
                        context,
                        'mailto:20240128@itla.edu.do',
                      ),
                    ),
                    ContactRow(
                      icon: Icons.phone,
                      label: 'Telefono',
                      value: '809-780-5645',
                      onTap: () => launchExternal(context, 'tel:+18097805645'),
                    ),
                    ContactRow(
                      icon: Icons.code,
                      label: 'GitHub',
                      value: 'github.com/luiscdano',
                      onTap: () => launchExternal(
                        context,
                        'https://github.com/luiscdano',
                      ),
                    ),
                    ContactRow(
                      icon: Icons.public,
                      label: 'Web',
                      value: 'www.cmlayer.com',
                      onTap: () =>
                          launchExternal(context, 'https://www.cmlayer.com'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Instituto Tecnologico de las Americas, Materia Desarrollo '
                  'de aplicaciones moviles impartida por el docente Amadis '
                  'Suarez Genao',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactRow extends StatelessWidget {
  const ContactRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(value),
                  ],
                ),
              ),
              const Icon(Icons.open_in_new, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class GenderResult {
  const GenderResult({
    required this.name,
    required this.gender,
    required this.probability,
  });

  final String name;
  final String gender;
  final double probability;

  factory GenderResult.fromJson(Map<String, dynamic> json) {
    final probabilityRaw = json['probability'];

    return GenderResult(
      name: (json['name'] as String?) ?? 'N/D',
      gender: (json['gender'] as String?) ?? 'female',
      probability: probabilityRaw is num ? probabilityRaw.toDouble() : 0,
    );
  }
}

class AgeResult {
  const AgeResult({required this.name, required this.age});

  final String name;
  final int age;

  factory AgeResult.fromJson(Map<String, dynamic> json) {
    final ageRaw = json['age'];

    return AgeResult(
      name: (json['name'] as String?) ?? 'N/D',
      age: ageRaw is int ? ageRaw : 0,
    );
  }
}

class University {
  const University({
    required this.name,
    required this.domains,
    required this.webPages,
  });

  final String name;
  final List<String> domains;
  final List<String> webPages;

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: (json['name'] as String?) ?? 'N/D',
      domains: _stringListFromDynamic(json['domains']),
      webPages: _stringListFromDynamic(json['web_pages']),
    );
  }
}

class WeatherResult {
  const WeatherResult({
    required this.time,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCode,
  });

  final DateTime time;
  final double temperature;
  final int humidity;
  final double windSpeed;
  final int weatherCode;

  factory WeatherResult.fromJson(Map<String, dynamic> json) {
    final currentRaw = json['current'];
    if (currentRaw is! Map<String, dynamic>) {
      throw const FormatException('current no encontrado');
    }

    final timeRaw = currentRaw['time'];
    final time =
        DateTime.tryParse((timeRaw as String?) ?? '') ?? DateTime.now();

    final temperatureRaw = currentRaw['temperature_2m'];
    final humidityRaw = currentRaw['relative_humidity_2m'];
    final windRaw = currentRaw['wind_speed_10m'];
    final codeRaw = currentRaw['weather_code'];

    return WeatherResult(
      time: time,
      temperature: temperatureRaw is num ? temperatureRaw.toDouble() : 0,
      humidity: humidityRaw is int ? humidityRaw : 0,
      windSpeed: windRaw is num ? windRaw.toDouble() : 0,
      weatherCode: codeRaw is int ? codeRaw : 0,
    );
  }
}

class PokemonResult {
  const PokemonResult({
    required this.name,
    required this.baseExperience,
    required this.abilities,
    required this.imageUrl,
    required this.cryUrl,
  });

  final String name;
  final int baseExperience;
  final List<String> abilities;
  final String? imageUrl;
  final String? cryUrl;

  factory PokemonResult.fromJson(Map<String, dynamic> json) {
    final abilitiesRaw = json['abilities'];
    final abilities = <String>[];

    if (abilitiesRaw is List) {
      for (final entry in abilitiesRaw) {
        if (entry is Map<String, dynamic>) {
          final abilityRaw = entry['ability'];
          if (abilityRaw is Map<String, dynamic>) {
            final name = abilityRaw['name'];
            if (name is String && name.isNotEmpty) {
              abilities.add(name);
            }
          }
        }
      }
    }

    String? image;
    final spritesRaw = json['sprites'];
    if (spritesRaw is Map<String, dynamic>) {
      final frontDefault = spritesRaw['front_default'];
      if (frontDefault is String && frontDefault.isNotEmpty) {
        image = frontDefault;
      }

      final otherRaw = spritesRaw['other'];
      if (otherRaw is Map<String, dynamic>) {
        final officialRaw = otherRaw['official-artwork'];
        if (officialRaw is Map<String, dynamic>) {
          final officialDefault = officialRaw['front_default'];
          if (officialDefault is String && officialDefault.isNotEmpty) {
            image = officialDefault;
          }
        }
      }
    }

    String? cry;
    final criesRaw = json['cries'];
    if (criesRaw is Map<String, dynamic>) {
      final latest = criesRaw['latest'];
      if (latest is String && latest.isNotEmpty) {
        cry = latest;
      }
    }

    final experienceRaw = json['base_experience'];

    return PokemonResult(
      name: (json['name'] as String?) ?? 'N/D',
      baseExperience: experienceRaw is int ? experienceRaw : 0,
      abilities: abilities,
      imageUrl: image,
      cryUrl: cry,
    );
  }
}

class WordpressPost {
  const WordpressPost({
    required this.title,
    required this.excerpt,
    required this.link,
  });

  final String title;
  final String excerpt;
  final String link;

  factory WordpressPost.fromJson(Map<String, dynamic> json) {
    final titleRaw = json['title'];
    final excerptRaw = json['excerpt'];

    String title = 'Sin titulo';
    if (titleRaw is Map<String, dynamic>) {
      final rendered = titleRaw['rendered'];
      if (rendered is String && rendered.isNotEmpty) {
        title = cleanHtml(rendered);
      }
    }

    String excerpt = 'Sin resumen.';
    if (excerptRaw is Map<String, dynamic>) {
      final rendered = excerptRaw['rendered'];
      if (rendered is String && rendered.isNotEmpty) {
        excerpt = cleanHtml(rendered);
      }
    }

    final link = (json['link'] as String?) ?? 'https://wordpress.org/news/';

    return WordpressPost(title: title, excerpt: excerpt, link: link);
  }
}

enum AgeStage { young, adult, elder }

AgeStage _stageFor(int? age) {
  final safeAge = age ?? 0;

  if (safeAge < 18) {
    return AgeStage.young;
  }

  if (safeAge < 60) {
    return AgeStage.adult;
  }

  return AgeStage.elder;
}

String _labelFor(AgeStage stage) {
  switch (stage) {
    case AgeStage.young:
      return 'Joven';
    case AgeStage.adult:
      return 'Adulto';
    case AgeStage.elder:
      return 'Anciano';
  }
}

List<String> _stringListFromDynamic(dynamic input) {
  if (input is! List) {
    return const [];
  }

  return input.whereType<String>().toList();
}

String formatDateTime(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  final year = date.year;
  final hour = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');

  return '$day/$month/$year $hour:$minute';
}

String capitalize(String value) {
  if (value.isEmpty) {
    return value;
  }

  return value[0].toUpperCase() + value.substring(1);
}

String cleanHtml(String html) {
  final withoutTags = html.replaceAll(RegExp(r'<[^>]*>'), ' ');
  final decoded = withoutTags
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&amp;', '&')
      .replaceAll('&#038;', '&')
      .replaceAll('&quot;', '"')
      .replaceAll('&#8217;', "'")
      .replaceAll('&#8216;', "'")
      .replaceAll('&#8220;', '"')
      .replaceAll('&#8221;', '"')
      .replaceAll('&#8230;', '...');

  return decoded.replaceAll(RegExp(r'\s+'), ' ').trim();
}

Future<void> launchExternal(BuildContext context, String rawUrl) async {
  final parsed = Uri.tryParse(rawUrl);
  Uri? uri = parsed;

  if (uri == null) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Enlace invalido.')));
    return;
  }

  if (!uri.hasScheme) {
    uri = Uri.tryParse('https://$rawUrl');
  }

  if (uri == null) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Enlace invalido.')));
    return;
  }

  final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!context.mounted) {
    return;
  }

  if (!opened) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No fue posible abrir el enlace.')),
    );
  }
}

String weatherDescription(int code) {
  if (code == 0) {
    return 'Despejado';
  }

  if (code == 1 || code == 2 || code == 3) {
    return 'Parcialmente nublado';
  }

  if (code == 45 || code == 48) {
    return 'Niebla';
  }

  if (code >= 51 && code <= 57) {
    return 'Llovizna';
  }

  if (code >= 61 && code <= 67) {
    return 'Lluvia';
  }

  if (code >= 71 && code <= 77) {
    return 'Nieve';
  }

  if (code >= 80 && code <= 82) {
    return 'Chubascos';
  }

  if (code >= 95) {
    return 'Tormenta';
  }

  return 'Condicion desconocida';
}

String weatherSimpleCondition(int code) {
  if (code == 0) {
    return 'Soleado';
  }

  if (code == 1 || code == 2 || code == 3 || code == 45 || code == 48) {
    return 'Nublado';
  }

  if ((code >= 51 && code <= 57) ||
      (code >= 61 && code <= 67) ||
      (code >= 80 && code <= 82) ||
      code >= 95) {
    return 'Lluvioso';
  }

  return 'Variable';
}

IconData weatherIcon(int code) {
  if (code == 0) {
    return Icons.sunny;
  }

  if (code == 1 || code == 2 || code == 3) {
    return Icons.cloud_queue;
  }

  if (code == 45 || code == 48) {
    return Icons.foggy;
  }

  if ((code >= 51 && code <= 57) ||
      (code >= 61 && code <= 67) ||
      (code >= 80 && code <= 82)) {
    return Icons.umbrella;
  }

  if (code >= 95) {
    return Icons.thunderstorm;
  }

  return Icons.cloud;
}
