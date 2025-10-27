cmake_minimum_required(VERSION 3.16)

project(TrafficManagement VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick )


qt_standard_project_setup(REQUIRES 6.8)

add_subdirectory(src/core)
#add_subdirectory(src/utils)


qt_add_executable(appTrafficManagement
    main.cpp
)


qt_add_qml_module(appTrafficManagement
    URI TrafficManagement
    VERSION 1.0
    QML_FILES
        Main.qml
        qml/components/TrafficLight.qml
        qml/components/Vehicle.qml
        qml/pages/ControlPanel.qml
        QML_FILES qml/simulationEngine.qml
        QML_FILES qml/pages/area.qml
        QML_FILES

)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appTrafficManagement PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appTrafficManagement
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appTrafficManagement
    PRIVATE Qt6::Quick
    traffic_core
    #traffic_utils
)

include(GNUInstallDirs)
install(TARGETS appTrafficManagement
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

