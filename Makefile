# vitae
CXX=/usr/local/opt/llvm/bin/clang++
CXXFLAGS=-std=c++11 -Wall -Werror -Wno-unneeded-internal-declaration
FLEX=/usr/local/opt/flex/bin/flex
BISON=/usr/local/opt/bison/bin/bison

TARGET_NAME=vitae

all: $(TARGET_NAME)
.PHONY: all

$(TARGET_NAME): parser.hpp scanner.cpp main.cpp
	$(CXX) $(CXXFLAGS) -o $(TARGET_NAME) *.cpp

scanner.cpp: scanner.l parser.hpp
	$(FLEX) -o scanner.cpp scanner.l

parser.hpp: parser.y
	$(BISON) --defines=parser.hpp --output=parser.cpp parser.y

test: all
	cat ./tests/sample.txt | ./$(TARGET_NAME)

clean:
	rm parser.cpp parser.hpp scanner.cpp $(TARGET_NAME)