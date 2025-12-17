qt_add_library(traffic_core STATIC

trafficcontroller.cpp


trafficcontroller.h

controlpanelhandler.h
positioncalculator.h positioncalculator.cpp
primaryisoscene.h primaryisoscene.cpp
primaryisoscene.h primaryisoscene.cpp
)


target_include_directories(traffic_core PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)
target_link_libraries(traffic_core PRIVATE Qt6::Core)




