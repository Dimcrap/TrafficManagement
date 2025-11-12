import QtQuick 2.15
import QtQuick.Layouts




 Rectangle {
     id:timecounter
     color: "orange"

    property int runspeed:50
    property string trafficstage: "low"
    property bool running: true
    property int currCount:0
    property int targetCount:99


     function updateNum(){
              var image1Path;
              var image2Path;
              if(currCount>9){
              image1Path="qrc:/images/seven-sagment/LED_digit_0.png"
               image2Path= currCount===9?"qrc:/images/seven-sagment/LED_digit_9.png":
                            currCount==8?"qrc:/images/seven-sagment/LED_digit_8.png":
                            currCount==7?"qrc:/images/seven-sagment/LED_digit_7.png":
                            currCount==6?"qrc:/images/seven-sagment/LED_digit_6.png":
                            currCount==5?"qrc:/images/seven-sagment/LED_digit_5.png":
                            currCount==4?"qrc:/images/seven-sagment/LED_digit_4.png":
                            currCount==3?"qrc:/images/seven-sagment/LED_digit_3.png":
                            currCount==2?"qrc:/images/seven-sagment/LED_digit_2.png":
                            currCount==1?"qrc:/images/seven-sagment/LED_digit_1.png":
                            "qrc:/images/seven-sagment/LED_digit_0.png"
              }else{

              }


     }


    Timer{
        id:counterTimer
        interval: 1000 * (runspeed/50)
        running: timecounter.running && timecounter.currCount < timecounter .targetCount
        repeat: true
        onTriggered: {
              if(){

              }else{

              }
        }
    }

    RowLayout{
            anchors.fill: parent
            spacing:0


         Image {
              id: leftnum
              source: "qrc:/images/seven-sagment/LED_digit_0.png"
              Layout.fillWidth: true
              Layout.fillHeight: true
              Layout.preferredWidth: 1
              fillMode: Image.Stretch
         }

         Image {
              id: rightnum
              source: "qrc:/images/seven-sagment/LED_digit_1.png"
              Layout.fillWidth: true
              Layout.fillHeight: true
              Layout.preferredWidth: 1
              fillMode: Image.Stretch
         }

    }


    }



