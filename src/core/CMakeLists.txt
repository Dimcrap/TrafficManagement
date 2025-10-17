qt_add_library(traffic_core STATIC
vehiclemodel.cpp
trafficcontroller.cpp
simulationengine.cpp
)


target_link_libraries(traffic_core PRIVATE Qt6::Core)

target_include_directories(traffic_core PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})



