class Target < ISM::Software
    
    def build
        super

        makeSource(["-f","makefile"],buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/bin")
        moveFile("#{mainWorkDirectoryPath(false)}unrar","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/bin/unrar")
    end

end
