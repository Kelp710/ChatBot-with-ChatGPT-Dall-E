import '../utils/exports.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting Page'),
      ),
      body: Column(
        children: [
          Expanded(child: TempSlider()),
          Expanded(child: DropdownMenuExample()),
        ],
      ),
    );
  }
}

class TempSlider extends StatefulWidget {
  const TempSlider({super.key});

  @override
  State<TempSlider> createState() => _TempSliderState();
}

class _TempSliderState extends State<TempSlider> {
  @override
  Widget build(BuildContext context) {
    double currentSliderValue = Provider.of<Temp>(context, listen: false).temp;

    return Scaffold(
      body: Slider(
        value: currentSliderValue,
        min: 0,
        max: 1,
        divisions: 10,
        label: currentSliderValue.toString(),
        onChanged: (double value) {
          setState(() {
            currentSliderValue = value;
            context.read<Temp>().adjustTemp(value);
          });
        },
      ),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  final TextEditingController colorController = TextEditingController();

  ColorLabel? selectedColor;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<ColorLabel>> colorEntries =
        <DropdownMenuEntry<ColorLabel>>[];
    for (final ColorLabel color in ColorLabel.values) {
      colorEntries.add(DropdownMenuEntry<ColorLabel>(
          value: color, label: color.label, enabled: color.label != 'Grey'));
    }

    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: Scaffold(
        body: SafeArea(
            child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropdownMenu<ColorLabel>(
                    initialSelection: ColorLabel.green,
                    controller: colorController,
                    label: const Text('Color'),
                    dropdownMenuEntries: colorEntries,
                    onSelected: (ColorLabel? color) {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

enum IconLabel {
  smile('Smile', Icons.sentiment_satisfied_outlined),
  cloud(
    'Cloud',
    Icons.cloud_outlined,
  ),
  brush('Brush', Icons.brush_outlined),
  heart('Heart', Icons.favorite);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}
