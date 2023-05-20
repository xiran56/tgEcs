CC = clang++

SRC_PREF = ./src/

OBJ_PREF = ./obj/

IMPORT_LIB = ./lib/libtgecs.h

SOURCES = $(wildcard $(SRC_PREF)*.cpp)

OBJECTS = $(patsubst $(SRC_PREF)%.cpp, $(OBJ_PREF)%.o, $(SOURCES))

FLAGS = -target x86_64-pc-windows-gnu -g

CFLAGS = -std=c++17 -Wall -Werror -Wpedantic $(FLAGS)

LFLAGS = $(FLAGS) -s -shared -Wl,--subsystem,windows,--out-implib,$(IMPORT_LIB)

DEFINTIONS = -D ECS_EXPORT

INCLUDE = -I./internal/include/allocator

LINK = -L./internal/lib/allocator -ltgallocator

TARGET = ./bin/ecs.dll

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) -o $(TARGET) $(OBJECTS) $(LINK) $(LFLAGS)

$(OBJ_PREF)%.o: $(SRC_PREF)%.cpp
	$(CC) -c -o $@ $(INCLUDE) $< $(CFLAGS) $(DEFINTIONS)

clean:
	rm -f $(OBJECTS)
