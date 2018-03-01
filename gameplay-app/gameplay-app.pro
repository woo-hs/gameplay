QT -= core gui
TARGET = gameplay-app
TEMPLATE = app
CONFIG += c++11
CONFIG -= qt
CONFIG(debug, debug|release): DEFINES += _DEBUG

SOURCES += src/App.cpp

HEADERS += src/App.h

INCLUDEPATH += src
INCLUDEPATH += ../gameplay/src
INCLUDEPATH += ../external-deps/include

win32 {
    DEFINES += _WINDOWS WIN32
    DEFINES += VK_USE_PLATFORM_WIN32_KHR
    SOURCES += src/main-windows.cpp
    INCLUDEPATH += $$(VULKAN_SDK)/Include
    CONFIG(debug, debug|release): LIBS += -L$$PWD/../gameplay/Debug/debug/ -lgameplay
    CONFIG(release, debug|release): LIBS += -L$$PWD/../gameplay/Release/release/ -lgameplay
    CONFIG(debug, debug|release): LIBS += -L$$PWD/../external-deps/lib/windows/x86_64/Debug/ -lgameplay-deps
    CONFIG(release, debug|release): LIBS += -L$$PWD/../external-deps/lib/windows/x86_64/Release/ -lgameplay-deps
    LIBS += -lkernel32 -luser32 -lgdi32 -lwinspool -lcomdlg32 -ladvapi32 -lshell32 -lole32 -loleaut32 -luuid -lodbc32 -lodbccp32 -limm32 -limagehlp -lversion -lwinmm -lxinput
    LIBS += -L$$(VULKAN_SDK)/Lib -lvulkan-1
    QMAKE_CXXFLAGS_WARN_ON -= -w34100
    QMAKE_CXXFLAGS_WARN_ON -= -w34189
    QMAKE_CXXFLAGS_WARN_ON -= -w4302
    QMAKE_CXXFLAGS_WARN_ON -= -w4311
    QMAKE_CXXFLAGS_WARN_ON -= -w4244
    RC_FILE = gameplay-app.rc
}

linux {
    DEFINES += VK_USE_PLATFORM_XCB_KHR
    SOURCES += src/main-linux.cpp
    INCLUDEPATH += $$(VULKAN_SDK)/include
    INCLUDEPATH += /usr/include/gtk-2.0
    INCLUDEPATH += /usr/lib/x86_64-linux-gnu/gtk-2.0/include
    INCLUDEPATH += /usr/include/atk-1.0
    INCLUDEPATH += /usr/include/cairo
    INCLUDEPATH += /usr/include/gdk-pixbuf-2.0
    INCLUDEPATH += /usr/include/pango-1.0
    INCLUDEPATH += /usr/include/gio-unix-2.0
    INCLUDEPATH += /usr/include/freetype2
    INCLUDEPATH += /usr/include/glib-2.0
    INCLUDEPATH += /usr/lib/x86_64-linux-gnu/glib-2.0/include
    INCLUDEPATH += /usr/include/pixman-1
    INCLUDEPATH += /usr/include/libpng12
    INCLUDEPATH += /usr/include/harfbuzz
    CONFIG(debug, debug|release): LIBS += -L$$PWD/../gameplay/Debug/ -lgameplay
    CONFIG(release, debug|release): LIBS += -L$$PWD/../gameplay/Release/ -lgameplay
    CONFIG(debug, debug|release): LIBS += -L$$PWD/../external-deps/lib/linux/x86_64/ -lgameplay-deps
    CONFIG(release, debug|release): LIBS += -L$$PWD/../external-deps/lib/linux/x86_64/ -lgameplay-deps
    LIBS += -lm -lrt -ldl -lX11 -lpthread -lgtk-x11-2.0 -lglib-2.0 -lgobject-2.0 -lxcb
    LIBS += -L$$(VULKAN_SDK)/lib/ -lvulkan
    QMAKE_CXXFLAGS += -lstdc++ -pthread -w
}

macx {
    DEFINES += VK_USE_PLATFORM_MACOS_MVK
    INCLUDEPATH += $$(VULKAN_SDK)/include
    OBJECTIVE_SOURCES += src/main-macos.mm
    CONFIG(debug, debug|release): LIBS += -L$$PWD/../gameplay/Debug/ -lgameplay
    CONFIG(release, debug|release):LIBS += -L$$PWD/../gameplay/Release/ -lgameplay
    CONFIG(debug, debug|release): LIBS += -L$$PWD/../external-deps/lib/macos/x86_64/ -lgameplay-deps
    CONFIG(release, debug|release): LIBS += -L$$PWD/../external-deps/lib/macos/x86_64/ -lgameplay-deps
    LIBS += -F$$(VULKAN_SDK)/macOS/Frameworks -framework vulkan
    LIBS += -F$$(VULKAN_SDK)/MoltenVK/macOS -framework MolenVK
    LIBS += -F/System/Library/Frameworks -framework Metal
    LIBS += -F/System/Library/Frameworks -framework MetalKit
    LIBS += -F/System/Library/Frameworks -framework GameKit 
    LIBS += -F/System/Library/Frameworks -framework IOKit
    LIBS += -F/System/Library/Frameworks -framework OpenAL
    LIBS += -F/System/Library/Frameworks -framework QuartzCore
    LIBS += -F/System/Library/Frameworks -framework Cocoa
    LIBS += -F/System/Library/Frameworks -framework Foundation
    QMAKE_CXXFLAGS += -x c++ -x objective-c++ -stdlib=libc++ -w -arch x86_64
    QMAKE_INFO_PLIST = gameplay-app.plist
    ICON = gameplay-app.icns
    res.files = res
    res.path = Contents/Resources
    QMAKE_BUNDLE_DATA += res
}

DISTFILES += \
    game.config
