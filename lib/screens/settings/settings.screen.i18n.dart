import 'package:i18n_extension/i18n_extension.dart';

enum Gender { male, female }

extension Localization on String {
  String get i18n => localize(this, t);

  String gender(Gender gnd) => localizeVersion(gnd, this, t);

  static var t = Translations("en_us") +
      {
        "en_us": "Categories",
        "pt_br": "Categorias",
      } +
      {
        "en_us": "manage categories",
        "pt_br": "gerênciar categorias",
      } +
      {
        "en_us": "About us",
        "pt_br": "Sobre nós",
      } +
      {
        "en_us": "Logout",
        "pt_br": "Sair",
      } +
      {
        "en_us": "Not Categorized",
        "pt_br": "Não Categorizado",
      } +
      {
        "en_us":
            "This project was developed by students from the Software Engineering course at\nPUC Minas. Meet the team: ",
        "pt_br":
            "Esse projeto foi desenvolvido por alunos do curso de Engenharia de Software pela\nPUC-Minas. Conheça a equipe: ",
      } +
      {
        "en_us": "About us",
        "pt_br": "Sobre nós",
      } +
      {
        "en_us": "Developer"
            .modifier(Gender.male, 'Developer')
            .modifier(Gender.female, 'Developer'),
        "pt_br": "Desenvolvedor"
            .modifier(Gender.female, 'Desenvolvedora')
            .modifier(Gender.male, 'Desenvolvedor'),
      };
}
