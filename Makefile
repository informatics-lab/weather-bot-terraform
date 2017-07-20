export

all: help

help:
	terraform

plan:
	terraform plan terraform

apply: simple-apply

simple-apply:
	terraform apply terraform

destroy:
	terraform destroy terraform
