import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final String userName;
  // Variabel för att spara användarnamnet.

  final String email;
  // Variabel för att spara e-postadressen.

  const EditProfileScreen({
    // Konstruktor för att skapa profilsidan.

    Key? key,
    // Unik nyckel för widgeten (valfri).

    required this.userName,
    // Kräver att användarnamn skickas in.

    required this.email,
    // Kräver att e-post skickas in.

  }) : super(key: key);
  // Skickar nyckeln till föräldraklassen.

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
// Kopplar klassen till dess tillstånd.
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Klass som hanterar sidans tillstånd och logik.

  late TextEditingController userNameController;
  // Kontroll för användarnamnsfältet som initieras senare.

  late TextEditingController emailController;
  // Kontroll för e-postfältet som initieras senare.

  final TextEditingController passwordController = TextEditingController();
  // Kontroll för lösenordsfältet.

  final TextEditingController repeatPasswordController = TextEditingController();
  // Kontroll för att upprepa lösenordsfältet.

  bool _isEditing = false;
  // Variabel som styr om fälten kan redigeras.

  @override
  void initState() {
    // Funktion som körs när sidan laddas.

    super.initState();
    // Anropar föräldraklassens initState.

    userNameController = TextEditingController(text: widget.userName);
    // Sätter användarnamn i fältet.

    emailController = TextEditingController(text: widget.email);
    // Sätter e-post i fältet.
  }

  void _saveChanges() {
    // Funktion för att spara ändringar.

    if (passwordController.text != repeatPasswordController.text) {
      // Kollar om lösenorden inte matchar.

      ScaffoldMessenger.of(context).showSnackBar(
        // Visar ett meddelande på skärmen.

        SnackBar(content: Text("The password does not match")),
        // Meddelande om att lösenorden är olika.

      );
      return;
      // Avbryter funktionen.
    }

    setState(() {
      // Uppdaterar sidans tillstånd.

      _isEditing = false;
      // Låser fälten igen.
    });

    ScaffoldMessenger.of(context).showSnackBar(
      // Visar ett meddelande på skärmen.

      SnackBar(content: Text("Profile is now updated")),
      // Meddelande om att profilen sparats.
    );
  }

  @override
  Widget build(BuildContext context) {
    // Bygger sidans utseende.

    return Scaffold(
      // Grundstruktur för sidan.

      backgroundColor: Color(0xFF955A5A),
      // Sätter bakgrundsfärgen till rödbrun.

      appBar: AppBar(
        // Lägger till en toppmeny.

        title: Text("My Profile"),
        // Sätter titel till "My Profile".

        backgroundColor: Colors.pink[100],
        // Sätter toppmenyns färg till ljusrosa.

        centerTitle: true,
        // Centrerar titeln.
      ),

      body: NotificationListener<ScrollNotification>(
        // Lyssnar på scroll-händelser.

        onNotification: (scrollInfo) {
          // Hanterar scroll-meddelanden.

          if (scrollInfo is ScrollUpdateNotification &&
              (scrollInfo.metrics.pixels == 0 ||
                  scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent)) {
            // Kollar om användaren är högst upp eller längst ner.

            return true;
            // Bekräftar händelsen.
          }
          return false;
          // Ignorerar andra händelser.
        },

        child: SingleChildScrollView(
          // Gör sidan scrollbar.

          physics: BouncingScrollPhysics(),
          // Lägger till studs-effekt vid scroll.

          padding: EdgeInsets.all(24),
          // Lägger till mellanrum runt innehållet.

          child: Column(
            // Organiserar innehållet i en kolumn.

            crossAxisAlignment: CrossAxisAlignment.start,
            // Vänsterjusterar innehållet.

            children: [
              // Lista med sidans innehåll.

              SizedBox(height: 20),
              // Lägger till tomt utrymme.

              _label("Username"),
              // Visar etikett för Username.

              _buildTextField(userNameController, enabled: _isEditing),
              // Skapar textfält för användarnamn.

              _label("G-mail"),
              // Visar etikett för e-post.

              _buildTextField(emailController, enabled: _isEditing),
              // Skapar textfält för e-post.

              _label("New Password"),
              // Visar etikett för lösenord.

              _buildTextField(passwordController, enabled: _isEditing, obscureText: true),
              // Skapar textfält för lösenord (dolt).

              _label("Repeat Password"),
              // Visar etikett för att upprepa lösenord.

              _buildTextField(repeatPasswordController, enabled: _isEditing, obscureText: true),
              // Skapar textfält för att upprepa lösenord (dolt).

              SizedBox(height: 30),
              // Lägger till tomt utrymme.

              Center(
                // Centrerar knapparna.

                child: Column(
                  // Organiserar knappar i en kolumn.

                  children: [
                    // Lista med knappar.

                    ElevatedButton(
                      // Skapar en knapp.

                      onPressed: () {
                        // Vad som händer när knappen trycks.

                        setState(() {
                          // Uppdaterar tillstånd.

                          _isEditing = true;
                          // Gör fälten redigerbara.
                        });
                      },

                      style: ElevatedButton.styleFrom(
                        // Styling för knappen.

                        backgroundColor: Colors.white,
                        // Vit bakgrund.

                        foregroundColor: Colors.black,
                        // Svart text.

                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        // Mellanrum runt texten.
                      ),

                      child: Text("Edit profile"),
                      // Knappens text.
                    ),

                    SizedBox(height: 10),
                    // Lägger till tomt utrymme.

                    ElevatedButton(
                      // Skapar en knapp.

                      onPressed: _isEditing ? _saveChanges : null,
                      // Kör _saveChanges om redigering är på, annars inaktiverad.

                      style: ElevatedButton.styleFrom(
                        // Styling för knappen.

                        backgroundColor: Colors.green[300],
                        // Grön bakgrund.

                        foregroundColor: Colors.black,
                        // Svart text.

                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        // Mellanrum runt texten.
                      ),

                      child: Text("Save Changes"),
                      // Knappens text.
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    // Funktion för att skapa etiketter.

    return Padding(
      // Lägger till mellanrum runt etiketten.

      padding: const EdgeInsets.only(top: 16, bottom: 6),
      // Specificerar mellanrummets storlek.

      child: Text(
        // Skapar text för etiketten.

        text,
        // Texten som visas.

        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        // Stil: fet, storlek 18, vit färg.
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller,
      {bool obscureText = false, bool enabled = true}) {
    // Funktion för att skapa textfält.

    return TextField(
      // Skapar ett textfält.

      controller: controller,
      // Kopplar fältet till en kontroll.

      obscureText: obscureText,
      // Döljer text om det är lösenord.

      enabled: enabled,
      // Styr om fältet kan redigeras.

      decoration: InputDecoration(
        // Styling för fältet.

        filled: true,
        // Fyller bakgrunden.

        fillColor: Colors.pink[100],
        // Ljusrosa bakgrund.

        border: OutlineInputBorder(
          // Skapar en ram runt fältet.

          borderRadius: BorderRadius.circular(30),
          // Rundar hörnen.

          borderSide: BorderSide.none,
          // Tar bort ramlinjen.
        ),
      ),
    );
  }
}