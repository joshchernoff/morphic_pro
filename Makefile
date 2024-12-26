# Makefile

.PHONY: dev

dev:
	podman compose up db --remove-orphans & mix phx.server & wait