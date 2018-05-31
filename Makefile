install: 
		@echo Installing...
		@cp ./mullvad /usr/local/bin/
		@cp ./mullvad-completion /etc/bash_completion.d/
		@. /etc/bash_completion.d/
		@mkdir -p $$HOME/.config/mullvad
	
		@sleep 1
		@echo "Installed! \n\nRun 'mullvad update servers' before trying to connect"

remove:
		@echo Removing files...
		@rm /usr/local/bin/mullvad
		@rm /etc/bash_completion.d/mullvad-completion
		@. /etc/bash_completion.d/
	
		@sleep 1
		@echo "Removed"
