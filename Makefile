DOTFILES = ctags gitconfig githelpers screenrc vim vimrc
DOTFILE_DEST := $(DOTFILES:%=~/.%)

DOTDIRS := $(filter-out ./,$(dir $(DOTFILES)))
DOTDIR_DEST := $(DOTDIRS:%=~/.%)

UNAME := $(shell uname -s)

COMMAND_T_DIR := vim/bundle/command-t
ifeq ($(UNAME),Darwin)
RAKE := /usr/local/bin/rake
COMMAND_T_LIB := $(COMMAND_T_DIR)/ruby/command-t/ext.bundle
else
RAKE := /usr/bin/rake
COMMAND_T_LIB := $(COMMAND_T_DIR)/ruby/command-t/ext.so
endif


.PHONY: all links commandt rake clean

all: links commandt

links: $(DOTDIR_DEST) $(DOTFILE_DEST)

$(DOTDIR_DEST):
	mkdir -p $@

$(DOTFILE_DEST): $(wildcard ~/).%: %
	ln -s $(addprefix dotfiles/,$<) $@

commandt: $(COMMAND_T_LIB)

$(COMMAND_T_LIB): $(RAKE)
	cd $(COMMAND_T_DIR) && rake make

$(RAKE):
ifeq ($UNAME),Darwin)
	brew install ruby
endif
ifeq ($UNAME),Linux)
	CODENAME := $(shell lsb_release -a 2>/dev/null | awk '/Codename/ { print $$2 }')
	ifeq ($CODENAME),precise)
		apt-get install build-essential ruby ruby-dev rake
	else
		apt install build-essential ruby2.3 ruby2.3-dev rake
	endif
endif

clean:
	-rm $(DOTFILE_DEST)
	-rm -rf $(COMMAND_T_LIB)
