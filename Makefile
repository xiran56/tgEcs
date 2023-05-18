CC = clang++

SRC_PREF = ./src/

OBJ_PREF = ./obj/

SOURCES = $(wildcard $(SRC_PREF)*.cpp)

OBJECTS = $(patsubst $(SRC_PREF)%.cpp, $(OBJ_PREF)%.o, $(SOURCES))

FLAGS = -target x86_64-pc-windows-gnu -g

CFLAGS = -std=c++17 -Wall -Werror -Wpedantic $(FLAGS)

LFLAGS = $(FLAGS)

INCLUDE = -I./internal/include/allocator

LINK = -L./internal/lib/allocator -ltgallocator

# Для тестов вместо библиотеки динамической компановки

TARGET = ./bin/prog

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) -o $(TARGET) $(OBJECTS) $(LINK) $(LFLAGS)

$(OBJ_PREF)%.o: $(SRC_PREF)%.cpp
	$(CC) -c -o $@ $(INCLUDE) $< $(CFLAGS)
