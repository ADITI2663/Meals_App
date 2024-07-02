import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';
import '../dummy_data.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> _availableMeals;
  CategoryMealsScreen(this._availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  late List<Meal> displayedItem;
  var _loadedInitData = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedItem = widget._availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedItem.removeWhere((meal) => meal.id == mealId);
    });
  }
  // final String categoryId;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedItem[index].id,
            title: displayedItem[index].title,
            imageUrl: displayedItem[index].imageUrl,
            duration: displayedItem[index].duration,
            complexity: displayedItem[index].complexity,
            affordability: displayedItem[index].affordability,
          );
        },
        itemCount: displayedItem.length,
      ),
    );
  }
}
