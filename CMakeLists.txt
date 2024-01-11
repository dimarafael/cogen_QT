cmake_minimum_required(VERSION 3.16)

project(cogen VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 REQUIRED COMPONENTS Quick SerialBus Charts)


qt_add_executable(appcogen
    main.cpp
    appmanager.h appmanager.cpp
    modbus.h modbus.cpp
    trendlog.h trendlog.cpp
    alarmlist.h alarmlist.cpp
)

if(WIN32)
  set(QUICK_CONTROLS "QtQuick.Controls.Windows")
elseif(APPLE)
  set(QUICK_CONTROLS "QtQuick.Controls.macOS")
else()
  set(QUICK_CONTROLS "QtQuick.Controls.Basic")
endif()

qt_add_qml_module(appcogen
    URI cogen
    VERSION 1.0
    IMPORTS
        ${QUICK_CONTROLS}
    QML_FILES
        Main.qml
        TextFit.qml
        MenuButton.qml
        TopMenuItem2Lines.qml
        TopMenuItem1Lines.qml
        Stopwatch.qml
        PopUpPlusMinus.qml
        PopUpPlusMinus10.qml
        PageSettings.qml
        AlarmList.qml
    RESOURCES
        img/logo.svg
        img/Coffee_Bean.svg
        img/play.svg
        img/stop.svg
        img/gear.svg
        img/drum.svg
        img/fire.svg
        img/mixer.svg
        img/cooler.svg
        img/air.svg
        img/fan.svg
    SOURCES
        alarmlistmodel.h alarmlistmodel.cpp
        alarmitem.h alarmitem.cpp
)

set_target_properties(appcogen PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appcogen
    PRIVATE Qt6::Quick
    PRIVATE Qt6::SerialBus
    PRIVATE Qt6::Charts
)

install(TARGETS appcogen
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
