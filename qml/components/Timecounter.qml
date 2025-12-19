import QtQuick 2.15
import QtQuick.Layouts




 Rectangle {
     id:timecounter
     color: "orange"

    property int runspeed:30
    property var trafficstage: "Low Traffic"
    property bool running: false
    property int currCount:0
    property int targetCount:targetCountFinder()
    property int round:1

     signal changeTlights(var color1,var color2)
     signal roundfinsished()

     onTrafficstageChanged: {
                   targetCount=targetCountFinder();
     }


     function updateStatus(){
              //console.log("Current count:",currCount);
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

     function nextRound(){
              return    (trafficstage=="Low Traffic" && round<2 ||
                         trafficstage=="Medium Traffic" && round<3 ||
                         trafficstage=="High Traffic"
                         && round <4)? true:false;
     }

     function targetCountFinder(){
              switch (timecounter.trafficstage){
              case "Medium Traffic":
                            return 12;
              case "High Traffic":
                            return 18;
              default:
                           // console.log("targetCountFinder value :"+trafficstage)
                            return 8;
              }
     }

    Timer{
          id:roundShif
          interval: 2000 / (runspeed/50)
          running: false
          repeat:false
          onTriggered: {
              round++;
              var cols=defineColor()
              changeTlights(cols[0],cols[1]);
              //changeTlights("red","green");
              counterTimer.start();
          }
    }

    Timer{
        id:counterTimer
        interval: 300 / (runspeed/50)
        running:timecounter.running //timecounter.running && timecounter.currCount < timecounter .targetCount
        repeat: true
        onTriggered: {
              if(timecounter.currCount< timecounter.targetCount){
              currCount++;
              updateStatus();
              }else /*if(currCount==targetCount)*/{

                         if(nextRound()){
                            currCount=0;
                            changeTlights("yellow","yellow");
                            counterTimer.stop();
                            roundShif.start();
                         }else{
                            //console.log("else condition for executing reset counter executed");
                            resetCounter();
                         }
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
              var cols=defineColor()
              changeTlights(cols[0],cols[1]);
              running=true;
    }

    function resetCounter(){
              currCount=0;
              round=1;
              //counterTimer.running=false;
              updateStatus();
              stopCounting();
              roundfinsished();
              changeTlights("off","off");
    }

    function defineColor(){
              var colors=[];
                  if(timecounter.round%2!=0){
                            colors.push("red","green");
                  }else{
                            colors.push("green","red");
                  }
                  return colors;
    }

    Component.onCompleted: {
                  updateStatus();
                  //console.log("target count:"+targetCount)
    }

    }



