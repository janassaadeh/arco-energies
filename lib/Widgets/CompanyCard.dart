// import 'dart:js_interop';
// import 'dart:typed_data';
import 'package:company_pages/Services/image_service.dart';
import 'package:flutter/material.dart';
// import 'package:company_pages/Services/ApiService.dart';
import 'package:shimmer/shimmer.dart';
class CompanyCard extends StatefulWidget {
  final String title;
  final String subtitle1;
  final String subtitle2;
  // final String? imageId;
  dynamic? imageData;

   CompanyCard({
    Key? key,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    //  this.imageId,
    this.imageData
  }) : super(key: key);

  @override
  _CompanyCardState createState() => _CompanyCardState();
}

class _CompanyCardState extends State<CompanyCard> {
  ImageService _apiService = ImageService();
  // Uint8List? _imageData;

  @override
  void initState() {
    super.initState();

  }

  // Future<void> _fetchImage() async {
  //   try {
  //     if(widget.imageId!=null){
  //     // Fetch image data using the provided image ID
  //     Uint8List imageData = await _apiService.getImageFromId(widget.imageId!);

  //     // Update the state to trigger a rebuild with the fetched image data
  //     setState(() {
  //       _imageData = imageData;
  //     });
  //     }

  //   } catch (e) {
  //     // Handle errors
  //     print('Failed to fetch image: $e');
  //   }
  // }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, right: 25, left: 25, bottom: 12),
      child: Container(
        height: 70,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: .0),
              child: 
              
              widget.imageData=='no image'?
                     Container(
                width: 78.86980438232422,
                height: 69.47300720214844,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Color.fromRGBO(209, 73, 91, 1), Color.fromRGBO(209, 73, 91, 0.5)],
                  ),
                ),
                
                child: 
                      Image.asset("assets/images/CustomerW.png",color:Colors.white),
                
                // ,
                ):
              Container(
                width: 78.86980438232422,
                height: 69.47300720214844,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  // gradient: LinearGradient(
                  //   begin: Alignment.topRight,
                  //   end: Alignment.bottomLeft,
                  //   colors: [Color.fromRGBO(209, 73, 91, 1), Color.fromRGBO(209, 73, 91, 0.5)],
                  // ),
                ),
                child:
                ClipRRect(
              borderRadius: BorderRadius.circular(12),
                  child: 
                  
                  
                  widget.imageData!=null?
                    
                       Image.memory(
                        widget.imageData!,
                      fit: BoxFit.cover, // Cover the entire area of the container
                              width: double.infinity, // Set the width and height to fill the container
                              height: double.infinity,
                      )
                      // : CircularProgressIndicator():
                      :
                      
                      Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                color: Colors.white,
              ),
            )
                ),
                
              ),
            ),
            SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  widget.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromRGBO(0, 61, 91, 1),
                    fontFamily: 'Inter',
                    fontSize: 18,
                    letterSpacing: -0.44,
                    fontWeight: FontWeight.w800,
                    height: 1.28,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      widget.subtitle1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xff72D4AB),
                        fontFamily: 'Inter',
                        fontSize: 14,
                        letterSpacing: -0.44,
                        fontWeight: FontWeight.w600,
                        height: 1.28,
                      ),
                    ),
                    SizedBox(width: 10),
                    Image.asset('assets/images/dot.png'),
                    SizedBox(width: 10),
                    Text(
                      widget.subtitle2,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xff777676),
                        fontFamily: 'Inter',
                        fontSize: 14,
                        letterSpacing: -0.44,
                        fontWeight: FontWeight.w600,
                        height: 1.28,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
              ],
            )
          ],
        ),
      ),
    );
  }
}
