default: compile

VERSION=1.9.4

.PHONY=compile
compile:
	go get ./...
	go build -o terraform-provider-stripe

test: compile
	terraform init
	terraform fmt
	terraform plan -out terraform.tfplan
	terraform apply terraform.tfplan

.PHONY=install-linux
install-linux: compile
	mkdir -p ~/.terraform.d/plugins/terraform.local/bchatelard/stripe/$(VERSION)/linux_amd64
	cp ./terraform-provider-stripe ~/.terraform.d/plugins/terraform.local/bchatelard/stripe/$(VERSION)/linux_amd64/terraform-provider-stripe_v$(VERSION)

.PHONY: authors
authors:
	./scripts/generate_authors