.PHONY: rebook
rebook: rebook-go-standardebooks.arm rebook-go-standardebooks.x86

rebook-go-%.arm:
	go get ./
	env GOOS=linux GOARCH=arm GOARM=7 go build -ldflags "-s -w" -o rebook-go-$*.arm $*.go
	cp rebook-go-$*.arm ../../../build/
	
rebook-go-%.x86:
	go get ./
	env go build -ldflags "-s -w" -o rebook-go-$*.x86 $*.go
	cp rebook-go-$*.arm ../../../build/

clean:
	rm -f rebook-go-.arm rebook-go-*.x86
