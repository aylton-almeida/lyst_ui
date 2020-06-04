import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  String get i18n => localize(this, t);

  static var t = Translations("en_us") +
      {
        "en_us": "An error occurred, please try again later",
        "pt_br": "Ocorreu um erro, por favor tente novamente mais tarde",
      } +
      {
        "en_us": "Delete Note",
        "pt_br": "Deletar Nota",
      } +
      {
        "en_us": "cancel",
        "pt_br": "cancelar",
      } +
      {
        "en_us":
            "Are you sure you want to delete the category? All notes inside it will be deleted as well",
        "pt_br":
            "Você tem certeza que quer deletar essa categoria? Todas suas notas serão apagadas também",
      } +
      {
        "en_us":
            "Are you sure you want to clear the category? All notes inside it will be deleted",
        "pt_br":
            "Você tem certeza que quer limpar essa categoria? Todas suas notas serão apagadas",
      } +
      {"en_us": "confirm", "pt_br": "confirmar"} +
      {
        "en_us": "Category created with success!",
        "pt_br": "Categoria criada com sucesso"
      } +
      {
        "en_us": "Category updated with success!",
        "pt_br": "Categoria atualizada com sucesso"
      } +
      {
        "en_us": "Type a title for the category",
        "pt_br": "Digite um titulo para a categoria"
      } +
      {"en_us": "Colors", "pt_br": "Cores"} +
      {"en_us": "Category title...", "pt_br": "Titulo da categoria..."} +
      {"en_us": "Danger Zone", "pt_br": "Zona de perigo"} +
      {"en_us": "clear category", "pt_br": "limpar categoria"} +
      {"en_us": "Delete category", "pt_br": "Deletar categoria"} +
      {
        "en_us": "Be carefull! Deleting a category will delete all its lysts",
        "pt_br": "Cuidado! Apagar uma categoria vai deletar todas suas lysts"
      } +
      {
        "en_us": "You can only edit non default categories",
        "pt_br": "Você só pode editar categorias não padrão"
      } +
      {"en_us": "Manage Categories", "pt_br": "Gerenciar categorias"} +
      {
        "en_us": "Not Categorized",
        "pt_br": "Não Categorizado",
      } +
      {"en_us": "Clear category", "pt_br": "Limpar categoria"};
}
