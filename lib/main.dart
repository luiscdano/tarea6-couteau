import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:url_launcher/url_launcher.dart';

const String _toolboxImage1Path = 'assets/images/cajaherramientas01.png';
const String _toolboxImage2Path = 'assets/images/cajaherramientas02.png';
const String _maleImagePath = 'assets/images/azul.png';
const String _femaleImagePath = 'assets/images/rosa.png';
const String _pokemonModuleImagePath = 'assets/images/pokebolas.png';
const String _youngImagePath = 'assets/images/edad_joven.png';
const String _adultImagePath = 'assets/images/edad_adulto.png';
const String _elderImagePath = 'assets/images/edad_anciano.png';
const String _aboutImagePath = 'assets/images/me.png';

const String _genderApi = 'https://api.genderize.io/';
const String _ageApi = 'https://api.agify.io/';
const String _universitiesApi = 'https://adamix.net/proxy.php';
const String _weatherApi =
    'https://api.open-meteo.com/v1/forecast?latitude=18.4861&longitude=-69.9312&current=temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m&timezone=America%2FSanto_Domingo';
const String _pokemonApi = 'https://pokeapi.co/api/v2/pokemon/';
const String _wordpressApi =
    'https://wordpress.org/news/wp-json/wp/v2/posts?per_page=3';
const String _wordpressLogoUrl =
    'https://s.w.org/style/images/about/WordPress-logotype-standard.png';

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

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Tarea 6 - Couteau'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.home_repair_service), text: 'Caja'),
              Tab(icon: Icon(Icons.wc), text: 'Genero'),
              Tab(icon: Icon(Icons.cake), text: 'Edad'),
              Tab(icon: Icon(Icons.school), text: 'Universidades'),
              Tab(icon: Icon(Icons.cloud), text: 'Clima RD'),
              Tab(icon: Icon(Icons.catching_pokemon), text: 'Pokemon'),
              Tab(icon: Icon(Icons.newspaper), text: 'WordPress'),
              Tab(icon: Icon(Icons.person), text: 'Acerca de'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ToolboxScreen(),
            GenderScreen(),
            AgeScreen(),
            UniversitiesScreen(),
            WeatherScreen(),
            PokemonScreen(),
            WordpressScreen(),
            AboutScreen(),
          ],
        ),
      ),
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
            Text(
              '1) Caja de herramientas',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'La app funciona como una caja de herramientas para diferentes servicios.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            _AssetImageCard(
              title: 'Caja de herramientas 01',
              imagePath: _toolboxImage1Path,
            ),
            const SizedBox(height: 14),
            _AssetImageCard(
              title: 'Caja de herramientas 02',
              imagePath: _toolboxImage2Path,
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
            Text(
              '2) Prediccion de genero',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'API: $_genderApi?name=irma',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 14),
            if (_isLoading) const LinearProgressIndicator(),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
            if (result != null) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: borderColor, width: 1.5),
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre: ${result.name}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      isMale
                          ? 'Genero predicho: Masculino (azul)'
                          : 'Genero predicho: Femenino (rosa)',
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Probabilidad: ${(result.probability * 100).toStringAsFixed(1)}%',
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        isMale ? _maleImagePath : _femaleImagePath,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
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

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '3) Prediccion de edad',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'API: $_ageApi?name=meelad',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 14),
            if (_isLoading) const LinearProgressIndicator(),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
            if (result != null) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFD5DCE6)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre: ${result.name}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text('Edad estimada: ${result.age} anos'),
                    const SizedBox(height: 4),
                    Text('Clasificacion: ${_labelFor(stage)}'),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        _imageFor(stage),
                        height: 170,
                        width: double.infinity,
                        fit: BoxFit.cover,
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '4) Universidades por pais',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'API: $_universitiesApi?country=Dominican+Republic',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _countryController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _fetchUniversities(),
                    decoration: const InputDecoration(
                      labelText: 'Pais en ingles',
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
            const SizedBox(height: 12),
            if (_isLoading) const LinearProgressIndicator(),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
            const SizedBox(height: 10),
            Expanded(child: _buildUniversitiesBody(context)),
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
                  university.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text('Dominio: $domain'),
                const SizedBox(height: 4),
                Text(
                  'Web: ${website.isEmpty ? 'N/D' : website}',
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
            Text(
              '5) Clima en Republica Dominicana',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Fuente: Open-Meteo (Santo Domingo, RD)',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _isLoading ? null : _fetchWeather,
              icon: const Icon(Icons.refresh),
              label: const Text('Actualizar clima de hoy'),
            ),
            const SizedBox(height: 12),
            if (_isLoading) const LinearProgressIndicator(),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
            if (weather != null) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFD5DCE6)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            weatherDescription(weather.weatherCode),
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
            Text(
              '6) Pokemon',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'API: ${_pokemonApi}pikachu',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                _pokemonModuleImagePath,
                width: double.infinity,
                height: 170,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _fetchPokemon(),
                    decoration: const InputDecoration(
                      labelText: 'Nombre del pokemon',
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
            const SizedBox(height: 12),
            if (_isLoading) const LinearProgressIndicator(),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
            if (pokemon != null) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFD5DCE6)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 110,
                          height: 110,
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
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                capitalize(pokemon.name),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Experiencia base: ${pokemon.baseExperience}',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
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

  @override
  void initState() {
    super.initState();
    unawaited(_fetchPosts());
  }

  Future<void> _fetchPosts() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final uri = Uri.parse(_wordpressApi);
      final response = await http.get(uri).timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw Exception('Error HTTP ${response.statusCode}');
      }

      final json = jsonDecode(response.body);
      if (json is! List) {
        throw const FormatException('Formato inesperado');
      }

      final posts = json
          .whereType<Map<String, dynamic>>()
          .map(WordpressPost.fromJson)
          .take(3)
          .toList();

      if (!mounted) {
        return;
      }

      setState(() {
        _posts = posts;
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '7) Noticias WordPress',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'API usada para el foro: $_wordpressApi',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD5DCE6)),
              ),
              child: Image.network(
                _wordpressLogoUrl,
                height: 64,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const SizedBox(
                  height: 64,
                  child: Center(child: Icon(Icons.public)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            FilledButton.icon(
              onPressed: _isLoading ? null : _fetchPosts,
              icon: const Icon(Icons.refresh),
              label: const Text('Actualizar 3 ultimas noticias'),
            ),
            const SizedBox(height: 12),
            if (_isLoading) const LinearProgressIndicator(),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
            const SizedBox(height: 8),
            Expanded(child: _buildPostsList(context)),
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
            Text(
              '8) Acerca de',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 62,
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
                  'El icono de la app esta configurado con tu foto en assets/images/profile_photo.jpg usando flutter_launcher_icons.',
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

class _AssetImageCard extends StatelessWidget {
  const _AssetImageCard({required this.title, required this.imagePath});

  final String title;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                height: 210,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
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

String _imageFor(AgeStage stage) {
  switch (stage) {
    case AgeStage.young:
      return _youngImagePath;
    case AgeStage.adult:
      return _adultImagePath;
    case AgeStage.elder:
      return _elderImagePath;
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
