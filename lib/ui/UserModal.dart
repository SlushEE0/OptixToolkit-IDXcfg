// Flutter imports:
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:OptixToolkit/services/database.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

class UserModal extends StatelessWidget {
  final User user;
  const UserModal({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color blue = Color(0xff159deb);
    final Color green = Color(0xff15ee07);
    final Color yellow = Color(0xffebe712);
    final Color red = Color(0xffd5212c);
    final Color orange = Color(0xffff9415);

    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
    );

    final Map<String, TextStyle> styleMap = {
      "Arrived": GoogleFonts.rubik(
        color: green,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
      "Shipped": GoogleFonts.rubik(
        color: yellow,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
      "Ordered": GoogleFonts.rubik(
        color: orange,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
      "Failure": GoogleFonts.rubik(
        color: red,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
    };
    Widget doneButton = TextButton(
      child: Text(
        "Done",
        style: GoogleFonts.rubik(
          fontWeight: FontWeight.bold,
          color: Color(0xff159deb),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return AlertDialog(
      title: Text(
        user.displayName,
        style: GoogleFonts.rubik(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          color: Color(0xff159deb),
        ),
      ),
      backgroundColor: Color(0xff26292c),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Status: ',
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  TextSpan(
                    text: (user.certified) ? "Certified" : "Not Certified",
                    style: (user.certified)
                        ? GoogleFonts.rubik(
                            fontWeight: FontWeight.bold,
                            color: green,
                            fontSize: 20.0,
                          )
                        : GoogleFonts.rubik(
                            fontWeight: FontWeight.bold,
                            color: red,
                            fontSize: 20.0,
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(blue),
              ),
              onPressed: () async {
                var res = await Database.addCertifyRole(
                    Provider.of<firebase.IdTokenResult>(context, listen: false),
                    user.uid,
                    context);
                if (res) {
                  Navigator.of(context).pop();
                  print("worked");
                }
              },
              child: RichText(
                text: TextSpan(
                  text: 'Certify User',
                  style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(blue),
              ),
              onPressed: () async {
                var res = await Database.removeCertifyRole(
                    Provider.of<firebase.IdTokenResult>(context, listen: false),
                    user.uid,
                    context);
                if (res) {
                  Navigator.of(context).pop();
                  print("worked");
                }
              },
              child: RichText(
                text: TextSpan(
                  text: 'Uncertify User :(',
                  style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        doneButton,
      ],
    );
  }
}
