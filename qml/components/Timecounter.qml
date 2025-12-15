import QtQuick 2.15
import QtQuick.Layouts




 Rectangle {
     id:timecounter
     color: "orange"

    property int runspeed:50
    property string trafficstage: "Low Traffic"
    property bool running: true
    property int currCount:0
    property int targetCount:10
    property int round:0

     function updateStatus(){
              console.log("Current count:",currCount);
     }

     function getImagePath(digit){
              var image1Path;
              var image2Path;


              if(currCount<10){
              image1Path="qrc:/images/seven-sagment/LED_digit_0.png";
              image2Path= "qrc:/images/seven-sagment/LED_digit_"+currCount+".png";
              }else{
              image1Path= "qrc:/images/seven-sagment/LED_digit_"+currCount.toString()[0]+".png";
              image2Path= "qrc:/images/seven-sagment/LED_digit_"+currCount.toString()[1]+".png";
              }
              return digit>0?image2Path:image1Path;
     }

     function nextRound(trafficstage,round){
              return    (trafficstage=="Low Traffic" && round<2 ||
                         trafficstage=="Medium Traffic" && round<3 ||
                         trafficstage=="High Traffic"
                         && round <4)? true:false;
     }

    Timer{
        id:counterTimer
        interval: 1000 / (runspeed/50)
        running:timecounter.running // timecounter.running && timecounter.currCount < timecounter .targetCount
        repeat: true
        onTriggered: {
              if(timecounter.currCount< timecounter.targetCount){
              currCount++;
              updateStatus();
              }else if(currCount==targetCount){
              (nextRound())?currCount=0:resetCounter();
              }else{
                  currCount=0;
                  stopCounting();
              }
        }
    }

    RowLayout{
            anchors.fill: parent
            spacing:0


         Image {
              id: leftnum
              source: getImagePath(0)
              Layout.fillWidth: true
              Layout.fillHeight: true
              Layout.preferredWidth: 1
              fillMode: Image.Stretch
         }

         Image {
              id: rightnum
              source: getImagePath(1)
              Layout.fillWidth: true
              Layout.fillHeight: true
              Layout.preferredWidth: 1
              fillMode: Image.Stretch
         }

    }


    function stopCounting(){
                  running=false;
    }

    function startCounting(){
                  running=true;
    }

    function resetCounter(){
                  currCount=0;
                  updateStatus();
    }
    Component.onCompleted: {
                  updateStatus();
    }

    }



