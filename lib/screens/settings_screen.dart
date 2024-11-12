import 'package:flutter/material.dart';
import 'package:printify/responsive/device_dimensions.dart';
import 'package:printify/widgets/custom_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Settings"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Pro Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BECOME PRO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: DeviceDimensions.responsiveSize(context) * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: DeviceDimensions.screenHeight(context) * 0.04,),
                        Text(
                          'Unlock all premium features and enjoy total control over app',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: DeviceDimensions.responsiveSize(context) * 0.035,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.workspace_premium,
                    color:Colors.white,
                    size: DeviceDimensions.responsiveSize(context) * 0.18,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // General Section
            _buildSectionTitle(context , 'General'),
            // ListTile(
            //   leading: Icon(Icons.language, color: Colors.indigo),
            //   title: Text('Language'),
            //   subtitle: Text('English'),
            //   onTap: () {
            //     // Handle language change
            //   },
            // ),

            // SizedBox(height: 20),

            // Others Section
            //_buildSectionTitle('Others'),
            ListTile(
              leading: Icon(Icons.star_border, color: Color.fromARGB(255, 254, 110, 0)),
              title: Text('Rate us', style: TextStyle(fontSize: DeviceDimensions.responsiveSize(context) * 0.04)),
              onTap: () {
                // Handle rating
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback_outlined, color: Color.fromARGB(255, 254, 110, 0)),
              title: Text('Feedback', style: TextStyle(fontSize: DeviceDimensions.responsiveSize(context) * 0.04)),
              onTap: () {
                // Handle feedback
              },
            ),
            ListTile(
              leading: Icon(Icons.share, color: Color.fromARGB(255, 254, 110, 0)),
              title: Text('Share App', style: TextStyle(fontSize: DeviceDimensions.responsiveSize(context) * 0.04)),
              onTap: () {
                // Handle app sharing
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip_outlined, color: Color.fromARGB(255, 254, 110, 0)),
              title: Text('Privacy Policy', style: TextStyle(fontSize: DeviceDimensions.responsiveSize(context) * 0.04)),
              onTap: () {
                // Handle privacy policy
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize:  DeviceDimensions.responsiveSize(context) * 0.045,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}