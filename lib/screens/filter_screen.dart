import 'package:flutter/material.dart';
import 'package:meals/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;
  const FilterScreen(
      {Key? key, required this.saveFilters, required this.currentFilters})
      : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'] as bool;
    _lactoseFree = widget.currentFilters['lactose'] as bool;
    _vegan = widget.currentFilters['vegan'] as bool;
    _vegetarian = widget.currentFilters['vegetarian'] as bool;
    super.initState();
  }

  Widget buildSwtitchTile(String title, String description, bool currentValue,
      Function updateValue) {
    return SwitchListTile(
      activeColor: Theme.of(context).colorScheme.secondary,
      value: currentValue,
      onChanged: (newValue) {
        updateValue(newValue);
      },
      title: Text(title),
      subtitle: Text(description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Filters'),
          actions: [
            IconButton(
                onPressed: () {
                  final selectedFilters = {
                    'gluten': _glutenFree,
                    'lactose': _lactoseFree,
                    'vegan': _vegan,
                    'vegetarian': _vegetarian
                  };
                  widget.saveFilters(selectedFilters);
                },
                icon: const Icon(Icons.save))
          ],
        ),
        drawer: const MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text('Adjust your meal selection.',
                  style: Theme.of(context).textTheme.headline6),
            ),
            Expanded(
                child: ListView(
              children: [
                buildSwtitchTile('Gluten-free',
                    'only include gluten-free meals', _glutenFree, (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                buildSwtitchTile(
                    'Lactose-free',
                    'only include lactose-free meals',
                    _lactoseFree, (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
                buildSwtitchTile(
                    'Vegetarian', 'only include Vegetatian meals', _vegetarian,
                    (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
                buildSwtitchTile('Vegan', 'only include Vegan meals', _vegan,
                    (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
              ],
            ))
          ],
        ));
  }
}
