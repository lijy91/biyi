import 'package:biyi_app/widgets/customized_app_bar/customized_app_bar.dart';
import 'package:uikit/uikit.dart';

class TabVocabularyScene extends StatelessWidget {
  const TabVocabularyScene({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      navigationBar: const CustomizedAppBar(
        title: Text('Vocabulary'),
      ),
      child: Container(),
    );
  }
}
