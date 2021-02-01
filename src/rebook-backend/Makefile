.PHONY: rebook
rebook: rebook-go-standardebooks
clean: clean-standardebooks

rebook-go-%:
	$(MAKE) -C $*
	
clean-%:
	$(MAKE) -C $* clean
