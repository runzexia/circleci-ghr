RELEASE_TAG=$$(git describe --abbrev=0 --tags)

dist-tools:
	@go get github.com/mitchellh/gox

dist: dist-tools
	rm -rf ./bin/*
	mkdir -p ./bin/hello-world_linux-amd64_$(RELEASE_TAG)
	mkdir -p ./bin/hello-world_darwin-amd64_$(RELEASE_TAG)
	mkdir -p ./bin/hello-world_windows-amd64_$(RELEASE_TAG)
	gox -osarch="linux/amd64" -output=./bin/hello-world_linux-amd64_$(RELEASE_TAG)/hello-world_$(RELEASE_TAG)
	gox -osarch="darwin/amd64" -output=./bin/hello-world_darwin-amd64_$(RELEASE_TAG)/hello-world_$(RELEASE_TAG)
	gox -osarch="windows/amd64" -output=./bin/hello-world_windows-amd64_$(RELEASE_TAG)/hello-world_$(RELEASE_TAG)
	cd bin && ls --color=no | xargs -I {} tar -czf {}.tgz {}
	rm -rf ./bin/hello-world_linux-amd64_$(RELEASE_TAG)
	rm -rf ./bin/hello-world_darwin-amd64_$(RELEASE_TAG)
	rm -rf ./bin/hello-world_windows-amd64_$(RELEASE_TAG)


.PHONY: all build copy test vet fmt fmtcheck errcheck dist-tools dist
