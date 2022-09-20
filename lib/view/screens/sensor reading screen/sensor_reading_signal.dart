import 'package:counter_iot/view/Widgets/buttons.dart';
import 'package:flutter/material.dart';

class SensorReadingSignal extends StatefulWidget {
  const SensorReadingSignal({Key? key}) : super(key: key);

  @override
  State<SensorReadingSignal> createState() => _SensorReadingSignalState();
}

class _SensorReadingSignalState extends State<SensorReadingSignal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:const Text("Sensor Reading"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: 
                [
                sensorReadingWidget(true),
                sensorReadingWidget(true),
                sensorReadingWidget(true),
                sensorReadingWidget(true),
                ],
            ),
          )),
         Positioned(child: buttonSelect(
                context: context,
                  onTap: () {}, buttonType: ButtonType.secondAddSensor),
                  bottom: 10,
                  right: 10,)
        ],

      ),
    );
  }

  Widget sensorReadingWidget(bool flag){
    return  SizedBox(
      width: MediaQuery.of(context).size.width-4,
      child: Column(
        children: [
          Row(
            
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 10
                    ,
                    child: CircleAvatar(
                      
                    ),
                  ),
                  flag?const Text("LN Sensor one"):const Text("JN Sensor one"),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding:const EdgeInsets.all(5),
                    child: TextButton(onPressed: (){}, child:const Text("Verify"))),
                  IconButton(onPressed: (){}, icon:const Icon(Icons.delete_forever_outlined)),
                ],
              )
            ],
          ),
          
        ],
      ),
    );
  }
}