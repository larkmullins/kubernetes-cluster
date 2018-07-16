define USAGE

Kubernetes Cluster - CentOS
===========================

Usage: make [target]

This Makefile builds the Kubernetes on CentOS VMs

Commands:
endef

.DEFAULT_GOAL := build
.PHONY: help usage

usage:
	@: $(info $(USAGE))

help: usage
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'
	@echo ""

build: --start --tls --end ## Build the cluster (default target)

clean: --clean-artifacts --clean-tls ## Clean workspace

etcd:
	@echo "Installing ETCD"
	@vagrant ssh etcd-01 -c 'etcdctl member list'

# private targets
--start:
	@echo "\n==> Building Kubernetes Cluster"

--end:
	@echo "\n==> Kubernetes is COMPLETED\n"

--clean-artifacts:
	@echo "==> Cleaning Artifacts"
	@cd provision/artifacts && find . ! -name '.gitkeep' -type f -exec rm -f {} +

--clean-tls:
	@echo "==> Cleaning TLS"
	@rm -f provision/tls/certs/*.pem

--tls:
	@printf "%-4s- Generating TLS Certificates..."
	@cd provision/tls && ./make-certs-server.sh > /dev/null 2>&1
	@printf "COMPLETE"