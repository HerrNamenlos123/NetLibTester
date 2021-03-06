
#include "pch.h"
#include "NetLib.h"

uint64_t getMicros() {
    using namespace std::chrono;
    return duration_cast<microseconds>(system_clock::now().time_since_epoch()).count();
}

int main() {
    NetLib::SetLogLevel(NetLib::LOG_LEVEL_TRACE);
    NetLib::UDPClient client("10.0.0.14", 8888);

    uint64_t old = getMicros();
    uint64_t interval = 1000000;
    while (true) {
        if (getMicros() - old >= interval) {
            old += interval;

            std::cout << "Millis: " << getMicros() << std::endl;
            client.send("Hello world");
        }
    }
}
