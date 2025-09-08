import 'package:newsapp/Models/categories_model.dart';

List<Categories> getCategories() {
  List<Categories> categories = [];

  Categories categoriesModel = Categories();

  categoriesModel.categoriesName = "Business";
  categoriesModel.image = "images/business.jpg";
  categories.add(categoriesModel);
  categoriesModel = Categories();

  categoriesModel.categoriesName = "Entertainment";
  categoriesModel.image = "images/entertainment.jpg";
  categories.add(categoriesModel);
  categoriesModel = Categories();

  categoriesModel.categoriesName = "Sport";
  categoriesModel.image = "images/sport.jpg";
  categories.add(categoriesModel);
  categoriesModel = Categories();

  categoriesModel.categoriesName = "Health";
  categoriesModel.image = "images/health.jpg";
  categories.add(categoriesModel);
  categoriesModel = Categories();

  categoriesModel.categoriesName = "Science";
  categoriesModel.image = "images/science.jpg";
  categories.add(categoriesModel);
  categoriesModel = Categories();

  return categories;
}
