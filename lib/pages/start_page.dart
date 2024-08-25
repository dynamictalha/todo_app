import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytodoapp/pages/Botton_nav_page.dart'; // Ensure this import is correct and the file exists

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF000000),
              Color(0xFF0C36CC),
            ],
            begin: Alignment(-1, 1),
            end: Alignment.bottomRight,
            stops: [0.5, 0.5],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [Color(0xFF0C36CC), Colors.blueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Text(
                        "TO",
                        style: GoogleFonts.abel(
                          color: Colors
                              .white, // This color will be replaced by the gradient
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                          shadows: [
                            Shadow(
                              offset: Offset(4.0, 4.0),
                              blurRadius: 10.0,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // Space between "TO" and "DO"
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [Color(0xFF000000), Color(0xFF25261F)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Text(
                        "DO",
                        style: GoogleFonts.abel(
                          color: Colors
                              .white, // This color will be replaced by the gradient
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                          shadows: [
                            Shadow(
                              offset: Offset(4.0, 4.0),
                              blurRadius: 10.0,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // Action for the button
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Botton_nav(), // Remove const if Botton_nav is not a constant widget
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero, // Remove default padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF0C36CC),
                          Color(0xFF000000),
                        ],
                        begin: Alignment(-1, 1),
                        end: Alignment.bottomRight,
                        stops: [0.5, 0.5],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                     
                      width: 150, // Set the width to 150
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(10, 10),
                           
                            blurRadius: 20,
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(0.2),
                            offset: Offset(-10, -10),
                           
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'START',
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'NOW',
                            style: TextStyle(
                              color: Color(0xFF0C36CC),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
