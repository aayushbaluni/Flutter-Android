import 'package:flutter/material.dart';

class details extends StatelessWidget {
  final freq;
  final Data_Rate;
  final LORA_SNR;
  final PAYLOAD;
  final MAC;
  final RSSI;
  final time;
  const details({Key? key,required this.LORA_SNR,required this.PAYLOAD,required this.freq,required this.MAC, required this.Data_Rate,required this.time,required this.RSSI}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title: Text('Time: $time',style: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Text(
              "Freq:     $freq",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),Text(
              "Data_Rate:     $Data_Rate",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),Text(
              "RSSI:     $RSSI",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),Text(
              "LORA_SNR:     $LORA_SNR",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),Text(
              "MAC:     $MAC",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),Text(
              "Freq:     $freq",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
