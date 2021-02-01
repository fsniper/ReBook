
.PHONY: all

all: rebook-ui rebook-backend

rebook-ui:
	make -C src/rebook-ui compile

rebook-backend:
	make -C src/rebook-backend

clean:
	make -C src/rebook-ui clean
	make -C src/rebook-backend clean
	rm -rf build/*
	rm -rf bin/*
	rm -rf libs/*
	rm -rf src/github* src/golang* src/google* src/._cpp
