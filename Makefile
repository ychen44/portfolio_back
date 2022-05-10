# to initalize terraform project in dev
.PHONY: dev-init
dev-init:
	docker-compose -f ./docker-compose.yml run --rm terraform -chdir=./dev init -backend-config=../backend-dev.tf

# format dev terraform
.PHONY: dev-fmt
dev-fmt:
	docker-compose -f ./docker-compose.yml run --rm terraform -chdir=./dev fmt

# plan dev terraform
.PHONY: dev-plan
dev-plan:
	docker-compose -f ./docker-compose.yml run --rm terraform -chdir=./dev plan -var-file="dev-us-east-1.tfvars" 

# apply dev terraform
.PHONY: dev-apply
dev-apply:
	docker-compose -f ./docker-compose.yml run --rm terraform -chdir=./dev apply -var-file="dev-us-east-1.tfvars" -auto-approve

# apply dev terraform
.PHONY: dev-output
dev-output:
	docker-compose -f ./docker-compose.yml run --rm terraform -chdir=./dev output 

# destory dev terraform
.PHONY: dev-destroy
dev-destroy:
	docker-compose -f ./docker-compose.yml run --rm terraform -chdir=./dev destroy -var-file="dev-us-east-1.tfvars" -auto-approve

.PHONY: dev-console
dev-console:
	docker-compose -f ./docker-compose.yml run --rm terraform -chdir=./dev console

.PHONY: dev-refresh
dev-refresh:
	docker-compose -f ./docker-compose.yml run --rm terraform -chdir=./dev refresh 

