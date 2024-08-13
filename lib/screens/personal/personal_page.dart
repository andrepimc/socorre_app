import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socorre_app/components/base_appbar_component.dart';
import 'package:socorre_app/components/button_component.dart';
import 'package:socorre_app/components/text_input_component.dart';
import 'package:socorre_app/main.dart';
import 'package:socorre_app/models/user_model.dart';
import 'package:socorre_app/services/store/user_store.dart';
import 'package:socorre_app/theme/my_app_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  //username text controller
  TextEditingController usernameController = TextEditingController();

  //tel text controller
  TextEditingController telController = TextEditingController();

  final User user = supabase.auth.currentUser!;
  String? avatarUrl = GetIt.I<UserStore>().user.avatar_url;

  bool loading = false;

  @override
  void initState() {
    setState(() {
      usernameController.text = GetIt.I<UserStore>().user.username!;
      if (GetIt.I<UserStore>().user.tel != null) {
        telController.text = GetIt.I<UserStore>().user.tel!;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        title: "Meus dados",
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                if (image == null) return;
                final imageExt = image.path.split('.').last.toLowerCase();
                final imageBytes = await image.readAsBytes();
                final String id = user.id;
                String path = '/$id/profile';
                await supabase.storage.from('profiles').uploadBinary(
                    path, imageBytes,
                    fileOptions: FileOptions(
                        upsert: true, contentType: 'image/$imageExt'));
                String imageUrl =
                    supabase.storage.from('profiles').getPublicUrl(path);
                imageUrl = Uri.parse(imageUrl).replace(queryParameters: {
                  't': DateTime.now().millisecondsSinceEpoch.toString()
                }).toString();
                setState(() {
                  avatarUrl = imageUrl;
                });
              },
              child: SizedBox(
                height: 64,
                width: 64,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: avatarUrl == null
                      ? const Icon(Icons.person_3)
                      : Image.network(
                        
                          avatarUrl!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: TextInputComponent(
                color: MyAppColors.darkDarkerGrey,
                controller: usernameController,
                text: "Nome de usuário",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: TextInputComponent(
                color: MyAppColors.darkDarkerGrey,
                controller: telController,
                type: TextInputType.phone,
                text: "Telefone celular",
              ),
            ),
            ButtonComponent(
                func: () async {
                  final usernameTrim = usernameController.text.trim();
                  final telTrim = telController.text.trim();
                  final userId = supabase.auth.currentUser!.id;
                  setState(() {
                    loading = true;
                  });
                  try {
                    await supabase.from('profiles').update({
                      'username': usernameTrim,
                      'tel': telTrim,
                      'avatar_url': avatarUrl
                    }).eq('id', userId);
                    UserModel userModel = UserModel(
                      id: userId,
                      email: GetIt.I<UserStore>().user.email,
                      username: usernameTrim,
                      tel: telTrim,
                      avatar_url: avatarUrl  
                    );
                    await GetIt.I<UserStore>().getUser(userModel);
                    BotToast.showText(text: "Sucesso!");
                  } on Exception catch (e) {
                    // TODO
                  } finally {
                    setState(() {
                      loading = false;
                    });
                  }
                },
                text: "Atualizar",
                loading: loading)
          ],
        ),
      ),
    );
  }
}
